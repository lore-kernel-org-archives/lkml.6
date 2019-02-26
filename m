Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055D6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0840206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jmv5MX0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbfBZLVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:21:18 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57096 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBZLVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:21:18 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1QBIfZd163256;
        Tue, 26 Feb 2019 11:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=LZoP1tXlJEvSW0N+wsoE+Eyfk/MfkVu/zJR2HZr0Dk0=;
 b=Jmv5MX0VamdiDIkRUAKZQnC5pm9XKA3YBgq/3rvktkswBBiPL8gtAjlOlprFMMHHe+tw
 6qEcDa/wf4457LWtWMLiHNewLIoi1ttXvRx3VYo0y3eemB5e/ydxsQ/KvKOnT9o75bTu
 qWKN2cEd8PsJx4UyroGRRN3dn51Lro8wK2pqF5KI51KZsJTCK4qh+nl+gll8fWhgDRT2
 kUIupw46T1rqLc4Dk90QiYWS9haFur0kVlXUUfIk7tiCDEYf0+mYr7DbzX8HPESrV5RN
 moRXh0nhUzGi80VpiDXKAnJbxwcKE2gbKVQisoG9yJ/Sm3Sr8vGUQY8Ye5rT2pNt4wIn Kg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qtupe466a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 11:21:08 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1QBL6wR003337
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 11:21:07 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1QBL661009880;
        Tue, 26 Feb 2019 11:21:06 GMT
Received: from [192.168.1.67] (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Feb 2019 03:21:06 -0800
Subject: Re: [PATCH RFC 20/39] xen-blkback: module_exit support
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
 <20190220201609.28290-21-joao.m.martins@oracle.com>
 <20190225185719.GA16013@char.us.oracle.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <29073305-4c54-99c1-74e1-7bdc6090f88d@oracle.com>
Date:   Tue, 26 Feb 2019 11:20:59 +0000
MIME-Version: 1.0
In-Reply-To: <20190225185719.GA16013@char.us.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9178 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=667 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902260085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/19 6:57 PM, Konrad Rzeszutek Wilk wrote:
> On Wed, Feb 20, 2019 at 08:15:50PM +0000, Joao Martins wrote:
>>
>> Implement module_exit to allow users to do module unload of blkback.
>> We prevent users from module unload whenever there are still interfaces
>> allocated, in other words, do module_get on xen_blkif_alloc() and
>> module_put on xen_blkif_free().
> 
> This patch looks like it can go now in right?
> 
Yes.

	Joao
