Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524405671-2-7854723560190142598
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES daen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524405670; b=cMxL+YT6dKGjNOuSEgIxOxlmS6RMvKU1hqM/2USVFE0CCopbC9
    w/konYJda+irFbgY35hs1ljZfON2Id40ApPUoIfc9p5TDP2dahPlt8VvN2wxunbC
    V4eaVy2j9b4NDiuZM25kcZxXy+nUki6QLyIf53k8wEX5VMg3toDbgVjzL9zAL/I4
    LMtBiUFc3GOAGkFb8ghGFqrOX6uzJINFpFItJwJ3E70qAPQtEtLliypDYZxReqxe
    Kooz0Zcuu6kfLjxBqnjLj6x1v6tGlnPifKCPYK6wyTNLqgKj75pdwHifwJE/apbJ
    4O80PPhouYSHo8fd5LNDD/i2Ml/e19ASPe4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405670; bh=aw7w4GjIMudzkSQtFjUalvdn7eq2fN
    H9e3UN0iEI45E=; b=gyQba03KxnvTSWHFSeH95fZFHN/mPVWPC8wzIEiX2fHgjy
    hi+bw5Y5A8au/WqlHv8f4wUiNlJYeUH3GJznbrJ8aOwr3Ao8a7ZYDYefm8Ssu82d
    pJ0fadcukSOJDyPxGl3N8Tus95rvq3MdTyoUbDwWGK3tNW/htxaW/8PcLn5QU0KR
    Ae9oGjv+poKmqgljoveUR+7+gSG4UpjkxnYo0/4MXSeBXiBC2t7DHP69wsS0fjrr
    W5bK1iW9LHcE+sw7Ey94zd8liPIhZM/QtXRh8cSrqPEZzid5y3FIPbk9AdRbsqrp
    4dNHQ77R6hhtqOqNC8YMjW1EIYkOH26BeVDhkLUA==
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
X-CM-Envelope: MS4wfCGQjZQjQuPSDNf5CHnAzwA/aJUX0SGLxU+YLGVfUUDZY4UqFy+5vm3m1X+43QtXQ2SQMK6JeXICusLbeEHsAu2VXp/vvZjvGmCifaoCZ3AcMKokbtuE
    YPoZV0RViLr1gIN6UI/Y1TueGV+K3jzPTNtf1RT8ncOribZASuS9aj+qkNEfuZPsvu6W/TE4X1NRIG6VEUHoL9AIx6cab6XNFehVxCxc1M40O4fLmnQHBF5s
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=mpaa-ttXAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=ag1SF4gXAAAA:8
    a=ALTnucOfrOSWVTradHsA:9 a=305Ezi1rW_i1A3II:21 a=a1gN9-G8JxdQImrz:21
    a=QEXdDO2ut3YA:10 a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754620AbeDVOBH (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:01:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47766 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754646AbeDVOBE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:01:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.16 148/196] dt-bindings: clock: mediatek: add binding for fixed-factor clock axisel_d4
Date: Sun, 22 Apr 2018 15:52:48 +0200
Message-Id: <20180422135111.890281754@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
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

From: Sean Wang <sean.wang@mediatek.com>

commit 55a5fcafe3a94e8a0777bb993d09107d362258d2 upstream.

Just add binding for a fixed-factor clock axisel_d4, which would be
referenced by PWM devices on MT7623 or MT2701 SoC.

Cc: stable@vger.kernel.org
Fixes: 1de9b21633d6 ("clk: mediatek: Add dt-bindings for MT2701 clocks")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/dt-bindings/clock/mt2701-clk.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/dt-bindings/clock/mt2701-clk.h
+++ b/include/dt-bindings/clock/mt2701-clk.h
@@ -176,7 +176,8 @@
 #define CLK_TOP_AUD_EXT1			156
 #define CLK_TOP_AUD_EXT2			157
 #define CLK_TOP_NFI1X_PAD			158
-#define CLK_TOP_NR				159
+#define CLK_TOP_AXISEL_D4			159
+#define CLK_TOP_NR				160
 
 /* APMIXEDSYS */
 
