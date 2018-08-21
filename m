Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7FCC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E67214C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E67214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeHUKxa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:53:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726253AbeHUKxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:53:30 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7L7YOh5078660
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 03:34:28 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m0cm7m8kp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 03:34:28 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Tue, 21 Aug 2018 08:34:25 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Aug 2018 08:34:20 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7L7YJdw45875314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Aug 2018 07:34:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2234C11C052;
        Tue, 21 Aug 2018 10:34:20 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8A4F11C04A;
        Tue, 21 Aug 2018 10:34:19 +0100 (BST)
Received: from localhost (unknown [9.77.215.214])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Aug 2018 10:34:19 +0100 (BST)
Date:   Tue, 21 Aug 2018 13:04:17 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v9 0/4] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Song Liu <liu.song.a23@gmail.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        ananth@linux.vnet.ibm.com, jolsa@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        open list <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, mhiramat@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, Oleg Nesterov <oleg@redhat.com>,
        paul.burton@mips.com, Peter Zijlstra <peterz@infradead.org>,
        ralf@linux-mips.org, Steven Rostedt <rostedt@goodmis.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
        <CAPhsuW70nRkwM8C76m4c_XF4tjepdRWYezg15sTvkMUDtHZ8JQ@mail.gmail.com>
In-Reply-To: <CAPhsuW70nRkwM8C76m4c_XF4tjepdRWYezg15sTvkMUDtHZ8JQ@mail.gmail.com>
User-Agent: astroid/0.13.0 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 18082107-0016-0000-0000-000001F98918
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082107-0017-0000-0000-0000324FD619
Message-Id: <1534836620.dp1nz6tfz0.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-21_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808210081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song Liu wrote:
> I am testing the patch set with the following code:
> 
> #include <stdio.h>
> #include <unistd.h>
> 
> volatile short semaphore = 0;
> 
> int for_uprobe(int c)
> {
>         printf("%d\n", c + 10);
>         return c + 1;
> }
> 
> int main(int argc, char *argv[])
> {
>         for_uprobe(argc);
>         while (1) {
>                 sleep(1);
>                 printf("semaphore %d\n", semaphore);
>         }
> }
> 
> I created a uprobe on function for_uprobe(), that uses semaphore as
> reference counter:
> 
>   echo "p:uprobe_1 /root/a.out:0x49a(0x1036)" >> uprobe_events

Is that even valid? That _looks_ like a semaphore, but I'm not quite 
sure that it qualifies as an _SDT_ semaphore. Do you see this issue if 
you instead use the macros provided by <sys/sdt.h> to create SDT 
markers?


- Naveen


