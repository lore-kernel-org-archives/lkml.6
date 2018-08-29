Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F370C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46D420647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46D420647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbeH3BJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:09:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728883AbeH3BJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:09:44 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TL97Qp031792
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:11:03 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m5y0ej812-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:11:02 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 17:11:01 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 17:10:57 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TLAukj24510570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 21:10:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74A2CB205F;
        Wed, 29 Aug 2018 17:09:52 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5700EB206C;
        Wed, 29 Aug 2018 17:09:52 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 17:09:52 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5A7E316C025C; Wed, 29 Aug 2018 14:10:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC LKMM 6/7] EXP tools/memory-model: Make scripts take "-j" abbreviation for "--jobs"
Date:   Wed, 29 Aug 2018 14:10:52 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829211018.GA19646@linux.vnet.ibm.com>
References: <20180829211018.GA19646@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082921-0060-0000-0000-000002A65C1A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080715; UDB=6.00557480; IPR=6.00860700;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 21:11:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082921-0061-0000-0000-000046558D73
Message-Id: <20180829211053.20531-6-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "--jobs" argument to the litmus-test scripts is similar to the "-jN"
argument to "make", so this commit allows the "-jN" form as well.  While
in the area, it also prohibits the various forms of "-j0".

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/scripts/parseargs.sh | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/scripts/parseargs.sh b/tools/memory-model/scripts/parseargs.sh
index 96b307c8d64a..859e1d581e05 100755
--- a/tools/memory-model/scripts/parseargs.sh
+++ b/tools/memory-model/scripts/parseargs.sh
@@ -95,8 +95,18 @@ do
 		LKMM_HERD_OPTIONS="$2"
 		shift
 		;;
-	--jobs|--job)
-		checkarg --jobs "(number)" "$#" "$2" '^[0-9]\+$' '^--'
+	-j[1-9]*)
+		njobs="`echo $1 | sed -e 's/^-j//'`"
+		trailchars="`echo $njobs | sed -e 's/[0-9]\+\(.*\)$/\1/'`"
+		if test -n "$trailchars"
+		then
+			echo $1 trailing characters "'$trailchars'"
+			usagehelp
+		fi
+		LKMM_JOBS="`echo $njobs | sed -e 's/^\([0-9]\+\).*$/\1/'`"
+		;;
+	--jobs|--job|-j)
+		checkarg --jobs "(number)" "$#" "$2" '^[1-9][0-9]\+$' '^--'
 		LKMM_JOBS="$2"
 		shift
 		;;
-- 
2.17.1

