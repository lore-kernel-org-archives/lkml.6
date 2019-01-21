Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FFEC2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C128C20823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k/upCbL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbfAUPSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:18:11 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48554 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729739AbfAUPSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:18:10 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0LFI5La100091;
        Mon, 21 Jan 2019 09:18:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548083885;
        bh=GJHellUMuPpm46jHno8omFFja4yDJet75xcqY99T7lw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=k/upCbL8BkykidXHub7XrE90/Wp2MS3q3+mEFmheU3/kHasgUV7S2oA98gSqfkmLL
         gT/fT7ZeFYgA5fJ2XPp5I7wB/JICKCPmLmv4v4IRl6xk/m6UY5eTCDX972EWMuZwqn
         Hn6ccS7MlQAeSMjjt+gp8Pa25yfNmpeYclYtLVkY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0LFI4g7055898
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 09:18:04 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 21
 Jan 2019 09:18:04 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 21 Jan 2019 09:18:04 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0LFI4uS015434;
        Mon, 21 Jan 2019 09:18:04 -0600
Date:   Mon, 21 Jan 2019 09:18:04 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] Documentation: dt: Add binding info for
 jz4740-musb driver
Message-ID: <20190121151804.GB30080@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Cercueil <paul@crapouillou.net>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190117223330.16631-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190117223330.16631-1-paul@crapouillou.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 07:33:27PM -0300, Paul Cercueil wrote:
> This commit adds documentation for the device-tree bindings of the
> jz4740-musb driver, which provides support for the USB gadget mode
> of the JZ4740 and similar SoCs from Ingenic.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Rob Herring <robh@kernel.org>

The series is applied. Thanks.

Regards,
-Bin.
