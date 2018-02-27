Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-757978-1519715517-2-8409943014775652413
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES encafr, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519715516; b=d//esfhIHmN3Dyw5eUjeLgmhKxtWXMLl0pFp81uFQ0tEZu2
    whCEhVU2DDuW89hf34c9b1a1aEZrswE5REOsmy2yMZ7nwJl/Lhh1GrOGhs5MLlAz
    1DSPQeMPhCgeNgA6MabsgBtbRXqgeIv99Nq4s8ZTjWhhz8u1x/Bn+N9+eELyaXu5
    ygDVJhZUjUHoO0HCsIExinGWlj55Pw8IjMZRMKUONBO4G2uPlGWlrqIA80hpfJAF
    q64C27+5ndn19GSnHmabGGngmN7T0zeJzKzNH0mS70CtEN4uuinaPUPW43MPSFtJ
    vS9rMICSJP3QC9iPBz35K+bp8C/PrT2+u6j1ypQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519715516;
    bh=xWDaMznBZPpcQpqsiA+auuj8nKENc+1EHnbnm+SM0w4=; b=PpwP26JVaEvX
    d6ridAYqsYL5l366Ni9yXo7bih8OqWQ7zP6bUVoUAv4YO2Q5mrHl3JZn8JZOF8n2
    eENFHPSGi6Tye0ojutZAdBoMrEMjy7QkuGVEY/5unw/P1aX/5XgKAhs4O7iLg/Eb
    tFSaJ4TGjF7chgsR2cGFOLUyg1Jati3eA+i6vqWMYEGySkggI2Mab4gZ+d6ugsYL
    /+2Ixbp8bqlqL5IS6NofHkCL4j6CVh5eBc8+2HiB3rX1g6bUuEP3Wv066gxQM/SW
    cp+cP0AIgeS8wNbGtonj7kIjRNj3MrqOjZCSX8D1+seIngGSuXm8M26Xl4+X72DD
    8I6XGecvmw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=CtH6AxF3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=CtH6AxF3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeB0HLv (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 02:11:51 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50110 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752109AbeB0HLo (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 02:11:44 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180227071142euoutp029b75d0b6ef64f498d0edd39c822e3246~XHTKKf5NZ2547425474euoutp02z
X-AuditID: cbfec7f5-b5fff700000028a9-b1-5a9504ad3e2c
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
Subject: [PATCH v5 3/6] arm64: dts: exynos: add micro-USB connector node to
 TM2 platforms
Date: Tue, 27 Feb 2018 08:11:31 +0100
Message-id: <20180227071134.28063-4-a.hajda@samsung.com>
X-Mailer: git-send-email 2.16.2
In-reply-to: <20180227071134.28063-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTURzGPbt3d3fD2WUKnqZUjIoUslfohiVmMS7VB6EvMbFaeVHLTdtV
        axYlobGlme+ZWuYrZi5t86VGulyjkaZzrTSdoiRaWmmoI8TKtl389jz/53ee/+FwcET0CxXj
        icpUWqWUJ0kwAdrxdsW2U4eWyHYX9WDk6LMBLnlL85NLPi9r4ZLDy1+5ZJXFPfvoWsDIwol8
        lLTZWnmktqCOR+qnhrikw1iJkWW2bg5Z05CNkDrLOI+sH7ZzyOwuCy+SoJofNQPKkXeXQ1Vo
        HnApfZMWoyZyrBzKUHeTymtrAtSSflM0LhMciqOTEtNp1a6Ic4KEmf5WNMWEXa1ph5lAx70D
        +Dgk9sOxArtbC3AR0QigoyILYc0SgJ/fTaDrVPuqEbBBA4CLBivKmjUAO0vmEQ+FESHwr2EE
        8+gAIhbOfzB6qxBiEIWDfXM8T+BPxMBvGo13OUpsg47VKe9cSJBwsWYNY9dthtX9n7ylfOIg
        NJW+xzxFkHBi8HfnD/cB3G2Owaf3wlneH85Z23isDoZaTQ+H5XMA7O3WIqwpBtA25+CwVDh8
        Y7V7b4EQfrCw4z7Clgqh5raIRShYOekCrD4Cpxpfed9CROQCWF+O5APxY+DTBALpNEYRTzP7
        lPSVMEauYNKU8WEXkhV64P4Hff+srheg+895MyBwIPEVRgYXy0RceTqjVpgBxBFJgPBJbZFM
        JIyTqzNoVfJZVVoSzZhBEI5KAoVndtyQiYh4eSp9iaZTaNV6ysH54kzgzDgtFQSZAiPipmcl
        XdL+Ub70+vBkeYj5QIy+xWD02er7hZkSj1Pf1UNZG6VVfkhVlnNMHW1fO/x6jeM8Yd++unCy
        VhBa/VL3ULfFd+Z41ORAs2XZt1dgSqxr21taetkQlWtMXZnut9WtjlxT+Ou6LhYfHa2c3RBb
        aRqIcJ2SoEyCfE8oomLk/wGxNp/mAwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsVy+t/xy7qrWaZGGUyebWVxa905Voumjres
        FhtnrGe1uP7lOavF/CNAsStf37NZTLo/gcXi/PkN7BadE5ewW2x6fI3V4vKuOWwWM87vY7JY
        tKyV2WLtkbvsFkuvX2SyaN17hN1BwGPNvDWMHpf7epk8ZnfMZPXYtKqTzeN+93Emj81L6j36
        tqxi9Pi8SS6AI4rLJiU1J7MstUjfLoEr49nZDSwF+9kqFm2VaGBcy9rFyMkhIWAisfX3LsYu
        Ri4OIYEljBLd75+wQjiNTBKTTmxnBqliE9CU+Lv5JhuILSIQK/H21GdmkCJmgQssEr8nzmQH
        SQgLREuc6/sC1sAioCpx+fdjsDivgIXEp0X/2SDWyUssPHsVrIZTwFJi/7QzYHEhoJr7ncdY
        JzDyLGBkWMUoklpanJueW2yoV5yYW1yal66XnJ+7iREYstuO/dy8g/HSxuBDjAIcjEo8vDPk
        pkQJsSaWFVfmHmKU4GBWEuFduXhylBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe8waVUUIC6Ykl
        qdmpqQWpRTBZJg5OqQbG1klJP/wk6iWS5uqavbFcJXiy9WdV27zo85K3JlU8O7qdu6pt5hmF
        CYu0/k9N/nDlrv7Wn/2b41iWbM29zpFjZJumzm5/790eAc9Pr++7H9za/VbDqP9IcdeSGpbl
        KzndLh4OURK7kLAz63ppXfPSgxt2H+9OF1HqSBHi8ZvQm/7+14Jzas/FlViKMxINtZiLihMB
        bjgOMlUCAAA=
X-CMS-MailID: 20180227071139eucas1p1d28b39a6636a7e6625aeb3a16091f81a
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180227071139eucas1p1d28b39a6636a7e6625aeb3a16091f81a
X-RootMTR: 20180227071139eucas1p1d28b39a6636a7e6625aeb3a16091f81a
References: <20180227071134.28063-1-a.hajda@samsung.com>
        <CGME20180227071139eucas1p1d28b39a6636a7e6625aeb3a16091f81a@eucas1p1.samsung.com>
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
2.16.2

