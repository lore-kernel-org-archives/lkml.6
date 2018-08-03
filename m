Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F803C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE70821775
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFiwquQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE70821775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbeHCSGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 14:06:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39253 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeHCSGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 14:06:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so5365880lji.6;
        Fri, 03 Aug 2018 09:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJ3Jxy0e0+HdwFAZXbi7BkykABkjFBL258HiCCbt7YY=;
        b=pFiwquQxdaITpL22bj6iqBwrQzQB3CIpokVGazhUGHuIOYdMHEUQ9ir8bgNxmtrpbk
         Yfyehzvg5sNTfpNkGBfm3jbPFBsuOXGS3uZpLAN5i5B12QEBDz62a62mm5r+x6kr9oaW
         rcEoDXfL6C931YID+YjW5ZlQc6qRT/Sspw+V5W36UnN26qBJA2O6f0OdbzqAQ4TgqJOk
         /Wc4BnR9Ff4YVW8v7U4p9HQh4AJ65UPsVL/C4dJzvBDQKisvnWGcExxQjL+UKUHv2DNd
         eAOfax9ecvh16ZYEsGoXuqBcboSs0f16q8DBDWVi2PRtqsM+s/ErhDVjii6zrxfnuupA
         6sQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJ3Jxy0e0+HdwFAZXbi7BkykABkjFBL258HiCCbt7YY=;
        b=Khv0DByHv+tL1VUV5ITcaQ200y078v4hXI4dP+9UFZTgfnhlgbqP0v5Kgs3Bya7L8v
         z2JMNINARMmx7l+YDebBmTOZwQoXgoCE9koJLfFBOZCr0VQZCpcteX0ZlySWxZbeDblJ
         KS4vgjSxBWzg4h14u/Kc1DtLhGE1kqPxuAi7A27pEHtFT7mcywvNdk+taGMoVCFRpUSs
         RmJfY+1Hy80TIw+bnMOQGD9qjIBppMkDodc2BHP2M/UQUypzZRq1JqrcNnrDikpT0ruZ
         TTU1i9hpLQSUczi17ACE53FtAzbZ4GX4yp458I8THQqr51zreTrnwxibV75n3jQBBp8t
         7/9Q==
X-Gm-Message-State: AOUpUlExmXrsOxW6Kw3qVBiAQlS4afWsANUu8/mILT8UF/iHOeOt6X7R
        LwdXqU1IgZ0lsP30yZxl9MrFsHuFhrWszAdPJxs=
X-Google-Smtp-Source: AAOMgpfNZljE66XO1oQThbCrnrZzmhVlEB+YUFjR1qCCTryPkjiYfhzDDlazYaqNRdxCIkJylO445GTtQt6QpDta86M=
X-Received: by 2002:a2e:740f:: with SMTP id p15-v6mr6187617ljc.130.1533312560746;
 Fri, 03 Aug 2018 09:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180719132003.GA30981@sandybridge-desktop> <20180720102532.GA20284@amd>
 <1532346156.3057.11.camel@suse.com> <20180723162302.GA4503@sandybridge-desktop>
 <1532590246.7411.3.camel@suse.com> <20180726081404.GG4244@linux-l9pv.suse>
 <20180730170415.GQ4244@linux-l9pv.suse> <20180803033702.GB416@sandybridge-desktop>
 <20180803053445.GC4244@linux-l9pv.suse> <CADjb_WSURQz86+E8kakNf7UBDM+aho+uaz3QdDkuGsEgan=szw@mail.gmail.com>
 <20180803140443.GD4244@linux-l9pv.suse>
In-Reply-To: <20180803140443.GD4244@linux-l9pv.suse>
From:   Ryan Chen <yu.chen.surf@gmail.com>
Date:   Sat, 4 Aug 2018 00:09:08 +0800
Message-ID: <CADjb_WQoa7eDhioZ8iVAzc8=BnBMbJyMCCLyxxgLjnzxi-R6XQ@mail.gmail.com>
Subject: Re: [PATCH 0/4][RFC v2] Introduce the in-kernel hibernation encryption
To:     jlee@suse.com
Cc:     Chen Yu <yu.c.chen@intel.com>, oneukum@suse.com,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ebiggers@google.com, "Theodore Ts'o" <tytso@mit.edu>,
        smueller@chronox.de, denkenz@gmail.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-crypto@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kookoo.gu@intel.com, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 10:06 PM joeyli <jlee@suse.com> wrote:
>
> On Fri, Aug 03, 2018 at 09:14:22PM +0800, Ryan Chen wrote:
> > On Fri, Aug 3, 2018 at 1:35 PM joeyli <jlee@suse.com> wrote:
> > >
> > > On Fri, Aug 03, 2018 at 11:37:02AM +0800, Yu Chen wrote:
> > > > Hi Joey,
> > > > On Tue, Jul 31, 2018 at 01:04:15AM +0800, joeyli wrote:
> > > > > Hi all,
> > > > >
> > > > > On Thu, Jul 26, 2018 at 04:14:04PM +0800, joeyli wrote:
> > > > > > On Thu, Jul 26, 2018 at 09:30:46AM +0200, Oliver Neukum wrote:
> > > > > > > On Di, 2018-07-24 at 00:23 +0800, Yu Chen wrote:
> > > > > > > >
> > > > > > > > Good point, we once tried to generate key in kernel, but people
> > > > > > > > suggest to generate key in userspace and provide it to the
> > > > > > > > kernel, which is what ecryptfs do currently, so it seems this
> > > > > > > > should also be safe for encryption in kernel.
> > > > > > > > https://www.spinics.net/lists/linux-crypto/msg33145.html
> > > > > > > > Thus Chun-Yi's signature can use EFI key and both the key from
> > > > > > > > user space.
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > ecryptfs can trust user space. It is supposed to keep data
> > > > > > > safe while the system is inoperative. The whole point of Secure
> > > > > > > Boot is a cryptographic system of trust that does not include
> > > > > > > user space.
> > > > > > >
> > > > > > > I seriously doubt we want to use trusted computing here. So the
> > > > > > > key needs to be generated in kernel space and stored in a safe
> > > > > > > manner. As we have a saolution doing that, can we come to ausable
> > > > > > > synthesis?
> > > > > > >
> > > > > > >         Regards
> > > > > > >                 Oliver
> > > > > >
> > > > > > Crurently there have two solutions, they are trusted key and EFI key.
> > > > > > Both of them are generated in kernel and are not visible in user space.
> > > > > >
> > > > > > The trusted key is generated by kernel then sealed by the TPM's
> > > > > > SRK. So the trusted key can be stored in anywhere then be enrolled
> > > > > > to kernel when we need it. EVM already uses it.
> > > > > >
> > > > > > The EFI key is Jiri Kosina's idea. It is stored in boot services
> > > > > > variable, which means that it can only be access by signed EFI binary
> > > > > > (e.g. signed EFI boot stub) when secure boot be enabled. SLE applied
> > > > > > this solution a couple of years.
> > > > > >
> > > > > > I am working on put the EFI key to key retention service. Then
> > > > > > EFI key can be a master key of encrypted key. EVM can also use
> > > > > > it:
> > > > > > https://github.com/joeyli/linux-s4sign/commit/bae39460393ada4c0226dd07cd5e3afcef86b71f
> > > > > > https://github.com/joeyli/linux-s4sign/commit/f552f97cc3cca5acd84f424b7f946ffb5fe8e9ec
> > > > > >
> > > > > > That's why I want to use key retention service in hibernation
> > > > > > encryption/authentication. Which means that we can use key
> > > > > > API to access trusted key and EFI key.
> > > > > >
> > > > >
> > > > > Here is a proof of concept for using the key retention service
> > > > > to encrypt/sign snapshot image. It's using EFI key now, I will
> > > > > add encrypted key support in the key handler later:
> > > > >     https://github.com/joeyli/linux-s4sign/commit/6311e97038974bc5de8121769fb4d34470009566
> > > > >
> > > > Thanks for the work, I have two questions here:
> > >
> > > My EFI key patch set is almost done. I will send it soon.
> > >
> > Okay, please send them out then we can have further discussion
> > on that.
> > > > 1. Could you please describe a little more about the scenario on
> > > >    how the user could use the secret key for hibernation encryption?
> > > >    A requirement is that, the user should provide a passphrase(for key derivation, i.e.)
> > > >    during resume. I was thinking how user could interact with
> > > >    the security key mechanism here.
> > > >
> > >
> > > User space doesn't need to involve. The EFI root key is generated by
> > > EFI boot stub and be transfer to kernel. It's stored in EFI boot service
> > > variable that it can only be accessed by trusted EFI binary when
> > > secure boot is enabled.
> > >
> > Okay, this apply to the 'suspend' phase, right?
> > I'm still a little confused about the 'resume' phase.
> > Taking encryption as example(not signature),
> > the purpose of doing hibernation encryption is to prevent other users
> > from stealing ram content. Say, user A uses a  passphrase to generate the
> > key and encrypted the hibernation snapshot and stores it on the disk .
> > Then if user
> > B wants to do a hibernation resume to A's previous environment, B has
> > to provide the same passphrase.
> > If I understand correctly, the secret key is saved in  header and stored
> > on the disk. Which means,  any one can read the header from the disk
> > to get  the secret key in trampoline  thus decrypt the image, which is not
> > safe.
>
> The secret key that it's saved in snapshot header is a session key which
> is encrypted by ERK (EFI root key). The ERK only lives in kernel space.
> So the session key is still secure.
>
> When resume, the session key will be decrypted/verified by ERK. Then
> kernel uses the session key to decrypted/verified snapshot image.
>
OK, I see.
> Of course that we can direct use ERK to encrypt/authenticate snapshot
> image. Actually the first version of hibernation verification in SLE
> direct uses ERK. So the snapshot header only keeps signature but no
> encrypted session key.
>
> I add session key in new version because I want to align with
> the use case of TPM trusted key + encrypted key. Then hibernation
> can use key retention service API to access EFI key or encrypted key.
>
> Compare the trusted key with EFI secure key:
>
> TPM SRK ----seal-----> Trusted key    ---encrypt---> Encrypted key
> ERK     ---encrypt---> EFI secure key ---encrypt---> Encrypted key
>
> Both of them can be the master key of encrypted key.
>
So either Trusted key or EFI secure key(session key) could be used
for snapshot encryption, right?
> If EFI key can not be accepted by kernel community, then the TPM
> trusted key + encrypted key will be the only solution. We can very
> easy to switch to encrypted key by using key retention service
> API.
>
Back to question raised previously,  how could TPM or EFI key be used to
prevent user B from resuming to the environment of A? It appears to me
that, although A is the user who  launches the hibernation,   B could
 resume to the context of A because there's no certification during
resume. Is there any way to introduce the  password based verification?
Best,
Yu
> Thanks a lot!
> Joey Lee
