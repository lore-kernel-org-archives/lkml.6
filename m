Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33478C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A63218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NEjaQSIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbfB0BMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:12:12 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38146 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbfB0BML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:12:11 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1R18w0Z083402;
        Wed, 27 Feb 2019 01:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : from :
 subject : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=wmFQbYxgCFg7pzeDgrYLsS02n2Qqv1NJ96353ZpVYYU=;
 b=NEjaQSIKHRYdVMCW8tIi+URAaqB25AQXLF5krnqQpFD7QGBdUsfnsZRH6p1F52EoLEOm
 ue0XkMyV56njH2cO/6XOaFRx9Ra6uKcbq0VH15mk8nFG1G08fI7CJlI6ixGxMYDamzhv
 lpyQnGVyuWEcQRrWNIdfjYFAs3NqoEqmIejsq0lomFMtrNTzuMHgvZTYOj8tiVWi9ne5
 oavFJkfz3ckB+ypUinOpamy2LFIO07aE95HrdAzfzp6dSyedU8RoZbOKXmohErZ7Wrw1
 IBW+Nf+BHyHgz6v+K1LPcYclZFG4TqegPVyqfQUvwvMjgZfMhn5uvA5S9XHxkJjzHu+X Cg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2qtxtrqwnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Feb 2019 01:12:00 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1R1Btwl013786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Feb 2019 01:11:55 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1R1Bsh3021015;
        Wed, 27 Feb 2019 01:11:55 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Feb 2019 17:11:54 -0800
To:     linux-kernel@vger.kernel.org
Cc:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
        Joe Jin <joe.jin@oracle.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Subject: Why the return type of jiffies_to_usecs() is 'unsigned int' but not
 'unsigned long'
Message-ID: <b624c1e1-63bb-6bd4-ccf4-fe9e637d77bf@oracle.com>
Date:   Wed, 27 Feb 2019 09:15:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9179 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902270005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am writing to ask about why the return type of jiffies_to_usecs() and
jiffies_to_msecs() are 'unsigned int', but not 'unsigned long'?

For instance, about jiffies_to_usecs(), suppose the input is 0x7770ef70
(2003893872), that is, jiffies_to_usecs(0x7770ef70).

Suppose USEC_PER_SEC=1000000L and HZ=1000, we expect the result to be
0x000001d291274d80. However, as the return type is 'unsigned int', the leading
32 bits are ignored and the actual result is 0x91274d80.

expected jiffies_to_usecs(0x7770ef70) : 0x000001d291274d80
current jiffies_to_usecs(0x7770ef70)  :         0x91274d80

I think jiffies_to_msecs() would have the same issue.

As both jiffies_to_usecs() and jiffies_to_msecs() are totally called by 680
locations in the lasted mainline linux kernel, the below patch would generate
lots of warnings. Almost all warnings are due to printk or trace event.



diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index fa92824..d961b30 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -288,8 +288,8 @@ extern unsigned long preset_lpj;
 /*
  * Convert various time units to each other:
  */
-extern unsigned int jiffies_to_msecs(const unsigned long j);
-extern unsigned int jiffies_to_usecs(const unsigned long j);
+extern unsigned long jiffies_to_msecs(const unsigned long j);
+extern unsigned long jiffies_to_usecs(const unsigned long j);

 static inline u64 jiffies_to_nsecs(const unsigned long j)
 {
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 2edb508..72c139d 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -305,7 +305,7 @@ COMPAT_SYSCALL_DEFINE1(adjtimex, struct compat_timex __user
*, utp)
  * Avoid unnecessary multiplications/divisions in the
  * two most common HZ cases:
  */
-unsigned int jiffies_to_msecs(const unsigned long j)
+unsigned long jiffies_to_msecs(const unsigned long j)
 {
 #if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
 	return (MSEC_PER_SEC / HZ) * j;
@@ -322,7 +322,7 @@ unsigned int jiffies_to_msecs(const unsigned long j)
 }
 EXPORT_SYMBOL(jiffies_to_msecs);

-unsigned int jiffies_to_usecs(const unsigned long j)
+unsigned long jiffies_to_usecs(const unsigned long j)
 {
 	/*
 	 * Hz usually doesn't go much further MSEC_PER_SEC.
-- 
2.7.4

------------------------------------------------------



While I am still struggling on those warnings, would you please confirm if the
'unsigned int' return type is by design on purpose or it is a bug as I mentioned
above?

So far the latest 4.9.x stable kernel is affected by a steal usage 100% issue
and the root cause is the incorrect return type of jiffies_to_usecs(). I will
discuss that in another email thread for more details later to facilitate people
to grep/search for similar/same issue on google in the future. That issue is not
reproducible after I change the return type of jiffies_to_usecs() to 'unsigned
long'.

Thank you very much!

Dongli Zhang
