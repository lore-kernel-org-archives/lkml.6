Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E597C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC79206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbeLNU4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:56:06 -0500
Received: from gateway20.websitewelcome.com ([192.185.47.18]:43742 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730848AbeLNU4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:56:05 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id BC61A400D4FFE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 14:56:04 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id XuVAgIZBF2PzOXuVAg49y9; Fri, 14 Dec 2018 14:56:04 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=51702 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gXuV7-001GHR-4D; Fri, 14 Dec 2018 14:56:01 -0600
Subject: Re: [PATCH v2 3/3] PCI: imx: Add support for i.MX8MQ
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-pci@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
        cphealy@gmail.com, l.stach@pengutronix.de,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
References: <20181206073545.10967-1-andrew.smirnov@gmail.com>
 <20181206073545.10967-4-andrew.smirnov@gmail.com>
 <20181214203042.GC20725@google.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <aacb613f-ad8b-8db9-1c63-a346ac62c772@embeddedor.com>
Date:   Fri, 14 Dec 2018 14:55:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181214203042.GC20725@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.106.44
X-Source-L: No
X-Exim-ID: 1gXuV7-001GHR-4D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.106.44]:51702
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/14/18 2:30 PM, Bjorn Helgaas wrote:
> [+cc Gustavo for fallthrough annotation]

> 
>> @@ -301,6 +312,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>>   
>>   	switch (imx6_pcie->variant) {
>>   	case IMX7D:
>> +	case IMX8MQ: /* FALLTHROUGH */
>>   		reset_control_assert(imx6_pcie->pciephy_reset);
>>   		reset_control_assert(imx6_pcie->apps_reset);
>>   		break;
> 
> I'm not an expert on fallthrough annotation (Gustavo, cc'd, is), but
> this looks wrong.  It's the IMX7D case that falls through, not the
> IMX8MQ case.
> 

Correct.

> The recent annotations added by Gustavo are at the point where the
> "break" would normally be, e.g.,
> 
>    case IMX7D:
>      /* fall through */                    <--- annotation
>    case IMX8MQ:
>      <code>
>      break;
> 
> But in this case there's actually no IMX7D-specific *code* there, so I
> suspect the annotation is unnecessary.  It's obvious that IMX7D and
> IMX8MQ are handled the same, so there's really no opportunity for the
> "forgotten break" mistake -Wimplicit-fallthrough is trying to find.
> 

Yep. That's correct. There is no need for those annotations in this patch.

> If we *do* want this annotation, we should spell it the same as
> Gustavo has been, i.e., "fall through".
> 

This is a matter of style. For -Wimplicit-fallthrough, "FALLTHROUGH" is 
as valid a "fall through".

Although, currently, there are 1997 instances of "fall through" vs 235 
of "FALLTHROUGH" in linux-next.

Thanks
--
Gustavo

