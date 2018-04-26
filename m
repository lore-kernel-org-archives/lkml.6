Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3121895-1524774617-2-9782190109763147811
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524774616; b=aM/Lz7zubevynJsKuQixIW6Jm3Av1CdmzqJTmBQ95qOu0RJLMB
    f8ANRCdy4UuZPWndGiP+kr8WEr5DmvNsCPjbKT6zGQWOCrs9PPcLZdlNBBpPBD2y
    l8R5XKrTFPnVGOqQQMVPcVJ2nrF62LW4r0VfvIoF7QxlwJokX8rlbgZrUVowiwMZ
    PWB7jpBKicdss8PPmjmY0v0ll0Ph+b5ZWTLYlgEKnEiMR5ETMbkJAr7ykVPrGaNN
    Wq1gj6j/0Hfo+I1PtCTDA/1FHOHcI7tg77qsXF3ViLr9CfLaAo1J/YwrioilOIoP
    O8c5i3LWvIwmKCsbnMFNaFRcPGrxczbWDPyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:sender
    :list-id; s=fm2; t=1524774616; bh=l3kKyPXIX1yDp8Ou/+Mv1/mhf1H8j0
    XubpYxmsxkpUc=; b=nx569AuTShPY14qlmp0AE/PH4DWeHP5TOtP2D8h8W2uOpR
    pAlXIZYiX6NHGKlzxLu+J1rr0zP2WL6Y77QjIpziombKhzBSVuZqtvwTibatwpZ2
    KtPYw0sBwwIEXl6a3TvIIxULn6HKO6ok5Li2TcvEElYeaXg9+cVvt+/yJvpLRPeU
    lmSyeXong6URWRdV/3iUAObJrOsmxF/dLsxiD7pxtvjjZTn71uT4F3JmdyXkd/ko
    4+5wiqC646kUiRv7HoQamjx445P7gHOcvMFF5FRhhYxLbnPR6KeaCFqiuh6y+cXB
    zdJCGesvdOr8CyfdDKTBI50vyMOsCINuvkucKv2Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=QS6WDHwl x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=QS6WDHwl x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG8Zh6AETFglByZietIcVc9NqWqCykjIy0IetZkwjhKnY35+6tHh8twZc8Ykvwa/XEtCdZvL1UWQ0OkdvQXeVNyE7Yth2tvPjbEUYSa2qCb6e9YXs++Z
    IfrK2C6Nf9AlQUmlgMgjpB2SzQ2+MwlbL4Knur1ukQAdKOGJxNoxC0iLlBhD83lpPMFY/T+rQtajHAbYXjJyHWqYXbREa6XVGnYL0h9GnGF3l9QpgZbRJsgV
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8 a=eeWHcVxF30HX67qIXVgA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753652AbeDZUaP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 16:30:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38300 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753393AbeDZUaO (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 16:30:14 -0400
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, mhocko@suse.com, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: [PATCH] mm: sections are not offlined during memory hotremove
Date: Thu, 26 Apr 2018 16:30:02 -0400
Message-Id: <20180426203002.3151-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8875 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=798
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804260190
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Memory hotplug, and hotremove operate with per-block granularity. If
machine has large amount of memory (more than 64G), the size of memory
block can span multiple sections. By mistake, during hotremove we set
only the first section to offline state.

The bug was discovered because kernel selftest started to fail:
https://lkml.kernel.org/r/20180423011247.GK5563@yexl-desktop

After commit, "mm/memory_hotplug: optimize probe routine". But, the bug is
older than this commit. In this optimization we also added a check for
sections to be in a proper state during hotplug operation.

Fixes: 2d070eab2e82 ("mm: consider zone which is not fully populated to have holes")

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/sparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 62eef264a7bd..73dc2fcc0eab 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -629,7 +629,7 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 	unsigned long pfn;
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
-		unsigned long section_nr = pfn_to_section_nr(start_pfn);
+		unsigned long section_nr = pfn_to_section_nr(pfn);
 		struct mem_section *ms;
 
 		/*
-- 
2.17.0
