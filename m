Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F47C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124AC218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="CEDdeE3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389875AbeLUKfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:35:37 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36265 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387777AbeLUKfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:35:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so2353110pgm.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vc2pWQ2gpKs6vdbxYdfXIyaWGAmfkAhv2wdELljEOUg=;
        b=CEDdeE3LB21LE0jMkeyUr41BM3HQobyeHnD89bxeXeqJ1/YW1sQhkdeKl2NgCtdvwT
         h6RQY4IVvwM2AIU89LdsHZEBEjuizZYTw3tSLj5lEtRWQSyblCdO2cDIlgK5k2Pp6ZCZ
         iIE3PIrW6I4wkmEexP7zKHx/gj752Y5aeItvF/XHpMrmRu0ryMUABL7l3caGi+hSamSX
         8b6Sj7ebJHNypTL5umwebym5Q/vTrg9TLoWZpc0n0f7O2Utgbx0Hu4ORpfFSJZbQDC+o
         e+jBj+6LUVGnm8GXxUozt6Bl9narr+JxeE3nyxqpKd/8hxTOEPgkoQK8Stcd6T0Z+HkS
         1JcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vc2pWQ2gpKs6vdbxYdfXIyaWGAmfkAhv2wdELljEOUg=;
        b=bZM3YDR87JgPocRFpzWAdPagQZAy6+4axmE6zlRkp8zG1HBgsMfFDfHQnGryxvvXlu
         gKly2NM78uJMGyEwckDJsn3Ea8yUuj9lbAtytpPw1sY3aMFd4hZRnrngC3sMPVZekLeM
         egYirdt564HCf7MRO+E4ki1p3xhtZDT61e4MTqBWjFDU8cSxyltz8dREJz5J9+h5qw4w
         vTxEOeqQZSSGLq0Aq6tBGEGLPe/jhcPONUp6E/qIK4oxws37bAWuOapZdDWU4rM4ta33
         pa6YTSFVvdhTB4Vmd/MhR2bTWmcWBn+DD5cmcBqvlBrMpZiGiCM4j/df8SVAmYfQLUNt
         HHKA==
X-Gm-Message-State: AA+aEWZwrS+kPLq6qreV1tGon7+4uxrnBB/JtSnQ7Yvj24vhbwbHvwJ8
        uexgJSAdFZaOs8JUVb3vFpbLwA==
X-Google-Smtp-Source: AFSGD/XNZlJBq4dQM2DBPpNGijKxt2Rayidbk3mzSA+U6mclG6MF4kvVa4KhIikrwPEnLnTQKUzvAA==
X-Received: by 2002:a62:1b50:: with SMTP id b77mr1980170pfb.36.1545388535643;
        Fri, 21 Dec 2018 02:35:35 -0800 (PST)
Received: from kshutemo-mobl1.localdomain (fmdmzpr04-ext.fm.intel.com. [192.55.54.39])
        by smtp.gmail.com with ESMTPSA id 22sm34279774pgd.85.2018.12.21.02.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 02:35:34 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id A3304300816; Fri, 21 Dec 2018 13:35:30 +0300 (+03)
Date:   Fri, 21 Dec 2018 13:35:30 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hsiangkao@mail.ru,
        kirill.shutemov@linux.intel.com, stable@vger.kernel.org,
        zhangjun <openzhangj@gmail.com>
Subject: Re: [PATCH] ubifs: Get/put page when changing PG_private
Message-ID: <20181221103530.zahcs4gm5mlknhug@kshutemo-mobl1>
References: <20181215150130.19381-1-richard@nod.at>
 <386368225.TvJUPtmGVW@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <386368225.TvJUPtmGVW@blindfold>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 09:56:25AM +0100, Richard Weinberger wrote:
> Am Samstag, 15. Dezember 2018, 16:01:30 CET schrieb Richard Weinberger:
> > The page migration code assumes that a page with PG_private
> > set has its page count elevated by 1.
> > UBIFS never did this and therefore the migration code was unable
> > to migrate some pages owned by UBIFS.
> > The lead to situations where the CMA memory allocator failed to
> > allocate memory.
> > 
> > Fix this by using get/put_page when changing PG_private.
> > 
> > Cc: <stable@vger.kernel.org>
> > Cc: zhangjun <openzhangj@gmail.com>
> > Fixes: 4ac1c17b2044 ("UBIFS: Implement ->migratepage()")
> > Reported-by: zhangjun <openzhangj@gmail.com>
> > Signed-off-by: Richard Weinberger <richard@nod.at>
> 
> FYI, on the XFS side a similar change caused a regression.
> https://marc.info/?l=linux-fsdevel&m=154530861202448&w=2
> 
> Until this regression is not fully understood, including the implications
> for UBIFS, I'll not merge this patch.

This looks like a reasonable resolution to me:

http://lkml.kernel.org/r/20181221093919.GA2337@lst.de

But let's wait the inclusion (or objection).

-- 
 Kirill A. Shutemov
