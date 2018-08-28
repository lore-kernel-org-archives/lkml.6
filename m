Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3821EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F77208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aWoxKPc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F77208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbeH1E4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 00:56:38 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50348 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeH1E4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 00:56:38 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7S17GIi099327;
        Mon, 27 Aug 2018 20:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535418436;
        bh=9yquBdzGEgc7ZcjvYmoAM1kFEFE4jC350JAVuUjzyXU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=aWoxKPc0yMeQWlNi71YHtTaPQKWrKz8ZcX4tuticYKocNVQMaUUmWsdrfN2m4ciTZ
         65sBva0LKtqj4761eDL+a8U4xUb+/LejDdW1lOeHX7G/Vjc03O0bbIAoQ9kiWJigIJ
         Oci9iyuK5+vqT95pEGEB34260FCIVGqry5n48e6o=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7S17GDU022219;
        Mon, 27 Aug 2018 20:07:16 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 27
 Aug 2018 20:07:16 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 27 Aug 2018 20:07:16 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7S17G0P024293;
        Mon, 27 Aug 2018 20:07:16 -0500
Date:   Mon, 27 Aug 2018 20:07:16 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V3 0/2] firmware: ti_sci: Add host-id as an optional
 parameter
Message-ID: <20180828010716.sc4ogfvvplvzhs7g@kahuna>
References: <20180828005924.13092-1-nm@ti.com>
 <7a73e77f-b119-89bc-cd0e-bbd6628b1395@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7a73e77f-b119-89bc-cd0e-bbd6628b1395@oracle.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01:05-20180828, Santosh Shilimkar wrote:
> On 8/27/2018 5:59 PM, Nishanth Menon wrote:
> > Hi Santosh,
> > 
> > This is the rebase to v4.19-rc1 and repost of the patch series [1]
> > Please find attached series to enable host-id as an optional dt property.
> > 
> > [1] https://patchwork.ozlabs.org/cover/931822/
> > 
> > No Functional changes. Will be great if we can get this in rc cycle,
> > but, will defer to you.
> > 
> > Nishanth Menon (2):
> >    Documentation: dt: keystone: ti-sci: Add optional host-id parameter
> >    firmware: ti_sci: Provide host-id as an optional dt parameter
> > 
> Yes I had this series bookmarked and was going to merge it now since
> rc1 is out. Will get to it in next few days & it should showup
> in next. But don't plan to send it for rc since its not a regression"
> as such. Thanks for following up Nishant !!

Understood. Thanks, Santosh.
-- 
Regards,
Nishanth Menon
