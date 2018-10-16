Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50565C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1338720869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RNBFix26"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1338720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeJPVYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:24:32 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54606 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbeJPVYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:24:32 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181016133401euoutp01846a689d38210264d7449262a61f416b~eGh6cPp1G2590425904euoutp01C
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 13:34:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181016133401euoutp01846a689d38210264d7449262a61f416b~eGh6cPp1G2590425904euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539696841;
        bh=FDi4zCsZG2TsfcB2hzkCDWmUN6NEHGuiJXXxIFiJgIs=;
        h=To:Cc:From:Subject:Date:References:From;
        b=RNBFix26xg/SKNZ9J4BR+dxnybGzwjAThNnEcmHPyRGv9m4gXQ48QvJoMJGwIl5kK
         jDzyBk1SiOFSyoz6Jy040+knsODYFDgWTL5MhIyF4wXACM+U+seVhz5tsbsCzFuJ0G
         5GW2Q3ecVHZjZ8QjvtX6TIZFsFz2JM4r0OGzmocQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181016133400eucas1p196ec5f4b9fafc410b43d9249f76db4e2~eGh6CSuiC3214332143eucas1p1X;
        Tue, 16 Oct 2018 13:34:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4C.84.04806.8C8E5CB5; Tue, 16
        Oct 2018 14:34:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181016133400eucas1p2f5bab263e70ed0308ce47544fb64a57f~eGh5UqXXL3084730847eucas1p2h;
        Tue, 16 Oct 2018 13:34:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181016133359eusmtrp264b3e2e74b98d15a93548b10f0080f44~eGh5Gg__t1010010100eusmtrp22;
        Tue, 16 Oct 2018 13:33:59 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-e6-5bc5e8c88c06
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6F.3E.04128.7C8E5CB5; Tue, 16
        Oct 2018 14:33:59 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181016133359eusmtip1530fb7da29f2e7668a36f8fc0b2426d0~eGh43WsKz0790107901eusmtip1P;
        Tue, 16 Oct 2018 13:33:59 +0000 (GMT)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] m68k: remove redundant 'default n' from Kconfig
Date:   Tue, 16 Oct 2018 15:33:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsWy7djP87onXhyNNvg9TcPi2a29TBaXd81h
        s1j+ZC2zA7PHocMdjB4nW7+xeHzeJBfAHMVlk5Kak1mWWqRvl8CV0b/8DUvBQt6Kjra8Bsbf
        nF2MHBwSAiYS06YWdzFycQgJrGCUOPXxLyOE84VR4uz0ZjYI5zOjxPmNW1i7GDnBOnZe62OH
        SCxnlGi/9QbKeQ9U9XoDI8hcEQFdiTk/mUAamAUcJb6fmckOYrMJWElMbF/FCGILCzhI3D+0
        DKyGRUBVYu7NW2CtogIREv1n1EHCvAKCEidnPmGBGCMvsf3tHGaIG+6zSey+YwtRUyZx7u9s
        ZohvXCS+bK2EKBGWeHV8CzuELSPxf+d8JpArJQSmM0q8+bWUBcJZzyix5swxJogqa4nDxy+y
        ggxiFtCUWL9LHyLsKDH94mImiPl8EjfeCkKcwycxadt0qLW8Eh1tQhDVahIblm1gg1nbtXMl
        1MUeEkcuN4JDUEggVuL7gbvsExgVZiF5chaSJ2ch3LCAkXkVo3hqaXFuemqxcV5quV5xYm5x
        aV66XnJ+7iZGYJo4/e/41x2M+/4kHWIU4GBU4uH9cf1ItBBrYllxZe4hRgkOZiUR3vRLR6OF
        eFMSK6tSi/Lji0pzUosPMUpzsCiJ8y6btzFaSCA9sSQ1OzW1ILUIJsvEwSnVwNjp46Cff2j1
        1zsTjf7W7zX//cj0kMWE2eaTZOK33rJ9Xjm55U+k0pKT7GmT9/l9zAvPnKH7fmE4m6ZHJ9fO
        K4meXxRvWNhzT/q96t67LXe/t0rsm3l3smRmyeSnbSJOc1liZdY5ODv1uU5Rllhzq1God7uC
        0FOLrCcujXcNbvK9Pyo1m18sqFiJpTgj0VCLuag4EQCoqravDwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsVy+t/xu7rHXxyNNriwzcTi2a29TBaXd81h
        s1j+ZC2zA7PHocMdjB4nW7+xeHzeJBfAHKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdo
        bB5rZWSqpG9nk5Kak1mWWqRvl6CX0b/8DUvBQt6Kjra8BsbfnF2MnBwSAiYSO6/1sXcxcnEI
        CSxllLi6fCFzFyMHUEJG4vj6MogaYYk/17rYQGwhgbeMEp1LpEFKRAR0Jeb8ZAIJMws4Snw/
        M5MdxGYTsJKY2L6KEcQWFnCQuH9oGVgNr4CdxNxzT8FqWARUJebevAVWIyoQIXHrYQcLRI2g
        xMmZT1ggZqpL/Jl3iRnClpfY/nYO8wRG/llIymYhKZuFpGwBI/MqRpHU0uLc9NxiI73ixNzi
        0rx0veT83E2MwIDeduznlh2MXe+CDzEKcDAq8fD+uH4kWog1say4MvcQowQHs5IIb/qlo9FC
        vCmJlVWpRfnxRaU5qcWHGE2BDp/ILCWanA+MtrySeENTQ3MLS0NzY3NjMwslcd7zBpVRQgLp
        iSWp2ampBalFMH1MHJxSDYzByibvvhu/NhGZZJEV/YZdQ3d3exb7YZt9HJL7um7az1xwIZlD
        ObxndXk035ZOtbRP3z5qy/3rir3tZheR++ndzCM3dr6aNf177517AUZZynMExG5c28UolPbR
        xO+h/u77W5jU/x83ZxHcUvlKKHL2R4OEp+r5qrsfOObW3s32Z2tnODv/ibwSS3FGoqEWc1Fx
        IgDfUywCfgIAAA==
Message-Id: <20181016133400eucas1p2f5bab263e70ed0308ce47544fb64a57f~eGh5UqXXL3084730847eucas1p2h@eucas1p2.samsung.com>
X-CMS-MailID: 20181016133400eucas1p2f5bab263e70ed0308ce47544fb64a57f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016133400eucas1p2f5bab263e70ed0308ce47544fb64a57f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016133400eucas1p2f5bab263e70ed0308ce47544fb64a57f
References: <CGME20181016133400eucas1p2f5bab263e70ed0308ce47544fb64a57f@eucas1p2.samsung.com>
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
 arch/m68k/Kconfig.machine |    2 --
 1 file changed, 2 deletions(-)

Index: b/arch/m68k/Kconfig.machine
===================================================================
--- a/arch/m68k/Kconfig.machine	2018-09-03 18:11:11.397792454 +0200
+++ b/arch/m68k/Kconfig.machine	2018-10-16 15:32:04.359635259 +0200
@@ -317,7 +317,6 @@ config UBOOT
 	help
 	  If you say Y here kernel will try to collect command
 	  line parameters from the initial u-boot stack.
-	default n
 
 config 4KSTACKS
 	bool "Use 4Kb for kernel stacks instead of 8Kb"
@@ -395,7 +394,6 @@ comment "ROM configuration"
 
 config ROM
 	bool "Specify ROM linker regions"
-	default n
 	help
 	  Define a ROM region for the linker script. This creates a kernel
 	  that can be stored in flash, with possibly the text, and data
