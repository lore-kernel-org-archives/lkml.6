Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB04BC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C0A21A64
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C0A21A64
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeFVHig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:38:36 -0400
Received: from mail.netline.ch ([148.251.143.178]:44816 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbeFVHie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:38:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 9AE3B2A6046;
        Fri, 22 Jun 2018 09:38:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id iWk7uzzz1_Y3; Fri, 22 Jun 2018 09:38:32 +0200 (CEST)
Received: from thor (252.228.127.176.dynamic.wline.res.cust.swisscom.ch [176.127.228.252])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id 611812A6045;
        Fri, 22 Jun 2018 09:38:31 +0200 (CEST)
Received: from localhost ([::1])
        by thor with esmtp (Exim 4.91)
        (envelope-from <michel@daenzer.net>)
        id 1fWGeM-00086r-Rf; Fri, 22 Jun 2018 09:38:30 +0200
Subject: Re: [PATCH] drm/amdgpu: Count disabled CRTCs in commit tail earlier
To:     Lyude Paul <lyude@redhat.com>
Cc:     amd-gfx@lists.freedesktop.org,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        David Airlie <airlied@linux.ie>,
        Tony Cheng <Tony.Cheng@amd.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Shirish S <shirish.s@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180621204832.22448-1-lyude@redhat.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <a07b99f8-e5ea-fa8c-dc43-75c032c4afd0@daenzer.net>
Date:   Fri, 22 Jun 2018 09:38:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621204832.22448-1-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-21 10:48 PM, Lyude Paul wrote:
> This fixes a regression I accidentally reduced that was picked up by
> kasan, where we were checking the CRTC atomic states after DRM's helpers
> had already freed them. Example:
> 
> [...]
> 
> So, we fix this by counting the number of CRTCs this atomic commit disabled
> early on in the function before their atomic states have been freed, then use
> that count later to do the appropriate number of RPM puts at the end of the
> function.
> 
> Fixes: 97028037a38ae ("drm/amdgpu: Grab/put runtime PM references in atomic_commit_tail()")
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Michel Dänzer <michel@daenzer.net>
> Reported-by: Michel Dänzer <michel@daenzer.net>

Actually, it was reported by Tom St Denis <tom.stdenis@amd.com>. With
that fixed,

Acked-by: Michel Dänzer <michel.daenzer@amd.com>

(needs review by DC folks)


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
