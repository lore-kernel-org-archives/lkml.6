Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA299C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99BCF2064E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KgrzOMcP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99BCF2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeJJD3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 23:29:21 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57970 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbeJJD3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 23:29:21 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w99KAYRV055119;
        Tue, 9 Oct 2018 15:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539115834;
        bh=Cy8i25b+597u+q7P5I1tuEiD+mRUsET8sV1H/KNN5oU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KgrzOMcPrOedsVOukRHQY3z7eyHYrI4WelLU9RgEruaufLXKAoiS5mJJqW0Q8VgiX
         3qo18qAIDu5ZG5hZgdgNRWEkrsfMpKEiSrQkn0lKttWfmW+2RkDpe0HxjA9MKa96tg
         Dsuj497HHVw0dTcWtLW7SxRojbHe3CtRn+GW2KfI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w99KAYrR015464;
        Tue, 9 Oct 2018 15:10:34 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 9 Oct
 2018 15:10:34 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 9 Oct 2018 15:10:34 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w99KAY02024389;
        Tue, 9 Oct 2018 15:10:34 -0500
Subject: Re: [RFC PATCH 02/11] dt-bindings: phy: add cpsw port interface mode
 selection phy bindings
To:     Tony Lindgren <tony@atomide.com>
CC:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
 <20181008234949.15416-3-grygorii.strashko@ti.com>
 <20181009144000.GL5662@atomide.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <3fa09831-0f70-dfcc-3fd9-f877215a4631@ti.com>
Date:   Tue, 9 Oct 2018 15:10:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009144000.GL5662@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/2018 09:40 AM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [181008 23:54]:
>> +Examples:
>> +	phy_gmii_sel: phy-gmii-sel {
>> +		compatible = "ti,am3352-phy-gmii-sel";
>> +		syscon-scm = <&scm_conf>;
>> +		#phy-cells = <2>;
>> +	};
> 
> Now that this driver can live in it's proper place in the

right

> dts, you may want to consider just using standard reg
> property for it instead of the syscon-scm. And also get
> rid of the syscon reads and writes.

Could you help clarify how to get syscon in this case?
syscon_node_to_regmap(dev->parent->of_node)?

Also, there are could be more then one gmii_sel registers in SCM in the future,
so I hidden offsets in of_match data. 
As result, "reg" not needed at all now.

-- 
regards,
-grygorii
