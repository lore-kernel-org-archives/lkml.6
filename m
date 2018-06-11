Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Q9mEHXoaHlsZGAAAmS7hNA
	; Mon, 11 Jun 2018 06:46:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D1D3A607BB; Mon, 11 Jun 2018 06:46:16 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HBiy+2RU"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4D1CF600D0;
	Mon, 11 Jun 2018 06:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D1CF600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754068AbeFKGqM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 02:46:12 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:38236 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753974AbeFKGqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 02:46:10 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelnx194.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5B6jXb7018436;
        Mon, 11 Jun 2018 01:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528699533;
        bh=rmM8FIsoOqMYX9eAs1e9A5xt38/N4GcVQNl9NWSst4I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HBiy+2RUfG1qQUWRPvTpIrebn6lNzNFE0Ca0d4H3PtQkHpvO14w4zpIr8jCJVRCrx
         T3jd77K5cZDeP4RkfOoKbkxoql7GSVJtrVBA8egHyyjkruu2xiabzpFsEmSslQqBw6
         +PdwxTqcLyQoC/tPQNrv5DuPhF2cO8RPvMpQ+NPA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5B6jXuL022752;
        Mon, 11 Jun 2018 01:45:33 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 11
 Jun 2018 01:45:33 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 11 Jun 2018 01:45:33 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5B6jTRh007415;
        Mon, 11 Jun 2018 01:45:30 -0500
Subject: Re: [PATCH v3 4/6] bus: ti-sysc: Add support for software reset
To: Tony Lindgren <tony@atomide.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <mark.rutland@arm.com>,
        <paul@pwsan.com>, <t-kristo@ti.com>, <robh+dt@kernel.org>,
        <bcousson@baylibre.com>
References: <20180606060826.14671-1-faiz_abbas@ti.com>
 <20180606060826.14671-5-faiz_abbas@ti.com>
 <20180607073530.GH5738@atomide.com>
 <a169ba7f-53f2-cf9a-a9ee-daffd6b53279@ti.com>
 <20180608062158.GI5738@atomide.com>
 <acdfef83-8778-e8f4-e423-ed04a9a8a649@ti.com>
 <20180611060957.GN5738@atomide.com>
 <f460481f-85a9-2a41-a894-6f25122dee8a@ti.com>
 <20180611062904.GO5738@atomide.com>
From: Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <89d55b0b-fe9e-793b-2694-25755ac2bc15@ti.com>
Date: Mon, 11 Jun 2018 12:17:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180611062904.GO5738@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 11 June 2018 11:59 AM, Tony Lindgren wrote:
> * Faiz Abbas <faiz_abbas@ti.com> [180611 06:28]:
>> Great. I thought I completely misunderstood you. But I don't see what
>> adding another function will accomplish. A QUIRK flag used in the same
>> function would work well enough>
> Fine with me as long as the function stays simple for both
> syss and sysc reset.
>


In general a reset status bit being in sysstatus is the norm and it
being in sysconfig should be the "quirk" for which a flag needs to be
added. What do you think?

As an aside, naming bitshifts by the name of the platform they were
originally added in seems weird. There should be some generic mask
saying "soft reset is the 0th bit". Currently I am using
SYSC_OMAP4_SOFTRESET for a dra76x module. I guess it depends on how many
different sysconfig types we have.

Thanks,
Faiz
