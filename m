Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751257AbeEBMJR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:09:17 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33093 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbeEBMJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:09:12 -0400
X-Google-Smtp-Source: AB8JxZoZ2Kl2dBpok7k8U90X5OvVYQIfP1QMVkXmyI8101BDTedogFlbW9roXZui1KBQvc1yhbKeuEhvjNmLbW5pVqc=
MIME-Version: 1.0
In-Reply-To: <20180502000250.GI10479@thunk.org>
References: <20180427201036.GL5965@thunk.org> <20180429143205.GD13475@amd>
 <20180429170541.lrzwyihrd6d75rql@sultan-box> <20180429184101.GA31156@amd>
 <20180429202033.ysmc42mj2rrk3h7p@sultan-box> <20180429220519.GQ5965@thunk.org>
 <01000163186628e6-3fe4abfc-eaaf-470c-90c8-2d8ad91db8f1-000000@email.amazonses.com>
 <CAFxkdAogN0S9vgQhKoO+Zpp07bXveDQYPLvwjULoTRv3Or83qQ@mail.gmail.com>
 <20180501125518.GI20585@thunk.org> <CAFxkdArLwrG8x6fNtLUfHedKrH_0d97V6UEzOCBgK8Shkir9pQ@mail.gmail.com>
 <20180502000250.GI10479@thunk.org>
From: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 2 May 2018 07:09:11 -0500
Message-ID: <CAFxkdAp83uWnju0KZKd2edveuzmiDW_sqMORC7uoR+pwgQECNw@mail.gmail.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Justin Forbes <jmforbes@linuxtx.org>, Jeremy Cline <jeremy@jcline.org>,
        Sultan Alsawaf <sultanxda@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 7:02 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Tue, May 01, 2018 at 05:35:56PM -0500, Justin Forbes wrote:
>>
>> I have not reproduced in GCE myself.  We did get some confirmation
>> that removing dracut-fips does make the problem less dire (but I
>> wouldn't call a 4 minute boot a win, but booting in 4 minutes is
>> better than not booting at all).  Specifically systemd calls libgcrypt
>> before it even opens the log with fips there, and this is before
>> virtio-rng modules could even load. Right now though, we are looking
>> at pretty much any possible options as the majority of people are
>> calling for me to backout the patches completely from rawhide.
>
> FWIW, Debian Testing is using systemd 238, and from what I can tell
> it's calling libgcrypt and it has the same (as near as I can tell)
> totally pointless hmac nonsense, and it's not a problem that I can
> see.  Of course, Debian and Fedora may have a different set of
> patches....
>
Yes, Fedora libgcrypt is carrying a patch which makes it particularly
painful for us, we have reached out to the libgcrypt maintainer to
follow up on that end. But as I said before, even without that code
path (no dracut-fips) we are seeing some instances of 4 minute boots.
This is not really a workable user experience.  And are you sure that
every cloud platform and VM platform offers, makes it possible to
config virtio-rng?

Justin
