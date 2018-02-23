Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3775223-1519416027-2-13479180804922694351
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
    t=1519416026; b=OkSM3z/crgUQ8xX+ihH7yemjfvHjIjoTX4gLmAiN83S+9S9
    npb/1BkUevOrTYgGNxbqXAeflfe7fvSYZk/XjK3cwLQWj6yx/qus5ZQMqRARvTNM
    cjn2JsjI+UUfp1QfCc3Ad/Z9K7aHZOJ9kLkds0YoLM/0xoOlabicMsZQ7W5lrhAM
    F283SbuwdOfuvTTVWHu3NmIA54MGLBBLc/XD5qLdY5n/3yfeOR/mKI9PhfWQGgeT
    VdC4QmNmnw/ob2YpJfHID1gurHR6HSuVnjOiL41t8gdX1uiSZiU99UXIHd2bnC59
    RJIU5PdAoYeXQMFScFeu7ct7SKEC2wsUng00MOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519416026; bh=bY90TcO5vWPUJqxE+f8zcX307E
    tbSnX41oQ4SzAdT0U=; b=IE3O3zan+/MT63qRYqNjWIopnFfYvhJX3F9UFQ1C0E
    jvPTSHpj8/aCGh+TEjrn6kWbEyCYyX1ODVWGwV+0Kj0kx6sM2T+tRe58DfPz97RO
    XylQFj3w4R4NRMuiVU4akrepTikrTNsRs15pHCLerP1Oem40WNOny4oSpbi1dt3D
    6ECR2kpgIBLRGJnNhGzz5vb7FkWF069b9Ksjyt5lp1Zy3o9PvHKtzWR0ob4B5iM3
    Zl1Rhs3by44EVpGBUciWME5HeA6wcUeJ90KGiNH2oNcbSj04/0QIgEcrYbY3mPHj
    eO1dJ9MTTmUk48Vtfp4/jBxSnMM0CTZUQoaR/RemzfNg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933351AbeBWSnm (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:43:42 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42296 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932953AbeBWSnl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:43:41 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH 4.9 035/145] arm64: dts: add #cooling-cells to CPU nodes
Date: Fri, 23 Feb 2018 19:25:41 +0100
Message-Id: <20180223170729.439727564@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit acbf76ee05067c3942852019993f7beb69a0f45f upstream.

dtc complains about the lack of #coolin-cells properties for the
CPU nodes that are referred to as "cooling-device":

arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: Warning (cooling_device_property): Missing property '#cooling-cells' in node /cpus/cpu@0 or bad phandle (referred from /thermal-zones/cpu_thermal/cooling-maps/map@0:cooling-device[0])
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: Warning (cooling_device_property): Missing property '#cooling-cells' in node /cpus/cpu@100 or bad phandle (referred from /thermal-zones/cpu_thermal/cooling-maps/map@1:cooling-device[0])

Apparently this property must be '<2>' to match the binding.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
[arnd: backported to 4.15]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -73,6 +73,7 @@
 			reg = <0x000>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -89,6 +90,7 @@
 			reg = <0x100>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@101 {
