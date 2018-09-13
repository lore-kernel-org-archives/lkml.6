Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30166FC6182
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 22:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E852086C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 22:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PyDea6CR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E852086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbeINDaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 23:30:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35280 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbeINDaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 23:30:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8DMDtgT091467;
        Thu, 13 Sep 2018 22:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=reply-to : subject :
 references : to : cc : from : message-id : date : mime-version :
 in-reply-to : content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=YL3mI0chfkhxEnzcHseoHiXzb9R1AnqMOVv1ldjS/r4=;
 b=PyDea6CRU+83gWdhbLeDm5L2FB3qagZMmO6f3iH18LRMxJD54FygG8O6zmP63cb5O8I5
 l4tLyxsqg2bxA9lwJgWXMMv5hHTVNEh5mxoqmXMtFW5+z+7DdNN9YFINDoofOfBiIbbR
 +HLFTupQEQ2q40+2KEAsjkUC9qCuJTQwfmtvUgJXe3z49tUST7nK7AYD7hFkInkQRAve
 s0Yf7aDctimCvvlJCFF18feykOcZcFgYnkzaqViKj/m2BOu1QhacRyS05wjW+3n//VMD
 wdkjfku60PV2d71yvHfUW2mwJQYEUxxQu/Qv21Q+uiwc0hGKp85bVGCi3vRMs0i9Dtuz Tw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2mc72r3xgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Sep 2018 22:18:44 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8DMIhbU025364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Sep 2018 22:18:43 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8DMIhw8028789;
        Thu, 13 Sep 2018 22:18:43 GMT
Received: from [10.132.93.61] (/10.132.93.61)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Sep 2018 15:18:42 -0700
Reply-To: prakash.sangappa@oracle.com
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
References: <20180912230212.GA6567@avx2>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mhocko@kernel.org,
        dave.hansen@intel.com, cl@linux.com, khandual@linux.vnet.ibm.com
From:   "prakash.sangappa" <prakash.sangappa@oracle.com>
Message-ID: <dd4c3282-03b8-7480-fea7-fecce0ea2444@oracle.com>
Date:   Thu, 13 Sep 2018 15:17:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180912230212.GA6567@avx2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9015 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=962
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809130220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/12/2018 04:02 PM, Alexey Dobriyan wrote:
>> The /proc/pid/numa_vamaps shows mapped address ranges to numa node id
>> from where the physical pages are allocated.
> All these files make the problem with useless dentry and /proc/*/* inode
> instantiations worse (unlike top level /proc/* files which are
> tolerable).
>
>> +address-range	numa-node-id
>> +
>> +00400000-00410000 N1
>> +00410000-0047f000 N0
>> +0047f000-00480000 N2
>> +00480000-00481000 -
>> +00481000-004a0000 N0
>> +004a0000-004a2000 -
>> +004a2000-004aa000 N2
>> +004aa000-004ad000 N0
>> +004ad000-004ae000 -
> 'N' is useless data.

'N' could be dropped.

>
> Parsing with awk won't work because field #3 is separated with space
> but field #2 with '-'.
>
> %08lx-%08lx kind of sucks: 32-bit get aligned data so parsing can be
> faster by pointing to &p[8+1] but not on 64-bit.
> If scanf("%lx-%lx") is used then leading zeroes are useless.

This was similar to how '/proc/*/maps' file presents the  address range.
However, we could separate start and end address of the range with a
space, if that would be preferred.

> Text is harder than it looks.

We could make each line fixed length.  It could be  "%016lx %016lx %04d"
i.e 4 digit for node number?

> Please in the name of everything holy add new honest system call.

