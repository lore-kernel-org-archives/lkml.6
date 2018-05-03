Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeECMXw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:23:52 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:38698 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbeECMXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:23:44 -0400
X-Google-Smtp-Source: AB8JxZqb6S/f+kcvnqrUtKp54FiqcNbnYsF2sS5Wgc0BWUDfgDERL6eF7pI0t/cvbSscdjAQ5iZlEOtS6zvjs4Q76xc=
MIME-Version: 1.0
In-Reply-To: <20180502222522.GA15457@thunk.org>
References: <20180429202033.ysmc42mj2rrk3h7p@sultan-box> <20180429220519.GQ5965@thunk.org>
 <01000163186628e6-3fe4abfc-eaaf-470c-90c8-2d8ad91db8f1-000000@email.amazonses.com>
 <CAFxkdAogN0S9vgQhKoO+Zpp07bXveDQYPLvwjULoTRv3Or83qQ@mail.gmail.com>
 <20180501125518.GI20585@thunk.org> <CAFxkdArLwrG8x6fNtLUfHedKrH_0d97V6UEzOCBgK8Shkir9pQ@mail.gmail.com>
 <20180502000250.GI10479@thunk.org> <CAFxkdAp83uWnju0KZKd2edveuzmiDW_sqMORC7uoR+pwgQECNw@mail.gmail.com>
 <20180502162653.GB3461@thunk.org> <3851ac8b-357d-3c82-2195-936e3c459212@redhat.com>
 <20180502222522.GA15457@thunk.org>
From: Justin Forbes <jmforbes@linuxtx.org>
Date: Thu, 3 May 2018 07:23:42 -0500
Message-ID: <CAFxkdApf7unUS0s4-NaD7RxePGN4WnNtqYcYqyQmbJJ6nnpF=Q@mail.gmail.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
To: "Theodore Y. Ts'o" <tytso@mit.edu>, Laura Abbott <labbott@redhat.com>,
        Justin Forbes <jmforbes@linuxtx.org>, Jeremy Cline <jeremy@jcline.org>,
        Sultan Alsawaf <sultanxda@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 2, 2018 at 5:25 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Wed, May 02, 2018 at 10:49:34AM -0700, Laura Abbott wrote:
>>
>> It is a Fedora patch we're carrying
>> https://src.fedoraproject.org/rpms/libgcrypt/blob/master/f/libgcrypt-1.6.2-fips-ctor.patch#_23
>> so yes, it is a Fedora specific use case.
>> From talking to the libgcrypt team, this is a FIPS mode requirement
>> to run power on self test at the library constructor and the self
>> test of libgrcypt ends up requiring a fully seeded RNG. Citation
>> is in section 9.10 of
>> https://csrc.nist.gov/CSRC/media/Projects/Cryptographic-Module-Validation-Program/documents/fips140-2/FIPS1402IG.pdf
>
> Forgive me if this is a stupid question, but does Fedora need FIPS
> compliance?  Or is this something which is only required for RHEL?
>
> ("Here's to FIPS: the cause of, and solution to, all of Life's
> problems."  :-)
>
One of the advantages of carrying such things in Fedora is we find
these problems before RHEL does and hopefully there is a solution in
place before they ever even see it.

>From the rawhide end, I just brought in virtio-rng as inline vs
module, this works around the issue for lots of users, but not all.
GCE is still impacted, and a user came to complain about it already
last night.  And of course any other virt platform without virtio-rng,
or some hardware. Most hardware installs don't have dracut-fips so
they will boot, eventually.

Justin
