Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDCCC04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBCF20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="YuDQIIAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBCF20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbeKTSpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:45:19 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39391 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbeKTSpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:45:19 -0500
Received: by mail-io1-f65.google.com with SMTP id j18-v6so750010iog.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 00:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EN13+x57Xzr6TnkLrLpREMPW7SiFINiSFJgP5nHjE8o=;
        b=YuDQIIAOJY2gkSBL8WW/q0m02MBJaAFHqfqgKN6JMfAPoA9OsaMNcqsAjNMtNNxouK
         lMxCtW+kzUZxpw/hRD0zD6tfPOmDddp+/QBEsoBLiydSIvEGORXqPXmkLMcCKwC7tKBS
         DzmtqTRqGtZHDaohzLgzs0WMLNXNnKxbAqII0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EN13+x57Xzr6TnkLrLpREMPW7SiFINiSFJgP5nHjE8o=;
        b=iBgMScYfPdgMgzYo8HCOh7rSc7dgmDkOyLquhlHy5EoA1IqI+FdZ1I9VWXmWp+isDZ
         7ZZ5uGXJZoWTBOHhGAz79i2/mH3zfQvMHd7CjNnzFlctcIn7oanH5mKKH/kszrTcfEkE
         0NnVp8ajFr1TiulOWfPDIP63kCfKd7kCaLlZBvX9iiAVPH6fwlVui5mT19+j2W2igGTh
         IfEbQe11MUPc7IewuGvALSEAnVeQjlmZ8Ogw4iloAzKlHnvop25HswR2h1mRjJyf35hk
         VbyB3qz3+BHcGDadg5M8b7OS8G9YsUDcmkQR1WHLPSXTaCm7V9D4yYbVdhWWznIAPCjZ
         DWvg==
X-Gm-Message-State: AA+aEWacrYX3OD9XLXA00iQBLyOc1KZh3OSL1VfidBdBpGDbMcnf5aH8
        SzGVAZGUS0LfwowHS5/NUzrWxqRwKOnoVKM55g+RHg==
X-Google-Smtp-Source: AFSGD/VglVwchQXK0XQToj2ueOzf7LhgoIauWaMw6Zt4Hz8FFEtnhr5RpTPgumt6YxWNp4npcXxj9sULixOcCCBFs+M=
X-Received: by 2002:a6b:fe13:: with SMTP id x19mr787582ioh.294.1542701847561;
 Tue, 20 Nov 2018 00:17:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542149969.git.rgb@redhat.com> <218e806e61cd5ae2fd38f9d546f953f86c763b58.1542149969.git.rgb@redhat.com>
 <CAJfpegtA74ULckL+PXoM9_pynV78EKOpQ603iZrp=hfR0z0z7w@mail.gmail.com> <20181119225856.dt3l7qzg2ftggon4@madcap2.tricolour.ca>
In-Reply-To: <20181119225856.dt3l7qzg2ftggon4@madcap2.tricolour.ca>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 20 Nov 2018 09:17:15 +0100
Message-ID: <CAJfpegt8H-8-PJyJbGe9zQB1DxBQLoMA0QRhc-gAH=mw6YKhVw@mail.gmail.com>
Subject: Re: [RFC PATCH ghak100 V1 1/2] audit: avoid fcaps on MNT_FORCE
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>, sgrubb@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 11:59 PM Richard Guy Briggs <rgb@redhat.com> wrote:

> The simple answer is that the audit PATH record format expects the four
> cap_f* fields to be there and a best effort is being attempted to fill
> in that information in an expected way with meaningful values.  Perhaps
> better to accept that it is unreasonable to expect any fcaps on any
> umount operation and simply ignore those fields in the PATH record for
> umount syscall events.

When there's a mount there are in fact two objects belonging to the
exact same path, each having completely independent metadata:  the
mount point and the root of the mount.  For example:

stat /mnt
umount /mnt
stat /mnt

The first stat will show the root of the mount, the second one will
show the mount point.
Which one is the relevant for audit?

Not saying audit should be doing getxattr on any of them, just trying
to see more clearly.

Thanks,
Miklos
