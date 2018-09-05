Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DF7C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3E6206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kQMhk+YE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3E6206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeIEQ6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:58:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51320 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbeIEQ6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:58:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w85CJ4TI143939;
        Wed, 5 Sep 2018 12:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=J4PZDoNwoRsPkEsLOpKLxnisS59CO+3WXY8qmm3VpLU=;
 b=kQMhk+YEtUFwddNtbfpz8ehpZe2bx+sD7n+iehDX1uMQ+5TWEZOuu2vQRxCA9qkFRMwm
 Hc/1Jy51/4unPRDJ/od5PtupzUFLRE4XBZMXNFRdN9k3Wxxn8mX8KqGJfUlBjaZxMMs8
 7H4lel3Yi1lrQqHxlePWTfSTTLHSC/3Gx7UThycaPErduO3qu6l57hwhvrClBtSrActa
 SqK20YG3wCEHVTbNmXbZNnMLHB/CttLA4kOiJLsC9pmehNj2gn8rzzRSsVhN4N9Q4uuY
 uTAnSw6lUo+hBmrJrpveo6iSgHL3CHw0XZv+TEQWGfVy+knc4+cOtZG7xfavdzJxOTXc Zw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2m7jqpkmd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Sep 2018 12:28:36 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w85CSadd027940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Sep 2018 12:28:36 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w85CSZj6009555;
        Wed, 5 Sep 2018 12:28:36 GMT
Received: from [192.168.1.93] (/99.156.91.244)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Sep 2018 12:28:35 +0000
Subject: Re: [Jfs-discussion] [PATCH v2 4/5] jfs: cache NULL when both
 default_acl and acl are NULL
To:     cgxu519 <cgxu519@gmx.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20180831143352.22970-1-cgxu519@gmx.com>
 <20180831143352.22970-4-cgxu519@gmx.com>
 <0e37733e-9acd-cf82-62f7-420f0fa864eb@oracle.com>
 <c231d198-7a4e-63a0-0a7d-9211ab0abfe9@gmx.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Openpgp: preference=signencrypt
Message-ID: <582c17b3-5d52-24c0-8d95-af3d62071738@oracle.com>
Date:   Wed, 5 Sep 2018 07:28:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <c231d198-7a4e-63a0-0a7d-9211ab0abfe9@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9006 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=659
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809050131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/18 1:13 AM, cgxu519 wrote:
> 
> On 09/04/2018 04:34 AM, Dave Kleikamp wrote:
>> Are you pushing these as a series, or would you like this patch pushed
>> through the jfs tree?
> I'd hope maintainers pick individual patch to their tree.

I'll take care of this one.

Thanks,
Shaggy

> 
> Thanks,
> Chengguang
> 
>>
>> On 8/31/18 9:33 AM, Chengguang Xu wrote:
>>> default_acl and acl of newly created inode will be initiated
>>> as ACL_NOT_CACHED in vfs function inode_init_always() and later
>>> will be updated by calling xxx_init_acl() in specific filesystems.
>>> Howerver, when default_acl and acl are NULL then they keep the value
>>> of ACL_NOT_CACHED, this patch tries to cache NULL for acl/default_acl
>>> in this case.
>>>
>>> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
>> Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>
>>
