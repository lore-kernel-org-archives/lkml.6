Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC7BECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC2B214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfT8yeER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC2B214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733207AbeIYALT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:11:19 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:33353 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbeIYALT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:11:19 -0400
Received: by mail-pf1-f182.google.com with SMTP id d4-v6so9371528pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 11:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e+Umfz959IFdfmtQi0UHQSa29vkdmHaWoqpDA1Z99uQ=;
        b=XfT8yeER34dCd97h7vS2uwmQMNQ0LLDd5twQAb6O+c833gPgSI82JfaIB/RbgJhrY3
         ybTIDJUTQaAc+J3MrXn3LU/taUWhrUY/OKw9/3TwFZtueL+02IzHH+64fhXIWKX9hXHv
         S/MDKyGUmd31l/EbJOAu6QcC2N929dGMt72/XZwhT8AkfG4jZ0p5Y8JYohL0FeHUqFcf
         MONG0NyW1MUZEl+lB8r5tgjJZlH2l13Z+E4bdDkwTtpgbza3DOF8XyAedjfmW2MCs0wV
         wh9RWAVm1qJsLEzF6SZLbz/Mz8CaWN7+a1+2MOgOW5SPYNdY/8kS060s2uhwQgMXeht/
         O3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e+Umfz959IFdfmtQi0UHQSa29vkdmHaWoqpDA1Z99uQ=;
        b=Sanbuv8RLgwTlPON7bs7lpe1e3rENy5/Esm928yT47h124U14GFY4H4KFWwBsY39aK
         jqrQBysNhgQlHDz6ZlskhXaaqIjcIYjn1+RUYPMKWrS77sQbOdQp6tVNfhBCWtXLvFH6
         lyss+GIUHBTk2K8TZU0+aji0U35I2tGtfIuik/aKVK+rIi20snbnlZ4VDv0D01VzeROa
         0uCmgnDsGzBnqziZ4fw/BvH7/MeYI5TyZ8UyoL6R2OTfNwjq7mqiEA5X6iMnmxv7v568
         ZkguqR9jtlYnKH/c8xYEYQGLsXTLZRLBSaT4iSw4mpiGegJKub7vW7rP6yVIMOpm1UZq
         A8VQ==
X-Gm-Message-State: ABuFfohVt/4B37wBOZCOsVEIAMBV3rQXGQm7dZPzY7F5j2WZ2i+X1dOe
        EkTH4aAtWqVm4pvMUxDo4oSCj/90gdUJlTZh4f0=
X-Google-Smtp-Source: ACcGV60MrCCnIX3vfSwv6NCUYTOuTARReOQbQ/UPi/h7uxDah3ReGyX3tzZuiMuY4Gs1rSVr01ImtrGpTW48Wq2CRUE=
X-Received: by 2002:a63:d309:: with SMTP id b9-v6mr10636427pgg.163.1537812476245;
 Mon, 24 Sep 2018 11:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net> <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net> <589966d9cd0ddccc88f33fcb7975bb4464be7696.camel@surriel.com>
 <87zhwbj8xe.fsf@redhat.com> <CAMjeLr-mWag=iO=CoNHeK9pkCu4y6vZUp03_zpJOG+e=n85j+g@mail.gmail.com>
 <20180921231545.GC2966@thunk.org> <CAKON4Oy3=7H+9WxzK-xK=T7t7rN7L3_PsJ+cdUWTjiKN=BGSRg@mail.gmail.com>
 <20180922000521.u373eysq6dogcdfo@gmail.com> <CAKON4OxCpCMETfg087wV+ZQ3ssA7eDA8gBSxMYFL9ykVfEGwww@mail.gmail.com>
 <CAMo8Bf+ufr_RFtmKMrkCuvObSeGnU2a6L4sDC_LexRcN_a9xaA@mail.gmail.com>
In-Reply-To: <CAMo8Bf+ufr_RFtmKMrkCuvObSeGnU2a6L4sDC_LexRcN_a9xaA@mail.gmail.com>
From:   "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date:   Mon, 24 Sep 2018 14:07:43 -0400
Message-ID: <CAKON4OyAJJrTFihO-1W0uHAYY9ycQyMqMmGqMgEPxqp9EKhiPQ@mail.gmail.com>
Subject: Re: Code of Conduct: Let's revamp it.
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Joey Pabalinas <joeypabalinas@gmail.com>,
        Theodore Tso <tytso@mit.edu>,
        Mark Rosenblitt-Janssen <dreamingforward@gmail.com>,
        fche@redhat.com, Rik van Riel <riel@surriel.com>,
        Edward Cree <ec429@cantab.net>,
        Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 1:43 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Fri, Sep 21, 2018 at 5:24 PM, jonsmirl@gmail.com <jonsmirl@gmail.com> =
wrote:
> > On Fri, Sep 21, 2018 at 8:05 PM Joey Pabalinas <joeypabalinas@gmail.com=
> wrote:
> >> On Fri, Sep 21, 2018 at 07:31:05PM -0400, jonsmirl@gmail.com wrote:
> >>> How do you reconcile working on a public project while keeping email
> >>> address secret?
> >>
> >> This is a little more delicate, and I admit that I can't really
> >> think of any real solutions for this part...
> >
> > But... it this bothers you, simply don't use your private, personal
> > email address when working on the kernel. Anyone with the skills to
> > work on the kernel should know enough to be able to create email
> > aliases. No rule says you have to use your real name either.
>
> There is such rule:
>   https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html
>
> chapter "Developer=E2=80=99s Certificate of Origin 1.1" says

So the "Developer=E2=80=99s Certificate of Origin 1.1" appears to require
permission be given to use the names and email addresses. Those
anonymous commits in the logs pre-date the Certificate of Origin.

This line in the CoC still looks likely to be a source of future
conflict.  Say an LWN article reprints a thread on LKML and attributes
the quotes.  Could the author (a kernel contributor) of the LWN
article be attacked via the CoC for attributing the quotes? How can
journalism function if public statements can't be quoted without
permission? Not everyone participating on LKML has submitted a patch
under the Certificate of Origin (thus giving permission for use of
name/email).

It seems inconsistent to me that the name/address you use to publish
messages to a public email list can be considered private information.

From CoC...
* Publishing others=E2=80=99 private information, such as a physical or
electronic address, without explicit permission

>
>   then you just add a line saying:
>   Signed-off-by: Random J Developer <random@developer.example.org>
>   using your real name (sorry, no pseudonyms or anonymous contributions.)
>
> And in general, Developer=E2=80=99s Certificate of Origin
>   https://developercertificate.org/
>
> says
>
>   By making a contribution to this project, I certify that:
>   ...
> (d) I understand and agree that this project and the contribution
>     are public and that a record of the contribution (including all
>     personal information I submit with it, including my sign-off) is
>     maintained indefinitely and may be redistributed consistent with
>     this project or the open source license(s) involved.
>
> --
> Thanks.
> -- Max



--=20
Jon Smirl
jonsmirl@gmail.com
