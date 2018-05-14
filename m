Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1587535-1526340757-2-9503880458901055800
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526340757; b=WpQ0KPVuc49hxhjEWJAw+6iZell8nR70JnZaNEC+l+X+r28y74
    twl/StsAXRM0gaGD3OJT386wRrfK4iLVdqRhFvRhY8rtxFUI24VrOOvpyqozfaOl
    OHhW/INxrVWDNI5RDY3pH5AdjY2Fav/wnt0ATo6Pz59v4AMm275iKYDqHX+yJtnR
    y0EY6bLoo3Nue8tWW9Qv2QsuLwnHUFPXGnY9BlY2ZKNwExtj3KnbpdSDp6U5/3v9
    H+6Fxs3RM+Imb3ePpVTvDIt4cK1iONecI7HmFmhIYa7qKtjOkvi24zTq+CUEYH+b
    Od8zdkkM7hlCESr9g9vsXztL5o1FI5xgOSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1526340757; bh=s
    duHTo+unOWEkBf8SGIUWYQfjhw30cbraNmFyhuAT3o=; b=bH08WZFJnW8Qa+/zV
    XOYSxmyeHqkz6FGXeIm3u5Tm6tSuI0M1nhJFZ/9sONsqQq6HKejA8SRSZEYuYpQz
    bpKHHA59Ojyg1zPWITK+KHWgpit+p4EkK56oPDJTRGw9ZiYwiwYO2pMvuYkeKJNk
    lkM5dvRCot5memGAWMQeVYXAcQjYnLSlwfDyz4IH2xdQkc1M3kvP0OGQuvnM4HCA
    hjUGDoxuxA+orrU8mOaBm/5u/I+6Irac1IsN+JAcWdSLuuBNKwFLYrlGwZdNkGUI
    +Pm4HYgpIfzMcJwxNtkINvuAEtlPODMXRbDJwydN8CZ2sXJr4Gw/rDm+XywPWiTQ
    UYMsg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM5jko+iAHtU6tGY3/UugGkYDNd98QdykOxZ7qQJYJ3gO5BoaZxC7MommxYrZ3J7kFhupF+kJDvRHqiC2e34QevqaY9VSlULQ/jXMjxr49mZN/rfEzOQ
    j0Fki+2w0xonxJYaHot+3AIF14a5LeBmaZniSN5OuMrvN2Xd+Uuip24cZlOjcgizYQV7VEvxOtmiKEAeo9gQ+sQzGAE0k4QQEklRWekkzlNT7FViRzKQUWjt
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=VnNF1IyMAAAA:8 a=gmRCQ9VviJvyoVed6W4A:9 a=SrqJpGtjWbb5rzj8:21
    a=YSPZXl-4HrEEtv-3:21
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbeENXce (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 19:32:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752380AbeENXcd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 19:32:33 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 05/19] tools/memory-order: Improve key for SELF and SV
Date: Mon, 14 May 2018 16:33:43 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180514233328.GA7601@linux.vnet.ibm.com>
References: <20180514233328.GA7601@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051423-2213-0000-0000-000002A53F83
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009026; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032383; UDB=6.00527784; IPR=6.00811515;
 MB=3.00021114; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 23:32:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051423-2214-0000-0000-00005A1EAEC5
Message-Id: <1526340837-12222-5-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140230
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The key for "SELF" was missing completely and the key for "SV" was
a bit obtuse.  This commit therefore adds a key for "SELF" and improves
the one for "SV".

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 tools/memory-model/Documentation/cheatsheet.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
index c0eafdaddfa4..46fe79afc737 100644
--- a/tools/memory-model/Documentation/cheatsheet.txt
+++ b/tools/memory-model/Documentation/cheatsheet.txt
@@ -26,4 +26,5 @@ Key:	C:	Ordering is cumulative
 	DR:	Dependent read (address dependency)
 	DW:	Dependent write (address, data, or control dependency)
 	RMW:	Atomic read-modify-write operation
-	SV	Same-variable access
+	SELF:	Orders self, as opposed to accesses before and/or after
+	SV:	Orders later accesses to the same variable
-- 
2.5.2
