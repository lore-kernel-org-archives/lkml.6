Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2568158-1526386413-2-5801984170937082346
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526386413; b=VverNeU16bZZWjUABNOVgHs6IwJcVSWMDUZ9S9T/lPt2twz9Q1
    Ul1i36a5cckCQ8DgP8DozuxaXgZWGm8WBsxoYbWVtd7RLSCMSFl+Vezxk1jhGZx+
    jv3dhu9Yjt74naBmRqRkhAB/F3C5z+WcAtRSPlb85EFSC3d12Cp77yXXoElc2GaF
    uhauzkBGEuE4AbFInfmOq2VLa+mO5NzbNR8mwsK2Mm0qfZZtskiBV59HQhN/cY5r
    3DYBxW5HGAPfFedE1YF5pbPEJ8nICHq+qSbsgAvd7YX01CVODVFbY3lMvrdVdJqg
    NC0g595F7TCx5OkKlelqzRF/BX6lPsRMZVjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526386413; bh=
    zFbHBIy6JtCcdVH/K2+WX4041f5QhFeC50J4p7ewJ5I=; b=NIwDJwn4GEYBjfoJ
    FgVr8KNMafxrJOkdNWLZSWIyCMvTQy9W8wKCYOPyIx32WC1/qgcoRvqm5jxgI/yW
    W1EDMWSC5zx2UdPZyX+KE0xoWm4Vs+Rv/agbjkl9wiZxcUU3NtfzjU46Le5fDJXd
    txpKP+PsqaOwcXVIrjgIUE33VM/VA9DQq1l4QkwGahNlEz4UyTP32rgXIc0R423/
    bvFq9OK+sPH0tyyG+Jh9yZWo/igHMrI3gQB9MotivpCHTOMtF4DZZwvB1hcSxngk
    uOdk1cPlrw9rphL1/9ySUrNTR0D4m3w/53MYJnfsAacK+N1Bl7e+4nVZ5uTxrIig
    XOfE0g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=samsung.com header.i=@samsung.com header.b=irUloFJn
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=samsung.com header.i=@samsung.com header.b=irUloFJn
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJXG2MGD+pfYwJnszSn6tWVHmjnCL9e0KTEcts5F5sAw4ixDcWt18qCTE7kqVQGj4v9zags4XiBIGU0LS3HAdBrQYOExUTsnQVSxWoJsXwsIfSSqQB5C
    s74YERsQ0w9YgJs3p3BXwQ4Y7FfGCnIIR8pAdbMj5JZGFIP1gGDhxz8sOX2pRFh/n1N02wzK5uOnW0QZgSF7XN7EGRa4oFIATE0oeIW2KYYOVcHOWTg0EqE6
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=hD80L64hAAAA:8
    a=VwQbUJbxAAAA:8 a=KslkfLQnONUk45JxyP0A:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753224AbeEOMND (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 08:13:03 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45774 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752804AbeEOMMz (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 15 May 2018 08:12:55 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180515121253euoutp01111b623eb09bcd2def4133636d5c9674~u0FHNVzYl2728427284euoutp019
X-AuditID: cbfec7f2-1c1ff70000011644-eb-5afacec4d420
From: Andrzej Hajda <a.hajda@samsung.com>
To: linux-usb@vger.kernel.org (open list:DESIGNWARE USB3 DRD IP DRIVER)
Cc: Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: exynos: add OF graph between USB-PHY and
 MUIC
Date: Tue, 15 May 2018 14:12:39 +0200
Message-id: <20180515121239.18192-3-a.hajda@samsung.com>
X-Mailer: git-send-email 2.17.0
In-reply-to: <20180515121239.18192-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsWy7djPc7pHzv2KMjiyVdji1rpzrBYbZ6xn
        tTjW9oTd4vqX56wW848AxZoXr2ezmHR/AovF+fMb2C06Jy5ht7i8aw6bxYzz+5gsFi1rZbZY
        e+Quu8XS6xeZLFr3HmF34PdYM28No8fsjpmsHptWdbJ57J+7ht2jb8sqRo/Pm+QC2KK4bFJS
        czLLUov07RK4Mq4/b2ArOM5Z0XvrEnsD4yr2LkYODgkBE4kJ7fldjFwcQgIrGCV65jUzQjif
        GSV+nGoCcjjBinZtb2aGSCxjlPj6/Bc7hPOfUWLzvdksIFVsApoSfzffZAOxRQTcJZYtv8YK
        UsQs8JFFoqXrI1hCWCBY4uWzl8wgNouAqkTz/GYWkDt4BSwkfjQVQGyTl3g2fR47iM0pYCmx
        fsITFpA5EgJH2CSuv3vFDlHkInG+aQobhC0s8er4Fqi4jERnx0EmCLta4uaLJqjmDkaJ+7/b
        oRqsJQ4fv8gKYjML8ElM2jadGRIYvBIdbUIQJR4Sl46thprpKPHg+XwmiI97GCUOvr7NPIFR
        agEjwypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzAmD/97/inHYxfLyUdYhTgYFTi4d0x
        42eUEGtiWXFl7iFGCQ5mJRHe3UZAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxxGnVRQgLpiSWp
        2ampBalFMFkmDk6pBkZp4/56p+x11w2Oi9lJ9ZrXqL3N+el09+rU9f/9dm398F+W+6eGu/fj
        uv17E9YUzT72r9Wg49056Yuh7hITb085YC8WWnSo73lYy4YJmoHveWXthFZcTYx7/6XB79OG
        8++3W7ktiSg49qmY++vW8+4hs6sL1smffatSVDIp+XTuhnd/z3Su3h+qxFKckWioxVxUnAgA
        AGyKMPUCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsVy+t/xa7qHz/2KMtj3Qd3i1rpzrBYbZ6xn
        tTjW9oTd4vqX56wW848AxZoXr2ezmHR/AovF+fMb2C06Jy5ht7i8aw6bxYzz+5gsFi1rZbZY
        e+Quu8XS6xeZLFr3HmF34PdYM28No8fsjpmsHptWdbJ57J+7ht2jb8sqRo/Pm+QC2KK4bFJS
        czLLUov07RK4Mq4/b2ArOM5Z0XvrEnsD4yr2LkZODgkBE4ld25uZuxi5OIQEljBKvNm8lRXC
        aWSS+Pv6ODNIFZuApsTfzTfZQGwRAXeJZcuvgRUxC3xlkZj0/SXYKGGBYImXz16CNbAIqEo0
        z29m6WLk4OAVsJD40VQAsU1e4tn0eWDlnAKWEusnPGEBsYWASuY++8w0gZFnASPDKkaR1NLi
        3PTcYkO94sTc4tK8dL3k/NxNjMCw3Hbs5+YdjJc2Bh9iFOBgVOLh3THjZ5QQa2JZcWXuIUYJ
        DmYlEd7dRkAh3pTEyqrUovz4otKc1OJDjNIcLErivOcNKqOEBNITS1KzU1MLUotgskwcnFIN
        jF1eAsr1HxhCNk349itZSuTDxx0nr9z5mbsubevytbyvpMJuVveqe7o4PjKXOnQub8GGBsnI
        gKpVV7asuNpldGWuwWxlq5yeFHPJaXrq/Wu9JvG0THRXk+vSmZv34PrsSWv19bwXF3s/6gnM
        1/K4LbHnfNVpVWln7T1nejTtQhduMU5JUDGSUmIpzkg01GIuKk4EANIpGrBHAgAA
X-CMS-MailID: 20180515121251eucas1p160dd3dcff49f0dad845ed6be98f33bbe
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180515121251eucas1p160dd3dcff49f0dad845ed6be98f33bbe
X-RootMTR: 20180515121251eucas1p160dd3dcff49f0dad845ed6be98f33bbe
References: <20180515121239.18192-1-a.hajda@samsung.com>
        <CGME20180515121251eucas1p160dd3dcff49f0dad845ed6be98f33bbe@eucas1p1.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

OF graph describes USB data lanes between USB-PHY and respective MUIC.
Since graph is present and DWC driver can use it to get extcon, obsolete
extcon property can be removed.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 .../dts/exynos/exynos5433-tm2-common.dtsi     | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index 03453b822093..042e5894a138 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -868,6 +868,18 @@
 					};
 				};
 			};
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					muic_to_usb: endpoint {
+						remote-endpoint = <&usb_to_muic>;
+					};
+				};
+			};
 		};
 
 		regulators {
@@ -1287,12 +1299,17 @@
 
 &usbdrd_dwc3 {
 	dr_mode = "otg";
-	extcon = <&muic>;
 };
 
 &usbdrd30_phy {
 	vbus-supply = <&safeout1_reg>;
 	status = "okay";
+
+	port {
+		usb_to_muic: endpoint {
+			remote-endpoint = <&muic_to_usb>;
+		};
+	};
 };
 
 &xxti {
-- 
2.17.0

