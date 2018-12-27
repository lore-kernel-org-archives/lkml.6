Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40EEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 16:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719B320879
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 16:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="Lf9ivfN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbeL0Q2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 11:28:14 -0500
Received: from vern.gendns.com ([98.142.107.122]:40948 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbeL0Q2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 11:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=y+kGUCB1+8fLhg3IJ1Z6BZFbVIcGq1DOLF8KUZUsMr8=; b=Lf9ivfN73Gud5qzSgvduC8rfvY
        FYaBJVqUCTAxKZi60cLYyZkb5PBJeldc4sh9S2xR24Dpr4CafigbQC9GMdpe1yYh1qCaRFptijHlC
        6TITKyBswQQh486oczWIWDxIKGJQB1WVejPEXVIGJzZWYo3hnvQ7KkkNq7VWwx82piT+5guoTr131
        7fkedLVWc6y84fO31zHKXsb47JoOpJ1JVGX3xyt6b2ODSC7cXL1kcgDKDDzYI6hqzhUXvV+ssOXCn
        5Kh63lOp44G0jTW2VsPIP5e//EvEjKYlGDxs3IJz7QAHlzJQNfQjFKQi1baDrCd7bTC8LZbn50rnd
        brpoKPEA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:48608 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gcYU2-0003Qs-BW; Thu, 27 Dec 2018 11:26:06 -0500
Subject: Re: [PATCH v1 7/7] drm: remove include of drmP.h from
 drm_gem_cma_helper.h
To:     Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Alexey Brodkin <abrodkin@synopsys.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20181226210215.GA27610@ravnborg.org>
 <20181226210353.13993-7-sam@ravnborg.org>
From:   David Lechner <david@lechnology.com>
Message-ID: <6c792214-ed92-e942-0e3d-72628c037d00@lechnology.com>
Date:   Thu, 27 Dec 2018 10:28:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181226210353.13993-7-sam@ravnborg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/18 3:03 PM, Sam Ravnborg wrote:
> Fix fallout in various files/drivers.
> 

What fallout is being fixed? It would be helpful if we received the full
patch series for context. It would also be nice to have a more detailed
description in this commit message.

