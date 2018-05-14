Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1572352-1526340762-2-1597640660285122001
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526340762; b=h6WxgyfHEdeHc2Glu6mSPnWjqegRDQibWHo4Aj+7WsMaVR3yj6
    N48nvZ5dY4YUpjt7GvRe2gbRSvLmhU7ubgiWqOr381ggaTW2E7AEJDwY6TqLdPJ1
    RoKZWrRAa+6TQunk5c5Z2Acma0gS5KIeeVTjY0iB1CnualrSTB52tKZOWv8Ob2Vd
    3M3HB5un03+I/iGlfbtvIsx2myI/T7vRhJ2vlv5cjWI3q687SZjpAVGTRVS0dNRi
    Taoa6KC57/u8irBb5+fUcaKXnJY+zDD9qEBSPuksLwADp4DGrvP75Msas+E88KJr
    GP5N22+zAYY99wo/n4JIZA6q5Abhn6HHt7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1526340762; bh=E
    oi4/HEo3/ZfqBVx7vnwYVuXVz5pxsGfLZ/yRqsF4Dg=; b=GyqM/DB6aZXbaguHr
    EI0YJsxRLJssjAdF/7rQn3MsFjNu6W0kHw2yu6BcTk20wLyLRNyuEkhBNcoxfWl6
    ZEbCA1DHW9qfj34JAffUpwwEj9AVk97evBdZhdHj9NkxzgHq8i2NtpvCX8lmSCR+
    Qu2eZm/dtZ9lY9FHfBGDn0gKCQHYcKFzjAiv8Z/M1yN0fBSbrzi9xEbLceWy4RuD
    Nz8brxlDt0kKUFVsBRWTrhj63VNUTZWjsvhWV3scW/MFuLYu93zqrNQkW7KeVA8C
    DUrQYwgBXw3gx1BewYCvS7YjMMxmu8VIDLpjZ8CKcinLDkR+G5Juemw8NsIWr2Bc
    xK8FA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfFCK9VkCw6X/SIECg1z/ksOmzJ4ASCtfz/KuEFsjIVHgSbxF7xhb4OSUn/kyQZmBfEVRoQmC6Lu3KYwDIpgyMX0MYAUaAGSi0f8CZydZF53keuRoZ/ow
    AJWKItdkrUnyGjr7H90utXVGbtXyGYzADUDaPIphu3QDceGJKNylNwDXYQNV2h3baGKFu3OrOWqvQEr//hht3PP/ThPy/+Eig6DKds2etq0vZ0XD7aAAZXRz
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=VnNF1IyMAAAA:8 a=DGVp42UCY6lLdWa1cXcA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752375AbeENXch (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 19:32:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752385AbeENXcd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 19:32:33 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 04/19] tools/memory-model: Fix cheat sheet typo
Date: Mon, 14 May 2018 16:33:42 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180514233328.GA7601@linux.vnet.ibm.com>
References: <20180514233328.GA7601@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051423-0052-0000-0000-000002EE72F6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009026; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032383; UDB=6.00527784; IPR=6.00811514;
 MB=3.00021114; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 23:32:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051423-0053-0000-0000-00005CAF434F
Message-Id: <1526340837-12222-4-git-send-email-paulmck@linux.vnet.ibm.com>
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

From: Paolo Bonzini <pbonzini@redhat.com>

"RWM" should be "RMW".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/Documentation/cheatsheet.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
index 956b1ae4aafb..c0eafdaddfa4 100644
--- a/tools/memory-model/Documentation/cheatsheet.txt
+++ b/tools/memory-model/Documentation/cheatsheet.txt
@@ -1,6 +1,6 @@
                                   Prior Operation     Subsequent Operation
                                   ---------------  ---------------------------
-                               C  Self  R  W  RWM  Self  R  W  DR  DW  RMW  SV
+                               C  Self  R  W  RMW  Self  R  W  DR  DW  RMW  SV
                               --  ----  -  -  ---  ----  -  -  --  --  ---  --
 
 Store, e.g., WRITE_ONCE()            Y                                       Y
-- 
2.5.2
