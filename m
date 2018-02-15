Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1276118-1518691280-2-1418818703700435671
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518691280; b=v3b111m/wJCb6lgTpJ5zWV9ybYBCwhANu4S4qJyPPRpEd8h
    OYjt8r7lRweuY2F8WQ345RIJO187Vs3w26ZCslOg2/VJZfF9J0aFiZ1LYAoxeoVN
    3RmZKTp88KfBBJy1NiWM+wqrHi+vcmKYrKkcQG411b6J5rjXiwx2b6r/1iPPKS+V
    MM8To8IA4pkHgeyaRNFfeWlJC5a2yi8FkkQFVXmwNMnQ9CFevZNeOIDoXN9bpgfU
    VqMGS14VSoecybIJjArx04W8+qZTSPIy2QvYA68YzJrbGh1iGbrWEnF7Cw29gBSg
    cjCkiAyWUcP5r5hj6AF2pJUhPnYwyGz1MgFnooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518691280;
    bh=1iVetdBY2LjX/8Y2RMsutd2pE9or8Ex7S1tTOtQ/Llw=; b=VD8rYtHQW5pr
    A2FMOqCHpdC/6fufl0/JXNxBxDK/mn3/6wYVhmodnze/6vFuBETObJI9EyEf47yW
    nKBWZ2PZ0gM8UTCOTsfudRYGp6z1EkouruVWzSZvXpLORUwgcHNjj88JKXCBHNRy
    l4+zu666nMmNxGn+m7dPiepGUvQKZrYT9w/GduCkZEjsju35lm/DUROJ2WOjSAcE
    NueZV2XguR5NqLYtxADiOZodn4EfqQzFpM25cn7e2KC9ceyyi98P3+G1DB1407a1
    86dcOk2IM4BBXM8SoU8eZ2B7oIjkjMt9Dfn7N4+I5C0lzUALutZyTbY0bFBDlRvU
    GS+jhBXsjg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=m+bXB6o8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=m+bXB6o8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030245AbeBOKlD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 05:41:03 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47551 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755365AbeBOKjd (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Feb 2018 05:39:33 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180215103931euoutp01c3f2ef590868827f05f8acb3cb5dd7e1~TeZLwFtsn1210812108euoutp01A
X-AuditID: cbfec7f2-5ffe19c000011644-77-5a85636027ee
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
Subject: [RFC PATCH v2 3/6] arm64: dts: exynos: add micro-USB connector node
 to TM2 platforms
Date: Thu, 15 Feb 2018 11:39:17 +0100
Message-id: <20180215103920.32017-4-a.hajda@samsung.com>
X-Mailer: git-send-email 2.16.1
In-reply-to: <20180215103920.32017-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTYRjG+3YuOxMXp2n4MctiIJSRlwj5IgsliYN/KV2IienUk9d52VHL
        CBOvc+YlHWZUmmZmXpfaDEktXQ0cOW8kFqKUZK20pplIF/N46r/neb7f+/C+8FGYbAmXU3FJ
        aawmSZWoIB1w48v1kYMRUflKb8MHiN60jxAoR7tIoEfVHQSa+r5AoFrTZja5+pVEFbPlOLJa
        DWJUdL1BjDrfvybQRO9tElVb+0WovjEfQ22mGTG6PzUmQvl9JrE/zbTWtAJmorRExNzS3iSY
        zuYikpktNouYroarTGl3M2BWOt2CKaWDXzSbGJfBaryORzjE3rEXYikD5KXWRb04G7QROiCh
        IH0YNg+2AB1woGR0E4D6yh5cMCsATs6bSR2gtqjpVlchbwSwxlCPCWYDwNKSn4CvIun98HfX
        NMlrZzoMLo33bkEYPYrDUYtNzDc50eGwxxDHMzjtDidsTSI+ltIIzs+FChvtgUNfcgg+ltBH
        oL4W8S2QfktC7RqP80wgnP/0AgjaCdrM3WJB74JF2uciYaAYwOH+IkwwegCttol/00fhkHls
        636M3g4rjDcw4Uop1BbIBISBhXV1mKAD4D1d2RYuo68B+KsqtRzI74JtzcCFTefUMSznk8Re
        9ORUai49KcYzKlndCTZ/geWPefkJWB2PHAQ0BRSOUm+/PKWMUGVwmepBAClM4Sy1K/OVMmm0
        KvMyq0kO16QnstwgcKVwhYv0/L4spYyOUaWxCSybwmr+v4ooiTwbxHv1udWlaSUha7nHnL/1
        LeyuHSiPPKRzbDd+tLQVfA6xP/Y2v0p1Mmo3qvJcogN6g0R2//CZk7Yz9IZ7oN638uyOdyee
        FvqWGC0Pc3JP/VgK44Ls6+eylkNxx2CibFtHfNCwm8eDZ1daxg9wCSZLgk3tt3N67+nuC5VS
        mGmSzylwLlbl44FpONVfQZpp/QEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsVy+t/xq7pxya1RBvPeWlncWneO1aKp4y2r
        xcYZ61ktrn95zmox/whQ7MrX92wWk+5PYLE4f34Du0XnxCXsFpseX2O1uLxrDpvFjPP7mCwW
        LWtltlh75C67xdLrF5ksWvceYXcQ8Fgzbw2jx+W+XiaP2R0zWT02repk87jffZzJY/OSeo++
        LasYPT5vkgvgiOKySUnNySxLLdK3S+DKmPuxnblgP1vFmrdT2BsY17J2MXJwSAiYSNxcI93F
        yMUhJLCEUeJx50VmCKeRSWLRQRCHk4NNQFPi7+abbCC2iECsxNtTn8GKmAUusEj8njiTHSQh
        LBAv8fP6A0YQm0VAVeLyqxVMIBt4BSwknjyIBglLCMhLHH7TBLaYU8BSYsp8C5CwEFDFxsnz
        WCcw8ixgZFjFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGK7bjv3cvIPx0sbgQ4wCHIxKPLwG
        Ni1RQqyJZcWVuYcYJTiYlUR4P0a1RgnxpiRWVqUW5ccXleakFh9ilOZgURLnPW9QGSUkkJ5Y
        kpqdmlqQWgSTZeLglGpgZLe4KdX7V2bRibfG7Wcuyjrr3vwXNPPemsfzp3nFrGptMGRerLnj
        87wrxpoLtq99c2yOhA6HGptfZPKcOXJsOZNieRxdVIqnFntOOp34VnvmDfvFQh6eR+Nru3/x
        d6UqLzl8YlePhmLhpoLFE0Mzj/3V01IXdyhenhPMeu+NkvYXl9pLK61OKLEUZyQaajEXFScC
        AC3oIcpTAgAA
X-CMS-MailID: 20180215103927eucas1p1009da1dfa940fa3a39e29c8d0894f305
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180215103927eucas1p1009da1dfa940fa3a39e29c8d0894f305
X-RootMTR: 20180215103927eucas1p1009da1dfa940fa3a39e29c8d0894f305
References: <20180215103920.32017-1-a.hajda@samsung.com>
        <CGME20180215103927eucas1p1009da1dfa940fa3a39e29c8d0894f305@eucas1p1.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since USB connector bindings are available we can describe it on TM2(e).

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index a1e93d91a3ed..7e49fadee412 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -798,6 +798,13 @@
 
 		muic: max77843-muic {
 			compatible = "maxim,max77843-muic";
+
+			musb_con: musb_connector {
+				compatible = "samsung,usb-connector-11pin",
+					     "usb-b-connector";
+				label = "micro-USB";
+				type = "micro";
+			};
 		};
 
 		regulators {
-- 
2.16.1

