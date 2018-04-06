Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1404550-1523021529-2-9774667798092525422
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021528; b=A+wfjnEi2Jmq5WEA9Tw7iFmQgGcuI9D2ajp4tcdmJK14qEXczB
    IpzJmiamQpMvDOK8mwgYSvUS+la6OdBg2JhwZcHNJxCZEI6Ow35whXbAFjPvod1a
    TpgcqH09zzY2pKQIbWy8aj7JFghR4k6lVi5xmBIyOcsdSuv7nj8SztPWmTNtr9gh
    Lva67rQpcEUFW4/fKCEJOp86DFlmjP8IpY7oRmXChgcjHutUyaYgmg7GcfB14U1V
    pqSu7rqwP0sEa46Qe9CLQDsO1hggzp+7vpa605SC7sHd6CYpblTV4uREiApu5kVj
    WhwbWR02z5O56rJXdat17CZIBRh91ipFD4yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021528; bh=WY0j7S1vrhGabQUbnyxwo/quhBt8ad
    SvF0xeB1tJhZY=; b=XAr+xUTCQ/6Ac9E59mx3YnFqIVKJkHKcRLhofFGXuiFSD/
    T9hx3HPtwA9vlQjDAybi/VaAJChqNwZ23ORbuwwVd3dYh8aU4fxYymhKMlF+GtEx
    1AnGfuFasff8GU+pf0DhRWXvMhik/APv8s7gk3mmQvhyTYngBl7CZ6ThVeMMOSBy
    u0rNDS8e8mOsrG3TZejj6JUumC1xyCsY4JuS8OS9P/6rgzDEKvIh5bFRe8SsfRa8
    bN4APN0eZl1CKh4ifopYrwzFy+F9Gvr8BYXfAJ3VG57RthGr6YByHuIVXLKGo3B8
    4uRJHlKEgr2RnBTLMkX6VdqjPm94HU1hXADVzsuA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfCANPjZThXIotPNTYQSHlIqbWDHxnu+emJB8pGkXNVk94vOyLOR4sqmLzIh5MZcWHAAGiaKl2ti6F5DB9vUDmXI8NW5M/kXeP06TtEp0lHBsI15yBpA4
    6OEP7s9pzlBIg9PgkJ8a8ao8OCkJKTZ90ys51eD9uwlV8skExi3awtW+GRrfywCzUYfnY9u3x6SEmvNecAaCklerunhPg7BCinzzanReSPUkIi0onyFboPp3
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=1EsaE_6oAAAA:8 a=sozttTNsAAAA:8 a=2KMo9-giAAAA:8
    a=yMhMjlubAAAA:8 a=1ikE9UWp9tzp_zwZXpwA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=3ZumFrijQQ-2J9H5h8ct:22 a=aeg5Gbbo78KNqacMgKqU:22
    a=UeCTMeHK7YUBiLmz_SX7:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755271AbeDFNcE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:32:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57264 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755231AbeDFNcD (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:32:03 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        "Andrew F. Davis" <afd@ti.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 66/72] Revert "ARM: dts: am335x-pepper: Fix the audio CODECs reset pin"
Date: Fri,  6 Apr 2018 15:24:07 +0200
Message-Id: <20180406084311.015218339@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 59df934af72fe74a64be6a0d8dba21375a5482bc which was
comit e153db03c6b7a035c797bcdf35262586f003ee93 upstream.

It requires a driver that was not merged until 4.16, so remove it from
this stable tree as it is pointless.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/am335x-pepper.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -139,7 +139,7 @@
 &audio_codec {
 	status = "okay";
 
-	reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
+	gpio-reset = <&gpio1 16 GPIO_ACTIVE_LOW>;
 	AVDD-supply = <&ldo3_reg>;
 	IOVDD-supply = <&ldo3_reg>;
 	DRVDD-supply = <&ldo3_reg>;
