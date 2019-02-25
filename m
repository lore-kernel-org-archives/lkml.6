Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AC8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9C520652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X54mfXg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbfBYVns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:43:48 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39184 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732019AbfBYVa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:30:58 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1PLU3JU058421;
        Mon, 25 Feb 2019 15:30:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551130203;
        bh=krOg0WhCAdgB24Ail2cnj3gYxCM5OGHOHTKVJUTCvMU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=X54mfXg3v/yN/I7Eqs4V2DmG9OhXM3HmBVxbmrXB74Cu7mfRBgAW56FrGdhYQYo4x
         HhhONPMWs6z7Zz8YAMdww9IY+r3SO1m/YcmAmujmvR5BvMFkDY6xO2Yp+bNUz9RMwc
         KsbTBdmbDsclRulxLfndPrpSe44vPZLnvDkXDwtU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1PLU28g044121
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Feb 2019 15:30:02 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 25
 Feb 2019 15:30:01 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 25 Feb 2019 15:30:01 -0600
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1PLU1rn013519;
        Mon, 25 Feb 2019 15:30:01 -0600
Subject: Re: [PATCH 2/4] bus: ti-sysc: Add support for PRUSS SYSC type
To:     Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@ti.com>
CC:     <tony@atomide.com>, <nsekhar@ti.com>, <linux-omap@vger.kernel.org>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <david@lechnology.com>,
        <woods.technical@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1549295637-24890-1-git-send-email-rogerq@ti.com>
 <1549295637-24890-3-git-send-email-rogerq@ti.com>
 <20190225212600.GA12346@bogus>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <0d071f1e-d3ad-9c1c-fb8f-9076df365a5e@ti.com>
Date:   Mon, 25 Feb 2019 15:30:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190225212600.GA12346@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2/25/19 3:26 PM, Rob Herring wrote:
> On Mon, Feb 04, 2019 at 05:53:55PM +0200, Roger Quadros wrote:
>> The PRUSS module has a SYSCFG which is unique. Add
>> support for it.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/bus/ti-sysc.c                 | 77 +++++++++++++++++++++++++++++++++++
>>  include/dt-bindings/bus/ti-sysc.h     | 11 -----
> 
> Did you intend to remove what you just added?

This series is not complete, and we will submitting another version once
the issues with AM335x and AM437x are sorted out. Please ignore this.

regards
Suman

> 
>>  include/linux/platform_data/ti-sysc.h |  1 +
>>  3 files changed, 78 insertions(+), 11 deletions(-)

