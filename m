Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2327735-1524250825-2-4355855286591114696
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524250824; b=lzy3lB7711wrpACFyxjn4U056AuIHHJ71NuTrK6xjUiKra8XKI
    W4bemlPJr0OxHb/ltL+k22bjbtF0MbTMBnrfDF/kYZFRWp4HDNxgWj/7P0P6V5tB
    S4Ser5P7M2XZz99kXlD4pi26MrclF8ZMoCeLwIZNhWvtkEoLGjTrhWnRjerulY6+
    RICy0l0OxGWm6WvITZlgqMkCE1YlFwYfYUivL1BoW9DI3tU/s5T6CMbRo4tOg5pI
    MyZXPdWPcgi9KIGNj77SPdVw+EXryDpaM+AsAmM9fpXG3U7uSiPVank9zb4vecZ7
    3rK3g2XSSZ01x25H3LJAZekwETCB62WZNM1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524250824; bh=eoboDEkHJ2jUv/vJLg0rxR1N98r4qI
    8BSSyE/TnTix0=; b=mCkF/Ab15W3JBP5Wx2AD2z2K3VRT1tLtZPdb5Q5QU9W2mF
    mN5p8GXUIPtvtCIVcOUK7qcTl5LCxBy1s36Ey0w8ezdUJsu781kdJkdSSDN//EMg
    b0rM4/NvgJg+gBNyiHxZ56T2Lr4lkM0PW9/GzqnW3qO+CyuzHBRPHcXV6p00zI3d
    XdZuFE+yzSyw0owMd9QHjUMCy+yn0PbozBvOccXIJxvfLTzbmUa94Jew8Vz9EGfY
    5smf/Z8/j05pBnPyezEfIPym24ewSd/Cx4N9T7GNoDf3CiqoMyDYozQnDwG+SMZl
    qN+zDNlDd3QS9lS6HSM50LnWrihgGgQAEA2UA+tQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=kbSQs2Wj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BHj5QrKJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=kbSQs2Wj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BHj5QrKJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOKbdw6Z/OwQkzIGman+V7lgvksMYLhUzZWMpgT9kZOhsnOFmEZZMcsnletX4AY4hJHHHdqxn8m/SVgncXcF3cAa9IfiP+s8PdaDbrKVc4vXBCZ6fgfT
    zcMVWXOkL26C3gJsVHCVDSOvtSrb8TSCIPhRyjmpxjKPE54JKe7AKz0umlWPYJ8eht4jbhemMFuOwtt4mRZ398psnJc7PHxiMqs5QV5ho7v2hs8H3NGDt97J
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=uP1ucDPQAAAA:8 a=LpQP-O61AAAA:8
    a=hD80L64hAAAA:8 a=P1BnusSwAAAA:8 a=n_pawpqYDKa4RYiHWAcA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22 a=9a9ggB8z3XFZH39hjkD6:22
    a=pioyyrs4ZptJ924tMmac:22 a=D0XLA9XvdZm18NrgonBM:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750927AbeDTTAK (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 15:00:10 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:33212 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbeDTTAJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Apr 2018 15:00:09 -0400
X-Google-Smtp-Source: AIpwx49nkD4sVu5B3/BdIDKJWlhjSAfREe8y1ss0jiSfOFFtBAno/AxzOeU4VNntV1HSxuw1HuK2Qw==
From: Sean Paul <seanpaul@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Sean Paul <seanpaul@chromium.org>, Rob Herring <robh@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        stable@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: vga-dac: Fix edid memory leak
Date: Fri, 20 Apr 2018 14:59:59 -0400
Message-Id: <20180420190007.1572-1-seanpaul@chromium.org>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

edid should be freed once it's finished being used.

Fixes: 56fe8b6f4991 ("drm/bridge: Add RGB to VGA bridge support")
Cc: Rob Herring <robh@kernel.org>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: <stable@vger.kernel.org> # v4.9+
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/bridge/dumb-vga-dac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge/dumb-vga-dac.c
index 498d5948d1a8..9837c8d69e69 100644
--- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
+++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
@@ -56,7 +56,9 @@ static int dumb_vga_get_modes(struct drm_connector *connector)
 	}
 
 	drm_mode_connector_update_edid_property(connector, edid);
-	return drm_add_edid_modes(connector, edid);
+	ret = drm_add_edid_modes(connector, edid);
+	kfree(edid);
+	return ret;
 
 fallback:
 	/*
-- 
Sean Paul, Software Engineer, Google / Chromium OS
