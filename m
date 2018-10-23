Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D66CC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5962075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="irDtUNY+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5962075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeJXRsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:48:30 -0400
Received: from mr85p00im-ztdg06011201.me.com ([17.58.23.181]:56534 "EHLO
        mr85p00im-ztdg06011201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726772AbeJXRsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:48:30 -0400
X-Greylist: delayed 3623 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Oct 2018 13:48:30 EDT
Received: from process-dkim-sign-daemon.mr85p00im-ztdg06011201.me.com by
 mr85p00im-ztdg06011201.me.com
 (Oracle Communications Messaging Server 8.0.2.2.20180531 64bit (built May 31
 2018)) id <0PH300A00G7UIG00@mr85p00im-ztdg06011201.me.com> for
 linux-kernel@vger.kernel.org; Wed, 24 Oct 2018 08:20:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;     s=04042017;
 t=1540369243;  bh=vmPaMOH9bsLe+O+lPqygCxhG9Gbbg4AKdjoKwn6ERB4=;
        h=Date:From:To:Subject:Message-id:MIME-version:Content-type;
        b=irDtUNY+xec2JceHo3j9JcoMNBPLD1dO4djexmIJ6hIisdw9idj2kEWsQ/A7+L6Vb
 Osad5hVG6Q5otolX6eLIM8icYzjpMOlinTZYYKg818fYLjeYCIZ55/YUxtiePsvn0+
 vXmivkTkYxuk8g9oj2dfvW48hRmJE6BR5Ai1YViaowL5gR899IA2EqseeXRZ5Z2Xil
 6f2FAwBh65ChbHTh2h+KWg/itdZQuM3/LWVObA0OJBCNCoKwZiZ6GjIzGj/PGIMmef
 PbVDIXDThbjfZBWdvqFCPgPadlfgcJJEqEDQPlXhC4/foNHfBudqF+HdwwIbpsfY3B
 N41lJOPY2pP5A==
Received: from icloud.com ([127.0.0.1]) by mr85p00im-ztdg06011201.me.com
 (Oracle Communications Messaging Server 8.0.2.2.20180531 64bit (built May 31
 2018)) with ESMTPSA id <0PH3009LKGIF0900@mr85p00im-ztdg06011201.me.com> for
 linux-kernel@vger.kernel.org; Wed, 24 Oct 2018 08:20:43 +0000 (GMT)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=883 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810240076
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2018-10-24_04:,, signatures=0
Date:   Tue, 23 Oct 2018 18:32:00 +0200
From:   damian <linux_dti@icloud.com>
To:     linux-kernel@vger.kernel.org
Subject: Kernel Build error with gcc 9
Message-id: <20181023163200.GB18519@zrhn9910b>
Mail-followup-to: linux-kernel@vger.kernel.org
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-disposition: inline
Content-transfer-encoding: 8bit
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

i know GCC 9 is currently in deployment progress. But i tried to build a
kernel 4.19RC8 with gcc 9 and i got the following error message:

Kernel: arch/x86/boot/bzImage is ready  (#1)
ERROR: "__popcountdi2" [drivers/net/wireless/broadcom/brcm80211/brcmfmac/brcmfmac.ko] undefined!
ERROR: "__popcountdi2" [drivers/net/ethernet/broadcom/bnx2x/bnx2x.ko] undefined!
/home/damian/kernel/linux/scripts/Makefile.modpost:92: die Regel für Ziel „__modpost“ scheiterte
make[2]: *** [__modpost] Fehler 1

with gcc 8 it works fine.
 
Any suggestion what could be the cause ?

Best regards
Damian
