Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F6A1625709
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38B4204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="FgIIretr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38B4204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbeG3TKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:10:11 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42005 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbeG3TKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:10:11 -0400
Received: by mail-pl0-f67.google.com with SMTP id z7-v6so5855683plo.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 10:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t3M5rTd8UQUZH8sFuvAzVipMcb+t1yIO3WUd6jwNRX0=;
        b=FgIIretr2ycxia6ucJ1+J3m1oUHGteyQIjB5kXwhBbvwsRYb7MhLUls6MmA3cm6E2u
         EXg0bSqowX/FL9iP3l7s3YR18a06rXRF+Y4pQj09GqOYfAQ7aNkzXfK4vMu2mxLLGXUk
         yOG5Kw2KbdDI2q8op3bQor/HYAuN3VXZxyLd1dOZuriL4S062cMPN2/l0EBy5ITIAgPl
         c2Jtf3GHYSvfsYDAbiW1Dz24SXH0XrNv1taffhOwaBaRP9JOg4OvsvanvstGgdT2AnLl
         hp8nRV1p1TWecA+/qv7sYyHXdBdcUSKIIKp8tVicOTVkDOyLXepL3ZkBfcepTHsRiYDW
         RWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t3M5rTd8UQUZH8sFuvAzVipMcb+t1yIO3WUd6jwNRX0=;
        b=Hw4Dhb3Qcvdx5Vk6Eh3NIn8TvuMYIBDHov+ODAMtrJJ2cz6pIJlXJkJRIox+Er8OnR
         oJ9fIRiwPfiPUgCX0ASkMZiWP5F3UHpqfVORp8zOjbgy+1MjY+XBSGBXdsHRDP7TuB5O
         BCmYqMj3mHBPZHrKcrLGmlvA9L2mn1aRtpNpQOS1056AfGKcJv+11yraNq++Tr8bk9rX
         wDSauBKoAlKRE6I4RXcgDzJyWaVPVg3Bg7HMBL1m1QYyadS0mTXIHkeMCOPnEty8ROZk
         VlxDzk0lLo1ZDaIndJmDPsLO6D/SVDn64VOqT7p3PEb+29NUJW/0aGvodkCVV8i7A6JV
         AB4A==
X-Gm-Message-State: AOUpUlHtIkt0giZPg8IEuRcA56VOU24A2WAD7mQdG9FFowVo8iFe++h9
        Xo6bReVtmm2rnLEExwHyJF8TYQ==
X-Google-Smtp-Source: AAOMgpehkMFT3YZn8mX39bOtQBRpBZBDKplEsP2TpC68+LmEcS3bS0pkdeuRJFxFDFvrBtmFZ7o27A==
X-Received: by 2002:a17:902:820e:: with SMTP id x14-v6mr17349532pln.218.1532972048973;
        Mon, 30 Jul 2018 10:34:08 -0700 (PDT)
Received: from xeon-e3 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id h69-v6sm34611076pfh.13.2018.07.30.10.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 10:34:08 -0700 (PDT)
Date:   Mon, 30 Jul 2018 10:34:06 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Yidong Ren <yidren@linuxonhyperv.com>
Cc:     Yidong Ren <yidren@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        devel@linuxdriverproject.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, madhans@microsoft.com
Subject: Re: [PATCH v4 net-next] hv_netvsc: Add per-cpu ethtool stats for
 netvsc
Message-ID: <20180730103406.189cdc5d@xeon-e3>
In-Reply-To: <20180730170945.20517-1-yidren@linuxonhyperv.com>
References: <20180724012622.26873-1-yidren@linuxonhyperv.com>
        <20180730170945.20517-1-yidren@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018 17:09:45 +0000
Yidong Ren <yidren@linuxonhyperv.com> wrote:

> From: Yidong Ren <yidren@microsoft.com>
> 
> This patch implements following ethtool stats fields for netvsc:
> cpu<n>_tx/rx_packets/bytes
> cpu<n>_vf_tx/rx_packets/bytes
> 
> Corresponding per-cpu counters already exist in current code. Exposing
> these counters will help troubleshooting performance issues.
> 
> for_each_present_cpu() was used instead of for_each_possible_cpu().
> for_each_possible_cpu() would create very long and useless output.
> It is still being used for internal buffer, but not for ethtool
> output.
> 
> There could be an overflow if cpu was added between ethtool
> call netvsc_get_sset_count() and netvsc_get_ethtool_stats() and
> netvsc_get_strings(). (still safe if cpu was removed)
> ethtool makes these three function calls separately.
> As long as we use ethtool, I can't see any clean solution.
> 
> Currently and in foreseeable short term, Hyper-V doesn't support
> cpu hot-plug. Plus, ethtool is for admin use. Unlikely the admin
> would perform such combo operations.
> 
> Signed-off-by: Yidong Ren <yidren@microsoft.com>

Reviewed-by: Stephen Hemminger <sthemmin@microsoft.com>
