Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07938ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD63E207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD63E207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeJZD7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:59:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41552 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbeJZD7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:59:44 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9PJPRIg056548;
        Thu, 25 Oct 2018 14:25:27 -0500
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9PJPR3D037267
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Oct 2018 14:25:27 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 25
 Oct 2018 14:25:27 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 25 Oct 2018 14:25:27 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9PJPRS7002329;
        Thu, 25 Oct 2018 14:25:27 -0500
Subject: Re: [PATCH net-next 0/4] net: ethernet: ti: cpsw: fix vlan mcast
To:     David Miller <davem@davemloft.net>, <ivan.khoronzhuk@linaro.org>
CC:     <linux-omap@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alexander.h.duyck@intel.com>,
        <bjorn@mork.no>
References: <20181024221059.21834-1-ivan.khoronzhuk@linaro.org>
 <20181025.113441.567599603045046210.davem@davemloft.net>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <12ca7599-e5f0-087f-674d-a887f3768913@ti.com>
Date:   Thu, 25 Oct 2018 14:25:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181025.113441.567599603045046210.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 10/25/18 1:34 PM, David Miller wrote:
> From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> Date: Thu, 25 Oct 2018 01:10:55 +0300
> 
>> The cpsw holds separate mcast entires for vlan entries. At this moment
>> driver adds only not vlan mcast addresses, omitting vlan/mcast entries.
>> As result mcast for vlans doesn't work. It can be fixed by adding same
>> mcast entries for every created vlan, but this patchseries uses more
>> sophisticated way and allows to create mcast entries only for vlans
>> that really require it. Generic functions from this series can be
>> reused for fixing vlan and macvlan unicast.
> 
> This is a bug fix but targetted at net-next, and indeed it is quite
> invasive as it adds new core infrastructure and converts the generic
> vlan code over to using it.
> 
> Unfortunately net-next is closed.
> 
> So if you want this bug fixed in mainline you will have to come up
> with a less invasive fix, and resubmit this net-next approach when the
> net-next tree opens back up.

I think it's ok to wait as this issue was always here, so it's not critical.

-- 
regards,
-grygorii
