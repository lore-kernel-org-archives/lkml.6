Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD8CC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0C92084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqHtOL6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0C92084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbeJAQqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:46:01 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33826 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbeJAQqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:46:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so8872496pfi.1;
        Mon, 01 Oct 2018 03:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z8VpPYPvwat8/MJt/LYs5BqqvnYofAow8TBVdQ+5HdM=;
        b=fqHtOL6J2z425hLODzSi0T60nayidDWs7qsaVeg/oy70ogW187AzXWMc4u3udaAQzU
         GMRukL6raD4qHFBNelEES82M2ArmnRxScGDcXTZvslLLO1V1qMJrK//njuqO0X4SHB3s
         ypkVWvIJ/etXH+inWnrCNS7dG61rEc/iNS9ezaoQt4WqSGDytRYcoRl2qG/H9ekw2MGQ
         oWHBte2zDMw/pMZDutkrmcyuhsnZOQXhXMN6V260TkDSjRna0dyrsy+OB6vHDiwy+O44
         2OF9ACSaAyP0QVvvd9sIMKTh1gdRazLnsLrAjtTUdoXlwXF1UDCDwtRF4HA9ESh1S6DM
         FMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z8VpPYPvwat8/MJt/LYs5BqqvnYofAow8TBVdQ+5HdM=;
        b=REzgkk/FhwZjM3ZkTRo/t3m6l60HzVz5YmexBTgTYmv18E3/gV0AnE4d7AlgaNhwlC
         5JENUKFPsw7U/UUD1i6TDx1jfGRUiXguX0H+74OVrV/e5YPAOXWXJckJYX82bU6Y49Ia
         KqTm9pl8FRDTDVKv1o3Sk+ZxgTV2cWTiZeWHSh2tpHaCWkJgP6N1uK9MQBBZzXeBlCSG
         y6avHnCNgev/iVcFzBSbS/2oHAzJw8uchKfA8yXfI6hZKDetjUF00TFGwIj0eaYfKW2W
         9Lpn0NYc1xg0MWTeJ9ckSwR44y5V6k4BQpsGQsZ04lFCeSgbaLEsGY+06FVfl29FujtE
         aPzQ==
X-Gm-Message-State: ABuFfojRRGLkfGiybJYqDq8RgqPlzkz6dKYJWx7zImTQ7wPqFHmVLpCL
        wzAz9AuhhqVMPMhfcQhnaZbA1+Y/
X-Google-Smtp-Source: ACcGV60RStXWFUU/c4B7nFq7bzfdsZW9M1P801DVR9kTHsIy4x5ciCDxwbkFHMb6a+FT/Qe9nPOnzA==
X-Received: by 2002:a63:1752:: with SMTP id 18-v6mr9689479pgx.131.1538388538388;
        Mon, 01 Oct 2018 03:08:58 -0700 (PDT)
Received: from localhost ([39.7.15.30])
        by smtp.gmail.com with ESMTPSA id u65-v6sm21467980pfb.144.2018.10.01.03.08.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 03:08:56 -0700 (PDT)
Date:   Mon, 1 Oct 2018 19:08:53 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] zram: fix missing zero pages for memory tracking
Message-ID: <20181001100853.GB578@jagdpanzerIV>
References: <20180919051846.234615-1-minchan@kernel.org>
 <20180919072916.GA1180@jagdpanzerIV>
 <20180922031107.GA131541@rodete-laptop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180922031107.GA131541@rodete-laptop-imager.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/22/18 12:11), Minchan Kim wrote:
> On Wed, Sep 19, 2018 at 04:29:16PM +0900, Sergey Senozhatsky wrote:
> > On (09/19/18 14:18), Minchan Kim wrote:
> > > We need to count zero filled pages as well as other pages in zram.
> > 
> > A nit,
> > 
> > 	'ZRAM_FLAG_SHIFT + 1' covers all ZRAM_SAME pages, not only
> > zero filled pages.
> 
> I was brainfart.

No, never :) And I totally didn't mean it.

	-ss
