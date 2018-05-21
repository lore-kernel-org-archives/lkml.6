Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1344077-1526937667-2-9651095342983070240
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enfr, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937666; b=FdbPsIOFY/bYoIR+SKhgYeGfT8mit8xQulhfzAXeRQewQ6npEJ
    zOHmeC5+YSijhn6OHw7Hfil+UfHdJSQrLeN521jtsXteZrHuhga0p3Af4x7GSbI+
    e2gmTbl0YNaMoEzMJvINfVau0hT6N7qccbzVNyX6qMV8UbH2HwZk4/5L3Qp92lpk
    S9ayYtMfFXNkc1EoNZlF5sO7CAFWDPgjPHLyG1zgycu2T6+N/Ny0Xh3SpMula/Q2
    M9h18rxDLl3c3065cOoSil1gOD9dce1gc33H+7FslLAUZ4ExmaIxhwmnJTntATwh
    uahVCK1baZiwNXi8ZXy1ulJSEZ8bYb91Db2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937666; bh=VAT/iZIXcGM60ooYsdx5m4RUEPQnJE
    Ct2hEgXL8NGjw=; b=IV3K+q9gpWc3vUSAOcmMMI+Pjv9EIsiqXxI7tW828t9Dxb
    tw7vS0OkazVqnbyBCHf/lZ0IzUGzF3z/ZDBz0BSOBCxuzA0TmeR24cvz0d09nVkw
    FiY4MvPKTkzDTAiBRaJyEFzfsl3YL00bxiJuo/YkxoKTb021xc3eZYjs/KezeZkv
    JyF6O/N73OSydI19bydZtiylnj99k02gDStKA6piGLqpekp1VhqpnZ5dUyHbaYn9
    y5VAV3s0m2vQuD0VP3HIaupbRzsodLOzJu8gYuT0Pkp63cIhCrjLpUlBC05WewNP
    22Zmopphks4NiVo5xpa+cb2RHFisng0EJYmdaLaA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=kba/ia3M x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=kba/ia3M x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfDAoyr8BaeCmLQTVR9LVdB8wFh5tO7sXDaCpN8HhQPL6wbsFFClRPBOogI5p+F4ymCUxlt0tgVKioGpZ/24H3Z5uN2TULTlMxiAPiWaFD/GONvmYflyG
    fWWSkViWguigN7W7raac2varAtcgrjAjOlqv804HdHHmC86P7qJWuZuY+pcgqEHtLHi/HCEUATjP/BnXcp4jk8rzABg1m4ve3n02KdJxG7EnFbck1abT1LtU
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=cm27Pg_UAAAA:8 a=ag1SF4gXAAAA:8 a=3YRngHjhscMVVBedhnkA:9
    a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753567AbeEUVVE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:21:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753989AbeEUVVA (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:21:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 67/95] x86/bugs: Make boot modes __ro_after_init
Date: Mon, 21 May 2018 23:11:57 +0200
Message-Id: <20180521210500.123463189@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
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

From: Kees Cook <keescook@chromium.org>

commit f9544b2b076ca90d887c5ae5d74fab4c21bb7c13 upstream

There's no reason for these to be changed after boot.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -129,7 +129,8 @@ static const char *spectre_v2_strings[]
 #undef pr_fmt
 #define pr_fmt(fmt)     "Spectre V2 : " fmt
 
-static enum spectre_v2_mitigation spectre_v2_enabled = SPECTRE_V2_NONE;
+static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
+	SPECTRE_V2_NONE;
 
 void x86_spec_ctrl_set(u64 val)
 {
@@ -407,7 +408,7 @@ retpoline_auto:
 #undef pr_fmt
 #define pr_fmt(fmt)	"Speculative Store Bypass: " fmt
 
-static enum ssb_mitigation ssb_mode = SPEC_STORE_BYPASS_NONE;
+static enum ssb_mitigation ssb_mode __ro_after_init = SPEC_STORE_BYPASS_NONE;
 
 /* The kernel command line selection */
 enum ssb_mitigation_cmd {
