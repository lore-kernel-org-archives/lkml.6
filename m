Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43C9C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9782520831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GUlKJZBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9782520831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbeLIE0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 23:26:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55358 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeLIE0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 23:26:47 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB94QPFR173088;
        Sun, 9 Dec 2018 04:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=WKPjiBYVhb+zOxf5+p+2Cw8+fVYvmeN2le0hr31F158=;
 b=GUlKJZBOpMGFvkxgLgITenBo8phXJMgbxbWUZDZnXlXOGaPyd7TbAzaAUkCtkxrb3P9c
 eykX1P0J1uw9PwhkdwHqTHJbzxFtADA4K8+kQPUdOm3kjNMb5aFHpHIv67U2VkMVGHrG
 HG73bxBFVM3u35Vq9YAZaRfAYbIDmTRYtuKBOKe6jAqTXj5KgJbOuuqsRYl1708A/Lch
 XNNZVtIBmgNW8TXwzyhopcHXy2/thz25m2BePsr6nURrLC3PLZU1rWvMS0G3tdmZ1NlC
 vXDBbruzP0wkdC4SnKIAZrapsyUGrdAg/aLaM300EbMT2eAA3wF68H2zM/w8HUgemlt+ Pg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2p85ctsu10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 09 Dec 2018 04:26:25 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB94QJYc004029
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 9 Dec 2018 04:26:20 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB94QJUL002735;
        Sun, 9 Dec 2018 04:26:19 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 08 Dec 2018 20:26:19 -0800
Subject: Re: [PATCH] firmware: ti_sci: Change to use DEFINE_SHOW_ATTRIBUTE
 macro
To:     Nishanth Menon <nm@ti.com>, Yangtao Li <tiny.windzz@gmail.com>
Cc:     t-kristo@ti.com, ssantosh@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181122140519.25166-1-tiny.windzz@gmail.com>
 <20181208160404.h7cuuq6jvafoxa32@akan>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <06387350-3247-539a-8eea-123d2f8e94d5@oracle.com>
Date:   Sat, 8 Dec 2018 20:26:32 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181208160404.h7cuuq6jvafoxa32@akan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9101 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=974
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812090041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/2018 8:04 AM, Nishanth Menon wrote:
> On 09:05-20181122, Yangtao Li wrote:
>> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>>
>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> 
> Thanks for the same and sorry for responding so late.
> 
> [...]
> 
> Santosh,
> could you pick this up? maybe for next rev or so?
> 
> Reviewed-by: Nishanth Menon <nm@ti.com>
> 
Sure !!
