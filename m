Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE3FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A0120821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NC2b1aoQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A0120821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbeKADhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:37:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50220 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730334AbeKADhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:37:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9VIYWtf173658;
        Wed, 31 Oct 2018 18:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=W3t2f2bAdmcADwFbXMNRdktXIiBY2gNdqS+7vxDZuSQ=;
 b=NC2b1aoQMHRIkQIRqr81MQedctFvMWuxs5KDBqryglFuTmYfa4BhSN/ubSxRalirD6y8
 68XPu4J3L7mDka3snGD6+tJtZao3++7s9n2QdHdlHfDlXggiEl9b9LxoHSgSRKIm3joV
 P5km5AJ+arexpFLk5NWnWX+d2SMMxYeNoeAXhfrQwoR9kJyEy/JjXN2aonaWBWZtikxi
 GGUf9WsSwn3XjwzsQIKVUBOq3716nYNU/LiOJWiJz6gRHzflWTFzCiNgMM27BKA9wTRp
 qcduCiPQsp5w1AzXireXmM3bs7YEDcD0xK1iQgz0eF8Gz2jmsD13LPolzoZbowklb+Nt 6w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2ncfyq4xh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Oct 2018 18:38:05 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9VIc4cO008204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Oct 2018 18:38:04 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9VIc3Ia019232;
        Wed, 31 Oct 2018 18:38:03 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Oct 2018 11:38:03 -0700
Subject: Re: [PATCH v2 09/10] irqchip: ti-sci-inta: Add support for Interrupt
 Aggregator driver
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, tglx@linutronix.de,
        jason@lakedaemon.net,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
 <20181018154017.7112-10-lokeshvutla@ti.com>
 <b20127dc-be43-3b00-9960-663738df0069@arm.com>
 <9969f24c-cdb0-1f5c-d0f4-b1c1f587325c@ti.com>
 <86va5ssrfm.wl-marc.zyngier@arm.com>
 <2369ea50-55db-c97b-5b43-99d572c97dc9@ti.com>
 <da27ecc5-db32-cf3a-c194-962c44bc782f@arm.com>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <18df8960-9165-ba50-2c25-9f00d32198e8@oracle.com>
Date:   Wed, 31 Oct 2018 11:38:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <da27ecc5-db32-cf3a-c194-962c44bc782f@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9063 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810310152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/2018 11:21 AM, Marc Zyngier wrote:
> Hi Grygorii,
> 

[...]

> 
> Well, I'm convinced that we do not want a networking driver to be tied
> to an interrupt architecture, and that the two should be completely
> independent. But that's my own opinion. I can only see two solutions
> moving forward:
> 
> 1) You make the IA a real interrupt controller that exposes real
> interrupts (one per event), and write your networking driver
> independently of the underlying interrupt architecture.
> 
> 2) you make the IA an integral part of your network driver, not exposing
> anything outside of it, and limiting the interactions with the IR
> *through the standard IRQ API*. You duplicate this knowledge throughout
> the other client drivers.
> 
> I believe that (2) would be a massive design mistake as it locks the
> driver to a single of the HW (and potentially a single revision of the
> firmware) while (1) gives you the required level of flexibility by
> hiding the whole event "concept" at a single location.
> 
> Yes, (1) makes you rewrite your existing, out of tree drivers. Oh well...
> 
My preference is also not tie the network driver with IA. BTW, this is
very standard functionality with other network drivers too. And this
is handled using MSI-X.

So strong NO for 1) from me as well.

regards,
Santosh
