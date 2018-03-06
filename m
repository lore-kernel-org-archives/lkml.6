Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3003213-1520296053-2-99741121487863286
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520296053; b=ARKXRwTyMWTrBn2P+A3bhJgwjW0td5qVpAPWJS8uN006eVm
    hw4yRRD2gJDrMsly2fqbn3OT2ZvngDQ7sSCfSlR2/zj7Wg7+5bL0Wa4pyut5XQyv
    LBigRtCZpw+M6zmmgHRWXMMIiP+T3OeQB2znKjVupVIimc+i0J2OsikLqjwSHy4F
    3MY9dROADTBS79iAKredYcwtlFmAFBPpJNJkJI0HJgVVODlInsuHo+eHV2mTAYxy
    X6/w8fYOKLYsVMIGPq4Uw01K1scDvBcThCIIb1btJopqdJzMMZDVaQL3NIm3vv71
    Z/5QlZ8zVb9XFmh+a1G31Ttm93FuNUHKFFiZiPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520296053;
    bh=DTajfdMi2DzVvpv4tMGwJgmg3l2ccIrodBJpjye2SuY=; b=MAAHoDSDnq0p
    XF6eHI40QBmM+GPfFiUgquXOofWRQ45JO4aN4/Yq1n4xKZlj00QdVlly+bjrG/Te
    SCRfGh+Nf3Vnj4B3yVVZ9G9GGyv13JJ0sLlsYovOsr9UqhIcsIzrTkSVTu0CzaG+
    2sADs8IJ59eDybwNtpUca+zrjstTyDw4qsCHIhlabrJjPZAs3LNKEXRxHKwBkZW9
    xlMxdx1S8sARS9pj/6IU6BVnUmX+qo5XIFBHWKp9w/q/coU7Dv+znT+vvBDJKuGu
    bRENSvTpKrASd9CUJw89UHHMAwJafeNKmLqssuxtR0fkRJa3MkvS+pcwt2ISib9S
    /Kfy8lFZNA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=N+7iWTc8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=N+7iWTc8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932581AbeCFA1a (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 19:27:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43192 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933542AbeCFA1A (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 19:27:00 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 63/65] kpti: Disable when running under Xen PV
Date: Mon,  5 Mar 2018 19:25:36 -0500
Message-Id: <20180306002538.1761-64-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=684
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060005
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Very very partial backport from aa8c6248f8c75 where
there is a check to see if this is an Xen PV guest - and
if so disable it.

The reason is that the PV ABI would require a major
overhaul to be Meltdown resistent.

Instead there are mitigations (PV in HVM) which are far more
suitable.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/mm/kaiser.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/mm/kaiser.c b/arch/x86/mm/kaiser.c
index 50783ad4861d..05fb616c9e2a 100644
--- a/arch/x86/mm/kaiser.c
+++ b/arch/x86/mm/kaiser.c
@@ -10,6 +10,7 @@
 #include <linux/mm.h>
 #include <linux/uaccess.h>
 #include <linux/ftrace.h>
+#include <xen/xen.h>
 
 #include <asm/kaiser.h>
 #include <asm/tlbflush.h>	/* to verify its kaiser declarations */
@@ -264,6 +265,9 @@ void __init kaiser_check_boottime_disable(void)
 	char arg[5];
 	int ret;
 
+	if (xen_pv_domain())
+		goto disable;
+
 	ret = cmdline_find_option(boot_command_line, "pti", arg, sizeof(arg));
 	if (ret > 0) {
 		if (!strncmp(arg, "on", 2))
-- 
2.16.2
