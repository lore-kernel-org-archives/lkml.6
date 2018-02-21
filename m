Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1047503-1519203383-2-779243343172800050
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
    t=1519203383; b=Z3dAlMdIutZDisKVY6xjjU389rVrQqqU97kUK19YztyaeyF
    jXjYVW2f1xQEUO3jCHjRHs5qnimPZx/utae7NRpjLyVx3cId5j3ytmr9VCdtssRW
    FDMVWnbS6KsZz7k9uEuiIaZosB64CL7E8DWy/qm/7BvEY20tFSk4AftHh1lMcNZ7
    rmbMeHShL76oqr6Xg37Vxj8mf/IjpuZNS6fmwtl7KoSh6o7WwGgKhzmfpJ6OjPPX
    X1kqUCAnozTTsgXq/fKFcBOeIvK+IbG3ldcSEVZkF8o+fiySG4J8P+VA0oKbytdB
    E4nG/McNF0UvkYRPjARasppMVuHzILijzT4K4lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519203383;
    bh=lf1MIceMtnSqAPQdc39VuIV6HHISQg2ZJw+T5cp2jK0=; b=VQ7BMP4Kg5bl
    RuWTDH3Ec3ZHODDx8TV0LLp4+RkQeSsnoNBdQgbWtA60v1KPNI71kaT5FZp85Tnh
    Ky2SADEohM4Ir4tPOZ2LvMHyi0mQE3C/2eDydH6Z9z0qJRBuuZ+hYQmAJrIiI+or
    sCDA2JedV3CRI/UMP5ISWcko5KZqVMVEQKIdssTjDebtJKUid56+2/F6Sn0XA7po
    p3rbF5/lQ2Vqu9g/SP1mI58oI/DJrMFhIRvBdzRmNrB+mAbnk8sRfJFauu4LEqq5
    uUTjs7cCr5pCZZeOzS1udfMh+LF52T8XX9Ntn47sOEuNbR77AwpfhpmZ1WoV1OVF
    XdSNdmw+FQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=XGZweLOk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=XGZweLOk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbeBUI4S (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 03:56:18 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57108 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbeBUI4J (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 21 Feb 2018 03:56:09 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180221085607euoutp026ac969b4cd291327439f0e6165e03974~VS2ngEBS12484424844euoutp02U
X-AuditID: cbfec7f2-1dbff70000011644-3d-5a8d34266ba5
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
Subject: [PATCH v4 3/6] arm64: dts: exynos: add micro-USB connector node to
 TM2 platforms
Date: Wed, 21 Feb 2018 09:55:38 +0100
Message-id: <20180221085541.14556-4-a.hajda@samsung.com>
X-Mailer: git-send-email 2.16.1
In-reply-to: <20180221085541.14556-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWy7djP87pqJr1RBitPS1jcWneO1aKp4y2r
        xcYZ61ktrn95zmox/whQ7MrX92wWk+5PYLE4f34Du0XnxCXsFpseX2O1uLxrDpvFjPP7mCwW
        LWtltlh75C67xdLrF5ksWvceYXcQ8Fgzbw2jx+W+XiaP2R0zWT02repk87jffZzJY/OSeo++
        LasYPT5vkgvgiOKySUnNySxLLdK3S+DKuPBZqGA/W0Xb+vusDYxrWbsYOTkkBEwkdm9YBWRz
        cQgJrGCUOLltBjOE85lRYmbTPEaYqmMv30FVLWOU2L7qGDtIQkjgP6PE8ak6IDabgKbE3803
        2UBsEYFYiXeXdoFNYha4wCJx4fQrsAZhgWiJDY8egk1lEVCVuPRsMdgdvAIWEks2rGWH2CYv
        cfhNE1icU8BS4vfeSWCDJARus0m8uPUUqshF4ueHdUwQtrDEq+NboOIyEpcnd7NANHQzSpza
        1wnVPYVR4vyry1Ad1hKHj18EW8EswCcxadt0oCIOoDivREebEESJh8TuKbdZIMKOEnv2yEO8
        38Mo8e9YD+sERqkFjAyrGMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAtPB6X/HP+1g/Hop
        6RCjAAejEg+vhU5PlBBrYllxZe4hRgkOZiUR3kqh3igh3pTEyqrUovz4otKc1OJDjNIcLEri
        vHEadVFCAumJJanZqakFqUUwWSYOTqkGxslsTg+uq7YlCNTY8n/Nauj++n6r0LaIr07X9Hb9
        bF/iUv0nYuWpzsxXuy+FCqezTI/oOMwnsaXrz+f46t6MpL3Cy+qenhFWvmjos+zaObWL86ak
        fU/c+MXf3zNK+6TVqY1ri46w7xT/KuiuXeTVWM0+VXJxj1tyF9Oqz/9eb9r5sbfG7/yOV0os
        xRmJhlrMRcWJAAmgHQoDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsVy+t/xa7qqJr1RBldOmVvcWneO1aKp4y2r
        xcYZ61ktrn95zmox/whQ7MrX92wWk+5PYLE4f34Du0XnxCXsFpseX2O1uLxrDpvFjPP7mCwW
        LWtltlh75C67xdLrF5ksWvceYXcQ8Fgzbw2jx+W+XiaP2R0zWT02repk87jffZzJY/OSeo++
        LasYPT5vkgvgiOKySUnNySxLLdK3S+DKuPBZqGA/W0Xb+vusDYxrWbsYOTkkBEwkjr18B2Rz
        cQgJLGGU2H3pABNIQkigkUliyUwPEJtNQFPi7+abbCC2iECsxNtTn5lBGpgFLrBI/J44kx0k
        ISwQLXHy5iuwIhYBVYlLzxaDbeAVsJBYsmEtO8Q2eYnDb5rA4pwClhK/905ihlhmIfHh3Ff2
        CYw8CxgZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgQG7LZjP7fsYOx6F3yIUYCDUYmH10Kn
        J0qINbGsuDL3EKMEB7OSCG+lUG+UEG9KYmVValF+fFFpTmrxIUZpDhYlcd7zBpVRQgLpiSWp
        2ampBalFMFkmDk6pBsYrtj+SmUKeuoqW3KpWm9Fvy/SC6aNXwO+qdl7Z5DKJ3v8Mvp/ecn7e
        aVp68I/1wnN2Ri8SPj7ve1S2SEnUeOXZzUkzoheedFQ8oW0avixYpO5NbfeimeG8nwyOTc3m
        b8hVL53ps55D5KaTyew434QDkz8fCs9q2ffu46zO9lPmU9IEni1VdlViKc5INNRiLipOBAAV
        SLCoVAIAAA==
X-CMS-MailID: 20180221085605eucas1p1b2da327fbaaf9851e2407e1d2a39c370
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180221085605eucas1p1b2da327fbaaf9851e2407e1d2a39c370
X-RootMTR: 20180221085605eucas1p1b2da327fbaaf9851e2407e1d2a39c370
References: <20180221085541.14556-1-a.hajda@samsung.com>
        <CGME20180221085605eucas1p1b2da327fbaaf9851e2407e1d2a39c370@eucas1p1.samsung.com>
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
index 0b61dda99569..f604f6b1a9c2 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -836,6 +836,13 @@
 
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

