Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1568560-1519219124-2-838197137013919360
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
    t=1519219124; b=PJLZB3fej+O0Yh5YS0iumW7lg2fov6JaBJttRejeV0v9gRD
    csT59EpNhQ2EmKqrxgKqpsIrRlo05qte/KwFbUPuo9YKmb5kUdX0UCMLvbK/x2To
    8elfuMunEByHF9J15EyUxdSWbTG9wQDYG8stCYpg1zxjwkMZG8tMoImEVlx9Hrrh
    qIPrnt5Lb+OMBfr4A5dmYAe2v9fMWUJ9PoFDdHN+YCHn+XyilMU+v2ErNcrqov97
    y521UPc6ZclusqpkHiBLzxIoTQ7M4vWwMfAExOoo3+8Z2QJSBl90F3VEBpvjd3N+
    iQYJU94gP0ZLfNvFbvGs0d5XHMMWduJRn/cEDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519219124; bh=3EXirVHo2Bu3iWwV3a6Kjh82HI
    v1niOmoMD+usEDHnE=; b=l/N394i3qSCtGx49MtrrHqKttx00H0THm4BWaGd8PK
    JwOIN9SioyE+xQdPXQfRieVcjWzWiFA5f3ytFrUOHDOMkY5wdy+wQizoz4TTqxBv
    3MkRdPduUAO7Lm3IYHoZW/n4J/4Bg33RV5u8OfpblaDogmLG3WGkYYqFZAcvqi0N
    aLaWCsOygJUrYudFbSR6dmgLI6dGVnIv+EgSe77gn7k4egFh9sntYLXhSomqbPAz
    51wAR02agWeipD9PcCLPOS9JOVHLGGc/TsLRm6L3pdlfj8FHfbVgAbkd4NWAUJHA
    nLMO6EXS8k9nbjViskjCFuHHpNirCfuADUks9/MeyqZA==
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
        id S1752034AbeBUNSW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:18:22 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45798 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933532AbeBUNMl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:12:41 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.15 154/163] ARM: dts: exynos: fix RTC interrupt for exynos5410
Date: Wed, 21 Feb 2018 13:49:43 +0100
Message-Id: <20180221124538.500512611@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit 5628a8ca14149ba4226e3bdce3a04c3b688435ad upstream.

According to the comment added to exynos_dt_pmu_match[] in commit
8b283c025443 ("ARM: exynos4/5: convert pmu wakeup to stacked domains"),
the RTC is not able to wake up the system through the PMU on Exynos5410,
unlike Exynos5420.

However, when the RTC DT node got added, it was a straight copy of
the Exynos5420 node, which now causes a warning from dtc.

This removes the incorrect interrupt-parent, which should get the
interrupt working and avoid the warning.

Fixes: e1e146b1b062 ("ARM: dts: exynos: Add RTC and I2C to Exynos5410")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/exynos5410.dtsi |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -333,7 +333,6 @@
 &rtc {
 	clocks = <&clock CLK_RTC>;
 	clock-names = "rtc";
-	interrupt-parent = <&pmu_system_controller>;
 	status = "disabled";
 };
 
