Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-298528-1524839659-2-12502850860766159917
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
    1524839659; b=TaWQb9ZQsBV3WKWsr/AKd+hoe3rvTwTcJw38Pu7M7OeBlrR96Z
    7ezCil8TnfvqeWcqLgTX6uga+akNKDkCLK3+dezHIOPvem5NY1SjdkFJzjZX6WO1
    a2opkfbWPQ07Ka7BorgVGDN9z6F710ZKkLiVlzGouuAalbD1fHadqj8cOqb8k2ea
    3oKtLlS+/Q5Zy24G4fxBE6jr4rlamMsbBo+z3RcXXsrb4S7MNWHx9fyRWTgw21nH
    6KY7nxM9SIlm5GKCCv+WWJKLSbK82oBXxhYMuQl7MUgglw4MP+8BWudi/KjKD4//
    naQfLqhNQS+8nDE8UwFWYMx61xcl5ykzlDwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524839659; bh=E8JGm0XVagAkY5+VvC6wNA6MqXTImy
    DtY07+k1c3nPA=; b=L0YQKdxjpbYMznauqVejAAtuMzGkHVJ6Afnsx72A1aVe6k
    OIPnAT7X4IWpmQAvCByef9Wgu0ifEANE8/bK92IODRpHqfR7dL8ke1iJ3N21octV
    vGNcz+gXf5Q091mJLR+GhXwCjGBPLI8ETs4mxlSv2dMKlSmELRqVaF0feRFEtBFd
    g+YM1iutZO8a/rg7dVXdHfozhUfQ20VQCYAjfcgRpjUfg1O+S8KEcG16bJhz4N0N
    XmXNsuRfxn0QbfgqAItP56b0eCDyVP93PPadloBvTtyhzwakg91Bpt1FzNeVw50M
    RkKTIp1+McHQW/T2PgO2kNSUA9rBLkfs7Pwlq4jA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfN2js20JTBlWfy/sbPVswxELQY9Jvxzuz7g36YT08BV/5GoTcBtPIjqees0U4m8tbyjsk5RHfJgDnsJKjhH+EVWqtYJqTOCs2v1x3Kl40YQvqJxahUdG
    /nni1o+mKQPQaZYpa2h7gnY3jNnMhBvr4/kenMI52JVXwmKS6qrSjoiy1C7XfzFr6NhnBmP2S9s0tHPL7eOxTqbgd9f3zPIkK8Jg6+CREznkZQQEw7yoLjRd
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=IpJZQVW2AAAA:8 a=LpQP-O61AAAA:8 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=ekXXw7t8VHbTjyK4kZIA:9 a=QEXdDO2ut3YA:10
    a=IawgGOuG5U0WyFbmm1f5:22 a=pioyyrs4ZptJ924tMmac:22 a=Vxmtnl_E_bksehYqCbjh:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934789AbeD0OKI (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:10:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934787AbeD0OKF (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:10:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB30A21892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Archit Taneja <architt@codeaurora.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 4.16 02/81] drm: bridge: dw-hdmi: Fix overflow workaround for Amlogic Meson GX SoCs
Date: Fri, 27 Apr 2018 15:58:04 +0200
Message-Id: <20180427135743.441724137@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Neil Armstrong <narmstrong@baylibre.com>

commit 9c305eb442f3b371fc722ade827bbf673514123e upstream.

The Amlogic Meson GX SoCs, embedded the v2.01a controller, has been also
identified needing this workaround.
This patch adds the corresponding version to enable a single iteration for
this specific version.

Fixes: be41fc55f1aa ("drm: bridge: dw-hdmi: Handle overflow workaround based on device version")
Acked-by: Archit Taneja <architt@codeaurora.org>
[narmstrong: s/identifies/identified and rebased against Jernej's change]
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1519386277-25902-1-git-send-email-narmstrong@baylibre.com
[narmstrong: v4.14 to v4.16 backport]
Cc: <stable@vger.kernel.org> # 4.14.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1637,6 +1637,8 @@ static void dw_hdmi_clear_overflow(struc
 	 * (and possibly on the platform). So far only i.MX6Q (v1.30a) and
 	 * i.MX6DL (v1.31a) have been identified as needing the workaround, with
 	 * 4 and 1 iterations respectively.
+	 * The Amlogic Meson GX SoCs (v2.01a) have been identified as needing
+	 * the workaround with a single iteration.
 	 */
 
 	switch (hdmi->version) {
@@ -1644,6 +1646,7 @@ static void dw_hdmi_clear_overflow(struc
 		count = 4;
 		break;
 	case 0x131a:
+	case 0x201a:
 		count = 1;
 		break;
 	default:
