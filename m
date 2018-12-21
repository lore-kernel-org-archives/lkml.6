Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9606C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D5E21927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="TfW153Yv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404521AbeLUSwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:52:02 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:38757 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404486AbeLUSwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:52:02 -0500
Received: by mail-oi1-f177.google.com with SMTP id a77so5587958oii.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 10:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SmEiwDInVcGDS92E1FZsvVW2dShsbthvbcoiGc6Wuno=;
        b=TfW153Yv46a/QblwQFW3dKCmgCmxni5z53ZBbmscu3w5JEQX6byaZ+W8+phjxDpiQs
         Vkv/NTxjDb5W4SaMHzetgOJNAFajfN2xnIH92MpQMXuzTG0llTOo2BsnoTE0QC2sjD9+
         S+BvotVpZajc7YazFzWlgkwTKlLwH58OBQxMScpyfm9WDfm6qytqCqGHBGyhEGecXP6P
         oYqJ4jQpNU6fiuWFZKgzyONb79N0bl2BztB7/9ohBDr6GTM7SZV6hY4aZNLArA0cC/QL
         NSthShVVPGqo/WLkVEhW8jT9xD6U2YyvGSF2cXKatT0PrC2qPxiCeWsw3hziM8gwORn5
         MptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SmEiwDInVcGDS92E1FZsvVW2dShsbthvbcoiGc6Wuno=;
        b=sfVLgvAMrULdf0YzD1+6eXQ4bG1byQHaXomef8MlJANwjgiEpP87j1qqBAw+KwVSkQ
         OvU2zx25OL4uSqoP2vYS1F8yfLhth+7/z2jXHqoDahOOJUyzROAqQlf9UuYVo7BhWFvC
         pwY/miohpKdBSDBthdSZ+j6HOlBlPAJCi8EWENtnXY/lWdjYC3HAi9DQDwBYme/qJhKC
         f0RIE73gQlmvYabpEhVFSIedWs76E8LKwI3PisnX80kx6lI6VU8jTm9hvaudX5Cbxxyo
         13KYtPFSsQSPFIll+tOWtueKAHipz/IMbnmwuZFU9n5ATjI1RH2OIkjc5hDEL+DfyBrk
         WQOw==
X-Gm-Message-State: AA+aEWa5UWPqQdbJMITVXFkITUWYbtGPGeFsn60VeFEFBF763dl7+Rf6
        hqgooc4PgxWqp+fQsN48nTKNON8gRWcz4VnnTxGUNA==
X-Google-Smtp-Source: ALg8bN69A94NIOu9wfxOHbSh763/NsgPHRbc2B+Gz0tUjOCBXC1Xm67lOMHU7+nxvYUlTiRRZxPqiJ1dQKoK/VlYU8k=
X-Received: by 2002:aca:2dc8:: with SMTP id t191mr2038674oit.235.1545418321087;
 Fri, 21 Dec 2018 10:52:01 -0800 (PST)
MIME-Version: 1.0
References: <20181221193244.3a6ed685@canb.auug.org.au> <8ae0ad4e-0c5c-a3dc-51b4-1616f459e45b@infradead.org>
In-Reply-To: <8ae0ad4e-0c5c-a3dc-51b4-1616f459e45b@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 21 Dec 2018 10:51:49 -0800
Message-ID: <CAPcyv4ic3Sf+KGcL3tDUx73GVY_gXmf4WPCxfA63jT6bW3LAEA@mail.gmail.com>
Subject: Re: linux-next: Tree for Dec 21 (nvdimm/security.o)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 10:44 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 12/21/18 12:32 AM, Stephen Rothwell wrote:
> > Hi all,
> >
> > News: there will be no linux-next release until Jan 2.  Have a good break.
> >
> > Changes since 20181220:
> >
>
> on x86_64:
>
> ld: drivers/nvdimm/security.o: in function `nvdimm_request_key':
> security.c:(.text+0xbe): undefined reference to `key_type_encrypted'
> ld: drivers/nvdimm/security.o: in function `nvdimm_lookup_user_key.isra.1':
> security.c:(.text+0x1ea): undefined reference to `key_type_encrypted'
>
>
> Full randconfig file is attached.

Could you send me that randconfig, offlist is fine.

It seems the "depends on ENCRYPTED_KEYS" I added is not sufficient.
