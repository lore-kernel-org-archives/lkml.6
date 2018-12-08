Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA51C64EB1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F47E205C9
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="k/St0+Me"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F47E205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbeLHQuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 11:50:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43917 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeLHQug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 11:50:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so6522777wrs.10;
        Sat, 08 Dec 2018 08:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vndz/d0CP33O+x4SSHWTZOylTcs/OCN5J/IErAS6H/8=;
        b=k/St0+Me+QBDUt/4Wx3MS+bSZOm9FDlsG3GrK7YH1FAT2NaluS95kcQW+DPsya9xUD
         ciICvMHEF10rXUhyCaMHN5/0GzbXN3FlBr9Xcy46WkT4s1hXraRGyChRNDdWI53HSLuX
         bh8i4yU98Cun0NuljFQwUko/XffeMbfbwwTgF3gLbAx2oz+i14av+ie5gK/FhQEB3BPh
         OEmryIOEw8jMDqoGO6rIjeOoRQ7ejYTnfR5PR+mv4Dnb1dyRCv1nZLebQEQpzEmLwXh6
         lwDLizl6Si9+vHLXUnP370Kdgr0DHANMYebj6nrQz28spGGSiDomfKzBoQRWvFknj5W9
         C69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vndz/d0CP33O+x4SSHWTZOylTcs/OCN5J/IErAS6H/8=;
        b=PoTVCS1XAwtAHnRLi0yOUfc7ivmXgDqGDZ2OFlHRp7XCLSXa/XUQ1GCAMzHWyA/7zn
         xuP2reqv2jkQNWRV/lq3Bou4lGObTN84mxQ7OsQz0dyj4zKF5qjphwVftrAMPXID/aVk
         CippEjUP7Y3Nl8zIeIaWhOye6RJVtLd2UO2UQ87VAzv/XzR3rVLTHSLbiFsWoqVtZMq4
         9CArVXQin+1LRO22/f2IBpzgHnaxJFHUuTaonpFbUlxd0/LHPZwZzCkeXrGY7AaBbnjn
         BbHwC6RUYQ+9ZOq3o0LtDpR+uVVWji2N7tq/kvbgiboenC/W4yZR0Y9jZhzPgpdnWLgn
         oGpQ==
X-Gm-Message-State: AA+aEWYvf9G+uApq9E9aZ7/XSCjdWhX7TtxJiPQ3GGK2Qdg+JR6EXfDI
        VKppX81CIMbbo3MbGXV9twg=
X-Google-Smtp-Source: AFSGD/UQG1pugXzlX/+BbJ5xM/f32FRjUZeon0BEyldClx69uoiIniCO5KVgB5CUyU+cslCGfuNReg==
X-Received: by 2002:adf:f8d2:: with SMTP id f18mr5041819wrq.265.1544287833921;
        Sat, 08 Dec 2018 08:50:33 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id n15sm11395651wrt.21.2018.12.08.08.50.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 08:50:33 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/3] ARM: dts: meson8: add the APB bus
Date:   Sat,  8 Dec 2018 17:50:24 +0100
Message-Id: <20181208165025.27689-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208165025.27689-1-martin.blumenstingl@googlemail.com>
References: <20181208165025.27689-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various peripherals (Mali GPU, NAND controller, VPU, etc.) are located
in the APB bus. Describe this bus so we can add devices to it.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index e5cd325d7ea8..3fd8260eba92 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -201,6 +201,14 @@
 			no-map;
 		};
 	};
+
+	apb: bus@d0000000 {
+		compatible = "simple-bus";
+		reg = <0xd0000000 0x200000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0xd0000000 0x200000>;
+	};
 }; /* end of / */
 
 &aobus {
-- 
2.19.2

