Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2381741-1522653055-2-12648563192139726234
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522653055; b=PVumUMLszSCkYvEwV8EbawkmFfhZT5qxn7PE3btJqSWV3kihd0
    4zEbD1QX+ms/pzEQ5QwmKd2f4VAopKl4n7DnnqcSAsD7aBhau1sP4JK5UB//uud8
    3strIjI75l+W8Tbb/c1t49O7L9MEbq2FhCjBW7z7uPEXRcU/WAqOmd6j2xFM487+
    aO3q9YRTvv66UAqQnTuiRq4xe6AHvI8Fa6espZFkA9THT+OinouUeFcreiFFF1H9
    zhFyL0248y3ilDdKNy7+sCDWfhmItYrGlkOdctjhNFBd2EQRZaNu4nVLki0WoknL
    e05SSVx+eBUHtUVE6sZvIo8Zy9LVVj8eJvEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1522653055; bh=O+6dDHoXxVmoPuCYxWa7Mw7lgjYKXs
    j0E9lzQ+J6D1E=; b=sE3LnVtB6YvmCrb2zDsvTE0Lnv3yha9w74++npvReqgysg
    gW/U+Uge72z9MQBeY9UJtjCTTjlZQNuU2I2iX1raIcQ/W4uwXAXztuTfqrpi9C1i
    s0hz+Ykw5f06RWaTfMvbHhDuT9PM/d7jsFB/grc8cUjUeVtbE3vQBSQ5UUsXD8Bh
    1DJB3WX6eSBAQyqDYII6Uj8qcrpRHfKmw4Amn31FeB91BKOridx1YJrbPizxvbX2
    C+MvvMICAsM1rfAXdm0QV3vs+asKnp5yxZP09bciLZSTbkZ8l2C0vdQlkkcyraq0
    ETnXJ6QFFLXgxPbAAwU17jgczS0rrJi+KIXbqYrg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=quora.org header.i=@quora.org header.b=CaMakeep x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=quora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=s8EiJQVN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=quora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=quora.org header.i=@quora.org header.b=CaMakeep x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=quora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=s8EiJQVN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=quora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPhXRvHX4WPCLsClsOV/vMTNfdOW+P6FWIkprxIn8oaW2QJfBNjuEvpQokie2MczY7U30CJJZ4hmUUgq9EGGAT1ZjDM82/a3YrEVVhk0OzwV0hAwEhoA
    iF7HFFFFj+KE15o+IhCumkF2hdgmH7YCIRLykJDNmVmgXuXv1lIBzBnyKZYJ8QJfhEo0FgSuWuDqYJYFGlIYUYlyAG9STjq4NoRoPpFWMMfXXvnX86oyn4BC
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=e5mUnYsNAAAA:8 a=-VAfIpHNAAAA:8 a=20KFwNOVAAAA:8 a=t9ty7G3lAAAA:8
    a=sTD_jXPAA2RGrFohESYA:9 a=AjGcO6oz07-iQ99wixmX:22 a=Vxmtnl_E_bksehYqCbjh:22
    a=srlwD-8ojaedGGhPAyx8:22 a=CsAS6f0m0zARWR-uHzm3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754151AbeDBHKw (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 03:10:52 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33955 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752583AbeDBHKv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 2 Apr 2018 03:10:51 -0400
X-Google-Smtp-Source: AIpwx483D5/z1YbW/I1XApxQ2QgcJW47VUS49V4Jm49xdpem0llmf7TJ48Z4sQKt8xhlPsQKnWE8fg==
From: Daniel J Blueman <daniel@quora.org>
To: linux-kernel@vger.kernel.org
Cc: Daniel J Blueman <daniel@quora.org>,
        dri-devel@lists.freedesktop.org, Eric Anholt <eric@anholt.net>,
        Dave Airlie <airlied@redhat.com>, stable@vger.kernel.org
Subject: [PATCH] drm/vc4: Fix memory leak during BO teardown
Date: Mon,  2 Apr 2018 15:10:35 +0800
Message-Id: <20180402071035.25356-1-daniel@quora.org>
X-Mailer: git-send-email 2.11.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

During BO teardown, an indirect list 'uniform_addr_offsets' wasn't being
freed leading to leaking many 128B allocations. Fix the memory leak by
releasing it at teardown time.

To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: Eric Anholt <eric@anholt.net>
Cc: Dave Airlie <airlied@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Daniel J Blueman <daniel@quora.org>
---
 drivers/gpu/drm/vc4/vc4_bo.c               | 2 ++
 drivers/gpu/drm/vc4/vc4_validate_shaders.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index 2decc8e2c79f..add9cc97a3b6 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -195,6 +195,7 @@ static void vc4_bo_destroy(struct vc4_bo *bo)
 	vc4_bo_set_label(obj, -1);
 
 	if (bo->validated_shader) {
+		kfree(bo->validated_shader->uniform_addr_offsets);
 		kfree(bo->validated_shader->texture_samples);
 		kfree(bo->validated_shader);
 		bo->validated_shader = NULL;
@@ -591,6 +592,7 @@ void vc4_free_object(struct drm_gem_object *gem_bo)
 	}
 
 	if (bo->validated_shader) {
+		kfree(bo->validated_shader->uniform_addr_offsets);
 		kfree(bo->validated_shader->texture_samples);
 		kfree(bo->validated_shader);
 		bo->validated_shader = NULL;
diff --git a/drivers/gpu/drm/vc4/vc4_validate_shaders.c b/drivers/gpu/drm/vc4/vc4_validate_shaders.c
index d3f15bf60900..7cf82b071de2 100644
--- a/drivers/gpu/drm/vc4/vc4_validate_shaders.c
+++ b/drivers/gpu/drm/vc4/vc4_validate_shaders.c
@@ -942,6 +942,7 @@ vc4_validate_shader(struct drm_gem_cma_object *shader_obj)
 fail:
 	kfree(validation_state.branch_targets);
 	if (validated_shader) {
+		kfree(validated_shader->uniform_addr_offsets);
 		kfree(validated_shader->texture_samples);
 		kfree(validated_shader);
 	}
-- 
2.11.0
