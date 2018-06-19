Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F8CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138E420836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cYUZAOZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138E420836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937650AbeFSLH6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:07:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937595AbeFSLH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+wAgsRKAr6ZA2lFKxLFISl5fk+HU2qag6MOsxjIe2VA=; b=cYUZAOZ/8juK+wiciKvyIwXNQ
        KL1Gglg4zDEDjhpueVnO/F+pJcgXk3cjqVNcX44vTGU8hEmZtoVE25fD9rm93KbyxYnI5fEGBy6Nl
        PiWsAH3hSH2tBEEpN2WN+iTBzZ816CI0eNZb74BmiU4ya3WhpU2rP6Cvd/UU+46W3XXRx7BUn56AP
        UrkT3uiC+6qEYyBGof79rn8WmI9Y7XOFua08N2gptI7dxn3sFl66qZiy5KysLmFennRA6jQ9yMpH7
        z8kvakrWL0+5FdwtP67nxnjt12YHl1wQDvoEy09Pp6h6kTKac0vs+bPW9RKYZL+LKJ27qfYZFch5W
        tUgo0+IBg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVEU5-0002CU-D4; Tue, 19 Jun 2018 11:07:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E646320298BAC; Tue, 19 Jun 2018 13:07:34 +0200 (CEST)
Date:   Tue, 19 Jun 2018 13:07:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Message-ID: <20180619110734.GO2458@hirez.programming.kicks-ass.net>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521142505.6522-4-quentin.perret@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 03:24:58PM +0100, Quentin Perret wrote:
> +struct em_freq_domain {
> +	struct em_cs_table *cs_table;
> +	cpumask_t cpus;
> +};

https://lkml.kernel.org/r/20180612125930.GP12217@hirez.programming.kicks-ass.net
