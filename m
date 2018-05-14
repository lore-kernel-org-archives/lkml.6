Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-289078-1526280991-2-6236170289231087
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES daen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526280990; b=NXQfnfzUueYRTD51mOdy94DJLFMHOVf2kWqyFZNXEZooiCpkEU
    3pGGLW7Qa4DQEJFVGsJfmuy8URjsx19SLuGX/nPozUNu0CU+XyEpJEsYEWUMLN9N
    NbnesZu2OK4cEab0RfJb/Xgs8BAPYJxe6WHd5q0stmqGysbyaVd2g01Y6Gmu4Kww
    LKsZ9m7C2BBLyjt5+JiHubnxU4RpT72BA/AA0zJGJ5YgnpNX3JLTUBYotTXXs7ym
    0DpKt1aXqd3hWxvUzQY4vO80YzXHhg7ZsjMeXa5NP8Bq0fFmF293R3acp5i+2uBp
    fMn2r4gHMU25zWj1l7AWIASltP7ZS8sUvxNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526280990; bh=lKudQ+05YROZ6ZUKXbb+ZPdri0Tk41
    TRke8RepFAV5A=; b=jbXRxpNaN/LyvdgtgPtZcZ7zmqRQwEqH7JkrD6tqCvwl0O
    bcPoBeO0WfoO0fHUX+//BzqAUI2uX7KgCic6nhtCxcZPNnpYNgnhIiJpcutJbQon
    7+iILtZPkaN6rl+XonsyiISI7KrHWB628YOtQBqJshukaaNzDmv9uYmRYDQlkr1+
    qG8fEJefg5I2E4Ff6Fvp8vPqJap5y/zWor/cPp5BQSGQFizi4NkjLh/+pyGuL6WF
    3AMkLYyS/uqPNW/BUGGdHnRRHoR0dvuW8LNHeXfqGSQv/tAZS6Ynfw8lzNE5BfOj
    f3nN9zKnUF24KMCCamCrh1AMrtN8BlcGyLBAqorQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=WTTeVGDd x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=WTTeVGDd x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHMdYt8VxTM+QyRzhKfhWFnwlwJMQeaIuVhhMemDB5UGkeYK7aDMcOBuCh8bnOOBZ62dU8xHYBr+xCkrAamjunM9RoL/awc1CUpjvRE9lOLaJbegeaoo
    EU1KO3b5ZIOX7d7qDjfcCEB4RJUGvo502vX6tDb05orPefjITAk+XPJn2n0jEf8TwZyttg88kS+mV9OJtbWu15lJgEdIDfaSTaBQqNLRx0drO8C0i5GSGMmJ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=-VAfIpHNAAAA:8 a=e5mUnYsNAAAA:8
    a=ag1SF4gXAAAA:8 a=cLmTEqLyBcbKPpRcc8oA:9 a=QEXdDO2ut3YA:10
    a=d3PnA9EDa4IxuAV0gXij:22 a=AjGcO6oz07-iQ99wixmX:22 a=srlwD-8ojaedGGhPAyx8:22
    a=Vxmtnl_E_bksehYqCbjh:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752988AbeENG41 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 02:56:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753448AbeENG4Z (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 02:56:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 4.14 37/62] drm/vc4: Fix scaling of uni-planar formats
Date: Mon, 14 May 2018 08:48:53 +0200
Message-Id: <20180514064818.428393636@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit 9a0e9802217291e54c4dd1fc5462f189a4be14ec upstream.

When using uni-planar formats (like RGB), the scaling parameters are
stored in plane 0, not plane 1.

Fixes: fc04023fafec ("drm/vc4: Add support for YUV planes.")
Cc: stable@vger.kernel.org
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Link: https://patchwork.freedesktop.org/patch/msgid/20180507121303.5610-1-boris.brezillon@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vc4/vc4_plane.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -535,7 +535,7 @@ static int vc4_plane_mode_set(struct drm
 	 * the scl fields here.
 	 */
 	if (num_planes == 1) {
-		scl0 = vc4_get_scl_field(state, 1);
+		scl0 = vc4_get_scl_field(state, 0);
 		scl1 = scl0;
 	} else {
 		scl0 = vc4_get_scl_field(state, 1);
