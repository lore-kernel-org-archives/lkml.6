Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A835CC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634522172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634522172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbeI1RQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 13:16:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53504 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729310AbeI1RQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 13:16:03 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SAnUUE093820
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 06:52:51 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2msgfap53r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 06:52:51 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Fri, 28 Sep 2018 11:52:48 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Sep 2018 11:52:45 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8SAqiSV65077260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Sep 2018 10:52:44 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AD3F11C066;
        Fri, 28 Sep 2018 13:52:24 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCB6F11C04A;
        Fri, 28 Sep 2018 13:52:23 +0100 (BST)
Received: from oc3784624756.ibm.com (unknown [9.152.212.24])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Sep 2018 13:52:23 +0100 (BST)
Subject: Re: [PATCH v2] perf test: S390 does not support watchpoints in test
 22
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
References: <20180928074317.42893-1-tmricht@linux.ibm.com>
 <b743ec89-9e54-e54d-86cc-f3312e06e23c@linux.ibm.com>
 <491ce3c5-f1ce-1513-3a9f-b86795e0332a@linux.ibm.com>
 <7a99b293-fd3d-db4a-fc4b-d552e2458fb9@linux.ibm.com>
From:   Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM
Date:   Fri, 28 Sep 2018 12:52:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7a99b293-fd3d-db4a-fc4b-d552e2458fb9@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18092810-0020-0000-0000-000002CCC5E0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092810-0021-0000-0000-0000211AF543
Message-Id: <c7b16721-0792-1f13-85fc-49d689b1ea2c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809280110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/2018 12:17 PM, Ravi Bangoria wrote:
> Hi Thomas,
> 
> On 09/28/2018 03:32 PM, Thomas-Mich Richter wrote:
>> I can rework the patch to use the is_supported() member function. The
>> down side is that the test does not show up in the list of executed tests anymore,
>> unless some debug output is enabled:
> 
> Which should be fine because s390 is doing that in all breakpoint related tests.
> But more important thing to suggest .is_supported field is, this patch has a
> regression on x86:
> 
> Before:
>   $ sudo ./perf test 22
>   22: Watchpoint                                            :
>   22.1: Read Only Watchpoint                                : Skip
>   22.2: Write Only Watchpoint                               : Ok
>   22.3: Read / Write Watchpoint                             : Ok
>   22.4: Modify Watchpoint                                   : Ok
> 
> After:
>   $ git apply 1.patch
>   $ make
>   $ sudo ./perf test 22
>   22: Watchpoint                                            :
>   22.1: Read Only Watchpoint                                : Skip
>   22.2: Write Only Watchpoint                               : Skip
>   22.3: Read / Write Watchpoint                             : Skip
>   22.4: Modify Watchpoint                                   : Skip
> 
> Intel hw does not support read only watchpoitns. If you use skip_if_fail=true,
> all subsequent testcases are skipped as well.
> 
> Thanks,
> Ravi
> 

Ahhh  ....  thanks a lot for the hint, will post version 3.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

