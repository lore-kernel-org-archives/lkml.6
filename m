Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EF0C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FB32084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pdnTuhSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71FB32084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeJEWJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:09:47 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47554 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbeJEWJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:09:47 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w95FAQQu116517;
        Fri, 5 Oct 2018 10:10:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538752226;
        bh=iN15LSdV7C+5/u+54DMRyONL6eGCXiL2CMABF8YM5I0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pdnTuhSB5XLi2QNPkA3rg5VgG17zMWungvfqAbT/obLkq4ddb5I1PdmKvgcYBp4px
         Kck349IpXaRf4mgjoBrIUTIOU1jcQOVwTKk2Qv/5MZpWOWqaBPnXi6mDWqyHrh5P0v
         ajebwz8ua3M/D6/js8Ed53VuWKYAjKMhMZaHR+70=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w95FAQge002892;
        Fri, 5 Oct 2018 10:10:26 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 5 Oct
 2018 10:10:26 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 5 Oct 2018 10:10:26 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w95FANM1026143;
        Fri, 5 Oct 2018 10:10:24 -0500
Subject: Re: [PATCH] arm64: dts: k3-am65-wakeup: Fix wakeup_uart reg address
To:     Vignesh R <vigneshr@ti.com>, Tero Kristo <t-kristo@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20180927050146.17847-1-vigneshr@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <8dc7a5d5-3e21-c2be-fde1-3f2bc6396bec@ti.com>
Date:   Fri, 5 Oct 2018 20:40:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927050146.17847-1-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 27 September 2018 10:31 AM, Vignesh R wrote:
> cbass_wakeup interconnect which is the parent of wakeup_uart node
> defines address-cells=1 and size-cells=1, therefore fix up reg property
> of wakeup_uart node accordingly. Otherwise, this UART instance fails to
> probe if enabled.
> 
> Fixes: 4201af2544b3 ("arm64: dts: ti: am654: Add uart nodes")
> Signed-off-by: Vignesh R <vigneshr@ti.com>

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh
