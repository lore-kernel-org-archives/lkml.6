Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2152BC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF9820869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pZ5hXuc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF9820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeJPVVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:21:41 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53403 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeJPVVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:21:40 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181016133108euoutp01ad148d323644ab0d7fe57a710312be80~eGfZ09gL92477224772euoutp01u
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 13:31:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181016133108euoutp01ad148d323644ab0d7fe57a710312be80~eGfZ09gL92477224772euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539696668;
        bh=DYSJDwdy9T36a0BNbl8xcXhKoomqJcjNl8wzzHGEir0=;
        h=To:Cc:From:Subject:Date:References:From;
        b=pZ5hXuc/XGSTFGxJHPUk6cgn77kcC7JLRiOfg1AfVCdiIo7+PUVWQufr4/zUuP9TF
         C2p/U9cNazhyCCbLD+c/JDsEBk+mtywgO/t6G0AU9Z5vWWHMUJPqwJ/JUpnogcgD5J
         olhlnZ/l+bc0296GnP3T57Ml6Qw1tqkRER+lXf2I=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181016133108eucas1p19a9af402f67bf514634deec1d31cb0ef~eGfZXAIpa0979809798eucas1p1v;
        Tue, 16 Oct 2018 13:31:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id BD.73.04294.C18E5CB5; Tue, 16
        Oct 2018 14:31:08 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181016133107eucas1p26f6edf4824df4b9ba464bd55edaeac85~eGfYreRiL1249012490eucas1p2n;
        Tue, 16 Oct 2018 13:31:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181016133107eusmtrp27d58bd30a9734082cf47611bfecbd454~eGfYqytc80938509385eusmtrp2Y;
        Tue, 16 Oct 2018 13:31:07 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-f0-5bc5e81cb558
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 32.DD.04128.B18E5CB5; Tue, 16
        Oct 2018 14:31:07 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181016133107eusmtip21ddec91a51e20391a33678960540aa51~eGfYahd1G0511305113eusmtip2z;
        Tue, 16 Oct 2018 13:31:07 +0000 (GMT)
To:     Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Cc:     linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] c6x: remove redundant 'default n' from Kconfig-s
Date:   Tue, 16 Oct 2018 15:31:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZduznOV2ZF0ejDba+4LR4/2Q1s8WR2ROY
        LC7vmsNm8X/6ZkYHFo+ds+6ye+zY9JrJ4/2+q2wenzfJBbBEcdmkpOZklqUW6dslcGUc2PKc
        veCpYMXsVasYGxgv8HYxcnBICJhI7LzK3cXIxSEksIJRov/GB3YI5wujxPszC1m7GDmBnM+M
        EjduZ4LYIA1357ayQRQtZ5T4+fckI4TznlFi/ayD7CBVIgLhEldvz2ABsZkFbCXW3YeIswlY
        SUxsX8UIYgsLOEos61kOtoFFQFXi3qO3jCAniQpESPSfUQcJ8woISpyc+QRqjLzE9rdzmEF2
        SQi8Z5OYfeklI0RRmcTPhrVMENe5SKxbvZwdwhaWeHV8C5QtI/F/53wmiObpjBJvfi1lgXDW
        M0qsOXMMqtta4vDxi6wgVzALaEqs36UPEXaUWLh8DQskvPgkbrwVhDiIT2LStunMEGFeiY42
        IYhqNYkNyzawwazt2rmSGcL2kJi4vo8NEqCxEhfWvGScwKgwC8mbs5C8OQvhhgWMzKsYxVNL
        i3PTU4uN8lLL9YoTc4tL89L1kvNzNzECE8jpf8e/7GDc9SfpEKMAB6MSD++P60eihVgTy4or
        cw8xSnAwK4nwpl86Gi3Em5JYWZValB9fVJqTWnyIUZqDRUmcd9m8jdFCAumJJanZqakFqUUw
        WSYOTqkGxqkvH7dd/S1pVxfC+saCX/q98ZKfk3fvvrh6k2r98suuNutjywW+d2ROvifAf+HY
        2yN+2leN7i+cFtDlM/nAx48vH5+Z2jXDsy1W4EWw1JunzQtUF36rK1+3qSniI8+UWeIlLVGF
        lz/yKl/OCdonlpr9qWfj2/ip7y8utHz+RVn5tJem8cuH9ceUWIozEg21mIuKEwFxcimeHAMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsVy+t/xe7rSL45GG/w+qGrx/slqZosjsycw
        WVzeNYfN4v/0zYwOLB47Z91l99ix6TWTx/t9V9k8Pm+SC2CJ0rMpyi8tSVXIyC8usVWKNrQw
        0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Ms4sOU5e8FTwYrZq1YxNjBe4O1i5OSQ
        EDCRuDu3la2LkYtDSGApo8SCK43sXYwcQAkZiePryyBqhCX+XOuCqnnLKPHswhcmkBoRgXCJ
        PYe1QWqYBWwl1t0/yA5iswlYSUxsX8UIYgsLOEos61nOCmLzCthJzHlzmxnEZhFQlbj36C1Y
        jahAhMSthx0sEDWCEidnPmGBmKku8WfeJWYIW15i+9s5zBMY+WchKZuFpGwWkrIFjMyrGEVS
        S4tz03OLjfSKE3OLS/PS9ZLzczcxAgN927GfW3Ywdr0LPsQowMGoxMP74/qRaCHWxLLiytxD
        jBIczEoivOmXjkYL8aYkVlalFuXHF5XmpBYfYjQFOnwis5Rocj4wCvNK4g1NDc0tLA3Njc2N
        zSyUxHnPG1RGCQmkJ5akZqemFqQWwfQxcXBKNTBu3j7JPt1sZ1X60kW7XtodVLP+/76LcY6P
        85tK4x03b9U2JsypuTzLx6z46jHdBBcZv9ZlomY8h+S9zqemRCS33Q5Zf5r3yKm9Gnln7pz0
        FV/0Q0I8ndH37PZsl9w1XNkhhQuXV7kr74u+7tWd9WejQybv/6eXK1snTlzOyWW8c67S3PDV
        7vlKLMUZiYZazEXFiQBD1j0DigIAAA==
Message-Id: <20181016133107eucas1p26f6edf4824df4b9ba464bd55edaeac85~eGfYreRiL1249012490eucas1p2n@eucas1p2.samsung.com>
X-CMS-MailID: 20181016133107eucas1p26f6edf4824df4b9ba464bd55edaeac85
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016133107eucas1p26f6edf4824df4b9ba464bd55edaeac85
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016133107eucas1p26f6edf4824df4b9ba464bd55edaeac85
References: <CGME20181016133107eucas1p26f6edf4824df4b9ba464bd55edaeac85@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'default n' is the default value for any bool or tristate Kconfig
setting so there is no need to write it explicitly.

Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
is not set' for visible symbols") the Kconfig behavior is the same
regardless of 'default n' being present or not:

    ...
    One side effect of (and the main motivation for) this change is making
    the following two definitions behave exactly the same:
    
        config FOO
                bool
    
        config FOO
                bool
                default n
    
    With this change, neither of these will generate a
    '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
    That might make it clearer to people that a bare 'default n' is
    redundant.
    ...

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/c6x/Kconfig           |    2 --
 arch/c6x/platforms/Kconfig |    5 -----
 2 files changed, 7 deletions(-)

Index: b/arch/c6x/Kconfig
===================================================================
--- a/arch/c6x/Kconfig	2018-10-09 15:58:36.295122871 +0200
+++ b/arch/c6x/Kconfig	2018-10-16 15:28:50.623630380 +0200
@@ -70,14 +70,12 @@ config CMDLINE
 config CMDLINE_FORCE
 	bool "Force default kernel command string"
 	depends on CMDLINE_BOOL
-	default n
 	help
 	  Set this to have arguments from the default kernel command string
 	  override those passed by the boot loader.
 
 config CPU_BIG_ENDIAN
 	bool "Build big-endian kernel"
-	default n
 	help
 	  Say Y if you plan on running a kernel in big-endian mode.
 	  Note that your board must be properly built and your board
Index: b/arch/c6x/platforms/Kconfig
===================================================================
--- a/arch/c6x/platforms/Kconfig	2018-09-03 18:11:11.249792456 +0200
+++ b/arch/c6x/platforms/Kconfig	2018-10-16 15:29:04.891630739 +0200
@@ -2,20 +2,15 @@
 
 config SOC_TMS320C6455
 	bool "TMS320C6455"
-	default n
 
 config SOC_TMS320C6457
 	bool "TMS320C6457"
-	default n
 
 config SOC_TMS320C6472
 	bool "TMS320C6472"
-	default n
 
 config SOC_TMS320C6474
 	bool "TMS320C6474"
-	default n
 
 config SOC_TMS320C6678
 	bool "TMS320C6678"
-	default n
