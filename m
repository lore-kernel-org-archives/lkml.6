Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA10C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8FA21736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfBSPJA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:09:00 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:65249 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725885AbfBSPI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:08:59 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 15630220-1500050 
        for multiple; Tue, 19 Feb 2019 15:08:54 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Colin King <colin.king@canonical.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190219150129.12728-1-colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190219150129.12728-1-colin.king@canonical.com>
Message-ID: <155058893121.30979.13044488959474735904@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH][next] drm/i915/selftests: fix memory leak of 'spin'
Date:   Tue, 19 Feb 2019 15:08:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2019-02-19 15:01:29)
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a memory leak of 'spin' on an error return path. Fix this by
> kfree'ing spin before the return.
> 
> Fixes: c06ee6ff2cbc ("drm/i915/selftests: Context SSEU reconfiguration tests")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

I hope already fixed by

commit 2a4a2754039594c60b58b02b6781428a85f6d745
Author: Chris Wilson <chris@chris-wilson.co.uk>
Date:   Fri Feb 15 19:50:10 2019 +0000

    drm/i915/selftests: Always free spinner on __sseu_prepare error

Thanks,
-Chris
