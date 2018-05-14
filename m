Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1557870-1526338456-2-5888719110360836146
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526338456; b=ZQ8wUq9HCl8//GTxYz1inIPJjaBwjgEYe+AjowljXb83lt6BpI
    +quRq4AQZ9W1NhI0C8iXie1mjnCUmXkJzeZjE6djvwyPd6rfeMmqJ/7PpIZZkLrZ
    v/3lBAeK78TtImwSNrJRU3UV3bcusS0IIMt8LafSES3vAT00vjGdaggbzsFbY3XZ
    cmAdXMwGH5MKAoQ+hFXeKNeLvAPTbdSHIAM33ZlXgXqFDMLAK6n6txB+hv36sxqh
    A8ljgspicHNwdDg9eHJ49xbEd9aZdv+sI2LdqmTQ2KdnCxyUzNpd0r4LlFfLOaVR
    OJMdly1BHCwvIsN+z1DSVm7ulFmQzjMnSdgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1526338456; bh=N
    MLqrirnLcVd5nj6/4no2pV3et5+jKqyMe66srBXbvc=; b=LjWSNFvCbLgJXen9B
    ynfYV0BplQhLkoCbFz7Tg2AAIN7M2X4qj/yO6oZkqUiiX8iFgz3SOTmqvg4N6EkI
    wK0tOjrNPhv0/ITEzKsTYICbG2P8BN+j0f7zkWbHyn9K9D5gfaegzwdJpItiri5O
    gPxMlHV+/gRXLna9oN7rETrHGQl8mzIJvVZ7tc5ZnJsWKzHLK11O9XRzLEHAxZP9
    whrMwt5zoqmigCVxOPaWOQjJKLPZwwn4KJbPVyWcZsYLOfXkwlkwSSQ3MVyPA3J3
    CFbd+0AdiBEm6W7Mhf6QZQbsdb7bCHYN1R654ntZwOWswkjKNDkk72gk1IBam39K
    SuLRw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMgXZ9P2Otj1kCa6Iv37iHVcqr/ikXL2kZwvjSncy+mNxCmcpOzg/2J/LN1S6Zb8kcxaRNj6aioM+C/PSeMtMzE76ZXf+P3CunudLsTElu09N17Dwx0T
    FVEhFbuD7W7fgqrAtj4TL8gd0eyARAZkiq3URFNJUBdqs13MG7qrhcyDlL8DhAnNAT6p0gLWz4/2FSZxCrAJML1hOpDhVqPu5K6SQ+vKBsMY4C9GFBRIVWyk
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8
    a=VnNF1IyMAAAA:8 a=jfU3rlwaHHGLTXbPq6oA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752340AbeENWyN (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 18:54:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51642 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752243AbeENWyK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 18:54:10 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        SeongJae Park <sj38.park@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 8/8] atomic_ops.rst: Use `warning` rst directive
Date: Mon, 14 May 2018 15:55:33 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180514225457.GA5142@linux.vnet.ibm.com>
References: <20180514225457.GA5142@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051422-0048-0000-0000-0000026CF06D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009026; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032370; UDB=6.00527776; IPR=6.00811502;
 MB=3.00021114; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 22:54:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051422-0049-0000-0000-0000451F3300
Message-Id: <1526338533-6044-8-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140226
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: SeongJae Park <sj38.park@gmail.com>

One warning message in 'atomic_ops.rst' is not using 'warning' rst
directive while others does.  This commit modifies the message to use
'warning' rst directive.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 Documentation/core-api/atomic_ops.rst | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/core-api/atomic_ops.rst b/Documentation/core-api/atomic_ops.rst
index 4ea4af71e68a..2e7165f86f55 100644
--- a/Documentation/core-api/atomic_ops.rst
+++ b/Documentation/core-api/atomic_ops.rst
@@ -466,10 +466,12 @@ Like the above, except that these routines return a boolean which
 indicates whether the changed bit was set _BEFORE_ the atomic bit
 operation.
 
-WARNING! It is incredibly important that the value be a boolean,
-ie. "0" or "1".  Do not try to be fancy and save a few instructions by
-declaring the above to return "long" and just returning something like
-"old_val & mask" because that will not work.
+
+.. warning::
+        It is incredibly important that the value be a boolean, ie. "0" or "1".
+        Do not try to be fancy and save a few instructions by declaring the
+        above to return "long" and just returning something like "old_val &
+        mask" because that will not work.
 
 For one thing, this return value gets truncated to int in many code
 paths using these interfaces, so on 64-bit if the bit is set in the
-- 
2.5.2
