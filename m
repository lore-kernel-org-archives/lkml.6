Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7C1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D45120832
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tD5kymCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D45120832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbeK2N1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:27:47 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34134 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeK2N1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:27:47 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so229261plz.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 18:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Sh8fZmx9OhO97rIfd/9wjxe3+5Mrq/e+esPNgOqo+E=;
        b=tD5kymCenCDTerTgQWjbHxfnEBy4WXt4GKTyOLm5vf3Rb71bN3I16kKipHtg7AD93C
         yOPh9sE6yu/rBRgnfTJbE9vQBej4Xfy6DHjmucDl2xgkt3llSrp+GlyPWNy+8xVaPubE
         xMUQ5g1fa9OcIgpsg4g8aZbuKjHt2yZ75T4agxw/43N4QG1h3X0nOaOSXEWplXmx4U2F
         4e2Tc/MVF33v7xAf/XzMCABDOcrvDIFDSJdYACT/DSNfd6kltaTH7CzoY+CzrvxCGdRG
         mQ7wQ620J6qEfPxukgutOqcmYht3sYQ1Qxnzo7h7YDsgSomXI9R1VDDd8/aPNrzAVAHs
         Hf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Sh8fZmx9OhO97rIfd/9wjxe3+5Mrq/e+esPNgOqo+E=;
        b=Y6R9FYt/H6W4cvuGOIyjFvHzt9s/nbi9eYXcUEJQYO1yZ0+O/F0Lm01zEiwM1+nmpH
         TdhZaXoYDf6gTknrZXublIK6ukg0+o7/NFzqHcg6Le+28eNxSfBHUG263JkKCOpZiyma
         A6pgJI6vDoInI6OCB+vfBIoVAB0O159xbretKCsnwYBFisEEo8IRmV0TCE4ozLN2b4Vk
         fh0OVTCSjBKNtSIVl8opQp4SqjNNn6oL2J2YXesSgP48HWiHLSBYX+G7jrQA17FOkbn/
         CPQAep8gqCda4qm1opU6usYUrPbFjKRybO6D1RHY8xBzjXFCzSd4Y+5E7daFmnj8dWCR
         Iksw==
X-Gm-Message-State: AA+aEWYYqtCw2KGIgABY/qy3Ogkvdy/r+r82W4BFR29yrBHPDOwj3Qe1
        xbh9dTGd4AUHYCWVPFxgD4E=
X-Google-Smtp-Source: AFSGD/Vs6/GJLigtU/KvFAnJj+P/isDfL3aRL38DENXNKk98F3roX++yrPe8rxoBfVWFCcRC+umBkA==
X-Received: by 2002:a17:902:6ac3:: with SMTP id i3-v6mr39552163plt.153.1543458243481;
        Wed, 28 Nov 2018 18:24:03 -0800 (PST)
Received: from localhost ([175.223.15.27])
        by smtp.gmail.com with ESMTPSA id y184sm288188pgd.71.2018.11.28.18.24.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 18:24:02 -0800 (PST)
Date:   Thu, 29 Nov 2018 11:23:58 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH v3 7/7] zram: writeback throttle
Message-ID: <20181129022358.GA6379@jagdpanzerIV>
References: <20181127055429.251614-1-minchan@kernel.org>
 <20181127055429.251614-8-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127055429.251614-8-minchan@kernel.org>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/27/18 14:54), Minchan Kim wrote:
> diff --git a/Documentation/ABI/testing/sysfs-block-zram b/Documentation/ABI/testing/sysfs-block-zram
> index 65fc33b2f53b..9d2339a485c8 100644
> --- a/Documentation/ABI/testing/sysfs-block-zram
> +++ b/Documentation/ABI/testing/sysfs-block-zram
> @@ -121,3 +121,12 @@ Contact:	Minchan Kim <minchan@kernel.org>
>  		The bd_stat file is read-only and represents backing device's
>  		statistics (bd_count, bd_reads, bd_writes) in a format
>  		similar to block layer statistics file format.
> +
> +What:		/sys/block/zram<id>/writeback_limit
> +Date:		November 2018
> +Contact:	Minchan Kim <minchan@kernel.org>
> +Description:
> +		The writeback_limit file is read-write and specifies the maximum
> +		amount of writeback ZRAM can do. The limit could be changed
> +		in run time and "0" means disable the limit.
> +		No limit is the initial state.
> diff --git a/Documentation/blockdev/zram.txt b/Documentation/blockdev/zram.txt
> index 906df97527a7..64b61925e475 100644
> --- a/Documentation/blockdev/zram.txt
> +++ b/Documentation/blockdev/zram.txt
> @@ -164,6 +164,8 @@ reset             WO    trigger device reset
>  mem_used_max      WO    reset the `mem_used_max' counter (see later)
>  mem_limit         WO    specifies the maximum amount of memory ZRAM can use
>                          to store the compressed data
> +writeback_limit   WO    specifies the maximum amount of write IO zram can
> +			write out to backing device as 4KB unit
						       ^^^^
						page size units?

	-ss
