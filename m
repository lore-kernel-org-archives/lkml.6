Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86028C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 17:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DAA12080D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 17:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="njkX33pq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeLaRvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 12:51:19 -0500
Received: from vern.gendns.com ([98.142.107.122]:39020 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727482AbeLaRvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 12:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hU3v/BaE1auEC5jRsR00M4oFJ6dfjKk478hhTXI50EM=; b=njkX33pqKaARJ98EfdtGo22JdO
        jbWBgBWZ8Ias+eGdZTo+jvn7BGj7XSHbFplIEbdXWB3rrolpO+nYEMBdyvcaG/fErjXvsAl1G+aQ7
        RTSqgl+2aAL1ja6QQSLzwgZYxNbpWCsetPRTE3F6A8PLVgFPfjXc59nIyCSY4l91KfJ27J8AdoaBh
        CyJQnEmr7W41OEL+1jW/FcAjtM2BrbiGwC/xEc/c+CYmFcasgzhgU19aDz/Y7ylk3zTgyNsSE02a/
        p8muLBqY4/0vlpqL6fhqcjO7N9tqRVWGdiWVGSmHuT9C4VQWqdOAIB0Z2Km1/+/pOTuG3XhV2RT1x
        /S0Bxmog==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:43698 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1ge1gU-00007c-3w; Mon, 31 Dec 2018 12:49:02 -0500
Subject: Re: [PATCH v2 13/14] drm/tinydrm: do not reply on drmP.h from
 drm_gem_cma_helper.h
To:     Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Eric Anholt <eric@anholt.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
References: <20181230174838.32330-14-sam@ravnborg.org>
From:   David Lechner <david@lechnology.com>
Message-ID: <edcf6127-376b-7e42-ec95-a5216b168c85@lechnology.com>
Date:   Mon, 31 Dec 2018 11:51:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181230174838.32330-14-sam@ravnborg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

On 12/30/18 11:48 AM, Sam Ravnborg wrote:
> drmP.h was the only header file in the past and a lot
> of files rely on that drmP.h defines everything.
> The goal is to one day to delete drmP.h and
> as a step towards this it will no longer be included in the
> headers files in include/drm/
> 
> To prepare tinydrm/ for this add dependencies that
> othwewise was pulled in by drmP.h from drm_gem_cma_helper.h
> 
> To avoid that tinydrm.h became "include everything",
> push include files to the individual drivers.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: "Noralf Trønnes" <noralf@tronnes.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: David Lechner <david@lechnology.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---

Acked-by: David Lechner <david@lechnology.com>


