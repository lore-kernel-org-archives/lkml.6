Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1047503-1519203506-2-14085988114947692551
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
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
    t=1519203506; b=JCtxa3LwDZFbFU7sCl9RDFesmK8Wa2G3lujel+UCBFRqEE7
    UxBeHwnVtBx0UHdofaL29ds8PL2JhBQWYzPtQSyMglcTWCX1N7NKZS7wJRq8b/ab
    qtT2blq80Gx8xUlAT0OcN0uwUcYlc6mvNdXnqz7AW0yx/sJ0phJdXn9i8eNXDPQ3
    qVjKaFZuWMJBFdb2RfxmDJsBsQ3DBTB2Ua2piaGz+dRa6xvcICbZI78DIgTdJjSx
    8SkaWedQx//lpGlrD7zR5OmALeA32eeVlKqrHcevYkACj6ZLmKYIeYFj/y6utsbw
    7x+P0fu5st+cOknbEOSynznUzdGizwU7ol/aZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519203506;
    bh=m/GW9H6q/7I/TLHQluFu3GsDhHNNSZ8XRcmwX9BOnFo=; b=aVyBw9Fzmvnd
    RZ3AAraeJhkVyI5fAHB/PjUMPpaU3qQ72BwWu1VCUcPrmMN5mlMb3ISfw69N5PbW
    zuLdIbImejVhO7RCFJ6F3pZJUE5CsApT80G1d12wqOrl9gMsnjjHkZW3BkTX62h0
    bbWfK/YjBOwqGeTVe1/xpQU2Uby36w5Q18olHNsIopStO31zpleAFasve90JDzi6
    pawRUfBQoBniJjWL/8wgtpCoEEiXkUqnIACTM1sHeKXuTV7ONBxpcxgWlN7dtejF
    yczdrOfEhwJOVVA/H9DjXAP90IIxM7AXu3AgdIM4SN9+60B93BRAa6JHc3qPqNBc
    r+6d9dRMHQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=ZhvlUwDz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=ZhvlUwDz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752351AbeBUI6M (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 03:58:12 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57121 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752134AbeBUI4L (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 21 Feb 2018 03:56:11 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180221085609euoutp02f26fb1d02bbbfb8cacaa45db05cffa92~VS2pBnAWI2484424844euoutp02V
X-AuditID: cbfec7f5-f95739c0000028a9-ec-5a8d34289bc4
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
Subject: [PATCH v4 4/6] arm64: dts: exynos: add OF graph between MHL and USB
 connector
Date: Wed, 21 Feb 2018 09:55:39 +0100
Message-id: <20180221085541.14556-5-a.hajda@samsung.com>
X-Mailer: git-send-email 2.16.1
In-reply-to: <20180221085541.14556-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsWy7djP87oaJr1RBjsuM1vcWneO1aKp4y2r
        xcYZ61ktrn95zmox/whQ7MrX92wWk+5PYLE4f34Du0XnxCXsFpseX2O1uLxrDpvFjPP7mCwW
        LWtltlh75C67xdLrF5ksWvceYXcQ8Fgzbw2jx+W+XiaP2R0zWT02repk87jffZzJY/OSeo++
        LasYPT5vkgvgiOKySUnNySxLLdK3S+DK+N39ia3gLnfFnjM3mRoY73B0MXJySAiYSKx5eYqx
        i5GLQ0hgBaNE19QLUM5nRokl+3uZYKraJvxkhkgsY5R43b2JCcL5zyjx79s9FpAqNgFNib+b
        b7KB2CICsRLvLu0C62AWuMAiceH0K3aQhLBAhMSEFf/BilgEVCXuHjrDCmLzClhIzP/4kR1i
        nbzE4TdNYHFOAUuJ33sngQ2SELjNJjGpfxULRJGLxObD86AahCVeHd8CZctIXJ7czQLR0M0o
        cWpfJ1T3FEaJ868uQ31kLXH4+EWwFcwCfBKTtk0HKuIAivNKdLQJQZR4SNz+MRdqqKPElskH
        oCHTwygx791XpgmMUgsYGVYxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIEJoXT/45/3cG4
        70/SIUYBDkYlHl4LnZ4oIdbEsuLK3EOMEhzMSiK8lUK9UUK8KYmVValF+fFFpTmpxYcYpTlY
        lMR54zTqooQE0hNLUrNTUwtSi2CyTBycUg2MnG+nf3+eqj9li5EHr4/B/1nnTnyLMzP+cnjf
        cR3J1uqvyZGXT5186Lroncz67Yabfuavl5LZJRzvNV0mbbtE2Kawrf0vSgvitXV4s4v6gxYu
        PxdZOd1d3KhzN69YddAZ3rNzEh+8uPPD3/WZzpepCkoPpZbVa3llWU0+0XSi+YJCwNzGZrWL
        SizFGYmGWsxFxYkA4yF1YgYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsVy+t/xa7rqJr1RBr/2KlvcWneO1aKp4y2r
        xcYZ61ktrn95zmox/whQ7MrX92wWk+5PYLE4f34Du0XnxCXsFpseX2O1uLxrDpvFjPP7mCwW
        LWtltlh75C67xdLrF5ksWvceYXcQ8Fgzbw2jx+W+XiaP2R0zWT02repk87jffZzJY/OSeo++
        LasYPT5vkgvgiOKySUnNySxLLdK3S+DK+N39ia3gLnfFnjM3mRoY73B0MXJySAiYSLRN+Mnc
        xcjFISSwhFFi+e39rBBOI5NEx4Sp7CBVbAKaEn8332QDsUUEYiXenvoM1sEscIFF4vfEmWBF
        wgIREhNW/AcrYhFQlbh76AwriM0rYCEx/+NHdoh18hKH3zSBxTkFLCV+753EDGILAdV8OPeV
        fQIjzwJGhlWMIqmlxbnpucVGesWJucWleel6yfm5mxiBQbvt2M8tOxi73gUfYhTgYFTi4bXQ
        6YkSYk0sK67MPcQowcGsJMJbKdQbJcSbklhZlVqUH19UmpNafIhRmoNFSZz3vEFllJBAemJJ
        anZqakFqEUyWiYNTqoGx2dM3+ZcGL/MchT2X/V05H7Ja/pAo1OX4NZlxd5Cwzi0usz3vOe0O
        BC6dkcHjH3FwzYs8Vl7HRb0cK3JENmoWp0cE3BBf/SDB/pjD84ymKu+dS9df0lXP8OBUFf42
        3f//CnnDe8vfqWllRhWfNj75bMmc+1uvrrQ2P7ivzsZCtbRd5eiuTWJKLMUZiYZazEXFiQDg
        7MTGVgIAAA==
X-CMS-MailID: 20180221085607eucas1p1a08c82fac832049d79705b4222422fa9
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180221085607eucas1p1a08c82fac832049d79705b4222422fa9
X-RootMTR: 20180221085607eucas1p1a08c82fac832049d79705b4222422fa9
References: <20180221085541.14556-1-a.hajda@samsung.com>
        <CGME20180221085607eucas1p1a08c82fac832049d79705b4222422fa9@eucas1p1.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

OF graph describes MHL data lanes between MHL and respective USB
connector.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
v4:
- added missing reg property in connector's port node (Krzysztof)
---
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 32 ++++++++++++++++++++--
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index f604f6b1a9c2..2ed506df94d0 100644
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
@@ -842,6 +855,19 @@
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
+			};
 			};
 		};
 
-- 
2.16.1

