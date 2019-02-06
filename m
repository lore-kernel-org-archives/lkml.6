Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80914C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB7420811
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549470960;
	bh=1SUh9l/cxMwj6wc2ZQilHDbq3HKFOTfU+lKaBt7FAHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G8oEzvgdXmtfUQSWi6GRzYB4/h6lWQsrOPT4Oolh/iqDkPlieuTUWmRPP7SdOD+03
	 5clHHXRm1qudwNs/DWA9I6r/C1jI/E7S3qh+18xa40+Zbxv85ASS0Wn1KbsxqSZkJd
	 aRnFOjjZ9wi2yoKTbn+8QIr9zGIO8j7UAibSCPJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbfBFQf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:35:58 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44940 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbfBFQf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:35:58 -0500
Received: by mail-yb1-f194.google.com with SMTP id k189so2725681yba.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 08:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1bDqe5bpN75Cv8RakPvUvJU14xvpjTP2tT+FSOTp+n4=;
        b=OorqG8iKw60Ekk74Y7EKNnb+p91EV9Pow8ZdYleAP6TmguCIdw5DZZ1N6GPkKoUVKe
         WxLpFBrqT+O+oj+mukjkUVGGUk1Ut2wgavaXM5PG0UcqRfLovmFN+DcCheYRTT4P7aJS
         zxd/AZCFn1cy7Sdm3uoJdJ3EZBY2M0wuqymJYSriq66kBUfoMxIMvQjIcv+kyqV+CQm6
         L0NWZGpnzY099LNapiKZBRR6Mo4mC169JP4p2c85boZgLybW5A3tFJabIuShOR1ktaV8
         pUazgYXNwTWeXz01MP3K+3oLLuRAMFv7Mg6aSFsb6+NF7sE2WAL7dYydcODV8GuEIUwy
         AvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1bDqe5bpN75Cv8RakPvUvJU14xvpjTP2tT+FSOTp+n4=;
        b=FZeLdXd9dGrHx6vQe6OPlA5Hm3yc3uhIMZlxeVqjo8sjPacazaFnzuaopj13Br12Dx
         /EHDCw+nxGqMYemfX7/HtGCMh1cG0LhXLOYaTwYUnw2NM3IEs65GMHP2QjL5SsL/uClW
         JX85n6cHhuqHITYXS4Y5EkTNeBX7AJTxVKa/xUzApoTB/iVjlIf18CYUOBoiM8jAxiOT
         0pxHPZCPWQ+YksSgUVZZ3Njl6+fVBm066/cLaHBONCuIxIHd5sHR2S4sLUYCcw3gGMoc
         1FwtWUwxUF2Q5+gMlL9uR3y/17Llm2WIUw+JR6YUMjI7MMNpH1Jg8je7T/kBzR0mQvmg
         pQSw==
X-Gm-Message-State: AHQUAuZq58Gee25+rknJBxNc3A/M5iR8i9nfQUspT1WiMYC46dSGXoH3
        LSXLZKeyOrXTcGJUZ5hQrQw=
X-Google-Smtp-Source: AHgI3IasV/EY3WR3XheGJDq0Xu3BtoT7Ky9L0E5zJw15EdXKkSA8vZjsLl6CsU9bkybFXC3KAPBEOw==
X-Received: by 2002:a25:414f:: with SMTP id o76mr9089799yba.159.1549470956919;
        Wed, 06 Feb 2019 08:35:56 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:3bf9])
        by smtp.gmail.com with ESMTPSA id n66sm2263490ywf.49.2019.02.06.08.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 08:35:55 -0800 (PST)
Date:   Wed, 6 Feb 2019 08:35:54 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Ayush Mittal <ayush.m@samsung.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        pankaj.m@samsung.com, a.sahrawat@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH v2] kernfs: Allocating memory for kernfs_iattrs with
 kmem_cache.
Message-ID: <20190206163554.GI50184@devbig004.ftw2.facebook.com>
References: <CGME20190206050507epcas5p30ea6ad0f13693aeacbf41088d2c380a5@epcas5p3.samsung.com>
 <1549428942-5466-1-git-send-email-ayush.m@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549428942-5466-1-git-send-email-ayush.m@samsung.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 10:25:42AM +0530, Ayush Mittal wrote:
> Creating a new cache for kernfs_iattrs.
> Currently, memory is allocated with kzalloc() which
> always gives aligned memory. On ARM, this is 64 byte aligned.
> To avoid the wastage of memory in aligning the size requested,
> a new cache for kernfs_iattrs is created.
> 
> Size of struct kernfs_iattrs is 80 Bytes.
> On ARM, it will come in kmalloc-128 slab.
> and it will come in kmalloc-192 slab if debug info is enabled.
> Extra bytes taken 48 bytes.
> 
> Total number of objects created : 4096
> Total saving = 48*4096 = 192 KB
> 
> After creating new slab(When debug info is enabled) :
> sh-3.2# cat /proc/slabinfo
> ...
> kernfs_iattrs_cache   4069   4096    128   32    1 : tunables    0    0    0 : slabdata    128    128      0
> ...
> 
> All testing has been done on ARM target.
> 
> Signed-off-by: Ayush Mittal <ayush.m@samsung.com>
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
