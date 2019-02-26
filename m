Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC72C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D3421874
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbfBZWPB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:15:01 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:55926 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728766AbfBZWPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 17:15:01 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 15711205-1500050 
        for multiple; Tue, 26 Feb 2019 22:14:55 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Eric Biggers <ebiggers@kernel.org>, dri-devel@lists.freedesktop.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190226220858.214438-1-ebiggers@kernel.org>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-kernel@vger.kernel.org,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>, stable@vger.kernel.org
References: <20190226213053.GC218103@gmail.com>
 <20190226220858.214438-1-ebiggers@kernel.org>
Message-ID: <155121928860.5956.12770996408502874761@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm/vkms: fix use-after-free when drm_gem_handle_create() fails
Date:   Tue, 26 Feb 2019 22:14:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric Biggers (2019-02-26 22:08:58)
> From: Eric Biggers <ebiggers@google.com>
> 
> If drm_gem_handle_create() fails in vkms_gem_create(), then the
> vkms_gem_object is freed twice: once when the reference is dropped by
> drm_gem_object_put_unlocked(), and again by the extra calls to
> drm_gem_object_release() and kfree().
> 
> Fix it by skipping the second release and free.
> 
> This bug was originally found in the vgem driver by syzkaller using
> fault injection, but I noticed it's also present in the vkms driver.
> 
> Fixes: 559e50fd34d1 ("drm/vkms: Add dumb operations")
> Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
