Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1568560-1519219108-2-3767768626527927503
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519219107; b=HElB884+FWRIuwnEYDacneBFsCkLgeR+k0D2eqRTMVb7tD9
    Zdq9RhzMGCT38M3TipanYzG7OwJ/6w8v0Q/5abqD7MYfJw0oeY9KycXJKcGrvbmw
    FBJG+H9Cab+gjVAaBVSHyEsQpXIX9ZmkwAb1PkAIqpYWIfIeKOdRVpklmIy6pgdz
    4Z1r/RsvrrJW9QZBePLMExr48AySu7ML3sLEivOQl5JbzhbmXql4FszFToQPxnEC
    RyGJrRcUr3xhFVS+yNQWnpgHuREtDGyHxiWX8K9wZuljKlEy33t8DGstgsQjGrdP
    zLGfPsxW5UUNptf6oajCAhFipRpuWntSRH9ThrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519219107; bh=s0tO1dVDxhKJ8UdvMr3sBChv0M
    qvTZuXaw3yeD9Ohls=; b=uzXHQCQ3xYwTpwOAIuXFQ92QfsD/kbPiBFKdlODwQN
    DVQ9md8GFj9HhhZmd468qOy/qQ3heO5c6s9ri9H5XQoqnjX6+OZ+9MovtFWI6rmu
    2ptezC4Rgc/yv4+NqupgrEeTyDt85lYAqmN4BaOnqFrQNWdt1+PqWMbVgGLltxhI
    +aISoe8f9S2o9Vh2G5ldsK76kEgxfLk4J+OVk3Ah2UBtbLUBoolFGgtGrCPu2uxq
    iL+DU16Mk47R2Dtux1jx3DoQEtSzuOKD8aDDAT4GvOCsIYZOZqE4dFw/1dx3X23Q
    fGE1BN7Cl/cSdHoVna5pLkNGwKyFsqguFCyIc8Y4T7+A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeBUNR5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:17:57 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45822 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965647AbeBUNMr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:12:47 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Archit Taneja <architt@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>
Subject: [PATCH 4.15 156/163] arm64: dts: msm8916: Add missing #phy-cells
Date: Wed, 21 Feb 2018 13:49:45 +0100
Message-Id: <20180221124538.588828974@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Andersson <bjorn.andersson@linaro.org>

commit b0ab681285aa66064f2de5b74191c0cabba381ff upstream.

Add a missing #phy-cells to the dsi-phy, to silence dtc warning.

Cc: Archit Taneja <architt@codeaurora.org>
Fixes: 305410ffd1b2 ("arm64: dts: msm8916: Add display support")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Archit Taneja <architt@codeaurora.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/qcom/msm8916.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -906,6 +906,7 @@
 					    "dsi_phy_regulator";
 
 				#clock-cells = <1>;
+				#phy-cells = <0>;
 
 				clocks = <&gcc GCC_MDSS_AHB_CLK>;
 				clock-names = "iface_clk";
