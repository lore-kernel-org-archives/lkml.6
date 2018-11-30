Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB87C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9A620834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyQdc6Lc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9A620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeLADmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:42:47 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37844 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeLADmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:42:46 -0500
Received: by mail-pg1-f193.google.com with SMTP id 80so2725121pge.4;
        Fri, 30 Nov 2018 08:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Oe91JGLNbvJPTfKR/egTSoiieo6a2qUf334beQBoLSE=;
        b=cyQdc6LcmlePPFTheGFjU+lUhP6L2K7dWEJ2fgCeqctQza1JCGu7lC3CNGZiAyNQSD
         wcN9efOsjfiJtszBVUycqZYcnttxwlcCn1kB1wMYVVeV0io2iZItFbY1m5wQzzVkAWZ4
         uFflKZE8aMiY7EatteZ9kCy7K0e08hlJs6kk74r7AWrdjNRoy9yrCLYSblRe7pMGKTCV
         7ahWk0Y9UDUmoC5wCI6ht4MBCSrhgv8AFxEKISQ6YJI5woYxfQeE11goAnRcpqY9leSH
         fvB93eDzyX3AvIG3c+sWylmSi3gyr6vgq2QAlI4OhOHtCPtEZE9tLX4tL2E7D/EqG+jp
         QtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Oe91JGLNbvJPTfKR/egTSoiieo6a2qUf334beQBoLSE=;
        b=DUQt2ReUUXD4X+sMham2YPwzHKdDxqLUp4R59zW9CrpeSvFVfu30lZXwmL9DuE3CXi
         858CXskAQq6AC3yfSM3Ld1dx3eDSW19Wwfsf4Hg6d5RHaM52lXibxAZcoTIhX5z+oUHe
         D1w4AxNjYrbyk5ViDPrGBNQC765lorU7IscpcYDoP3conHMgoHXA23vTb+Nq2FdX3eVb
         xmfjA1sfbsLEV3s7vc0r3JzwT0Bv9wW9pbD9DjHOJzFmP2E4DPDcTQxigKEkCkFow1jF
         qRcSQksoJjL0udWEnuGrx4CIUfIMXpV8psuLPrrhsVetlge3i64hw/Y/NMClu04L7s/z
         DhOA==
X-Gm-Message-State: AA+aEWZomQZb6pLgBcHALzZCH+YC5HEvSMQZxEAGVbgTV3wE7+iSMvu4
        EPUofEqhjU2o5naCL0IkAdnJQosl
X-Google-Smtp-Source: AFSGD/XmDuhewQ60zPQWZqBvb2M2YDifOjA8Ktxve2mibF5yWPdzRjv1d+HfJzfS4leCCndfmfUoEg==
X-Received: by 2002:a63:de04:: with SMTP id f4mr5306622pgg.292.1543595574739;
        Fri, 30 Nov 2018 08:32:54 -0800 (PST)
Received: from localhost (c-24-4-239-105.hsd1.ca.comcast.net. [24.4.239.105])
        by smtp.gmail.com with ESMTPSA id c7sm10789644pfh.18.2018.11.30.08.32.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 08:32:53 -0800 (PST)
Date:   Fri, 30 Nov 2018 08:32:52 -0800
From:   Richard Cochran <richardcochran@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ptp: fix an IS_ERR() vs NULL check
Message-ID: <20181130163252.e6z33t23j3qud57z@localhost>
References: <20181130125834.u42dhxgof66rhya2@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130125834.u42dhxgof66rhya2@kili.mountain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 03:58:34PM +0300, Dan Carpenter wrote:
> The pps_register_source() function doesn't return NULL, it returns
> error pointers.

It keeps a local variable for errno, but then it returns NULL.
But this is about to change with this recent patch:

   26.Nov'18 YueHaibing [PATCH -next] pps: using ERR_PTR instead of NULL while pps_register_source fails

It hasn't been merged yet AFAICT, but gregkh said he take it.

Thanks,
Richard
