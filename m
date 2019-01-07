Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3D0C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51232173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="QTU9A2go"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfAGP7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:59:13 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:33657 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfAGP7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=0TZtFaGPJDLctq4aKx86sEF7MMzw0Zc8M2vOR+23yvA=;
        b=QTU9A2goQ8vxH8t+LoxJCi1ojjYQ1aJC8nEL4wGDcMoKHzZ/2BaOmoEOtWa6KeiVLZ0O99MfUfU5BZkmvdGS7cy8vKduRvYrCr8lQyNdkGIlN2g6RRzDJly1LeTdvVs57/hKLmAIQkcTrGrvmJKEzB1Vv5/4Qpc62AyxB+EqZk6mPVPkIyGw61PY7uevdMRTXMSAA2puxc+43Rft9W5kT42CY9uxzOHpz/W0TJYZ2C/SdBst9l7pSJfT+OvLAlwd/Jz9LeVOvuDJmE+FOhxH7ywdADL2BbqmYWbuxeysd2uEbymN4RzTOMtYunvOkSsv7sOdvWTHX6x8hrUXI2zxhA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:64481 helo=[192.168.10.174])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1ggXJ0-000164-CQ; Mon, 07 Jan 2019 16:59:10 +0100
Subject: Re: [PATCH v2 12/14] drm/stm: do not reply on drmP.h from
 drm_gem_cma_helper.h
To:     Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Yannick Fertre <yannick.fertre@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Philippe Cornu <philippe.cornu@st.com>
References: <20181230174838.32330-13-sam@ravnborg.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <ab7424bd-dcaf-3dbd-9ade-9067831550b3@tronnes.org>
Date:   Mon, 7 Jan 2019 16:59:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181230174838.32330-13-sam@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 30.12.2018 18.48, skrev Sam Ravnborg:
> drmP.h was the only header file in the past and a lot
> of files rely on that drmP.h defines everything.
> The goal is to one day to delete drmP.h and
> as a step towards this it will no longer be included in the
> headers files in include/drm/
> 
> To prepare stm/ for this add dependencies that
> othwewise was pulled in by drmP.h from drm_gem_cma_helper.h
> 
> Sort the include list when we anyway modify it.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Yannick Fertre <yannick.fertre@st.com>
> Cc: Philippe Cornu <philippe.cornu@st.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Vincent Abriou <vincent.abriou@st.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
