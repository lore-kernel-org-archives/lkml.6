Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4E044C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF80208D7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TLVV405g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF80208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935234AbeFMRVC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:21:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54486 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934889AbeFMRVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:21:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5DHJBo2070354;
        Wed, 13 Jun 2018 17:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=lgoUEM5q9BaOTwbF6Hivea+uwIhRNtOjLY9vqpMWCL0=;
 b=TLVV405gLof3RH22K8/kvJQ/Wht5anofJglUIoy6tYBeCNRocY6APbcZdYm6amhJWju/
 CPmnxej0mg0EJ5aylxQzgyHWBVNeRFMtqbJP9QpCJKwGFaKzXuGba48wxZlh+1fHOme3
 FP3nN73p7Hz0VZLqlN+pESwOALAzU809kiOWY2AT/azkmMZVvXTP1raD2F0tfjecGApL
 92uuKFI4N2fJPR74p4A5YAaSnVv3Ego5CLx3sGSRpzjhw0aqd9ZPxw5LGhf1XV/riSG0
 2fj7iJIlS+JAvLZBte9jhgsU8lOU0R7QFYJbXLntq1bGTC7ui+RZyb9msiVjs0CERIjz qA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2jk0xr9q2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 17:20:59 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5DHKwmn027837
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 17:20:58 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5DHKwWH013123;
        Wed, 13 Jun 2018 17:20:58 GMT
Received: from [10.154.100.228] (/10.154.100.228)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jun 2018 10:20:58 -0700
Subject: Re: [PATCH] selftests: sparc64: Fix to do nothing on non-sparc64
To:     "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180612232348.27979-1-shuah@kernel.org>
From:   Tom Hromatka <tom.hromatka@oracle.com>
Message-ID: <d6a1ce6d-4903-ec7a-10aa-d40118fce45c@oracle.com>
Date:   Wed, 13 Jun 2018 11:20:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180612232348.27979-1-shuah@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8923 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=716
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806130185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Shuah!

Tom


On 06/12/2018 05:23 PM, Shuah Khan (Samsung OSG) wrote:
> sparc64 test fails with the following errors on non-sparc64 systems. Fix
> the Makefile to do nothing on non-sparc64 systems to suppress the errors:
>
> make run_tests
> adi-test.c: Assembler messages:
> adi-test.c:302: Error: no such instruction: `rd %tick,%r13'
> adi-test.c:304: Error: no such instruction: `rd %tick,%rbp'
> adi-test.c:190: Error: no such instruction: `rd %tick,%rbp'
> adi-test.c:192: Error: no such instruction: `rd %tick,%rdx'
> adi-test.c:273: Error: no such instruction: `rd %tick,%rbx'
> adi-test.c:276: Error: no such instruction: `rd %tick,%rdx'
> adi-test.c:217: Error: no such instruction: `rd %tick,%rbp'
> adi-test.c:220: Error: no such instruction: `rd %tick,%rdx'
> adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
> adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
> adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
> adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
> adi-test.c:246: Error: no such instruction: `rd %tick,%rbp'
> adi-test.c:248: Error: no such instruction: `rd %tick,%rdx'
> adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
> adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
> adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
> <builtin>: recipe for target 'adi-test' failed
> make[1]: *** [adi-test] Error 1
> adi: [FAIL]
> ./drivers_test.sh: 24: ./drivers_test.sh: ./adi-test: not found
> ../lib.mk:73: recipe for target 'run_tests' failed
> make: *** [run_tests] Error 1
>
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>

Reviewed-by: Tom Hromatka <tom.hromatka@oracle.com>
