Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29E7C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9497C205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VZmb3ri+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9497C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeJVQcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:32:20 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43468 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbeJVQcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 12:32:20 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9M8EDmW013353;
        Mon, 22 Oct 2018 03:14:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1540196053;
        bh=6toUm9sVuR5/fbZ5FMP5fsg3n7mUeRRquVSOLSJRxm0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VZmb3ri+5aV5Xi2Y/M2JRcynq0f89rzh6NI/tXUCh/iRJFvW08V0essupyRnUtgwq
         kw8W74AXXu3jHWICNTUcbviY+Hu9G5CLD9OJksOkldNzbieuIWE50jjPyQwn6GYaOZ
         rXup7OBNvE8sLwWGORM45E3ugQikVsWf3wTIpVv4=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9M8EClv013349;
        Mon, 22 Oct 2018 03:14:12 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 22
 Oct 2018 03:14:10 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 22 Oct 2018 03:14:10 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9M8E76d003763;
        Mon, 22 Oct 2018 03:14:08 -0500
Subject: Re: omap4: support for manually updated display
To:     Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Pavel Machek <pavel@ucw.cz>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <nekit1000@gmail.com>,
        <mpartap@gmx.net>, <merlijn@wizzup.org>
References: <20180830090456.GA17277@amd>
 <797c13fa-7a5b-a809-7dd0-14b01a3046be@ti.com> <3205865.8O8aibZXye@avalon>
 <20180910174453.GV5662@atomide.com> <20181018221549.GB6364@amd>
 <20181019164450.GD43338@atomide.com>
 <20181019225827.s76wapp3cxrmp5af@earth.universe>
 <20181020003812.GE43338@atomide.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <6ebd84ad-3428-c2f5-da8b-e5b1c54ea5e2@ti.com>
Date:   Mon, 22 Oct 2018 11:14:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20181020003812.GE43338@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/18 03:38, Tony Lindgren wrote:
> * Sebastian Reichel <sre@kernel.org> [181019 15:58]:
>> I uploaded my current status here. It's not based on the newest
>> -next, but contains the interesting patches from Laurent. Also
>> the last few patches are not yet cleaned up, sorry for the mess.
> 
> Way to go, thanks :) Here's a quick fix for issues with loading
> and unloading modules, seems like this should be fixed somewhere
> else though?

I didn't get that far on drm-next with pandaboard. When loading modules, dsi_probe crashes. It is missing runtime_get(). But after adding runtime_get call, it fails and I see:

[   44.671081] omap_hwmod: dss_dsi2: _wait_target_ready failed: -16
[   44.677459] omapdss_dsi 58005000.encoder: use pm_runtime_put_sync_suspend() in driver?

Why is dsi2 busy (and what does it even mean)...

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
