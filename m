Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E8AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2646520869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s12bU6CB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2646520869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbeIDLhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:37:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52142 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbeIDLhm (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SJpV9X5Wq5evny3TCVTlNEwugO8IZaQvY+ywGHG2LoY=; b=s12bU6CB9KLoHG9txixoyhYxR
        uLpcJq7xQ55HnfANGKu7/vYXJRGglb+YJFI9L0PzqUW0yCIpgAnnnszDdvxSeJg678UD/UtyMnPUX
        7x/V99oPPJNVt89MzLcg0CdaUL6q6fZhq75fLW6YM6ca8YvNv3YOQkCYeVnfKfRAJsrLLMkLQbjK7
        GKnjAqEeL1ponQntbUEicyU4G0fMo5OxEA4XGl20ZrjuSzY2T5vwLBPMKwbQ6WTRzanbAWsr1Swss
        VkhqepUZf5s9QeeQQtFc3HkxXF5qKng6XdZbbKa+uH/0byBxW2ZHPFDW+8dL2wrgxJ8bU7BsXBbV5
        8kjca8Blw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fx5X5-00052U-9I; Tue, 04 Sep 2018 07:13:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CB155203C09CE; Tue,  4 Sep 2018 09:13:49 +0200 (CEST)
Date:   Tue, 4 Sep 2018 09:13:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, eranian@google.com,
        kan.liang@intel.com, jolsa@kernel.org,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf/x86/intel/uncore: Provide alias for IIO
 free-running boxes on SKX
Message-ID: <20180904071349.GZ24124@hirez.programming.kicks-ass.net>
References: <1536058697-22003-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536058697-22003-1-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 06:58:17PM +0800, Jin Yao wrote:
> root@skx /sys/devices# ls | grep uncore_iio
> uncore_iio_0
> uncore_iio_1
> uncore_iio_2
> uncore_iio_3
> uncore_iio_4
> uncore_iio_5
> uncore_iio_free_running_0
> uncore_iio_free_running_1
> uncore_iio_free_running_2
> uncore_iio_free_running_3
> uncore_iio_free_running_4
> uncore_iio_free_running_5

> root@skx /sys/devices# ls | grep uncore_iio
> uncore_iio_0
> uncore_iio_1
> uncore_iio_2
> uncore_iio_3
> uncore_iio_4
> uncore_iio_5
> uncore_iio_cbdma
> uncore_iio_mcp0
> uncore_iio_mcp1
> uncore_iio_pcie0
> uncore_iio_pcie1
> uncore_iio_pcie2

I think I'm ok with that, except of course for people that have
"free_running_#" in their scripts now and will to wtf when they upgrade
their kernel.

Do we care about them?
