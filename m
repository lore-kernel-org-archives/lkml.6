Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E198C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691B92075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549885764;
	bh=QI2Tk5KtE2U157ukKpPH2mHXw1wBSgAAGmtEC/tc/qQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xC+qFMXjrRRQBL9OD4qzkQebpFSnqXai4T3GxNQ1gFP7hNeOcvVO6awGvL/wtQmNa
	 PP+zyacXhgDUPkHljsmBKXa7lRP6ryLta8jHnlH+MS449cLM9K9h5hLy7dpBtXxk15
	 a4VFfnwfcIYkwCogfk+M+a8muA0eN1v7ieak2nKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfBKLtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 06:49:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:57958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfBKLtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 06:49:22 -0500
Received: from quaco.ghostprotocols.net (unknown [179.182.217.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9052F2075B;
        Mon, 11 Feb 2019 11:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549885762;
        bh=QI2Tk5KtE2U157ukKpPH2mHXw1wBSgAAGmtEC/tc/qQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cc4kh28PT7eOi74uabCDt9lBLrWlc9yrhmbJ3G99EIP9nWeGx8LgfNYPvFvTr3Qzl
         Zz/yHVd2bihN5YByQC9rk8UwmvraYR+cnYAkSn05jHFDaLR1D4UYIn1HY9z1NawlZ0
         Oh9nRP+f1m2FxKqDDP4NsAA/I1TvI6UOqS7sx2zM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A0BBE40ECC; Mon, 11 Feb 2019 08:49:18 -0300 (-03)
Date:   Mon, 11 Feb 2019 08:49:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf report: Add s390 diagnosic sampling descriptor size
Message-ID: <20190211114918.GB3269@kernel.org>
References: <20190211100627.85714-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211100627.85714-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 11, 2019 at 11:06:27AM +0100, Thomas Richter escreveu:
> On IBM z13 machine types 2964 and 2965 the descriptor
> sizes for sampling and diagnostic sampling entries
> might be missing in the trailer entry and are set to zero.
> 
> This leads to a perf report failure when processing diagnostic
> sampling entries.
> 
> This patch adds missing descriptor sizes when the trailer entry
> contains zero for these fields.

Thanks, applied.

- Arnaldo
