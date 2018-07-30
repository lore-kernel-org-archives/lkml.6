Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248CCC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE43208A4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE43208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbeGaBbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 21:31:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50066 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731406AbeGaBbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 21:31:38 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6UNsBMj063648
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 19:54:13 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kjak1byb0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 19:54:12 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Mon, 30 Jul 2018 19:53:44 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Jul 2018 19:53:40 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6UNrdxr11010568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Jul 2018 23:53:39 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD2F6112063;
        Mon, 30 Jul 2018 19:53:23 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74893112061;
        Mon, 30 Jul 2018 19:53:20 -0400 (EDT)
Received: from morokweng.localdomain (unknown [9.85.203.167])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
        Mon, 30 Jul 2018 19:53:19 -0400 (EDT)
References: <20180725024209.32586-1-bauerman@linux.ibm.com> <20180725024209.32586-2-bauerman@linux.ibm.com> <20180725135942.GC25188@rapoport-lnx>
User-agent: mu4e 1.0; emacs 25.3.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>
Subject: Re: [PATCH 1/3] userfaultfd: selftest: Fix checking of userfaultfd_open() result
In-reply-to: <20180725135942.GC25188@rapoport-lnx>
Date:   Mon, 30 Jul 2018 20:53:30 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18073023-0060-0000-0000-00000294FAC0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009459; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01068252; UDB=6.00549141; IPR=6.00846383;
 MB=3.00022414; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-30 23:53:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18073023-0061-0000-0000-000045FD079F
Message-Id: <8736w0b7r9.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-30_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807300250
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Mike,

Thanks for promptly reviewing the patches.

Mike Rapoport <rppt@linux.vnet.ibm.com> writes:

> Hi,
>
> On Tue, Jul 24, 2018 at 11:42:07PM -0300, Thiago Jung Bauermann wrote:
>> If the userfaultfd test is run on a kernel with CONFIG_USERFAULTFD=n, it
>> will report that the system call is not available yet go ahead and continue
>> anyway:
>>
>>   # ./userfaultfd anon 30 1
>>   nr_pages: 480, nr_pages_per_cpu: 120
>>   userfaultfd syscall not available in this kernel
>>   bounces: 0, mode:, register failure
>>
>> This is because userfaultfd_open() returns 0 on success and 1 on error but
>> all callers assume that it returns < 0 on error.
>>
>> Since the convention of the test as a whole is the one used by
>> userfault_open(), fix its callers instead. Now the test behaves correctly:
>>
>>   # ./userfaultfd anon 30 1
>>   nr_pages: 480, nr_pages_per_cpu: 120
>>   userfaultfd syscall not available in this kernel
>>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>
> It seems that this patch is superseded by the second patch in this series.

Yes, but since this is a simple bugfix while the other patch is a
proposed improvement which can be debated, I think it's worthwhile to
keep them separate.

--
Thiago Jung Bauermann
IBM Linux Technology Center

