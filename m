Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841677-1519419096-2-8389285212686600452
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519419095; b=uLzYkIQ6YdOTVr1g4WfjKiI/hJJcTaOBqTRHk/7PozE0SPE
    A4Gl4sgR62aVZAF3Y3ju2CSHTPtn6Qg1qZEDaUPeJeZSqrNHb+OwREAyDi04+Ree
    zvA9UI8Mtvj2aPetvRxBokEqZb3glh6B8wC1Osgawlik6o/1bkdj+T4ak9LMVJtG
    veAyaHL3/y3j4WJCol7JoDmjUeXqTr0oo80M/VY+3IBvgLvT1cjHn5vbfwmkcbEk
    I7aa0CGBFUmD3hZi5SF3xJSXjdGT2XyneGf1W2MV8DxpLSFgRFhPHqU2f+EFOmYv
    Viz9YC5MQ0O8elJGsu3Qi92kJ4IE7B3+RGtJ+Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519419095; bh=nZCLutVWqOmnTSPC935kwfbAHr
    RyDxzR5+GuLZP9FaA=; b=sp1mjiiIW43uOXMviOrg79Enk7vJ8vzyESM6umbKPR
    g94+iqr3BvKTZYfsxA1Pv/RF5f5zpS+TeNyMhSFCpsPHbDtrtx+5lY6Gf78P1wbK
    mRjj8LBi8hzPfX4XY6zUC6GxGIT+pQjJdNSqax0YNk881wz8lT4z8gWh0LlycP0Z
    +n3Fb1K2LYZnjVNzPBM5ITVeMvpY/t2Ktm1bJP/pIkxjvMXDz78bZlq2umL18YGh
    7xcQv/OMpi7SyLyg5E82CfjqKtknP6rktoQ3+wajioybKPYNacW7mNa9h7lakpSp
    fFBsJF+SjUPt+K8tayNNV1NTT/qclWlAwMzZc0/G8SzA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752566AbeBWUvE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 15:51:04 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34810 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752445AbeBWSbE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:31:04 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH 3.18 04/58] arm: spear600: Add missing interrupt-parent of rtc
Date: Fri, 23 Feb 2018 19:26:03 +0100
Message-Id: <20180223170207.309618188@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 6ffb5b4f248fe53e0361b8cbc2a523b432566442 upstream.

The interrupt-parent of rtc was missing, add it.

Fixes: 8113ba917dfa ("ARM: SPEAr: DT: Update device nodes")
Cc: stable@vger.kernel.org # v3.8+
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/spear600.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/spear600.dtsi
+++ b/arch/arm/boot/dts/spear600.dtsi
@@ -194,6 +194,7 @@
 			rtc@fc900000 {
 				compatible = "st,spear600-rtc";
 				reg = <0xfc900000 0x1000>;
+				interrupt-parent = <&vic0>;
 				interrupts = <10>;
 				status = "disabled";
 			};
