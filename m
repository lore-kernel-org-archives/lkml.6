Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF49C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE051222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="K0wZ9UJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502142AbfBNPb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:31:29 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:52378 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbfBNPb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:31:28 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 2883010C150E;
        Thu, 14 Feb 2019 07:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1550158288; bh=gHIPm80IUSLZcW5vAWa5DSVuzQ4+taDlm71Oi3DhJek=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=K0wZ9UJ2GbqpwdZd+H9uKU6d3LLD+E/jU4f8TjS6B4ES5nE0zzpv0UnX0X6pJ6zoc
         yW2hY6I7TfiGYUtqUeCb1RCjdxav8VcjGV85DW64/ypbqm7O5aMcUqc5uAY2J2cpM0
         WbcGSk+Irr4joTz4NZXNv80oKD+f2wFJtZub+vT8SlLVZL3kpAc8SX4YlypT72fhAQ
         j49ws27Im+9uERTirzm1v8R03ROohBMU64EPNMJAWMz5UVvsJOp49sZkJEdi08BC3D
         dOD1ZJiLVctv63lrKNUta2XCFL5rWzw40z0iqctlWwYZ78R4gcQHv2Yjn0/MZXq9PQ
         nqGke5aFDJoSw==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id BD4BEA0091;
        Thu, 14 Feb 2019 15:31:27 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 14 Feb 2019 07:30:48 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 14 Feb 2019 16:30:46 +0100
Received: from [10.107.19.176] (10.107.19.176) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 14 Feb 2019 16:30:45 +0100
Subject: Re: [net-next, PATCH] net: stmmac: use correct define to get rx
 timestamp on GMAC4
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1550153571-14404-1-git-send-email-alexandre.torgue@st.com>
 <7c03dff4-5185-dbd2-eeb4-867972512f2b@synopsys.com>
 <a62c35de-7afa-14ec-5ca6-05bd61b6d09d@st.com>
From:   Jose Abreu <jose.abreu@synopsys.com>
Message-ID: <478975ee-2254-96f2-be45-ab4e9539ad08@synopsys.com>
Date:   Thu, 14 Feb 2019 15:30:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <a62c35de-7afa-14ec-5ca6-05bd61b6d09d@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.107.19.176]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/2019 3:00 PM, Alexandre Torgue wrote:
> Hi Jose
> 
> On 2/14/19 3:18 PM, Jose Abreu wrote:
>> Hi Alexandre,
>>
>> On 2/14/2019 2:12 PM, Alexandre Torgue wrote:
>>> In dwmac4_wrback_get_rx_timestamp_status we looking for a RX
>>> timestamp.
>>> For that receive descriptors are handled and so we should use
>>> defines
>>> related to receive descriptors. It'll no change the functional
>>> behavior
>>> as RDES3_RDES1_VALID=TDES3_RS1V=BIT(26) but it makes code
>>> easier to read.
>>>
>>> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
>>>
>>> diff --git
>>> a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
>>> b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
>>> index 20299f6..9f062b3 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
>>> @@ -268,7 +268,7 @@ static int
>>> dwmac4_wrback_get_rx_timestamp_status(void *desc, void
>>> *next_desc,
>>>       int ret = -EINVAL;
>>>         /* Get the status from normal w/b descriptor */
>>> -    if (likely(p->des3 & TDES3_RS1V)) {
>>> +    if (likely(p->des3 & RDES3_RDES1_VALID)) {
>>
>> Shouldn't this also use le32_to_cpu() like bellow ?
> 
> I agree. I focused on cosmetic but yes you are right, we have to
> take car about endianness as this IP is used by different
> processors (using different endianness). I gonna send a v2.
> I think dwmac4_rx_check_timestamp have the same kind of issue.
> Another patch should be sent for it. no ?

Yeah. Maybe you can send all of that in this v2 patch also ?

Thanks,
Jose Miguel Abreu

> 
> regards
> Alex
> 
> 
> 
>>
>> Thanks,
>> Jose Miguel Abreu
>>
>>>           if (likely(le32_to_cpu(p->des1) &
>>> RDES1_TIMESTAMP_AVAILABLE)) {
>>>               int i = 0;
>>>  
