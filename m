Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88042C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6E82146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A6E82146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388971AbeK3Bg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:36:28 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:51088 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbeK3Bg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:36:27 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-MBX-04.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gSNL9-0005oT-PR from Ahsan_Hussain@mentor.com ; Thu, 29 Nov 2018 06:30:51 -0800
Received: from [137.202.157.113] (137.202.0.90) by
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Thu, 29 Nov 2018 14:30:47 +0000
To:     <dri-devel@lists.freedesktop.org>
CC:     <linux-kernel@vger.kernel.org>
From:   Ahsan Hussain <ahsan_hussain@mentor.com>
Subject: drm: understanding the kernel warning during drm_vblank_cleanup()
Organization: Mentor Graphics
Message-ID: <6198455d-59b4-c4b0-94c1-6e0d460f2451@mentor.com>
Date:   Thu, 29 Nov 2018 19:30:45 +0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I'm new to DRM and trying to understand the warning in 
drivers/gpu/drm/drm_vblank.c during drm_vblank_cleanup().

WARN_ON(READ_ONCE(vblank->enabled) &&
     drm_core_check_feature(dev, DRIVER_MODESET));

Is the drm driver responsible for making sure that !(vblank->enabled) in 
the .unbind operation, or is this something related to userspace? What 
does the warning signify? Git history did not help here at all.


Regards,

Ahsan.

