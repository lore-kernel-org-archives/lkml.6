Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542FDECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0A5214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Nu9yMYs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0A5214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732915AbeITWvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:51:08 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44136 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbeITWvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:51:07 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8KH4xP2051497;
        Thu, 20 Sep 2018 12:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537463099;
        bh=b5O4w94pcZaN7I6SE+QYpvIa+e32+mEWKpBovrBSKyk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Nu9yMYs6QmWHjODAJ3tr9WF1EbucmqmpaErSIm+gV8ns0H311j4xe/RMQkZz1lIuT
         AsuivnYZ7NDX4w2xzxY2w0PX1ggxUZ5dYkKqMbjeBuf+2JoHSimTCuIVY1bHOnw+Jr
         YVAV+pj/fOP4OBZBj5XNYXlCFURPWGOFMA5yzvEE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8KH4xmg019363;
        Thu, 20 Sep 2018 12:04:59 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 20
 Sep 2018 12:04:59 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 20 Sep 2018 12:04:58 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8KH4w9C030758;
        Thu, 20 Sep 2018 12:04:58 -0500
Subject: Re: [PATCH net-next 00/22] net: fix return type of ndo_start_xmit
 function
To:     YueHaibing <yuehaibing@huawei.com>, <davem@davemloft.net>,
        <dmitry.tarnyagin@lockless.no>, <wg@grandegger.com>,
        <mkl@pengutronix.de>, <michal.simek@xilinx.com>,
        <hsweeten@visionengravers.com>, <madalin.bucur@nxp.com>,
        <pantelis.antoniou@gmail.com>, <claudiu.manoil@nxp.com>,
        <leoyang.li@nxp.com>, <linux@armlinux.org.uk>, <sammy@sammy.net>,
        <ralf@linux-mips.org>, <nico@fluxnic.net>,
        <steve.glendinning@shawell.net>, <f.fainelli@gmail.com>,
        <w-kwok2@ti.com>, <m-karicheri2@ti.com>, <t.sailer@alumni.ethz.ch>,
        <jreuter@yaina.de>, <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <wei.liu2@citrix.com>, <paul.durrant@citrix.com>,
        <arvid.brodin@alten.se>, <pshelar@ovn.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-can@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-mips@linux-mips.org>,
        <linux-omap@vger.kernel.org>, <linux-hams@vger.kernel.org>,
        <devel@linuxdriverproject.org>, <linux-usb@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <dev@openvswitch.org>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <46f95cf9-8f8f-e3ab-3142-947faeee9fa9@ti.com>
Date:   Thu, 20 Sep 2018 12:04:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920123306.14772-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/20/2018 07:32 AM, YueHaibing wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, so make sure the implementation in
> this driver has returns 'netdev_tx_t' value, and change the function
> return type to netdev_tx_t.
> 

May be I missed smth, but it's acceptable to report standard error codes from
.xmit() callback as per dev_xmit_complete().

-- 
regards,
-grygorii
