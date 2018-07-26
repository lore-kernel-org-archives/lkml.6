Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70705C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192AE20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HX7J54kB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192AE20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731662AbeGZW0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 18:26:47 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:45372 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731231AbeGZW0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 18:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1532639290; x=1564175290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y/xuFozNGCO8cLVKSBbFR+46QURm7N4fDsN3oWYF1Wk=;
  b=HX7J54kBBLl1UklIsnyuCUhMwPzACwEVh6cAXoz/F8rdVynJi/OBY0UD
   Tq4pJjcZ1MqMX7si80vFOelSW7nlaStf9XM66xJvmQzfp8VDAsGYE2djr
   FSKcGA227WN6awNI2FR87HnQEYDOAq8zOC7qh220OMtST/IicSEMxMbID
   c=;
X-IronPort-AV: E=Sophos;i="5.51,406,1526342400"; 
   d="scan'208";a="746547190"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Jul 2018 21:03:39 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w6QL32Tc099720
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 26 Jul 2018 21:03:04 GMT
Received: from EX13D02UEE001.ant.amazon.com (10.43.62.208) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 26 Jul 2018 21:03:04 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D02UEE001.ant.amazon.com (10.43.62.208) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 26 Jul 2018 21:03:03 +0000
Received: from localhost (10.88.47.215) by mail-relay.amazon.com
 (10.43.62.226) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 26 Jul 2018 21:03:03 +0000
Date:   Thu, 26 Jul 2018 14:03:03 -0700
From:   Eduardo Valentin <eduval@amazon.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <rnayak@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>,
        <edubezval@gmail.com>, <smohanad@codeaurora.org>,
        <andy.gross@linaro.org>, <dianders@chromium.org>,
        <mka@chromium.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] thermal: tsens: bugfixes, cleanups
Message-ID: <20180726210303.GC7708@u40b0340c692b58f6553c.ant.amazon.com>
References: <cover.1532600791.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1532600791.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Amit,


On Thu, Jul 26, 2018 at 04:03:07PM +0530, Amit Kucheria wrote:
> Here is another series of tsens-related bugfixes and cleanups to prepare
> for IRQ support, among other things. It applies on top of another series[1]
> that did some code consolidation to add support for sdm845.
> 
> [1] https://lore.kernel.org/lkml/cover.1531895128.git.amit.kucheria@linaro.org/T/#t


Given it is already rc7 time, even if this is fixes series, I will only consider this for the merge window.

> 
> Changes since v1:
> - Fixup a couple of typos
> - Add review tag
> 
> Amit Kucheria (3):
>   thermal: tsens: Rename variable
>   thermal: tsens: switch from of_iomap() to devm_ioremap_resource()
>   thermal: tsens: Fix negative temperature reporting
> 
>  drivers/thermal/qcom/tsens-common.c | 19 ++++++++++---------
>  drivers/thermal/qcom/tsens-v2.c     | 23 ++++++++++-------------
>  2 files changed, 20 insertions(+), 22 deletions(-)
> 
> -- 
> 2.17.GIT
> 

-- 
All the best,
Eduardo Valentin
