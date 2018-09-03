Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C33C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3438920856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4A0lSt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3438920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbeICL7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 07:59:03 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53426 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbeICL7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 07:59:03 -0400
Received: by mail-wm0-f66.google.com with SMTP id b19-v6so72969wme.3;
        Mon, 03 Sep 2018 00:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+vdIIVFpRR/vxmZEgsmR75UU7/6Xtd6jr+Vl+5Op+To=;
        b=K4A0lSt+lIgM+c1fAAhtCANLtEhVWfkJd39xXHxei9KXHgi6XaUuGVKtADJ1jfFhJi
         e9SbzuJ+o7yQY1gQW5yBIO3KuFwlOYp4oklDBmD9zsyZlcB/ruCG9yqlCVwpqfTnpjfL
         ETVGTya3rkM6bU8w/pDma2QRfGjr/TKp5EASXiI7jgPaohths0V7xAAud9xaFjjha/Hb
         K2i8RwiZV7z0+VBM5h/sD/W+RWniVSSn1WCCUoLD7KMPlqcePmOTTzpWxA72az/kx13y
         5H7yLw/RfDiTuTI0Xvy+djV6x3gTVvxwm9MLejbE7OgFJeH/QH1LwsvkTPEaL+7/IcJF
         Xkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+vdIIVFpRR/vxmZEgsmR75UU7/6Xtd6jr+Vl+5Op+To=;
        b=qJh2RqnPNEW0gGa7BdxMUb634fCoYiWyIGA2giX55yTXNZFjof9I4uAZuj7VuokZRP
         I5wNh3GnC1HdR4zt5I++RxVtVSZT68JH/Hz010GYqhG5lPDN1TVKDwsqrOiHKDNULDgv
         ubQaEhodQqdsYOK3QtknvGAbwqe3ms3JSF3GrvgHXPNbtr6RhAWWq0OlViTeq0s8z2v1
         o8W9NxoL3tEuQGJxPGnBlTWUPRHNXrosioj6vhfYsJSxgzcSdshs1xzWoEsBGmbBMD3T
         IAyNOPZxgHPZGW/0NGg/7YJG6G8fVbxfr1zO0xVF+AKI1YRfSUidvg96WWXdenFK0T22
         2Mkw==
X-Gm-Message-State: APzg51DO8yqntYbQ/VaWxAvESC2+YAEP/tf/U7FrWIemX1yOBa3AJVzY
        B0ILclajzb5e7d2PzUmo4L3g1V1c4Pk=
X-Google-Smtp-Source: ANB0VdZVYPchQAw8nFioUagkgcziR0eJBMDUy6Zv8Sm72RCy/zejRe61i+QcXr60oOCPQsEt8NO0Uw==
X-Received: by 2002:a1c:1188:: with SMTP id 130-v6mr4280236wmr.138.1535960407148;
        Mon, 03 Sep 2018 00:40:07 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id w4-v6sm18926550wro.24.2018.09.03.00.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 00:40:06 -0700 (PDT)
Date:   Mon, 3 Sep 2018 09:40:05 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fat: Relax checks for sector size and media type
Message-ID: <20180903074005.7e3guj24ksq2l44c@pali>
References: <20180902131932.11558-1-pali.rohar@gmail.com>
 <87bm9ft5h5.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bm9ft5h5.fsf@mail.parknet.co.jp>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 September 2018 16:17:26 OGAWA Hirofumi wrote:
> Pali Rohár <pali.rohar@gmail.com> writes:
> 
> > Windows fastfat.sys driver accepts also media types 0x00 and 0x01 and
> > sector sizes 128 and 256 bytes. Linux mkfs.fat can format disk also to
> > larger FAT sector sizes then 4096 bytes, therefore relax also upper limit
> > restriction.
> 
> > -	if (!is_power_of_2(bpb->fat_sector_size)
> > -	    || (bpb->fat_sector_size < 512)
> > -	    || (bpb->fat_sector_size > 4096)) {
> > +	if (!is_power_of_2(bpb->fat_sector_size)) {
> 
> Just relaxing validation doesn't work. The block layer doesn't support
> smaller than 512, and lager than PAGE_SIZE.  (And in specification, fat
> doesn't support lager than 4096.)

Hi! I just sent this patch for discussion, with links to (now open
source) Windows implementation. I guess that Windows driver
implementation is more "authoritative" then Microsoft's own
specification. It is known that Windows implementation does not match
Microsoft specification.

I know at least 3 FAT specifications (MS EFI FAT, MS/SD card FAT,
ECMA-107) and you are right that Microsoft's one does not allow sector
sizes larger then 4096.

If there is limitation by block layer, then:

1) Why we do not check for PAGE_SIZE?

2) Is check in fat driver really needed (if block layer checks it)?

> >  static inline int fat_valid_media(u8 media)
> >  {
> > -	return 0xf8 <= media || media == 0xf0;
> > +	return 0xf8 <= media || media == 0xf0 || media == 0x00 || media == 0x01;
> >  }
> >  #endif /* !_LINUX_MSDOS_FS_H */
> 
> This is ok though, this would be for ancient floppy media.

Ok.

-- 
Pali Rohár
pali.rohar@gmail.com
