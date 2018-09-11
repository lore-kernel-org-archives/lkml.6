Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88343C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E33820865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tMXJpQkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E33820865
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeIKLqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:46:49 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50450 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbeIKLqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:46:49 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8B6mWek061317;
        Tue, 11 Sep 2018 01:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536648512;
        bh=Ul2xI3bbSQA+/ZiBmLhvkMV7ZzlKr0OMLgIRz4vH9x0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tMXJpQkLor4aEBFCmWAto/ky2aFqWPdcocouPNOT7j+r06y22WpCmcbCLXvCtSizC
         sMPTrpXhJw+MyVr+k8ExR16USIOoe7D/YzCX3pu6K+7ng9WYXFxqU9PaEBk97KMJOo
         QHVWm+nvTT2/2kIJIK0SV1afEgj1wvruEZ/TRdQ8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8B6mWMt026049;
        Tue, 11 Sep 2018 01:48:32 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 11
 Sep 2018 01:48:30 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 11 Sep 2018 01:48:30 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8B6mR2r027665;
        Tue, 11 Sep 2018 01:48:28 -0500
Subject: Re: omap4: support for manually updated display
To:     Tony Lindgren <tony@atomide.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Pavel Machek <pavel@ucw.cz>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <sre@kernel.org>,
        <nekit1000@gmail.com>, <mpartap@gmx.net>, <merlijn@wizzup.org>
References: <20180830090456.GA17277@amd>
 <797c13fa-7a5b-a809-7dd0-14b01a3046be@ti.com> <3205865.8O8aibZXye@avalon>
 <20180910174453.GV5662@atomide.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <42986939-9670-df31-8f30-b0bfbf559d90@ti.com>
Date:   Tue, 11 Sep 2018 09:48:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910174453.GV5662@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/18 20:44, Tony Lindgren wrote:

>> I want to make it clear that I don't want to claim any privilege in getting 
>> patches merged first. I am however worried that, without an easy way to test 
>> DSI support, and without enough time to focus on it, I would break whatever 
>> would be merged now in future reworks. I would thus like to find out how to 
>> collaborate on this task, hopefully to move towards usage of drm_bridge and 
>> drm_panel for DSI-based pipelines.
> 
> Real users with mainline kernel with a real product should
> always have priority over any ongoing clean-up.

If this were cleanup, it would of course be a low priority work. But
this is changing omapdrm to support DRM panels and bridges, which is
needed to support many real products in the mainline kernel.

Droid/N9 are no exceptions here, I have been keeping support for
multiple boards out of mainline for this same reason: I don't want to
add omapdrm specific code that will need to be rewritten and would
complicate this big change. Well, Droid/N9 are different in the sense
that they are much more complex cases than the boards I've been keeping out.

In any case, Laurent was ok with merging the patches, so let's merge
them after rebasing.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
