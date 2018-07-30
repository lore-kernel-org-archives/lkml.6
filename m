Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E9CC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A11208AC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A11208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbeGaBcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 21:32:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731406AbeGaBcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 21:32:50 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6UNri0t074153
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 19:55:25 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kjavhud0x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 19:55:24 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Mon, 30 Jul 2018 17:55:24 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Jul 2018 17:55:21 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6UNtKeo3146234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Jul 2018 16:55:20 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 358B47805F;
        Mon, 30 Jul 2018 17:55:20 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 319757805E;
        Mon, 30 Jul 2018 17:55:16 -0600 (MDT)
Received: from morokweng.localdomain (unknown [9.85.203.167])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Mon, 30 Jul 2018 17:55:12 -0600 (MDT)
References: <20180725024209.32586-1-bauerman@linux.ibm.com> <20180725024209.32586-3-bauerman@linux.ibm.com> <20180725141148.GD25188@rapoport-lnx>
User-agent: mu4e 1.0; emacs 25.3.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>
Subject: Re: [PATCH 2/3] userfaultfd: selftest: Skip test if a feature isn't supported
In-reply-to: <20180725141148.GD25188@rapoport-lnx>
Date:   Mon, 30 Jul 2018 20:54:53 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18073023-0004-0000-0000-0000146B15AB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009459; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01068252; UDB=6.00549142; IPR=6.00846384;
 MB=3.00022414; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-30 23:55:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18073023-0005-0000-0000-00008845FB08
Message-Id: <871sbkb7oy.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-30_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=987 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807300250
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mike Rapoport <rppt@linux.vnet.ibm.com> writes:

> Hi,
>
> On Tue, Jul 24, 2018 at 11:42:08PM -0300, Thiago Jung Bauermann wrote:
>> If userfaultfd runs on a system that doesn't support some feature it is
>> trying to test, it currently ends with error code 1 which indicates
>> test failure:
>> 
>>   # ./userfaultfd anon 10 10
>>   nr_pages: 160, nr_pages_per_cpu: 80
>>   bounces: 9, mode: rnd poll, userfaults: 7 59
>>   bounces: 8, mode: poll, userfaults: 0 0
>>   bounces: 7, mode: rnd racing ver, userfaults: 45 2
>>   bounces: 6, mode: racing ver, userfaults: 3 1
>>   bounces: 5, mode: rnd ver, userfaults: 55 32
>>   bounces: 4, mode: ver, userfaults: 69 0
>>   bounces: 3, mode: rnd racing, userfaults: 1 1
>>   bounces: 2, mode: racing, userfaults: 65 0
>>   bounces: 1, mode: rnd, userfaults: 44 1
>>   bounces: 0, mode:, userfaults: 3 2
>>   testing UFFDIO_ZEROPAGE: done.
>>   testing signal delivery: UFFDIO_API
>>   # echo $?
>>   1
>> 
>> Make the testcase return KSFT_SKIP instead, which is more accurate since it
>> is not a real test failure:
>> 
>>   # ./userfaultfd anon 10 10
>>   nr_pages: 160, nr_pages_per_cpu: 80
>>   bounces: 9, mode: rnd poll, userfaults: 3 0
>>   bounces: 8, mode: poll, userfaults: 6 1
>>   bounces: 7, mode: rnd racing ver, userfaults: 3 1
>>   bounces: 6, mode: racing ver, userfaults: 2 1
>>   bounces: 5, mode: rnd ver, userfaults: 2 1
>>   bounces: 4, mode: ver, userfaults: 3 47
>>   bounces: 3, mode: rnd racing, userfaults: 38 0
>>   bounces: 2, mode: racing, userfaults: 4 61
>>   bounces: 1, mode: rnd, userfaults: 16 6
>>   bounces: 0, mode:, userfaults: 55 25
>>   testing UFFDIO_ZEROPAGE: done.
>>   testing signal delivery: UFFDIO_API: Invalid argument
>>   # echo $?
>>   4
>> 
>> While at it, also improve the error message of the ioctl(UFFDIO_API) call.
>
> Can you please also make the test return KSFT_SKIP if userfaultfd(2) fails
> with ENOSYS?

Sure. v2 will have a separate patch implementing your suggestion.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

