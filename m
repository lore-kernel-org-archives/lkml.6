Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1148518-1519981302-2-12468025915354397446
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519981301; b=cZi1mIqNdHwmT9XbqaF4aUKSA0SI0or/3w4JS4tpHwMz/bO
    U+I3xmvCpQZqJCPeO/JTQow/3UrrAZe88er8q8aPD/25lzO9t1Z/qHzxh3zQVTS+
    Z6m/wmz4ap1XcpdkuoYzfdgCSMsveOb7lqxfYf3rFyYGGrlzDzTn0yPo0YU6j6Sy
    GjHlRDGS7rkoneDW/FRR0Fur7HMS89ATIqj7cSuBXJV29Y1U2JeLJzk1YxK9WcbY
    H2p1orj4n2oZ7ZbYAabzL9ZBXP38RxTyXU2wXFvI3OOL8dWkfcB7gUxTPPFSpQ+L
    mCyAasLEjSQcpP1iOQk9IhmS81iaXrjBkiDBb2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519981301; bh=k0G4KBW7Mmxc/WTf1BN+9x8Sgo
    XRKXw0aM5pzcYNmZ0=; b=jczlbAOEVulN5CnJ6/KTEdHWVKmMScWrlmaIgD/6+o
    UITBn8G5zvNnU6wyYaAPFk7FCmQgxEm8nICtElcpoUbwdiPYAcvUpkbbfWzdGroE
    NWvxI985oPKb92mNoIrznHcHRNyCsVyQ99etaMp8hhsNGmL9JUllMVQKrzUlOfxo
    vuzurNh4Ai8He7Sl7fB7zjkc3KXPvtxB4GC97ZV21BXsZGwBwicx0Jozhsz7TDE3
    B8do7SEx+l9XCtexgp61LufHB2UqSSK0qGLHrtcXytVx8OXzpoUWjkEBuX4EvUon
    foM0CbSnocld5CQnoCoSOortQ/6BMdbSpqg7yjWiE1OA==
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
        id S1424716AbeCBJBa (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 04:01:30 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:53908 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424734AbeCBJB2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 04:01:28 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 048/115] ARM: dts: ls1021a: fix incorrect clock references
Date: Fri,  2 Mar 2018 09:50:51 +0100
Message-Id: <20180302084505.824437515@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
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


[ Upstream commit 506e8a912661c97b41adc8a286b875d01323ec45 ]

dtc warns about two 'clocks' properties that have an extraneous '1'
at the end:

arch/arm/boot/dts/ls1021a-qds.dtb: Warning (clocks_property): arch/arm/boot/dts/ls1021a-twr.dtb: Warning (clocks_property): Property 'clocks', cell 1 is not a phandle reference in /soc/i2c@2180000/mux@77/i2c@4/sgtl5000@2a
arch/arm/boot/dts/ls1021a-qds.dtb: Warning (clocks_property): Missing property '#clock-cells' in node /soc/interrupt-controller@1400000 or bad phandle (referred from /soc/i2c@2180000/mux@77/i2c@4/sgtl5000@2a:clocks[1])
Property 'clocks', cell 1 is not a phandle reference in /soc/i2c@2190000/sgtl5000@a
arch/arm/boot/dts/ls1021a-twr.dtb: Warning (clocks_property): Missing property '#clock-cells' in node /soc/interrupt-controller@1400000 or bad phandle (referred from /soc/i2c@2190000/sgtl5000@a:clocks[1])

The clocks that get referenced here are fixed-rate, so they do not
take any argument, and dtc interprets the next cell as a phandle, which
is invalid.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/ls1021a-qds.dts |    2 +-
 arch/arm/boot/dts/ls1021a-twr.dts |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -215,7 +215,7 @@
 				reg = <0x2a>;
 				VDDA-supply = <&reg_3p3v>;
 				VDDIO-supply = <&reg_3p3v>;
-				clocks = <&sys_mclk 1>;
+				clocks = <&sys_mclk>;
 			};
 		};
 	};
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -187,7 +187,7 @@
 		reg = <0x0a>;
 		VDDA-supply = <&reg_3p3v>;
 		VDDIO-supply = <&reg_3p3v>;
-		clocks = <&sys_mclk 1>;
+		clocks = <&sys_mclk>;
 	};
 };
 
