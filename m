Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F437C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C906C20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HRUlM9ui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C906C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbeIJQxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:53:47 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:36618 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbeIJQxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:53:45 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8ABxS8K040360;
        Mon, 10 Sep 2018 06:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536580768;
        bh=yULmkcuU2Mpij8lywurxqGFbRvD7j6XcIpQGZXB0sN8=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=HRUlM9uiGnuuWEtkjN+8MYZAvjPsiH108qIqXF7cCnGLtGyNapl3U92G5DEYV4xwo
         1q8ipbfLDm0pDaJ0zvoxXKjFKXZ1uToq5QLLnWpubMn5MjkTXQGpeJ0xgjv6Q54brg
         IHcDczOhH8RCiC8DOK4u5OVScMRucMNpoVR6h4Nc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8ABxSU9028277;
        Mon, 10 Sep 2018 06:59:28 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 10
 Sep 2018 06:59:26 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 10 Sep 2018 06:59:26 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8ABxNn3001053;
        Mon, 10 Sep 2018 06:59:24 -0500
Subject: Re: omap4: support for manually updated display
To:     Pavel Machek <pavel@ucw.cz>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <tony@atomide.com>, <sre@kernel.org>,
        <nekit1000@gmail.com>, <mpartap@gmx.net>, <merlijn@wizzup.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20180830090456.GA17277@amd>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <797c13fa-7a5b-a809-7dd0-14b01a3046be@ti.com>
Date:   Mon, 10 Sep 2018 14:59:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830090456.GA17277@amd>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

(dropping Dave, no need to spam him)

On 30/08/18 12:04, Pavel Machek wrote:
> Hi!
> 
> There's neat series of patches on
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?h=droid4-pending-v4.19
> 
> They enable display support for my hardware. As you can imagine,
> display is rather important for a cellphone.
> 
> Tomi, can you take the patches? I can resubmit them in email, or
> shuffle them to another branch without mfd changes, or clean them up
> etc...

A large omapdrm change set from Laurent was merged into drm-next, and
I'm certain they conflict with this series. Laurent also has continued
that work, and while those new patches haven't been sent for review yet,
I fear they'll also conflict with these.

So in the minimum, a rebase on top of drm-next is needed.

I also continue to be very worried that adding DSI support to omapdrm at
this stage will be a huge extra burden for Laurent's work.

We should transform the panel-dsi-cm.c towards the common DRM model.
With a quick look, there seems to be a driver for Samsung's S6E63J0X03
panel. So possibly all the DSI features are there in the DRM framework,
but someone needs to check that and start working on panel-dsi-cm.c so
that it's ready when we finally switch to the DRM model.

In my opinion, which I've also expressed before, the above work is much
easier to do by first changing the omapdrm to DRM model, without any DSI
displays, and then add the DSI command mode support. But if people
insist on adding the DSI support already now, I would appreciate the
same people working on the DSI support so that Laurent doesn't have to
do it all.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
