Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322ADC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70E026F5B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jJQaX3Ed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70E026F5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752360AbeFZVRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:17:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59710 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751984AbeFZVRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:17:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5QLDt1T178189;
        Tue, 26 Jun 2018 21:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2017-10-26;
 bh=fEUig/5Ts4AEKHOcjYs+qpk9PMj1mVjiV1yo9OnZhi0=;
 b=jJQaX3Ed8JvYhvDkbQXtAUCEd9n2AKFLINo/UAR4jh0zfMgh963pQpHKAGDBJZPvidf/
 1034FCyDiMWhlvAig0XBEqQfft6GWBhXVU/gVcqpTzzXjOFxmapPrsBP050RBoa2Er7y
 vgE7NngoP/A4+Bnq+sVC9KaDMZF53Nw9e/qxBApIBe3IRZDu8kdPXP/Nj7jep/ey18hi
 ptEVo2h2B2DDhdAENeSAv5SzX5NTJWg69Sik/HRh6koNOOW6sfogOyflC9i5K8zJ2XQC
 DYSHAekPMcQ315GAfMLfJrL3VUvxfk1b5VwZNCfd5/AsdeljUKbgUu+ykOiIjuUyLw+M Nw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2jum57t9bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 21:17:21 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5QLHKPP015678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 21:17:20 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5QLHJ6r020975;
        Tue, 26 Jun 2018 21:17:19 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Jun 2018 14:17:18 -0700
Subject: Re: [linux-next PATCH 0/4] Enable network driver on K2G ICE and GP
 EVMs
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     Murali Karicheri <m-karicheri2@ti.com>, ssantosh@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1526066952-5230-1-git-send-email-m-karicheri2@ti.com>
 <8e1aa492-ae7a-de2b-f5d2-8756b10ece79@oracle.com>
Organization: Oracle Corporation
Message-ID: <3fd86a06-6702-8e1c-54e6-01b23f9fd4cd@oracle.com>
Date:   Tue, 26 Jun 2018 14:17:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <8e1aa492-ae7a-de2b-f5d2-8756b10ece79@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8936 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806260234
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/20/2018 8:17 PM, santosh.shilimkar@oracle.com wrote:
> On 5/11/18 12:29 PM, Murali Karicheri wrote:
>> Now that NetCP driver patches for K2G SoC is merged to linux-next master
>> this series add patches to enable network driver on K2G ICE and GP EVMs.
>>
>> Thanks
>>
>> Applied the patches on top of latest linux-next master, built kernel and
>> booted up on both EVMs. The logs are below
>>
>> K2G GP EVM: https://pastebin.ubuntu.com/p/ycZDnZXYPx/
>> K2G ICE EVM: https://pastebin.ubuntu.com/p/bdCpzgdrXr/
>>
>> Murali Karicheri (4):
>>    ARM: dts: k2g: add dt bindings to support network driver
>>    ARM: dts: keystone-k2g-evm: Enable netcp network driver
>>    ARM: dts: keystone-k2g-ice: Enable netcp network driver
>>    ARM: keystone: k2g: enable micrel and dp83867 phys
>>
[...]

>>
> Looks good. Will add this to the queue for 4.19. Thanks !!
> 
Applied. You should see it in linux-next as well.

Regards,
Santosh
