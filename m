Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55796C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A3720838
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A3720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406545AbeKWEsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:48:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729679AbeKWEsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:48:31 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAMHwetF044765
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 13:08:01 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nwya8560m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 13:08:01 -0500
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muvic@linux.ibm.com>;
        Thu, 22 Nov 2018 18:08:00 -0000
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 22 Nov 2018 18:07:56 -0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAMI7t1e11730984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Nov 2018 18:07:55 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62628BE051;
        Thu, 22 Nov 2018 18:07:55 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CED9BE053;
        Thu, 22 Nov 2018 18:07:52 +0000 (GMT)
Received: from Murilos-MBP.home (unknown [9.85.169.113])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 22 Nov 2018 18:07:52 +0000 (GMT)
Subject: Re: [PATCH 4.9 00/59] 4.9.139-stable review
To:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org,
        Murilo Fossa Vicentini <muvic@linux.vnet.ibm.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20181121183508.262873520@linuxfoundation.org>
 <b642656d-4b0d-cb68-f862-9d90bacc88cc@roeck-us.net>
From:   Murilo Fossa Vicentini <muvic@linux.ibm.com>
Date:   Thu, 22 Nov 2018 16:07:50 -0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b642656d-4b0d-cb68-f862-9d90bacc88cc@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18112218-0004-0000-0000-000014B6DDE5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010101; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01121210; UDB=6.00581861; IPR=6.00901329;
 MB=3.00024281; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-22 18:07:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112218-0005-0000-0000-000089994B27
Message-Id: <bf811213-e1ad-d70e-cf9e-57735e359377@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-22_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=795 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811220161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/18 14:33, Guenter Roeck wrote:
> drivers/net/ethernet/ibm/ibmvnic.c: In function 'ibmvnic_xmit':
> drivers/net/ethernet/ibm/ibmvnic.c:789:40: error: implicit declaration 
> of function 'skb_vlan_tag_present'
> 
> Caused by 5f51bb855fa1 ("ibmvnic: fix accelerated VLAN handling").
> Problem is missing include of linux/if_vlan.h, which was added upstream
> with commit 6052d5e2a1961b ("ibmvnic: Insert header on VLAN tagged
> received frame").
> 
> I have no idea if the offending patch fixes 6052d5e2a1961b, if both are
> independent, if both are needed, or if none is needed.
> Copying the authors of both patches.

Both address different parts of the code within the same VLAN 
functionality, patch 5f51bb855fa1 (or upstream e84b47941e15) is making a 
change on the transmit side, and the patch I sent upstream 
(6052d5e2a196) addresses an issue when the system firmware strips the 
VLAN tag on the receive side.

In the context of having proper VLAN support for the ibmvnic driver I 
would say both are needed, although potentially there are other patches 
needed for this functionality to work properly, for example upstream 
commit da75e3b6a029 (ibmvnic: Account for VLAN tag in L2 Header 
descriptor) and upstream commit 8dff66cc4195 (ibmvnic: Account for VLAN 
tag in L2 Header descriptor).

Best regards,
Murilo Vicentini

