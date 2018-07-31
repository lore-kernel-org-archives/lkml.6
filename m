Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D94C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D792208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D792208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732101AbeGaBji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 21:39:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56478 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729477AbeGaBji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 21:39:38 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6UNxJin049610
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 20:02:11 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kj97w73b9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 20:02:11 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Mon, 30 Jul 2018 18:02:10 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Jul 2018 18:02:07 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6V026dU62521374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Jul 2018 17:02:06 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5064DC605D;
        Mon, 30 Jul 2018 18:02:06 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DF78C6062;
        Mon, 30 Jul 2018 18:02:03 -0600 (MDT)
Received: from morokweng.localdomain (unknown [9.85.203.167])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Mon, 30 Jul 2018 18:02:02 -0600 (MDT)
References: <20180725024209.32586-1-bauerman@linux.ibm.com> <20180725024209.32586-4-bauerman@linux.ibm.com> <20180725141849.GE25188@rapoport-lnx>
User-agent: mu4e 1.0; emacs 25.3.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>
Subject: Re: [PATCH 3/3] userfaultfd: selftest: Report XFAIL if shmem doesn't support zeropage
In-reply-to: <20180725141849.GE25188@rapoport-lnx>
Date:   Mon, 30 Jul 2018 21:01:56 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18073100-0016-0000-0000-0000090FEAFD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009459; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01068253; UDB=6.00549142; IPR=6.00846386;
 MB=3.00022414; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-31 00:02:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18073100-0017-0000-0000-00003FD19783
Message-Id: <87zhy89ssr.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-30_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807300251
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mike Rapoport <rppt@linux.vnet.ibm.com> writes:

> Hi,
>
> On Tue, Jul 24, 2018 at 11:42:09PM -0300, Thiago Jung Bauermann wrote:
>> If userfaultfd runs on a system that doesn't support UFFDIO_ZEROPAGE for
>> shared memory, it currently ends with error code 1 which indicates test
>> failure:
>>
>>   # ./userfaultfd shmem 10 10
>>   nr_pages: 160, nr_pages_per_cpu: 80
>>   bounces: 9, mode: rnd poll, unexpected missing ioctl for anon memory
>>   # echo $?
>>   1
>>
>> This is a real failure, but expected so signal that to the test harness:
>
> I don't think its a real failure. If the kernel does not support
> UFFDIO_ZEROPAGE for shared memory the userfaultfd_zeropage_test can be
> simply skipped.

Ok, good point. I'll make that change in v2.

>>   # ./userfaultfd shmem 10 10
>>   nr_pages: 160, nr_pages_per_cpu: 80
>>   bounces: 9, mode: rnd poll, UFFDIO_ZEROPAGE unsupported in shmem VMAs
>>   # echo $?
>>   2
>>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> ---
>>  tools/testing/selftests/vm/userfaultfd.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
>> index bc9ec38fbc34..686fe96f617f 100644
>> --- a/tools/testing/selftests/vm/userfaultfd.c
>> +++ b/tools/testing/selftests/vm/userfaultfd.c
>> @@ -1115,6 +1115,14 @@ static int userfaultfd_stress(void)
>>  		expected_ioctls = uffd_test_ops->expected_ioctls;
>>  		if ((uffdio_register.ioctls & expected_ioctls) !=
>>  		    expected_ioctls) {
>> +			if (test_type == TEST_SHMEM &&
>> +			    (uffdio_register.ioctls & expected_ioctls) ==
>> +			    UFFD_API_RANGE_IOCTLS_BASIC) {
>> +				fprintf(stderr,
>> +					"UFFDIO_ZEROPAGE unsupported in shmem VMAs\n");
>> +				return KSFT_XFAIL;
>> +			}
>> +
>
> By all means, this check should be moved to userfaultfd_zeropage_test().

I made that change in v2.

> Ideally, we should call here ksft_test_result_skip() and simply return from
> the function.

In my understanding, calling ksft_test_result_skip() would require
converting the testcase to use the functions that generate TAP output.

Also, returning here isn't actually necessary: from my testing
userfaultfd_stress() doesn't require zeropage support in shmem so if the
only bit missing from uffdio_register.ioctls is the one for
UFFDIO_ZEROPAGE then this error can simply be ignored and the test can
continue. Do you agree?

>>  			fprintf(stderr,
>>  				"unexpected missing ioctl for anon memory\n");
>>  			return 1;


--
Thiago Jung Bauermann
IBM Linux Technology Center

