Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848B4ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1F720846
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqTpYgaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1F720846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbeGPVJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:09:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbeGPVJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:09:32 -0400
Received: from jouet.infradead.org (unknown [189.40.103.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 243C520846;
        Mon, 16 Jul 2018 20:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531773627;
        bh=AnZhwB74Ay7cGB5H9QsYL8pH1QqgVtvcPq9Y07zOM7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LqTpYgaWdhMFg8j3l6PiqHoK3o/HfFLrJcLDuxcxbFHjqpEmNbiQC5jW9C32h8xo8
         ZRnSY2O678u6cMVsKlp+xWYWz+xw4yXn0TSWsDRczgcp3YyfBViKb5nWgaTjid1ncK
         HY+23OYw25XZEG+K5BkRokedPdlVHk0UKWib9RGg=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 2EA83144881; Mon, 16 Jul 2018 16:40:23 -0400 (EDT)
Date:   Mon, 16 Jul 2018 16:40:23 -0400
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, ak@linux.intel.com, jolsa@redhat.com
Subject: Re: [PATCH 4/4 v4] perf stat: Add transaction flag (-T) support for
 s390
Message-ID: <20180716204023.GA13669@kernel.org>
References: <20180626071701.58190-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626071701.58190-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 26, 2018 at 09:17:01AM +0200, Thomas Richter escreveu:
> perf stat command line flag -T to display transaction counters is
> currently supported for x86 only.
> Add support for s390. It is based on the metrics flag -M transaction
> using the architecture dependend json files. This requires a metric
> named "transaction" in the json files for the platform.
> 
> Introduce new function metricgroup__has_metric() to check for
> the existance of a metric_name transaction.
> 
> As suggested by Andi Kleen, this is the new approach to support
> transactions counters. Other architectures will follow.

Applied the 4-part patch series,

- Arnaldo
