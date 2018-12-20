Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6264C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A422176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D9Q9GkTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbeLTJDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:03:34 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60166 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbeLTJDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:03:34 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBK931PR046797;
        Thu, 20 Dec 2018 03:03:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545296581;
        bh=je64GQv5fkJQoxiJSkHiUO/szatxLAvDbpDZvhS7foU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=D9Q9GkTpcvHaTnr5n4jzu3X+uz0yZksXlwz7RTWYhqyZt7K9BSAlE9YyXex/ZsMX6
         1034KDRQgSVTEBrglYomn3DhhgnFsABARVeH4JutndofESAzGWz6a7yDdxIC9jcmCH
         6fqW4HF6TEYTXinqMFi7Em7CIxO07IfztEIkruqU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBK93189026475
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Dec 2018 03:03:01 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 20
 Dec 2018 03:03:00 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 20 Dec 2018 03:03:00 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBK92vPn030184;
        Thu, 20 Dec 2018 03:02:57 -0600
Subject: Re: [PATCH 0/9] ASoC/ARM: Merge the davinci and omap audio
 directories
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <jarkko.nikula@bitmer.com>, <tony@atomide.com>
CC:     <alsa-devel@alsa-project.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jsarha@ti.com>
References: <20181217122142.6652-1-peter.ujfalusi@ti.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <4c9085db-3c55-49ee-30d3-46dca84e28ca@ti.com>
Date:   Thu, 20 Dec 2018 14:32:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181217122142.6652-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/18 5:51 PM, Peter Ujfalusi wrote:
> Mark, Tony, Sekhar: This series - as I mentioned - is based on next-20181210.
> Not sure what tag, branch, commit  I should base this, but I can resend v2 if
> needed.

For the series:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Looks like Mark has already applied it, but just for the record.

Thanks,
Sekhar
