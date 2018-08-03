Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80300C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B04E216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDL0pdbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B04E216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbeHCPKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:10:54 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46881 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731952AbeHCPKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:10:54 -0400
Received: by mail-lf1-f66.google.com with SMTP id l16-v6so4001897lfc.13;
        Fri, 03 Aug 2018 06:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S5tqbrSK2i0EAowI60lt4/pownmkugOqqMaLQdVRM/0=;
        b=kDL0pdbM1CeKaz7dhLiptEdWUqrZQGrzT/or6ve2LGem0eqZ8+3v2nfFNX/zJSH2LW
         mVeAlo6X6SLsmj52ReHVIb13wzIyY5tLheFqxGLeMe/UVSSkKVJJxBP0Dhhy53dJUgXO
         VfPdn6iUjsB8t2vND9vBWsBqTVk3vlnRDrG50tp/kncNhXPPG3/m9Uh4Ht1ajO6TTeKv
         Aid6Gw7/orKPxsA/xtTByVTHZusI2jtQLoyBkdwIKBmD9BF9OeGJ5aXNZmt+HroEJizA
         Z03TLSH3KmpO3k7hzg6KTWQEylvEoeamFFGNIAnx9nC27YBQZd+Dc1gG7zzvIgZUiRkC
         wqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S5tqbrSK2i0EAowI60lt4/pownmkugOqqMaLQdVRM/0=;
        b=d4wBuVP4Qi3WZNIjSLLEYuvQ6hfFUXgKRi+3TsS2WNg3Sm4TEe3wlIZOxDcmj7KXcs
         QDentN5dvr/o2BbLeGAcy6ZPsHpQnrQBYWNkqLU1NYXjWGjl8BaaC3GmC7xdBYKX2WQF
         pBVCJZ2YcneL8gfT0bWEOW+alRMLAruLbCVyTGh22huhjnDUCbRMGFnZXouM+RvCUqBb
         pXJ5Fid2ckk7gYdjPXPTy8ST+7kx6Cf1p5Ja/Oc0MH6BuVv7tl+QUcYPTRK8HvwFjkRw
         X/aDa75G+2kggkrZUxxY9ukbMEVRlOmaCeFRT/CuVwdv0pDp4UHZWADZ0VYm5GDTOfS3
         Lt7A==
X-Gm-Message-State: AOUpUlGg5aSCMGy15p5dw8IpJEgFg/xd3t/ozvbElHbcovhvNrZHlAZB
        TSlJShih6h2wRfVVh3otcvAViTGFC4yYqU2V/eg=
X-Google-Smtp-Source: AAOMgpdzRSgvjvjQVGV73iHgmIvaB/65lB55F6YhNzYoDo6sWtnag7Euu0WxWmezqobhXi0DnggP6l5+AhdOtcB6v0o=
X-Received: by 2002:a19:b2c7:: with SMTP id t68-v6mr4525703lfk.132.1533302073802;
 Fri, 03 Aug 2018 06:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180718235851.GA22170@sandybridge-desktop> <20180719110149.GA4679@amd>
 <20180719132003.GA30981@sandybridge-desktop> <20180720102532.GA20284@amd>
 <1532346156.3057.11.camel@suse.com> <20180723162302.GA4503@sandybridge-desktop>
 <1532590246.7411.3.camel@suse.com> <20180726081404.GG4244@linux-l9pv.suse>
 <20180730170415.GQ4244@linux-l9pv.suse> <20180803033702.GB416@sandybridge-desktop>
 <20180803053445.GC4244@linux-l9pv.suse>
In-Reply-To: <20180803053445.GC4244@linux-l9pv.suse>
From:   Ryan Chen <yu.chen.surf@gmail.com>
Date:   Fri, 3 Aug 2018 21:14:22 +0800
Message-ID: <CADjb_WSURQz86+E8kakNf7UBDM+aho+uaz3QdDkuGsEgan=szw@mail.gmail.com>
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

On Fri, Aug 3, 2018 at 1:35 PM joeyli <jlee@suse.com> wrote:
>
> On Fri, Aug 03, 2018 at 11:37:02AM +0800, Yu Chen wrote:
> > Hi Joey,
> > On Tue, Jul 31, 2018 at 01:04:15AM +0800, joeyli wrote:
> > > Hi all,
> > >
> > > On Thu, Jul 26, 2018 at 04:14:04PM +0800, joeyli wrote:
> > > > On Thu, Jul 26, 2018 at 09:30:46AM +0200, Oliver Neukum wrote:
> > > > > On Di, 2018-07-24 at 00:23 +0800, Yu Chen wrote:
> > > > > >
> > > > > > Good point, we once tried to generate key in kernel, but people
> > > > > > suggest to generate key in userspace and provide it to the
> > > > > > kernel, which is what ecryptfs do currently, so it seems this
> > > > > > should also be safe for encryption in kernel.
> > > > > > https://www.spinics.net/lists/linux-crypto/msg33145.html
> > > > > > Thus Chun-Yi's signature can use EFI key and both the key from
> > > > > > user space.
> > > > >
> > > > > Hi,
> > > > >
> > > > > ecryptfs can trust user space. It is supposed to keep data
> > > > > safe while the system is inoperative. The whole point of Secure
> > > > > Boot is a cryptographic system of trust that does not include
> > > > > user space.
> > > > >
> > > > > I seriously doubt we want to use trusted computing here. So the
> > > > > key needs to be generated in kernel space and stored in a safe
> > > > > manner. As we have a saolution doing that, can we come to ausable
> > > > > synthesis?
> > > > >
> > > > >         Regards
> > > > >                 Oliver
> > > >
> > > > Crurently there have two solutions, they are trusted key and EFI key.
> > > > Both of them are generated in kernel and are not visible in user space.
> > > >
> > > > The trusted key is generated by kernel then sealed by the TPM's
> > > > SRK. So the trusted key can be stored in anywhere then be enrolled
> > > > to kernel when we need it. EVM already uses it.
> > > >
> > > > The EFI key is Jiri Kosina's idea. It is stored in boot services
> > > > variable, which means that it can only be access by signed EFI binary
> > > > (e.g. signed EFI boot stub) when secure boot be enabled. SLE applied
> > > > this solution a couple of years.
> > > >
> > > > I am working on put the EFI key to key retention service. Then
> > > > EFI key can be a master key of encrypted key. EVM can also use
> > > > it:
> > > > https://github.com/joeyli/linux-s4sign/commit/bae39460393ada4c0226dd07cd5e3afcef86b71f
> > > > https://github.com/joeyli/linux-s4sign/commit/f552f97cc3cca5acd84f424b7f946ffb5fe8e9ec
> > > >
> > > > That's why I want to use key retention service in hibernation
> > > > encryption/authentication. Which means that we can use key
> > > > API to access trusted key and EFI key.
> > > >
> > >
> > > Here is a proof of concept for using the key retention service
> > > to encrypt/sign snapshot image. It's using EFI key now, I will
> > > add encrypted key support in the key handler later:
> > >     https://github.com/joeyli/linux-s4sign/commit/6311e97038974bc5de8121769fb4d34470009566
> > >
> > Thanks for the work, I have two questions here:
>
> My EFI key patch set is almost done. I will send it soon.
>
Okay, please send them out then we can have further discussion
on that.
> > 1. Could you please describe a little more about the scenario on
> >    how the user could use the secret key for hibernation encryption?
> >    A requirement is that, the user should provide a passphrase(for key derivation, i.e.)
> >    during resume. I was thinking how user could interact with
> >    the security key mechanism here.
> >
>
> User space doesn't need to involve. The EFI root key is generated by
> EFI boot stub and be transfer to kernel. It's stored in EFI boot service
> variable that it can only be accessed by trusted EFI binary when
> secure boot is enabled.
>
Okay, this apply to the 'suspend' phase, right?
I'm still a little confused about the 'resume' phase.
Taking encryption as example(not signature),
the purpose of doing hibernation encryption is to prevent other users
from stealing ram content. Say, user A uses a  passphrase to generate the
key and encrypted the hibernation snapshot and stores it on the disk .
Then if user
B wants to do a hibernation resume to A's previous environment, B has
to provide the same passphrase.
If I understand correctly, the secret key is saved in  header and stored
on the disk. Which means,  any one can read the header from the disk
to get  the secret key in trampoline  thus decrypt the image, which is not
safe.
Best,
Yu
> > 2. The generation of secret key in EFI boot environment is
> >    using a non standard derivation method in generate_secret_key(),
> >    I'm not sure if this is safe enough. This is why we tried to put
> >    PBKDF2 into kernel at first and leave it to the user space then.
> >
>
> Thank you for point out.
>
> The generate_secret_key() reuse the logic in kaslr_get_random_long()
> that it produces random seed by RDRAND, RDTSC and i8254. It doesn't
> standard like PBKDF2, but we do not have too many choices in the
> early boot stage. At least KASLR is using the same logic.
>
> We can relay on user space helper. But the helper must be authenticated
> by kernel. Currently we do not have kernel mechanism to verity user
> space process.
>
> Regards
> Joey Lee



-- 
Thanks,
Ryan
