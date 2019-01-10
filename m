Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A326C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E6E214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XRniBWCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfAJNZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:25:01 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43642 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbfAJNZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:25:00 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0ADOVA2025587;
        Thu, 10 Jan 2019 07:24:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547126671;
        bh=Fsf+p+0b4MPsPyVUlJ5ZKx8pYvtVAq5sij65t7K8DGI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XRniBWCGXTD8QWogIxeSGpGoU09zJMGX6CGeijEJgeJRsFVUfpNZUYLG73D5ExsMH
         TxQHzS1Pq5Vf4A3pFck2rHjcASruuQG9AQ5N47DD5KFZrp5oJjE2zn6TtnahoyRvSl
         Nl/prZrPnhi0R8qZG0Q5aT7f1jUZfPDCAUAQfjHc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0ADOVtU102016
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Jan 2019 07:24:31 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 10
 Jan 2019 07:24:31 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 10 Jan 2019 07:24:31 -0600
Received: from [172.24.145.124] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0ADORPW028687;
        Thu, 10 Jan 2019 07:24:28 -0600
Subject: Re: [PATCH 1/3] serial: 8250_omap: Drop check for of_node
To:     Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-serial@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190109091206.25759-1-vigneshr@ti.com>
 <20190109091206.25759-2-vigneshr@ti.com> <20190109214403.GW5544@atomide.com>
 <20190110120758.bz63neey5ztepw4m@earth.universe>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <dbc00a69-2144-6e30-e9b1-4f8ee272ab8a@ti.com>
Date:   Thu, 10 Jan 2019 18:54:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190110120758.bz63neey5ztepw4m@earth.universe>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10-Jan-19 5:37 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Jan 09, 2019 at 01:44:03PM -0800, Tony Lindgren wrote:
>> * Vignesh R <vigneshr@ti.com> [190109 09:11]:
>>> 8250_omap is DT only driver so dev->of_node always exists. Drop check
>>> for existence of valid dev->of_node to simplify omap8250_probe().
>>
>> That part seems safe to me now.
>>
>>> --- a/drivers/tty/serial/8250/8250_omap.c
>>> +++ b/drivers/tty/serial/8250/8250_omap.c
>> ...
>>> -		const struct of_device_id *id;
>>> -
>>> -		ret = of_alias_get_id(pdev->dev.of_node, "serial");
>>> -
>>> -		of_property_read_u32(pdev->dev.of_node, "clock-frequency",
>>> -				     &up.port.uartclk);
>>> -		priv->wakeirq = irq_of_parse_and_map(pdev->dev.of_node, 1);
>>> -
>>> -		id = of_match_device(of_match_ptr(omap8250_dt_ids), &pdev->dev);
>>> -		if (id && id->data)
>>> -			priv->habit |= *(u8 *)id->data;
>>
>> But this part it seems we still need to keep around
>> as we still have lots of clock-frequency references
>> in the *.dtsi files. Or am I missing something?
> 
> It's re-added a couple of lines later. Only the indent was removed.
> 

That's right. You beat me to it. Thanks :)

Regards
Vignesh
