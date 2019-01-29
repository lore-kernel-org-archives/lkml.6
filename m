Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DF5C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7391020857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cHk2LUjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfA2SV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:21:28 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46836 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfA2SV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:21:27 -0500
Received: by mail-yb1-f193.google.com with SMTP id y7so8533555ybg.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 10:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dC239ZrpeLmzKNGp7d/PMxvG6dvpCn21nw5Gvt8HUmM=;
        b=cHk2LUjzKuO08PqN6tHA2ob9kDTBUPqG4IP3XBq4fKgSUvY1lx/X4A+8udBlTZZmF2
         MEqAK1fG52bITYGEh+D0yDaUgyBKkj0zOGch7kiknjrrIyzuWIFeYVK8QxS3mj8VVOiJ
         IHGSOg4/OR0bFhhFxmsZPZ11380o3HIY0wYHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dC239ZrpeLmzKNGp7d/PMxvG6dvpCn21nw5Gvt8HUmM=;
        b=GiI5VO94Yck1lZMJoYgDoILgfH/SChl4OOi55a0uPIJXQbwXpIrmTNLMvo0UBrGSsi
         Zlh3ua4xN+ZoHlx8xlPbSBU2+HSRz4h+bsgheuOUvBYibxCT3vmWCsG+waB1rhKJJPgz
         CAGDvt+npltEsYfU+mWcHM6N5KA5q3hC9a/y9TtpKL35FKBP7XR2DBUMT1QFIehzUyK9
         BTu/5ApAEzoEjIThuvBzKW93ZyVymOLzDj1gIKYFAs0DpdFaokw1wBss7BrdJMV00pck
         PD6ai8+2h55WApEwAEnC7Vdo9PpeYoMCFw3NXKLiTsbi6iadg7iiPzwHRhytVMTFtIJZ
         wq2Q==
X-Gm-Message-State: AJcUukfhSzIQc1pDp6CUAC4URzJRJcDih/uopA4gOgMt07mECZsOxOEp
        8t/nMG9hkRFEiywHnYyHSjjBklSmRLgtQOhf1LW8uQ==
X-Google-Smtp-Source: ALg8bN5qmemLRZQJPQnWp/Vdr3HheUDfmIZsVModqoEdlC7pHqxv/K50YIumAwLOyfEB4eSB/7cs5q4tOUpsfEztDwg=
X-Received: by 2002:a25:16c6:: with SMTP id 189mr25723340ybw.17.1548786086721;
 Tue, 29 Jan 2019 10:21:26 -0800 (PST)
MIME-Version: 1.0
References: <20190129171143.3945af24@canb.auug.org.au> <a4e95bee-e5c5-94f5-a577-d55cdd419e86@infradead.org>
In-Reply-To: <a4e95bee-e5c5-94f5-a577-d55cdd419e86@infradead.org>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 29 Jan 2019 10:21:16 -0800
Message-ID: <CAJ-EccMgDvx81g-XgWymdYn_G5Ou8mgbef3GUbx-C_Ai5qF-pQ@mail.gmail.com>
Subject: Re: linux-next: Tree for Jan 29 (security/safesetid/)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed you don't have the following lines (or some of the other
related security ones) in your .config.

CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y

Seems like we need a 'depends on SECURITY' line (or something like
that) in security/safesetid/Kconfig -- let me see if that fixes things
and if so I'll upload a patch

On Tue, Jan 29, 2019 at 9:04 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 1/28/19 10:11 PM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20190125:
> >
>
> on x86_64:
>
> ld: security/safesetid/lsm.o:(.data+0x10): undefined reference to `security_hook_heads'
> ld: security/safesetid/lsm.o:(.data+0x38): undefined reference to `security_hook_heads'
> ld: security/safesetid/lsm.o: in function `safesetid_security_init':
> lsm.c:(.init.text+0x14): undefined reference to `security_add_hooks'
>
>
> Full randconfig file is attached.
>
> --
> ~Randy
