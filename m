Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADD4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827DE20861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NkwMutqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827DE20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632709AbeKXBxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:53:06 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60228 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394903AbeKXBxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:53:06 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wANF86Pm087087;
        Fri, 23 Nov 2018 09:08:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542985686;
        bh=sfdosebBKFm/dhrCAv03HlDg60dJh+kc+LAY8d6MdgY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=NkwMutqZUqInNXdgt9IyB5dMQaxic5z4EXMjbbQCdzBba4hbpq1gzgfEU8xGfdvgs
         gpvbqeDs/zzsRFrMDuJdYHJVshapsfFyHZncoq+YOX/OhJz5cesaWmmDBxOE2ql1TN
         NRAucxL+PlnqOvC7aIxdXSPmHFqMWbys+RIK45ww=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wANF861v035230
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Nov 2018 09:08:06 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 23
 Nov 2018 09:08:06 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 23 Nov 2018 09:08:06 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wANF85Ko016616;
        Fri, 23 Nov 2018 09:08:05 -0600
Date:   Fri, 23 Nov 2018 09:07:41 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <t-kristo@ti.com>
CC:     Vignesh R <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: pinctrl: k3: Introduce pinmux
 definitions
Message-ID: <20181123150741.yuxhvvysdw2mrjbf@kahuna>
References: <20181113060111.16374-1-vigneshr@ti.com>
 <20181113060111.16374-2-vigneshr@ti.com>
 <20181117160502.dhlqbx5qnmdp5iog@kahuna>
 <b8c1d975-2b4f-5530-2089-dc04c04f8d86@ti.com>
 <12c1d6e2-aba4-be0d-bfc5-1fb5d3ab45f8@ti.com>
 <9f87eb33-45b4-905a-2afd-5bbb450fc6c6@ti.com>
 <a411e291-d02d-064e-d08c-9ab7a1b1409e@ti.com>
 <0b796f85-5002-8eca-3e51-de239f7b3b41@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0b796f85-5002-8eca-3e51-de239f7b3b41@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:21-20181123, Tero Kristo wrote:
> > > > Is there a branch with these patches that I can use as base for my next
> > > > set of DT patches?
> > > 
> > > Don't have a branch for these atm, but I can create one if you need it.
> > 
> > Yes, that would be great. Thanks!
> > 
> 
> Pushed 4.20-rc1-am65x-queue into my public tree.

I wonder if we can put up a next branch that is available in linux-next
tree? I think it might be a little more convenient for many folks..

-- 
Regards,
Nishanth Menon
