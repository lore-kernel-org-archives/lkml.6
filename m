Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DEFC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA632086B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KOWwvPqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA632086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753970AbeFTBnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 21:43:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60370 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbeFTBm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 21:42:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5K1chkC172727;
        Wed, 20 Jun 2018 01:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=9AWLfj1fk2iTRypmB2YRiG5f4QzLMMkB1PgM+CfZsmM=;
 b=KOWwvPqT7JRf+wMKoM93TgTP1DqSI5ggAB8bsH7/rlXBWNV0n4mrix7eW2fpgXdO5X8V
 vhHcNTVzo8RijBMv9QjAh7EL3/mVoKqZ6+nKOLVng5I8Y9sC0FhWqaDXthIus5VdH7Zp
 8wDwXBMU0xiIHePwgrSWwqTmczE+PTpXMRLFFm7XPonN4kQtwy5aPqrdQuxX7nFigq52
 JwLK31vf9FiOB0WhiLx8Rv9UTsZPULMKwodwJCGTx6QfOYYdkv1g9bFV62hito4tPemZ
 WqWWjKbZ/wPCJ9l02TYAe8aRUXb8qZtSkt6Q2CzkN/jNYVHR0yHGFVgGJvQlsA+4uIGo YA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2jmt01jh3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 01:42:52 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5K1gp2N014028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 01:42:51 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5K1gonj022414;
        Wed, 20 Jun 2018 01:42:50 GMT
Received: from [10.159.143.233] (/10.159.143.233)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jun 2018 18:42:49 -0700
Subject: Re: [PATCH] selftests: net: add config fragments
To:     Anders Roxell <anders.roxell@linaro.org>, davem@davemloft.net,
        shuah@kernel.org, fw@strlen.de
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180619164111.30785-1-anders.roxell@linaro.org>
From:   Shannon Nelson <shannon.nelson@oracle.com>
Organization: Oracle Corporation
Message-ID: <f8995ed8-7ff8-d5fd-b2e0-5664510a4972@oracle.com>
Date:   Tue, 19 Jun 2018 18:42:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619164111.30785-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8929 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/2018 9:41 AM, Anders Roxell wrote:
> Add fragments to pass bridge and vlan tests.
> 
> Fixes: 33b01b7b4f19 ("selftests: add rtnetlink test script")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
> 
> Hi,
> 
> net/rtnetlink.sh still fails on tc hbt hierarchy, addrlabel and ipsec:
> Error: Specified qdisc not found.
> RTNETLINK answers: No such file or directory
> Error: Parent Qdisc doesn't exists.
> We have an error talking to the kernel, -1
> Error: Parent Qdisc doesn't exists.
> We have an error talking to the kernel, -1
> Error: Parent Qdisc doesn't exists.
> We have an error talking to the kernel, -1
> Error: Parent Qdisc doesn't exists.
> We have an error talking to the kernel, -1
> Error: Parent Qdisc doesn't exists.
> We have an error talking to the kernel, -1
> Error: Parent Qdisc doesn't exists.
> We have an error talking to the kernel, -1
> Error: Invalid handle.
> FAIL: tc htb hierarchy
> 
> FAIL: ipv6 addrlabel
> 
> FAIL: can't add fou port 7777, skipping test
> RTNETLINK answers: Operation not supported
> FAIL: can't add macsec interface, skipping test
> RTNETLINK answers: Protocol not supported
> RTNETLINK answers: No such process
> RTNETLINK answers: No such process
> ./rtnetlink.sh: line 527:  5356 Terminated              ip x m >
> $tmpfile
> FAIL: ipsec
> 
> 
> I'm using iproute2 tag: 4.17 and tried the qdisc command from the
> function kci_test_tc in net/rtnetlink.sh:
> $ tc qdisc add dev lo root handle 1: htb
> Error: Specified qdisc not found.
> 
> For kci_test_addrlabel it fails on this row:
> ip addrlabel list |grep -q "prefix dead::/64 dev lo label 1"
> 
> Any idea why these three fails?


The "Terminated" line is there because "ip x m" had been put into the 
background, and at the end of the ipsec test it is killed.  I can try to 
play some games with exec and redirection to make that go away.

The "FAIL: ipsec" is partly because the test isn't smart enough to look 
to see if there is any offload actually available to test.  I'm working 
on a patch to netdevsim to add the ipsec-offload in order to have a 
better test.  And yes, this should say "ipsec-offload", not "ipsec".

I don't know about the qdisk or addrlabel issues.

Cheers,
sln


> 
> Cheers,
> Anders
> 
>   tools/testing/selftests/net/config | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
> index 7ba089b33e8b..cd3a2f1545b5 100644
> --- a/tools/testing/selftests/net/config
> +++ b/tools/testing/selftests/net/config
> @@ -12,3 +12,5 @@ CONFIG_NET_IPVTI=y
>   CONFIG_INET6_XFRM_MODE_TUNNEL=y
>   CONFIG_IPV6_VTI=y
>   CONFIG_DUMMY=y
> +CONFIG_BRIDGE=y
> +CONFIG_VLAN_8021Q=y
> 
