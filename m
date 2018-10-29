Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B51BC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7295E2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7295E2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbeJ2Tly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:41:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729194AbeJ2Tlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:41:53 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9TAo7Gq109877
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 06:53:44 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ne0ey0ya5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 06:53:43 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 29 Oct 2018 10:53:42 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 29 Oct 2018 10:53:39 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9TArcjw61800566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Oct 2018 10:53:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B076411C04A;
        Mon, 29 Oct 2018 10:53:38 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B4DF11C050;
        Mon, 29 Oct 2018 10:53:38 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.152.212.21])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 29 Oct 2018 10:53:38 +0000 (GMT)
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
From:   Thomas-Mich Richter <tmricht@linux.ibm.com>
Subject: Linux 4.19.0 Build Error when CONFIG_ACPI not set.
Organization: IBM
Date:   Mon, 29 Oct 2018 11:53:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18102910-0028-0000-0000-0000030F2BED
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102910-0029-0000-0000-000023CB5120
Message-Id: <c4c5d427-a77e-4191-a84e-43ae9299c346@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-29_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810290103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I compile the 4.19.0 Linux kernel, I get this build error:

[root@f28 linux]# fgrep -r CONFIG_ACPI .config
# CONFIG_ACPI is not set
[root@f28 linux]#

[root@f28 linux]# make
  CALL    scripts/checksyscalls.sh
  DESCEND  objtool
  CHK     include/generated/compile.h
  CC      drivers/cpufreq/intel_pstate.o
drivers/cpufreq/intel_pstate.c: In function ‘show_base_frequency’:
        drivers/cpufreq/intel_pstate.c:726:10: error: implicit declaration of
        function ‘intel_pstate_get_cppc_guranteed’;
        did you mean ‘intel_pstate_get_epp’?
        [-Werror=implicit-function-declaration]
        ratio = intel_pstate_get_cppc_guranteed(policy->cpu);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                intel_pstate_get_epp
cc1: some warnings being treated as errors
make[2]: *** [scripts/Makefile.build:306: drivers/cpufreq/intel_pstate.o]
                Error 1
make[1]: *** [scripts/Makefile.build:546: drivers/cpufreq] Error 2
make: *** [Makefile:1052: drivers] Error 2
[root@f28 linux]# 

I am building on a virtual machine.

This was introduced with
commit 86d333a8cc7f ("cpufreq: intel_pstate: Add base_frequency attribute")

The function intel_pstate_get_cppc_guranteed() is called but the function
definition is within #ifdef CONFIG_ACPI/#endif conditional compile.

Any ideas how to fix this?
Thanks

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

