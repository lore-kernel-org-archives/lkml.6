Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9C5C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5700B20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5700B20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeKHGdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:33:55 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38466 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeKHGdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:33:55 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA7L1AIh050706;
        Wed, 7 Nov 2018 15:01:10 -0600
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA7L1AGc048138
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Nov 2018 15:01:10 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 7 Nov
 2018 15:01:10 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 7 Nov 2018 15:01:10 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA7L1A2v007051;
        Wed, 7 Nov 2018 15:01:10 -0600
Date:   Wed, 7 Nov 2018 15:00:59 -0600
From:   Nishanth Menon <nm@ti.com>
To:     "Vutla, Lokesh" <lokeshvutla@ti.com>
CC:     "R, Vignesh" <vigneshr@ti.com>, "Kristo, Tero" <t-kristo@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: k3-am65-wakeup: Fix wakeup_uart reg address
Message-ID: <20181107210059.j2wd4v2uawsjniol@kahuna>
References: <20180927050146.17847-1-vigneshr@ti.com>
 <8dc7a5d5-3e21-c2be-fde1-3f2bc6396bec@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8dc7a5d5-3e21-c2be-fde1-3f2bc6396bec@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:10-20181005, Vutla, Lokesh wrote:
> 
> 
> On Thursday 27 September 2018 10:31 AM, Vignesh R wrote:
> > cbass_wakeup interconnect which is the parent of wakeup_uart node
> > defines address-cells=1 and size-cells=1, therefore fix up reg property
> > of wakeup_uart node accordingly. Otherwise, this UART instance fails to
> > probe if enabled.
> > 
> > Fixes: 4201af2544b3 ("arm64: dts: ti: am654: Add uart nodes")
> > Signed-off-by: Vignesh R <vigneshr@ti.com>
> 
> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Tero:

Could we pick this up for rc2? looks like $subject might be good to fix
up to:
arm64: dts: ti: k3-am65-wakeup: Fix wakeup_uart reg address
instead of
arm64: dts: k3-am65-wakeup: Fix wakeup_uart reg address

could be fixed locally.

-- 
Regards,
Nishanth Menon
