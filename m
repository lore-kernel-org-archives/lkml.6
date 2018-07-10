Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58175C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1072B20878
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Zh72vfA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1072B20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751303AbeGJHQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 03:16:19 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:28699 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751010AbeGJHQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 03:16:17 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180710071615epoutp033dd423f106be7e6730207de45006431f~-8KG90Diy2877128771epoutp03U
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 07:16:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180710071615epoutp033dd423f106be7e6730207de45006431f~-8KG90Diy2877128771epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1531206975;
        bh=MjbxP5mDK5ZTTttS7ARqUyLwSWBJPtqVu1yHlS6Lbpc=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=Zh72vfA/BeMDlgtm1xZuyPJCh5DGGfp4+6FkGv4LqfyXDI7dbQ6o5/5za6aN8HS9B
         Kv3tvtkX6bCY/xab5LEfAhqrbwG9hQutT1V4W8J5AzwhRDJHs91mbp/clAmjRp/qix
         4IrtBl4TxO7JciYca7HB2OuYBm+XrPBBFf6OUZv8=
Received: from epsmges5p3new.samsung.com (unknown [182.195.40.194]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20180710071615epcas5p2fc239cc8d8f203b51946440644ad912d~-8KGemSQE0111501115epcas5p2W;
        Tue, 10 Jul 2018 07:16:15 +0000 (GMT)
X-AuditID: b6c32a4b-989ff70000001138-71-5b445d3f20b3
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.E0.04408.F3D544B5; Tue, 10 Jul 2018 16:16:15 +0900 (KST)
Message-ID: <2014348883.271177.1531206974788.JavaMail.jboss@ep1ml503>
Mime-Version: 1.0
Subject: RE: linux-next: build warning after merge of the printk tree
Reply-To: maninder1.s@samsung.com
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Petr Mladek <pmladek@suse.com>
CC:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vaneet Narang <v.narang@samsung.com>,
        PANKAJ MISHRA <pankaj.m@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180710164514.22c552db@canb.auug.org.au>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Date:   Tue, 10 Jul 2018 12:46:14 +0530
X-CMS-MailID: 20180710071614epcms5p5cd2a40c566d92969fdc749bd6de58b5c
Content-Type: multipart/mixed;
        boundary="----=_Part_271176_1830423383.1531206974788"
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmlq59rEu0Qc9qPovLu+awWRxc2MZo
        ce/NViaL/4+/slps3XuV3eLQybmMDmwejTdusHn0bVnF6LF+y1UWj8+b5AJYolJtMlITU1KL
        FFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4CWKymUJeaUAoUCEouL
        lfTtbIryS0tSFTLyi0tslaINDY30DA3M9YyMgLRprJWRKVBJQmrGlkU/WAva+SquzPrH3sB4
        iqeLkYNDQsBEYskrzy5GLg4hgd2MEr8+9zB1MXJy8Aq4Slw5/YMNpIZXQFDi7w5hEFMYKNy2
        pQSkQkhAUeLCjDWMEGEDiV9bNUDCbAJ6Eqt27WEBCYsIeEscuS4OMpxZ4BCjxJenDWDDJQR4
        JWa0P2WBsKUlti/fyghicwqYS1y6sYMNIi4qcXP1W3YY+/2x+YwQtohE672zzBC2oMSDn7uh
        4jISqzf3soAskxBoZ5TY/uAME4QzhVGi5eJdqG3mEudPzgfrZhFQlTjXvA/qIheJKaeOgG1j
        FgiTWNI5jQ3C5pPo/f0E7uod82BsVYmWmxtYYT74/PEj1HwPiYVvNjNCAqhOYuODh+wTGOVm
        IUJxFpINELa8xPa3c5hBSpgFNCXW79KHCKtJTOn/AlViJXH60mYoW1FiSvdD9gWM7KsYJVML
        inPTU4tNC4zzUsv1ihNzi0vz0vWS83M3MYLTppb3DsZN53wOMQpwMCrx8G5IdY4WYk0sK67M
        PcSoAjTr0YbVFxilWPLy81KVRHgNcoDSvCmJlVWpRfnxRaU5qcWHGE2B4TSRWUo0OR+Y6vNK
        4g1NjczMDCwNTI0tzAyVxHl/XBeIFhJITyxJzU5NLUgtgulj4uCUamD041sQldCs8eCnonXO
        A4437ypY3jvaXOnmf/DAriZweqXuhZ8PIu7+yrq+/aPM3/UqdT2pKVz6rdus782RFbixN3D5
        DcZtO1f1n5I0XLE1ZrFfXWh/LD8H7+7NXw06CkIP7j04pTD/y8pF3G98Jl3y7/wfWbK7i5Pl
        1t3siYd/e2zZ471B/ICqEktxRqKhFnNRcSIAhKQVFb0DAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180710064527epcas1p16fd9ad765711d69264b3251890bbcc2e
References: <20180710164514.22c552db@canb.auug.org.au>
        <CGME20180710064527epcas1p16fd9ad765711d69264b3251890bbcc2e@epcms5p5>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_271176_1830423383.1531206974788
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"

Hi Petr,
 
> Hi all,
 
> After merging the printk tree, today's linux-next build (x86_64
> allnoconfig) produced this warning:
 
> kernel/printk/printk.c:2033:13: warning: 'suppress_message_printing' defined but not used [-Wunused-function]
> static bool suppress_message_printing(int level) { return false; }
             ^~~~~~~~~~~~~~~~~~~~~~~~~
 
seems there is no user for suppress_message_printing when CONFIG_PRINTK is disabled,
because earlier it was getting used in console_unlock and now we shifted this into vprintk_emit
which will be disabled on disabling CONFIG_PRINTk.

should we remove this defination when CONFIG_PRINTK is disabled ?

> Introduced by commit
>  375899cddcbb ("printk: make sure to print log on console.")
------=_Part_271176_1830423383.1531206974788
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="No File Name 0"
Content-Transfer-Encoding: base64

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NCg0KaVFFekJBRUJDQUFkRmlFRU5JQzk2Z2la
ODF0V2RMZ0tBVkJDODBsWDBHd0ZBbHRFVmZvQUNna1FBVkJDODBsWA0KMEd4UVR3ZjlFWndkdHJY
TUxRd0QxL3FKT2FkUkhzMWZ5dlQ1bnlVZE1iQ1BjdGFNa2RJbTROc3l4MWxhaThyLw0Kb0ZNamps
TXFtd08rWXFuZVJ3b2podituQVo3NytDdEJVUm5WN2sycmlhemYzbUhjclVqSEN6ZlEyZWw1Rmdz
ag0KNnAzWWFvd2w0NStsVFZZYTl1RVp4czU5UVdXRnJabmZQS2REazhqREZlRnBwRzFOM1VIcjly
UUptOXBpczZUQQ0KOXJaRnVjeWVXQVpBZTd3TWticGVLUGw4d2hwVlVQWHh3RGd0Z0lqaW90Vmc1
dEtsdUM3Uk5jUXdMek1iQkgwbw0KdTJoYVgzU0RmZXFPZHhpMDVXZWg0UUlYS283a0ZBeVgzb3Mr
d3l5VVBvSXY0MHVXdWhMQWYxSTZXaGRQQmRiaQ0KZ0xDaXVLNXhybk5ZbWd4VVJnN21vSFVRKzBQ
ekR3PT0NCj1iU3JNDQotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0NCg==

------=_Part_271176_1830423383.1531206974788--
