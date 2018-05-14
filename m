Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1557870-1526338555-2-1751046822864614062
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526338555; b=AbEsUHOh7pMGHMbw9h2W3CgR+OgijnhDj2cxQEBhTxOvQ8o98c
    s3O0nT0jvysMcD55UC8CG6UTsqhwWCw5Z1uNi4YxWw2Q35By3IpVCgokcuW434Rg
    3mBXFOjc5NSHTvaN00IH4LTkpQJIZ37yV3PqDBJtMQKTeJj7cRdXYnzr7fvUT6+U
    +6B6cLc76z7UOZ0gbzozOYsCxzITBVIjiOieaati5N8UwFz3k04ZJQ1+G+6aiP0F
    7FJTJzOEkpFvedOBRZ9geKu97C4Yqo2vL5m4riVXj+ONUMKkagL22Cvt9wVrxswU
    WHl3QCjFBuHqujnqYnJIPvyIX5ByQHjOtgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1526338555; bh=y
    Z9uEpo9g5Wn34DaT5mYbGJpLcyLB44WNESTvZM+Pck=; b=LBkkxSxsqYM10cShs
    j9t87fFv+814GeMnWImQDoIXbCXv6ozDmUZvhFzecGs0s2K/AUam2X0Nv9C+hR4g
    23LjNN2zWEenRGRIP3BpyzCv8yFcWYD5njyctzuVYR5D9SF+em2ppwoxAxgAcOHr
    eBBOV4xpFCq5AA4r4t0N9FzraBKjhmzlyKkYQl4pT2q/hEpnaKP6Qe2LkAsAphOf
    Sja8oTzSxFViI7iY5hrA2Nhg1zUuCYIrduYck7kV/K+gGqJVs0ZunjpSn4zB+Zoo
    jmUB5ceZ2AyrtvF4kfPX3b6mDAAU/0/prWCiMfL9Ln6HSvN2K/bI1kkZgDuf+bRB
    YruEw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfONZYk2aCLM9udZylTON/MTWg7gF6jcp0+MW/llEHtU6lZD1xxO6a1pf4xjmirQUDsbpbEcB2tVcU1IhdioduQShy0FGyeAOHY0KhGxlCntNPfkrvoNr
    TiebOsl5VoL/AAFZ7Rj6qEKW7flY6sxc6dV6PLGrSQNhtPCxmf3+FQp+UF33S26vfQWlffiqYHTbe05RvOJC7IFbNvAfZjl/Z8hzlFEwqmBr4eXaGZt2ZCEY
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=7CQSdrXTAAAA:8
    a=wMNdZWldAAAA:8 a=9jRdOu3wAAAA:8 a=VnNF1IyMAAAA:8 a=JfrnYn6hAAAA:8
    a=20KFwNOVAAAA:8 a=07d9gI8wAAAA:8 a=LpQP-O61AAAA:8 a=o31FrKYsEuWBL0FqU2UA:9
    a=MnQ2L8rzvaU7GOI0:21 a=YDPa5ilSUdq4WDvS:21 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=FUarYpL4UH3yWsho8X8J:22 a=ZE6KLimJVUuLrTuGpvhn:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=e2CUPOnPG4QKp8I52DXD:22 a=pioyyrs4ZptJ924tMmac:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752559AbeENWzj (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 18:55:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53598 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752271AbeENWyK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 18:54:10 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH memory-model 1/8] docs/memory-barriers.txt: Fix broken DMA vs MMIO ordering example
Date: Mon, 14 May 2018 15:55:26 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180514225457.GA5142@linux.vnet.ibm.com>
References: <20180514225457.GA5142@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051422-0048-0000-0000-0000026CF06E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009026; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032370; UDB=6.00527776; IPR=6.00811502;
 MB=3.00021114; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 22:54:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051422-0049-0000-0000-0000451F32FE
Message-Id: <1526338533-6044-1-git-send-email-paulmck@linux.vnet.ibm.com>
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

From: Will Deacon <will.deacon@arm.com>

The section of memory-barriers.txt that describes the dma_Xmb() barriers
has an incorrect example claiming that a wmb() is required after writing
to coherent memory in order for those writes to be visible to a device
before a subsequent MMIO access using writel() can reach the device.

In fact, this ordering guarantee is provided (at significant cost on some
architectures such as arm and power) by writel, so the wmb() is not
necessary. writel_relaxed exists for cases where this ordering is not
required.

Fix the example and update the text to make this clearer.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Reported-by: Sinan Kaya <okaya@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 Documentation/memory-barriers.txt | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 6dafc8085acc..34c1970908a5 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1920,9 +1920,6 @@ There are some more advanced barrier functions:
 		/* assign ownership */
 		desc->status = DEVICE_OWN;
 
-		/* force memory to sync before notifying device via MMIO */
-		wmb();
-
 		/* notify device of new descriptors */
 		writel(DESC_NOTIFY, doorbell);
 	}
@@ -1930,11 +1927,15 @@ There are some more advanced barrier functions:
      The dma_rmb() allows us guarantee the device has released ownership
      before we read the data from the descriptor, and the dma_wmb() allows
      us to guarantee the data is written to the descriptor before the device
-     can see it now has ownership.  The wmb() is needed to guarantee that the
-     cache coherent memory writes have completed before attempting a write to
-     the cache incoherent MMIO region.
-
-     See Documentation/DMA-API.txt for more information on consistent memory.
+     can see it now has ownership.  Note that, when using writel(), a prior
+     wmb() is not needed to guarantee that the cache coherent memory writes
+     have completed before writing to the MMIO region.  The cheaper
+     writel_relaxed() does not provide this guarantee and must not be used
+     here.
+
+     See the subsection "Kernel I/O barrier effects" for more information on
+     relaxed I/O accessors and the Documentation/DMA-API.txt file for more
+     information on consistent memory.
 
 
 MMIO WRITE BARRIER
-- 
2.5.2
