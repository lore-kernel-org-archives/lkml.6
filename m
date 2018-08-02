Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B505C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB5E21571
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sRRzW8+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB5E21571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732243AbeHBXRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:17:49 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:56315 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeHBXRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:17:49 -0400
Received: by mail-it0-f68.google.com with SMTP id d10-v6so5630236itj.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xmtzbLIdxxaOJjhZ5lsJI801Ufrp2DdWZlZItH+F2ps=;
        b=sRRzW8+HFxHVopCYkSPtP+18jWH+A/E55Cca8a58K8X6K54dUEVi6WXN3GjH0QfU1u
         lZueDTui13735BO2JqJClNm8enEgNUkOO2tQfap5lP/klcsG6mabIXs7KS+mgoiBqGWg
         K8AOT0DfXOsFFvrB/wcv4qk9+TJ6M73bwFTxnTiWRU28Mzpof6NY18vITfUAz9scrf4H
         KxNmkKW9lu3Wu9OmzCCTGd//AWXdmmDd84pJJyg7r6eNl16ENJ44KfL3OmJOsydF1roB
         WjEOq3cBK8bfDnsm96AfKNSenIAw2gf/xv+wWEp+XGox9zSmcoowk5Kwm3zBD9tB3kK6
         +kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xmtzbLIdxxaOJjhZ5lsJI801Ufrp2DdWZlZItH+F2ps=;
        b=DkLcdsmXs0tGP2b/8eL8OD3d3nDIEeRMCQeEAgatY9SsayJ1Q/M1uM45xN6R8c1uK6
         lAltHA/3hSGuNFlkP2XWZg1+ZOH43zGAbbkldJBnPjCqgfBaB3FLpu747sV/bxnE9WdQ
         OV+ke/sVqaEBfVh4LsDCO/qkpNabQ8JXr42eQ8k7baa5NXHWl3oewseasIhCE+4frytm
         LBb0lcRcCe0iNkcPBO1X4vM9GC3DKqJj4aq1a1uwq15Es+1yLY05Qf9F1Bx4CydmAnrj
         fBOe2pyXmSZJ1aHGhAfk1qd/iVUVZvHb+jCkuyYPfRrqu5nYBYrD/pE9bjOrvF0JApz+
         hzQA==
X-Gm-Message-State: AOUpUlEEj3dYGUAJxHpFAtKFUIZt3RknW02LLOGgdbASF8Ryt4+AGFNS
        bGOjUc48VO+brakxtlREuZK1Rizw4904Sw==
X-Google-Smtp-Source: AAOMgpc2hZd3cnCY9xi2CmXTQVbX6mliMLJi5kRisbsNoDl2Iietek1qOYt0x/UjWeXxMJYx6c1m6g==
X-Received: by 2002:a24:818a:: with SMTP id q132-v6mr4222778itd.51.1533245091894;
        Thu, 02 Aug 2018 14:24:51 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id p11-v6sm1167338itf.41.2018.08.02.14.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 14:24:50 -0700 (PDT)
Subject: Re: [PATCH v2 0/9] block: Consolidate scsi sense buffer usage
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Juergen Gross <jgross@suse.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vinod Koul <vinod.koul@intel.com>,
        David Kershner <david.kershner@unisys.com>,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180731195155.46664-1-keescook@chromium.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <50e0f257-60d9-73c8-b4ac-a93c7bdccb57@kernel.dk>
Date:   Thu, 2 Aug 2018 15:24:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180731195155.46664-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/18 1:51 PM, Kees Cook wrote:
> This is a follow-up to commit f7068114d45e ("sr: pass down correctly
> sized SCSI sense buffer") which further cleans up and removes needless
> sense character array buffers and "struct request_sense" usage in favor
> of the common "struct scsi_sense_hdr".
> 
> First, drop a bunch of unused sense buffers:
>  [PATCH 1/9] ide-cd: Drop unused sense buffers
>  [PATCH 2/9] scsi: cxlflash: Drop unused sense buffers
> 
> Next, allow the sense buffer to be usable outside SCSI tree:
>  [PATCH 3/9] scsi: build scsi_common.o for all scsi passthrough request users
>  [PATCH 4/9] target: don't depend on SCSI
> 
> Then move all request_sense usage to scsi_sense_hdr:
>  [PATCH 5/9] block: Switch struct packet_command to use struct scsi_sense_hdr
> 
> And do some further cleanups for scsi_sense_hdr now that we can:
>  [PATCH 6/9] ide-cd: Remove redundant sense buffer
>  [PATCH 7/9] cdrom: Use struct scsi_sense_hdr internally
> 
> Finally add a build-time check to make sure we don't pass bad buffer sizes:
>  [PATCH 8/9] libata-scsi: Move sense buffers onto stack
>  [PATCH 9/9] scsi: Check sense buffer size at build time

Thanks Kees, applied for 4.19. Note that I hand applied patch #5 and #9,
since they did not apply directly to the block tree.

-- 
Jens Axboe

