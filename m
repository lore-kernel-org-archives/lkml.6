Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtMN1F/7tVJlckkjWK6HLimCmnbMqR8Xw9G+vud3Ixd4D44aVxnMIQuWvNlVFWxBCFQMYLw
ARC-Seal: i=1; a=rsa-sha256; t=1519981500; cv=none;
        d=google.com; s=arc-20160816;
        b=08O2eiPrt03bRG7Gy1mYtx3kmacCdn0FCF+/gx4AIsJqzP4Z8j7tCQvnx/Gw5W9b08
         /UKXvYDEDNfZlShp6qo0fibXJVxIRkFXsGHmrkhfyOTSvThkQCHOZslQ4dH92oyuSIM7
         aCnCR4/mBvc7/GXsSErkYg8vU8UbVDQza/V65LnpiqGXqr+JakejzsTBrk5xfM84pd4h
         WoWypdYyJYNlxvgRzHpfF8PzlKfwJJTcgXmLN1iKnHDrMxQpvfEmUxHWPM3eS1DLVa7i
         1j1D6yqCIsFTZN5aBBeRgi4BuN2yEppfutBFbujkH11/6SHEjRsCtq7KXXNFinAdGA7H
         GXDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wKo60op4bruOMKyIYp/m3vODP/JgVLhBE1KVZqq5KUI=;
        b=lUKC/NUNprBk16BWBj941W4GUquwtexSMiXrKzUuR/wJuLOvz4GcuOsvdkBA2EcZkx
         RZPq05kuw/o45wwNg2osKxh0QqsK0soDb0tFVsQ5sEgaLi7Pb7qsbGBxOmlMjm8/jhWX
         OdRGjyOXcb/Lbbtbrkde/OSScvEi817hh/PIYZGtyg+vy81bo0bLiajLEdFyf9n1gV1q
         ZahMWoiO+x9vQ/BKV2hh/NT+8BNEMx6R2C4guHmaomILnFpeJZp5ycIXK+NF7DYf+SBf
         EsYXWKv8u46cSr3O9snsSloimx9AgnNVM9nWf4aVFpOPflp/Qgs8tg+TrHzliV4Qzq8I
         jvKA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Antoine Tenart <antoine.tenart@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory CLEMENT <gregory.clement@free-electrons.com>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 4.14 111/115] arm64: dts: marvell: mcbin: add comphy references to Ethernet ports
Date: Fri,  2 Mar 2018 09:51:54 +0100
Message-Id: <20180302084508.331713669@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593816122198021674?=
X-GMAIL-MSGID: =?utf-8?q?1593816122198021674?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoine Tenart <antoine.tenart@free-electrons.com>

commit 760b3843fcd88f2a46e66eec08e2e6023a425809 upstream.

This patch adds comphy phandles to the Ethernet ports in the mcbin
device tree. The comphy is used to configure the serdes PHYs used by
these ports.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -228,8 +228,11 @@
 
 &cpm_eth0 {
 	status = "okay";
+	/* Network PHY */
 	phy = <&phy0>;
 	phy-mode = "10gbase-kr";
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cpm_comphy4 0>;
 };
 
 &cpm_sata0 {
@@ -263,15 +266,21 @@
 
 &cps_eth0 {
 	status = "okay";
+	/* Network PHY */
 	phy = <&phy8>;
 	phy-mode = "10gbase-kr";
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cps_comphy4 0>;
 };
 
 &cps_eth1 {
 	/* CPS Lane 0 - J5 (Gigabit RJ45) */
 	status = "okay";
+	/* Network PHY */
 	phy = <&ge_phy>;
 	phy-mode = "sgmii";
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cps_comphy0 1>;
 };
 
 &cps_pinctrl {
