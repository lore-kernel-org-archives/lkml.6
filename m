Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C74ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843D820821
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t1rHXSnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843D820821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeKAJuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:50:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60068 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeKAJuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WU/IKlh7kWnLALRMb5O0+LQL/zD/HiG3IbipHpShasM=; b=t1rHXSnZnZllFytFCfogggtMb
        lldLAOqy5mKoyBh+mtYJshlG3nQ1M8OEQtvUuJpr+zm+lcg6C8oKLLKCqrhGg42YJDzTdRVvn1Yqf
        InbOmwBb4VHr5nqXr8tjhiRbMrUKcG8JpzYus2PKRLcbc3CmNkrDmidiOix8olgDJIbp1A/WUsvxe
        NVb0sVYkRL8RNCg5cDiQ52AwyhDfocxxr8vwQfkPuMk+6ymli7/g0C62QH3j/s7G+Ry0M1C2GFxZq
        7yL35xELoaCnNtQblSecX68JTcWoFvIf2/F5KDqpSTx9WOROt/HIUbMl9ffdlrcPnBwp4whWiS+KK
        cLwGYXJjA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gI1Bd-0007OL-9E; Thu, 01 Nov 2018 00:50:13 +0000
Subject: Re: [PATCH v3 1/8] selftests/resctrl: Add README for resctrl tests
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        James Morse <james.morse@arm.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <1541019754-192204-1-git-send-email-fenghua.yu@intel.com>
 <1541019754-192204-2-git-send-email-fenghua.yu@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1cc6bf24-741b-73db-4933-3a609a8132d7@infradead.org>
Date:   Wed, 31 Oct 2018 17:50:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541019754-192204-2-git-send-email-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/18 2:02 PM, Fenghua Yu wrote:
> resctrl tests will be implemented. README is added for the tool first.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

Hi,

> ---
>  tools/testing/selftests/resctrl/README | 53 ++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 tools/testing/selftests/resctrl/README
> 
> diff --git a/tools/testing/selftests/resctrl/README b/tools/testing/selftests/resctrl/README
> new file mode 100644
> index 000000000000..09851a619547
> --- /dev/null
> +++ b/tools/testing/selftests/resctrl/README
> @@ -0,0 +1,53 @@
> +resctrl_tests - resctrl file system test suit
> +
> +Authors:
> +	Fenghua Yu <fenghua.yu@intel.com>
> +	Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
> +	Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
> +
> +resctrl_tests tests various resctrl functionalities and interfaces including
> +both software and hardware.
> +
> +Currently it supports Memory Bandwidth Monitoring test and Memory Bandwidth
> +Allocation test on Intel RDT hardware. More tests will be added in the future.
> +And the test suit can be extended to cover AMD QoS and ARM MPAM hardware

                suite

> +as well.
> +
> +BUILD
> +-----


cheers.
-- 
~Randy
