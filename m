Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1148518-1519981289-2-17453012012726001746
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519981288; b=j+O719AdLqETBQUHDnS8wBbOH63QpZuyxKpaXIuVcILjf5X
    0CVWP5EIl4f3i5QC9lv6Ccb1N2oU7OzkpJC/kSmiDWG+kNSuSW7ji0ZhFBIqaXEI
    uWSMj74Bm9CrlbHLvSxEq91hA2+VjpXtegnsnvgaEknEyJCgOQNNVK61cb6ABjwe
    su8Rw0IiQLdYYzTz+Q+oICiXIVq2DTfOlyfITtHsCwbjUCLMxlkITSf5PCumw9Sr
    8g8dujRS1WUGbcJhrMXjlRrMUoUFWVrAHT0aB+1cQn4hKRFFfehZnef4VozkE7TC
    smONrSijcQyDnUTfalZ29sSY61Cl7y6F/bfmQvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519981288; bh=PwrZbkmF9rQ2BtEIlHDsU0reGi
    wbnigOCIhNrhiPiQ8=; b=MivloYMYN+MPm3OE9QwvT/V1W/7bE9icaqRUTe56sb
    dhvCGf4cWo+HlvAJSbu54W0kzwfZuFKJCX62TH03MWMUiZAiIk/9cXpCXlD3+ME/
    7KZVL42nljsBzIkMGWJEEyFcbN53luZbDOL0RkfqEDMPHG6U8TgaapD2zMVe0tMZ
    iMo8ajGTDNEgXlVg7LbDaA4pHkblC+Fmjv+GutDBBLJe34YLarqthyS64YmBQnlo
    6YIqv3b7FllgkO3Cyja4NpnZOfRrnoD+rF3YZfB6ReFD5gVaBrTKgXhgDEmRULuJ
    QnwCaSmiIuj9FpKhlStZwZKExA22ck6wf2D9KqV6SwFg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424337AbeCBJBY (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 04:01:24 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:53852 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424716AbeCBJBW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 04:01:22 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
        Ben Widawsky <ben@bwidawsk.net>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 046/115] i915: Reject CCS modifiers for pipe C on Geminilake
Date: Fri,  2 Mar 2018 09:50:49 +0100
Message-Id: <20180302084505.740582206@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
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

From: Gabriel Krisman Bertazi <krisman@collabora.co.uk>


[ Upstream commit 8bc0d7ac934b6f2d0dc8f38a3104d281c9db1e98 ]

Current code advertises (on the modifiers blob property) support for CCS
modifier for pipe C on GLK, only to reject it later when validating the
request before the atomic commit.

This fixes the tests igt@kms_ccs@pipe-c-*, which should skip on GLK for
pipe C (see bug 104096).

A relevant discussion is archived at:

https://lists.freedesktop.org/archives/intel-gfx/2017-December/150646.html

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=104096
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Cc: Ben Widawsky <ben@bwidawsk.net>
Reviewed-by: Ben Widawsky <ben@bwidawsk.net>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20171220002410.5604-1-krisman@collabora.co.uk
(cherry picked from commit f0cbd8bd877f3d8c5b80a6b1add9ca9010d7f9d8)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/intel_display.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -13240,7 +13240,7 @@ intel_primary_plane_create(struct drm_i9
 	primary->frontbuffer_bit = INTEL_FRONTBUFFER_PRIMARY(pipe);
 	primary->check_plane = intel_check_primary_plane;
 
-	if (INTEL_GEN(dev_priv) >= 10 || IS_GEMINILAKE(dev_priv)) {
+	if (INTEL_GEN(dev_priv) >= 10) {
 		intel_primary_formats = skl_primary_formats;
 		num_formats = ARRAY_SIZE(skl_primary_formats);
 		modifiers = skl_format_modifiers_ccs;
