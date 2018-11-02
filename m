Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911F3C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491BD2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491BD2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeKBVXt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 17:23:49 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:51068 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726026AbeKBVXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 17:23:49 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 14327656-1500050 
        for multiple; Fri, 02 Nov 2018 12:16:42 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Robert Foss <robert.foss@collabora.com>, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robdclark@gmail.com
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20181102121313.23271-1-robert.foss@collabora.com>
Cc:     Robert Foss <robert.foss@collabora.com>
References: <20181102121313.23271-1-robert.foss@collabora.com>
Message-ID: <154116100076.30246.13155169401499183452@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH v2] drm/msm: Move fence put to where failure occurs
Date:   Fri, 02 Nov 2018 12:16:40 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Robert Foss (2018-11-02 12:13:13)
> If dma_fence_wait fails to wait for a supplied in-fence in
> msm_ioctl_gem_submit, make sure we release that in-fence.
> 
> Also remove this dma_fence_put() from the 'out' label.
> 
> Signed-off-by: Robert Foss <robert.foss@collabora.com>

Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>

Rob, this probably merits a cc:stable tag -- if the wait was interrupted
by a signal, the fence would be leaked.
-Chris
