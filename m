Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72E3C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9161F214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9161F214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbeKLGKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:10:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33618 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731819AbeKLGKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:10:04 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABKJGGi124513
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:20:35 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2npd3uugcb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:20:34 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 20:20:34 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 20:20:29 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABKKSKT46071860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 20:20:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05CBCB206C;
        Sun, 11 Nov 2018 20:20:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8409B2066;
        Sun, 11 Nov 2018 20:20:27 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 20:20:27 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B49F716C5D9C; Sun, 11 Nov 2018 12:20:28 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Pierce Griffiths <pierceagriffiths@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 06/17] torture: Remove unnecessary "ret" variables
Date:   Sun, 11 Nov 2018 12:20:16 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111201956.GA11935@linux.ibm.com>
References: <20181111201956.GA11935@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111120-0040-0000-0000-000004908B18
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116031; UDB=6.00577119; IPR=6.00896131;
 MB=3.00024115; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 20:20:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111120-0041-0000-0000-0000089993CA
Message-Id: <20181111202027.13585-6-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierce Griffiths <pierceagriffiths@gmail.com>

Remove return variables (declared as "ret") in cases where,
depending on whether a condition evaluates as true, the result of a
function call can be immediately returned instead of storing the result in
the return variable. When the condition evaluates as false, the constant
initially stored in the return variable at declaration is returned instead.

Signed-off-by: Pierce Griffiths <pierceagriffiths@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/torture.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 9410d1bf84d6..bbf6d473e50c 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -245,16 +245,15 @@ torture_onoff(void *arg)
  */
 int torture_onoff_init(long ooholdoff, long oointerval)
 {
-	int ret = 0;
-
 #ifdef CONFIG_HOTPLUG_CPU
 	onoff_holdoff = ooholdoff;
 	onoff_interval = oointerval;
 	if (onoff_interval <= 0)
 		return 0;
-	ret = torture_create_kthread(torture_onoff, NULL, onoff_task);
-#endif /* #ifdef CONFIG_HOTPLUG_CPU */
-	return ret;
+	return torture_create_kthread(torture_onoff, NULL, onoff_task);
+#else /* #ifdef CONFIG_HOTPLUG_CPU */
+	return 0;
+#endif /* #else #ifdef CONFIG_HOTPLUG_CPU */
 }
 EXPORT_SYMBOL_GPL(torture_onoff_init);
 
@@ -525,15 +524,13 @@ static int torture_shutdown(void *arg)
  */
 int torture_shutdown_init(int ssecs, void (*cleanup)(void))
 {
-	int ret = 0;
-
 	torture_shutdown_hook = cleanup;
 	if (ssecs > 0) {
 		shutdown_time = ktime_add(ktime_get(), ktime_set(ssecs, 0));
-		ret = torture_create_kthread(torture_shutdown, NULL,
+		return torture_create_kthread(torture_shutdown, NULL,
 					     shutdown_task);
 	}
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(torture_shutdown_init);
 
@@ -632,13 +629,10 @@ static int torture_stutter(void *arg)
 /*
  * Initialize and kick off the torture_stutter kthread.
  */
-int torture_stutter_init(int s)
+int torture_stutter_init(const int s)
 {
-	int ret;
-
 	stutter = s;
-	ret = torture_create_kthread(torture_stutter, NULL, stutter_task);
-	return ret;
+	return torture_create_kthread(torture_stutter, NULL, stutter_task);
 }
 EXPORT_SYMBOL_GPL(torture_stutter_init);
 
-- 
2.17.1

