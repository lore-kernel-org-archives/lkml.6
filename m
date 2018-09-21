Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B076ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D0A2154F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gSWqBVC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D0A2154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391406AbeIVBrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:47:00 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:36570 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390726AbeIVBrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:47:00 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8LJuEal036473;
        Fri, 21 Sep 2018 14:56:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537559774;
        bh=15vwSOaZDLUUKNk8nXl9KPoflrcd2a3mkbul84AL0B4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=gSWqBVC203IKvS8LRBKx4l7lDUgshdFhSX7EnAFIhzkQz6gnw7TxDcEmV9qqxW2ag
         0aI/8ce5Fu/AB55SLAfi8nHLefTjf0/vm3uNtjYGriWQHRYMImKX43KZljU4olqVUA
         CFej/6akkMftAiVtsiY1BxohQSVhwZyom7ZqQaX0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LJuE3Z026141;
        Fri, 21 Sep 2018 14:56:14 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 21
 Sep 2018 14:56:14 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 21 Sep 2018 14:56:14 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LJuDps011238;
        Fri, 21 Sep 2018 14:56:13 -0500
Date:   Fri, 21 Sep 2018 14:56:13 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <t-kristo@ti.com>,
        <tony@atomide.com>
Subject: Re: [PATCH] drivers: mailbox: Make ti-msgmr driver depend on ARCH_K3
Message-ID: <20180921195613.o55p5j6cil75k24d@kahuna>
References: <20180828005311.8529-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180828005311.8529-1-nm@ti.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 00:53-20180828, Nishanth Menon wrote:
> ti-msgmr driver can support K3 platforms as well.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
Jassi,
I am assuming as usual, you'd pick it up in v4.19-rc8 or nearabouts..
Just checking to make sure you have no objections.

Regards,
Nishanth Menon
