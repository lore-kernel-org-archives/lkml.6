Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id iXcmKSCzGlsrFQAAmS7hNA
	; Fri, 08 Jun 2018 16:48:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C30B1607A4; Fri,  8 Jun 2018 16:48:03 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcdM8l8S"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 43941601C3;
	Fri,  8 Jun 2018 16:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43941601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbeFHQsB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 12:48:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751643AbeFHQsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 12:48:00 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AECF2087F;
        Fri,  8 Jun 2018 16:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528476479;
        bh=Zt4pA0bZt2ln5n2p51SDn1gAlm/pykQNm7HP5aXbI2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kcdM8l8SQeF1xWIXy7A5CI3hk3oaK78hi/hHXFH311neni8B4AD/YcQ07CRb4zVwS
         7fsNO2umv/btOq28MvQH73s7npJSK9aKbJvBGKrTyvQd1bLpqOd8Uj5Jo17UK3Ue5b
         wKbRu//1M0TfE6F8IJCk1wgbvE28vu/+fnKvhY5Q=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 301401450F4; Fri,  8 Jun 2018 13:47:55 -0300 (-03)
Date: Fri, 8 Jun 2018 13:47:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script: Show hw-cache events
Message-ID: <20180608164755.GJ17292@kernel.org>
References: <1528455748-20087-1-git-send-email-s1seetee@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528455748-20087-1-git-send-email-s1seetee@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 08, 2018 at 04:32:28PM +0530, Seeteena Thoufeek escreveu:
> perf script fails to report hardware cache events (PERF_TYPE_HW_CACHE)
> where as perf report shows the samples. Fix it. Ex,
> 
>  # perf record -e L1-dcache-loads ./a.out
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.008 MB perf.data (11 samples)]
> 
> Before patch:
>  # perf script | wc -l
>  0
> After patch:
>  # perf script | wc -l
>  11

Thanks, tested and applied.

- Arnaldo
