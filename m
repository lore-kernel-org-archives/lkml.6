Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C1CC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20912146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dJxHMvNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20912146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbeLDFUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 00:20:12 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46748 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbeLDFUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 00:20:11 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB45K7DX084494;
        Mon, 3 Dec 2018 23:20:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543900807;
        bh=A5l27OZIP71eA/WoceQxJ8miPBD66NyGK3x0FcFT7LM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dJxHMvNPEOU3y7ZqCZVCfD0eEx/X2xvsmaEmtjQllfLpS4jDEoQ6q95q8rsDLKt7r
         PqmqE8fxzksckBjeF+zELa8AYlXzN1iB6Ro1EmC9UEKuBUvvvG6W8nhkOTr02Hc5/J
         frl8gBHXnnwZsNxnyPa55UBY4TIDBp2/6RvNpkmY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB45K7Vs056597
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Dec 2018 23:20:07 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 3
 Dec 2018 23:20:06 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 3 Dec 2018 23:20:06 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB45K4Ls027094;
        Mon, 3 Dec 2018 23:20:05 -0600
Subject: Re: [PATCH v2] phy: renesas: rcar-gen3-usb2: follow the hardware
 manual procedure
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
References: <1543561257-27594-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <TY2PR01MB229720D5323203C501260AACD8D30@TY2PR01MB2297.jpnprd01.prod.outlook.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <6886d7a2-6ab6-cecf-cc11-c0da70048bab@ti.com>
Date:   Tue, 4 Dec 2018 10:49:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <TY2PR01MB229720D5323203C501260AACD8D30@TY2PR01MB2297.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/11/18 12:39 PM, Yoshihiro Shimoda wrote:
>> From: Yoshihiro Shimoda, Sent: Friday, November 30, 2018 4:01 PM
>>
> <snip>
>> Also, this is the first email I send after changing the email server
>> to avoid using quoted-printable encoding.
> 
> This seems to work :)
> https://lore.kernel.org/lkml/1543561257-27594-1-git-send-email-yoshihiro.shimoda.uh@renesas.com/raw

merged now, thanks.

-Kishon
> 
> Best regards,
> Yoshihiro Shimoda
> 
