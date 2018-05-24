Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527155825-2-6489181546311154592
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES ensv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527155825; b=dQNLKMLTbJuELuEio8Ul0uxOgImEqC9HFWJMwaMMDThl+oGPum
    y/wHhEQBDOa8BlkGXqJoICqFrZmz0PV2R00SavLo67gUoAcPR0vFVLe3eu5rTBzL
    V7rJX4BJfL02qemksnB85b8u2AmwKaC8lH9dO1I3R8XL5KJd6ZrzRgrFI0Bxtv5J
    g5ba/3VY72aGhO33JeO2jrRQMOrvweVU62MdnOhhvfFGDt2tk5VT/FuWoLO7JHbO
    /1hh1bBxcmzQNL0ymbB88xFk3vSzJx1Q5ZGXzBl91cVFl5ahyep0BfKmNL1jOl0b
    N7/g4WloGppmgwLUIj3N1Me2+lJKoflVmLDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155825; bh=7qu/w/J094P7rqs5Vt9HzmYkpTC2mi
    T4oYSiJ0oGLFA=; b=dXNambuq3efO18xWVFi8hVhZ4c98blzclxE31M5tIYLg40
    CiSv3H/spdXyR4vIjxWCyfhUqvrH4Y5QPP8cimLYQo2V6IGifB3QOoI2ag8Zhchr
    4TlEOYpzGCPpPbfLqkxr+ZH6ZvT3Sgz7M98DVAlqg3AMAiuvoBhHaO70Ywdd4Wxv
    No7U1b/USCCgbwOxSJ4UzpF1fY1A0AK2nfCqxbUAcLVClkuLnPgNs1TtIpasEZB/
    M0EOw3zmFluuDDWjnefDZhOWzos5xa8KOZRXXmpeOp9GU2NxP56QaSWXGh/A+/FY
    yp1YsWTiNj1giNR9o7PfLaeTdLLqLB9CZXG7CV2A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=eDuCKcif x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=eDuCKcif x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfCsfRVK5bryZiU7Ra0ZPQ4C9X2TA0HqUZ1XNRO3KIbnVRrY7Ne/996KSOd6ARSDjp5vqL7DN6qaZfa8mqcsN+eRM+gtSLTUov9fuUqZBjeI306XN2jVA
    rn+uKerDP/U0TbL/ddR6HecAp4FLGAgyU3/wxAFDyO2M/iLekWQdSGAdma/7mtFFB6fTLNGTA1ikEtqlHgeUcsnLXeZr3Jz7GDeUFqvO3rWRyWPpGC4kdLKr
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=YOferK-rsSpu-SPiOigA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030377AbeEXJ5B (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:57:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030361AbeEXJ45 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:56:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 128/165] clk: hisilicon: mark wdt_mux_p[] as const
Date: Thu, 24 May 2018 11:38:54 +0200
Message-Id: <20180524093627.186445352@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit df934cbcbff7afbc024bf05f02615917c61f6470 ]

The symbol is in the __initconst section but not marked init, which
caused a warning when building with LTO.

This makes it 'const' as was obviously intended.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: c80dfd9bf54e ("clk: hisilicon: add CRG driver for Hi3516CV300 SoC")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/hisilicon/crg-hi3516cv300.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/hisilicon/crg-hi3516cv300.c
+++ b/drivers/clk/hisilicon/crg-hi3516cv300.c
@@ -204,7 +204,7 @@ static const struct hisi_crg_funcs hi351
 /* hi3516CV300 sysctrl CRG */
 #define HI3516CV300_SYSCTRL_NR_CLKS 16
 
-static const char *wdt_mux_p[] __initconst = { "3m", "apb" };
+static const char *const wdt_mux_p[] __initconst = { "3m", "apb" };
 static u32 wdt_mux_table[] = {0, 1};
 
 static const struct hisi_mux_clock hi3516cv300_sysctrl_mux_clks[] = {
