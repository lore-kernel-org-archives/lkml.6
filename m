Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CED6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAD320832
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzT6Qccf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAD320832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeK2NdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:33:20 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42379 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeK2NdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:33:19 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so197324pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 18:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pK4eXGfip163PIZ52dMAz+nSksjaIRxQf9YOk5NRSCQ=;
        b=HzT6QccfjlPMFyFyV+P+PcGMonJ2Ot8NBXw4MT653TtlLZ5t3mo+2Z2qeqeZqnC7bC
         eVr3SQ/6vxpt0wdvymkcrlEvqVlrUsdBOFpqYVJ3o75tWiMcPLKRMfdxd0T4yPSIeFf/
         tluohF1q+zBgmnRosscpdDAty4SFdNfTqzX1eohYHl21AZ5klx1Ihbze1lNaLjlQ/Vr3
         ZQGQy8kgn47Robq5WXrVM1gVrdrRPR6cqeGlBjrvOJtIrV5Qd1AXZt3E/Rk6tF96zzuw
         KAI7ThnTj7cLHbwQSZJHUHdpCrehS5MnZcLTD0mKv3bpNmRK4YWmI1zDRhlE5EFEVMl5
         PObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pK4eXGfip163PIZ52dMAz+nSksjaIRxQf9YOk5NRSCQ=;
        b=eePVrmsqxNaAdTHHAmvJdXzy84Z81Phces44PWZFIdczVTGt0IuOZqIopPe4ta1P49
         PXICS5lZnormskYeYgersKFNMU+kcKJKusWyI9XbKDa8KuNE4WoFryCke1gRsQ+e/TFJ
         ctxc9exHnYZzNxcxJYGJF65nal1bIl9dmrDTpj1B44DKVxgDjOF3GA386S7q4OzUkYeU
         ApIsw7Bf+y5zQ8VZ405fIsj6b+d5ZCIE3UNYhDeBk343KC9bXHk5BKSpdz9TztWKb9Xd
         LsWEPGIzu+RCUedGecobOh9DTljFTKz6HbmVKF/Niy01Mt8FbTGn7dZorRxh0OkeUXa/
         7Atg==
X-Gm-Message-State: AGRZ1gLwlpJQXTdOIHnJhSdVXyXjnDtpwvl4JJ1l3g/t9l3MVZRxhGCK
        tqzWH4N5WojIWrvi67uVDgQ=
X-Google-Smtp-Source: AJdET5eHtnRRW4mDA2SW78a7WXdrDaLjFM68Jp0jzWtHPvAWGFnyICFXBlOPzvWQi+wXQvdd5SeM3Q==
X-Received: by 2002:a62:19d5:: with SMTP id 204mr40109333pfz.33.1543458575081;
        Wed, 28 Nov 2018 18:29:35 -0800 (PST)
Received: from localhost ([175.223.15.27])
        by smtp.gmail.com with ESMTPSA id l19sm441922pfi.71.2018.11.28.18.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 18:29:34 -0800 (PST)
Date:   Thu, 29 Nov 2018 11:29:30 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH v3 4/7] zram: introduce ZRAM_IDLE flag
Message-ID: <20181129022930.GB6379@jagdpanzerIV>
References: <20181127055429.251614-1-minchan@kernel.org>
 <20181127055429.251614-5-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127055429.251614-5-minchan@kernel.org>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/27/18 14:54), Minchan Kim wrote:
> To support idle page writeback with upcoming patches, this patch
> introduces a new ZRAM_IDLE flag.
> 
> Userspace can mark zram slots as "idle" via
> 	"echo all > /sys/block/zramX/idle"
> which marks every allocated zram slot as ZRAM_IDLE.
> User could see it by /sys/kernel/debug/zram/zram0/block_state.
> 
>           300    75.033841 ...i
>           301    63.806904 s..i
>           302    63.806919 ..hi

Hopefully we will never have a 't' block state :)

	-ss
