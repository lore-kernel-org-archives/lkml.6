Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF837C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D1921899
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nqEzrhMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D1921899
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbeHMSIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:08:55 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53062 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbeHMSIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:08:55 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7DFQAs3100017;
        Mon, 13 Aug 2018 10:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1534173970;
        bh=zBcP5u3Xours4paJTyWyfAAdZ4SsFPqBkTPcYEydjoY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nqEzrhMRV5H6yE+K8YA8Xk6Sp5enAgbUOsLWkZcXnqPUxKOtiSOCMs50nFrBBqfDD
         soogXsm9GOKr74QzdH8dhXFsHttfOUKTbOqZ7yCaq8QSwqnHNFxO6szia3gfvnpcZj
         yR/MHPEPVNNzMkIxKoxO6qjTLujJmmerGNip9gkY=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7DFQAGw009535;
        Mon, 13 Aug 2018 10:26:10 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 13
 Aug 2018 10:26:09 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 13 Aug 2018 10:26:09 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7DFQ71h010458;
        Mon, 13 Aug 2018 10:26:07 -0500
Subject: Re: [PATCH v3 0/4] clk: clk: Add functions to save/restore clock
 context en-masse
To:     Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>
CC:     <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <d-gerlach@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1529568907-19930-1-git-send-email-j-keerthy@ti.com>
 <20180710055605.GF99251@atomide.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <ff0fdd50-a674-9475-290a-053ebf415ff8@ti.com>
Date:   Mon, 13 Aug 2018 18:25:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180710055605.GF99251@atomide.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/18 08:56, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [180621 01:18]:
>> Deep enough power saving mode can result into losing context of the clock
>> registers also, and they need to be restored once coming back from the power
>> saving mode. Hence add functions to save/restore clock context.
> 
> Patches 1 to 3 look good to me:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Stephen, if no more comments, can you please set up an immutable
> branch for me as otherwise the last patch might cause merge
> conflicts?
> 
> Regards,
> 
> Tony
> 

Stephen, Mike,

Any concerns about this series? This series touches core clock APIs 
slightly, but from my side these look fine. Do you want to pick #1-#3 up 
yourself or do you want me to setup a pull-req? Patch #4 seems like 
should go in via Tony's tree.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
