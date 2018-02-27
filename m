Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-613114-1519715648-2-7821916324993440352
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519715648; b=XS1MXBlDt+cyLAP4+kzG2BoCwtVnBynGbrB/x31o0kZFMok
    5q+7mPWtUtMnHhTfCTMiDSob3OAGqx1FWqN2jLd2x0EAK3JfqduMe+/wfmrqdgVH
    mcLlpZklyXusn4BZG1gmiV+/ZG1HpiY7h9/dTHNRN5Yf5piOYncRZzJPZqrufIha
    EBmyARLO7GRDijvmje40pf1SMDP4wCxsYoJZJeW7kzKYOJel3hZL1tdWa74uF3IE
    q3x4ZVy+89HDj536njNIKekoHDTBW8nUmA+CIbexWLIUqQZviGK8WkY52V5VlJkV
    rs9Xv0EPvFNN6D5LzEBa2Sx/4ONyfE7hqVwdkzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519715648;
    bh=BOgqTFEHAH7+NZJTWVZXJcFMkVh/IOqJ11nJ1Y19+ug=; b=HGdwP2r8GA0F
    hgV2J8vMV9KYL3XBKxRrJTzKwdP3PrWpR/i/TlxBY/C1i2TGk451FkcbI7DPVecM
    uRl+lJ95ddBHmC3KjCqeh728d3rm9ZE0T4q/hCXUFd6sJ7qrNQXhHZmfgAsaQstC
    fmca9W+sKm56IydfCgPoTwiW2lSOHAPxPoYfs4tMD0agImFp/trM4HApm2yQmlgx
    cVi2JDrm5sVVWQvq0Z618/7ujHu6WH654zQW7U7gamdLJSyTcdWElSH7PGcot1Gc
    bn43orUgPTPrDhyUBxI+57yumqwh+p+C+0b9KhmrhZBRFH/up1HxS2n0AClTJPf9
    fdih660MAg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=myCrdLAg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=myCrdLAg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeB0HNy (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 02:13:54 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47745 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752113AbeB0HLo (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 02:11:44 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180227071142euoutp01d91e0ef754723166b03888f329a26afd~XHTKM2haX2121121211euoutp016
X-AuditID: cbfec7f2-1c1ff70000011644-b5-5a9504adcd87
From: Andrzej Hajda <a.hajda@samsung.com>
To: devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Cc: Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v5 4/6] arm64: dts: exynos: add OF graph between MHL and USB
 connector
Date: Tue, 27 Feb 2018 08:11:32 +0100
Message-id: <20180227071134.28063-5-a.hajda@samsung.com>
X-Mailer: git-send-email 2.16.2
In-reply-to: <20180227071134.28063-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSe0hTURzu7D52N1xcpuBhhcEoKkHTKDiVSEbBJYqyCGv0cOptim7qrpoa
        lJqGjzIfW01ams1HimbOB6FsoolSU+dbUkpCQxKn5YOMMnNe/e97ng9+HAqTLuIyKkITx2o1
        yig5Kcabu37bvWpxvcLHNk+i8Td9BErLdBCo3lBHoLHlGQKVdG5owysLJCqYzMOR3f5WiLLy
        y4TIPDVKoKEWI4kMdqsAvarIwFBt52chKh8bEKAMS6fwJM3UFNcAZij3sYB5nllEMObqLJKZ
        zOkWMA1l95ncxmrALJk9LlIKsV8YGxWRwGoP+QeLwwuMlWRMhkvidOcfPAU8EGUDEQXpI7Av
        vQDLBmJKSr8G8IeuDvBkCcDVhVJsO5Vv0pO8UQFgUaoV58k6gI6vNtyZIumDcK3hE+nEbvQN
        OD/YsvkuRvfjsN82K3QarvRVaDH/3Szg9D6Y39a0WZDQCI4YF3B+bg8s7R3ZnBbRx2Db0x6S
        1ydJuNp6hsen4bp1RMBjVzjb3Sjk8W6YldkucA5DOgfAj9YsjCc6AO2zQ1uNE/B99wDhxBi9
        ExY0P9sIURu6BGY+lPIRBj7RzRA8DoA/LctbV3oEoPFLvTAPyF6CHdXAnY3n1CqW89Wwd7w5
        pZqL16i8Q6PVZrDxE2z/uhffgZXBkA5AU0DuIjF46BRSQpnAJak7AKQwuZukylSokErClEnJ
        rDb6ljY+iuU6wC4Kl7tLbh64p5DSKmUcG8myMax22xVQIlkKCLo013VZFdrSeG1gfHTN4bji
        P582dzu2vd2EfCuaeqfTQq5/KxbNrrfGDueMnHsR/CE9IDVxSuPySz1YbkiK8TQdL2nYuz8g
        qhIEesGjdwPPD6vP6hVBFo36lPlC8nrP3PdGkDjhkxBqg7WlssMTNUz4aKSrVV8WavOrKpQh
        Oc6FK309MS2n/A+GL6ozBQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsVy+t/xy7prWKZGGXTtV7W4te4cq0VTx1tW
        i40z1rNaXP/ynNVi/hGg2JWv79ksJt2fwGJx/vwGdovOiUvYLTY9vsZqcXnXHDaLGef3MVks
        WtbKbLH2yF12i6XXLzJZtO49wu4g4LFm3hpGj8t9vUwesztmsnpsWtXJ5nG/+ziTx+Yl9R59
        W1YxenzeJBfAEcVlk5Kak1mWWqRvl8CVMWnOcraCVp6KJ0d+szQwNnN2MXJySAiYSExcPJWt
        i5GLQ0hgCaPE4SmfWSCcRiaJNRcXsoFUsQloSvzdfBPMFhGIlXh76jMzSBGzwAUWid8TZ7KD
        JIQFIiT2bvrDAmKzCKhKTNy/FayBV8BC4uqc9ywQ6+QlFp69ygxicwpYSuyfdgasRgio5n7n
        MdYJjDwLGBlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBAbttmM/N+9gvLQx+BCjAAejEg/v
        DLkpUUKsiWXFlbmHGCU4mJVEeFcunhwlxJuSWFmVWpQfX1Sak1p8iFGag0VJnPe8QWWUkEB6
        YklqdmpqQWoRTJaJg1OqgZFbkPXmr33bnE4Zpr7Zs3bndv7bznV//9mKFgfqpew6uO5M67+l
        hbzx091/TDviEDdD7p6IQP9EdvFZIds3ZSzctF+F9+W700tcZ2/w+nBcM+z89sgz3G//Pwl4
        xKdpu7Xx7sRXS3pWPs7d3bqK8em6eac2q+y5J8X0MOzMmTNXdMS4a3j1/k7hV2Ipzkg01GIu
        Kk4EALjMZKVWAgAA
X-CMS-MailID: 20180227071140eucas1p15a8b8443c6d52c5fab79cc82c37dce09
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180227071140eucas1p15a8b8443c6d52c5fab79cc82c37dce09
X-RootMTR: 20180227071140eucas1p15a8b8443c6d52c5fab79cc82c37dce09
References: <20180227071134.28063-1-a.hajda@samsung.com>
        <CGME20180227071140eucas1p15a8b8443c6d52c5fab79cc82c37dce09@eucas1p1.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

OF graph describes MHL data lanes between MHL and respective USB
connector.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
v5: removed extra parenthesis (kbuild test robot)
v4: added missing reg property in connector's port node (Krzysztof)
---
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 31 +++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index f604f6b1a9c2..03453b822093 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -817,9 +817,22 @@
 		clocks = <&pmu_system_controller 0>;
 		clock-names = "xtal";
 
-		port {
-			mhl_to_hdmi: endpoint {
-				remote-endpoint = <&hdmi_to_mhl>;
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				mhl_to_hdmi: endpoint {
+					remote-endpoint = <&hdmi_to_mhl>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				mhl_to_musb_con: endpoint {
+					remote-endpoint = <&musb_con_to_mhl>;
+				};
 			};
 		};
 	};
@@ -842,6 +855,18 @@
 					     "usb-b-connector";
 				label = "micro-USB";
 				type = "micro";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@3 {
+						reg = <3>;
+						musb_con_to_mhl: endpoint {
+							remote-endpoint = <&mhl_to_musb_con>;
+						};
+					};
+				};
 			};
 		};
 
-- 
2.16.2

