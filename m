Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931ECC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12977204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bzI0XMON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12977204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbeH2Rx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:53:58 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:59088 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeH2Rx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:53:57 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id AB23724E1320;
        Wed, 29 Aug 2018 06:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535551013; bh=NCWt/tzj0Oac1n5RpcxhusXZRwL+RpTVxx9LSZxEOPI=;
        h=Subject:To:References:CC:From:Date:In-Reply-To:From;
        b=bzI0XMONZlZO1uJtMFtRKRLiwNDl446zL9ShbPxvm2iM4BqwyI+TyHN6CB9HTtnhK
         /A768H1RiTEip/qV05uhftc5BAkCm0TPejInJ2Aq6JIUP8ST98HhKHflJ5QAaPlAz0
         g+syP6vZt/IQ9jkmPyqXAw5gwS3G1/7BM9y9aT64PXmBdU6XOl/Ub19sZWgU6vpGQz
         jTbkQ6D6pCiyBr0r7r2zgQYZFYcmvu5PkKQ8Lf8hgYNttyylc/3PEMOwaWIfl5HFsd
         D021Ba0Vk92TGTgqx1Ju+yeqU5wFOYInQNMNq0D5WnCzQMlI7WDx8v+6d/GvRnann7
         NhbXxcPKqIVow==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id E7913353D;
        Wed, 29 Aug 2018 06:56:52 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 29 Aug 2018 06:56:52 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 29 Aug 2018 15:56:50 +0200
Received: from [10.0.2.15] (10.107.19.14) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 29 Aug
 2018 15:56:50 +0200
Subject: Re: [PATCH] Revert "net: stmmac: Do not keep rearming the coalesce
 timer in stmmac_xmit"
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "Jose Abreu" <Jose.Abreu@synopsys.com>, <netdev@vger.kernel.org>
References: <20180824090440.13411-1-jbrunet@baylibre.com>
 <d3858ef0-97c7-28b5-db4a-4ac71af52ba5@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>
From:   Jose Abreu <Jose.Abreu@synopsys.com>
Message-ID: <9a91148c-ed8e-a7ce-d37d-61b3fd6d455c@synopsys.com>
Date:   Wed, 29 Aug 2018 14:56:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <d3858ef0-97c7-28b5-db4a-4ac71af52ba5@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.14]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

++ Martin

Hi Martin,

I just saw you have the same problem as Jerome. Can you please
share the information I mention bellow?

Thanks and Best Regards,
Jose Miguel Abreu

On 28-08-2018 09:12, Jose Abreu wrote:
> Hi Jerome,
>
> On 24-08-2018 10:04, Jerome Brunet wrote:
>> This reverts commit 4ae0169fd1b3c792b66be58995b7e6b629919ecf.
>>
>> This change in the handling of the coalesce timer is causing regression on
>> (at least) amlogic platforms.
>>
>> Network will break down very quickly (a few seconds) after starting
>> a download. This can easily be reproduced using iperf3 for example.
>>
>> The problem has been reported on the S805, S905, S912 and A113 SoCs
>> (Realtek and Micrel PHYs) and it is likely impacting all Amlogics
>> platforms using Gbit ethernet
>>
>> No problem was seen with the platform using 10/100 only PHYs (GXL internal)
>>
>> Reverting change brings things back to normal and allows to use network
>> again until we better understand the problem with the coalesce timer.
>>
>>
> Apologies for the delayed answer but I was in FTO.
>
> I'm not sure what can be causing this but I have some questions
> for you:
>     - What do you mean by "network will break down"? Do you see
> queue timeout?
>     - What do you see in ethtool/ifconfig stats? Can you send me
> the stats before and after network break?
>     - Is your setup multi-queue/channel?
>     - Can you point me to the DT bindings of your setup?
>
> Thanks and Best Regards,
> Jose Miguel Abreu

