Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3124918-1523474034-2-14040082071266842408
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523474033; b=kYZ+/jHwNsvT+/Z3Tw7NoFbZo2EufVOyb+SUQqx7AdwJVd8SzH
    /WwScVPhBL0mCBf4oAqpSOgUIzV+aDtyy+GyKFFoKhD7/EKWP+fkRYquTuHVzcuZ
    ynC2/i1HfCSbWVh54QgsXENrE8QH6lAH3PgD94VpTU8tB/HLF6JNIj1Cfrt76oAD
    C+nctlI2NyyFiGKZ5nkvb8uWmno2MNHkmwhYvslXaPE4f51tqIirOQGUBknr+PRV
    Q6LCRL4jVdai3D1MAuHwMFmT0Uu8TRBl3cQ2u/ZYntcHwaO9L6TILt6j5oeQUkTq
    zTs4v4ONedBmIeORYe3DmlLRm7Rop2PU1MQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523474033; bh=bgenm0Tgfb+QXSXAbG7Mm6D4yKg1sa
    bTYE40VoB0sFE=; b=PNqhiUbp1Af61+jG7b9sJbuD+bSxcHKt7sBwn9WczUZw7B
    XIdarCWduWJbgHib5kwmfp0Q4O6Zg8k7VVkh1txarnBkx2XjlySGVqbojlAd+l95
    vA/z4voHqOo6pLFYeKZAqwkjuP+M4g5zZQv+a+tvHYGNDkulTQwD6oOaqS6gGnka
    cHLFikmkI6TZQNLXbvl7LbfBEsOEVvcXkJzU8lm+RXbPFR2jDsdVQjmdy8kbqnAk
    R4teYC+aN+oVy9YEnelXImN54GyVgAgVW039b+eYtJZoRUKAxtOWKvI89P1BveuZ
    BHSVlO0GeUfoSIc/jv0gFeF/Znc60CEW/f2uy8VA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFhNzMN3AWCl3txV5FrrTVcJt18izzAVo6XnsX8mpSYxqoefCqXd1uMH2WSTTGHOGu7tWLUBr1FRn6qrZLOiQAKsn8yZIAKlYh4ucdzutPHPcWppysRX
    HKCbaHPyMY+43reBD+K8GXf6dSLXlz3b1AnADPlS/ZpnktNWb+EOOKxtnLjTuXdCOglVlh7/W8WtbRgRBHhobhdWXxQWKw6GRiGseKugeS5So9PWNW1QaR4M
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=-VAfIpHNAAAA:8 a=e5mUnYsNAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=doU7KjFTIhEns1rJz4IA:9 a=QEXdDO2ut3YA:10 a=srlwD-8ojaedGGhPAyx8:22
    a=Vxmtnl_E_bksehYqCbjh:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934197AbeDKTFx (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:05:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40600 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934041AbeDKTFw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:05:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Anholt <eric@anholt.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 256/310] drm/vc4: Fix resource leak in vc4_get_hang_state_ioctl() in error handling path
Date: Wed, 11 Apr 2018 20:36:35 +0200
Message-Id: <20180411183633.443352303@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


[ Upstream commit d0b1d259a4b58b21a21ea82d7174bf7ea825e9cc ]

If one 'drm_gem_handle_create()' fails, we leak somes handles and some
memory.

In order to fix it:
  - move the 'free(bo_state)' at the end of the function so that it is also
    called in the eror handling path. This has the side effect to also try
    to free it if the first 'kcalloc' fails. This is harmless.
  - add a new label, err_delete_handle, in order to delete already
    allocated handles in error handling path
  - remove the now useless 'err' label

The way the code is now written will also delete the handles if the
'copy_to_user()' call fails.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Eric Anholt <eric@anholt.net>
Link: http://patchwork.freedesktop.org/patch/msgid/20170512123803.1886-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/vc4/vc4_gem.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -110,8 +110,8 @@ vc4_get_hang_state_ioctl(struct drm_devi
 					    &handle);
 
 		if (ret) {
-			state->bo_count = i - 1;
-			goto err;
+			state->bo_count = i;
+			goto err_delete_handle;
 		}
 		bo_state[i].handle = handle;
 		bo_state[i].paddr = vc4_bo->base.paddr;
@@ -123,13 +123,16 @@ vc4_get_hang_state_ioctl(struct drm_devi
 			 state->bo_count * sizeof(*bo_state)))
 		ret = -EFAULT;
 
-	kfree(bo_state);
+err_delete_handle:
+	if (ret) {
+		for (i = 0; i < state->bo_count; i++)
+			drm_gem_handle_delete(file_priv, bo_state[i].handle);
+	}
 
 err_free:
-
 	vc4_free_hang_state(dev, kernel_state);
+	kfree(bo_state);
 
-err:
 	return ret;
 }
 
