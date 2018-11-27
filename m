Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F9EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8811F208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="YBasQV6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8811F208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeK1G5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:57:19 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37728 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbeK1G5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:57:18 -0500
Received: by mail-io1-f66.google.com with SMTP id a3so18004675ioc.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 11:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FJpLmJ+NhtzfsWcoykkUmJgTZwUROJ/Eo8H3btKrpBI=;
        b=YBasQV6XrLeAZaFzrkcyLvrZWluXnOFXF+N9BEpIkU+Am5l5LcqQJTNZAGNUrT9krJ
         YO5TgJJ/bD8daXbtFmT4CoElQU+cqpLP1mMEFTTl2thQzDgKoWFlNJu98/nTPjf3m3hh
         k47FfXmyrDpfnzcDhGHKfdQje/tPwfCR6Fptw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJpLmJ+NhtzfsWcoykkUmJgTZwUROJ/Eo8H3btKrpBI=;
        b=smYNRsI0HBCP0dkVHVBHa8esISB2wZc2wyiByI5hCi0ZyEV+ilU1J/1Ba6l1hGRnbV
         f7cj/1V8Itfen5Zia1olc+iFc9WIlbyuJEm9fAHgNbGk0Mfmuf8QQwHe1uPc2ZeyFcG1
         p7UQO0tPYmNWMHOZG3O1FbUH9axDDVv5Qd3k9elxXbu/uDug1FF+z2NXi3cz1kxdiU8F
         w55KIcVYo48J7996j4T4AdXeV+p0byWVurLmpuy6Uleg9NXfne6Lo2t9tylrd5Ssf3CN
         yQ645ypQ/nwfCI++u9qxgjdP0LwuqUyRm0KHPSPOaXbieJyBg2Nzy2SnRDSJwVYcXN0b
         lK/A==
X-Gm-Message-State: AA+aEWaBxSNrmhBZI6a7R0VRkq16gQgcf1VdAgYu3Wt7rFWwcd71ZphD
        +BRx7ZqwdV3q7+xXFAYaRbE8EtR35LSiYDAE/d9M+w==
X-Google-Smtp-Source: AFSGD/XlTDUo2b9NdzFa2APW3FzL3mdN2WjLmv15jDHIJLSQFjnzEx1a1aVnAbf6WLFJqlf5y2OAE+n08+R6nBSuROI=
X-Received: by 2002:a6b:fe13:: with SMTP id x19mr24900548ioh.294.1543348698205;
 Tue, 27 Nov 2018 11:58:18 -0800 (PST)
MIME-Version: 1.0
References: <CAJfpegs9JjkXguemL4qSiBvRP6Dnut-D+nJo-oLFXkfCL1Egvw@mail.gmail.com>
In-Reply-To: <CAJfpegs9JjkXguemL4qSiBvRP6Dnut-D+nJo-oLFXkfCL1Egvw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 27 Nov 2018 20:58:06 +0100
Message-ID: <CAJfpegvfqx+0D32n1h2X7oj5d1mZWiLTcSSGpBnD+ba7AKzPyA@mail.gmail.com>
Subject: Re: overlayfs access checks on underlying layers
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Vivek Goyal <vgoyal@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-kernel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[resending with fixed email address for Paul Moore]

Moving discussion from github[1] to here.

To summarize: commit 007ea44892e6 ("ovl: relax permission checking on
underlying layers") was added in 4.20-rc1 to make overlayfs access
checks on underlying "real" filesystems more consistent.  The
discussion leading up to this commit can be found at [2].  The commit
broke some selinux-testsuite cases, possibly indicating a security
hole opened by this commit.

The model this patch tries to follow is that if "cp --preserve=all"
was allowed to the mounter from underlying layer to the overlay layer,
then operation is allowed.  That means even if mounter's creds doesn't
provide permission to for example execute underying file X, if
mounter's creds provide sufficient permission to perform "cp
--preserve=all X Y"  and original creds allow execute on Y, then the
operation is allowed.  This provides consistency in the face of
copy-ups.  Consistency is only provided in sane setups, where mounter
has sufficient privileges to access both the lower and upper layers.

The model may not have been perfectly followed, or possibly the model
itself is flawed.  I'd like to better understand the issues here.

Thanks,
Miklos

[1]  https://github.com/SELinuxProject/selinux-kernel/issues/43#issuecomment-442148920
[2] https://marc.info/?t=152762608800002&r=1
