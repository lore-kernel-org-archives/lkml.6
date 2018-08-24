Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4301AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3972157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NScSTPOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3972157C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbeHXKpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 06:45:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48520 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeHXKpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 06:45:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7O78wox179633;
        Fri, 24 Aug 2018 07:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=6Uf5BotzAhNt1LeL/TLOXcWwRO95aizcXLJfqSDOo74=;
 b=NScSTPOAbQ4pyRx/ZEXRAGVkYFoIGIFlhv6nQq+uEqLcYOo3Z5N3dN2LN2cd7xVbWgLQ
 DBrTSW4uP1Z0mq6e8OWbFyp0cuUiQMMaalsNzQUVrqoFUrc4+0CtpW1ie0WYDTt/vf03
 /lv2BxNsWTmSOYvO1o2Mbtff0WH2ya5WwTdZTj++NXCnlxflOXsKKrYO1xVGHdDp42tH
 9ADaAdxyUVMtR83QdDsjclCFs6n/z8AbUpzoz4GBMBJTkTlqXlX80FsAEiIJ7+IGIKgY
 Qb2mNrPXyWsEa+w9wIQRBEEQ4t/fcx2P1I2lzc5JDp/O6ka3CYTzBuZXwlSIstESQyY3 Ew== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2kxavu5hqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Aug 2018 07:12:14 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7O7CDpc014752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Aug 2018 07:12:13 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7O7CD9G005145;
        Fri, 24 Aug 2018 07:12:13 GMT
Received: from [10.182.69.179] (/10.182.69.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Aug 2018 00:12:13 -0700
Subject: Re: MQ-BFQ crashing on battery mode
To:     Massimo Burcheri <massimo@burcheri.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
References: <1534926011.18658.29.camel@burcheri.de>
 <a43c5bdd-06ec-ae23-ebd3-bda8c0ea4f5c@kernel.dk>
 <1535092156.11909.8.camel@burcheri.de>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <f2983f77-8cc7-2734-9acb-c2cea4a90bd8@oracle.com>
Date:   Fri, 24 Aug 2018 15:12:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535092156.11909.8.camel@burcheri.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8994 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=762
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808240077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Massimo

On 08/24/2018 02:29 PM, Massimo Burcheri wrote:
> On Wed, 2018-08-22 at 11:42 -0600, Jens Axboe wrote:
>> Any chance you can try 4.18 at least?
> Of course, I tried the kernel.org sources now, sys-kernel/vanilla-sources-4.18.3 
> on Gentoo. The issue is the same.

In the first mail of this thread, you said:
"
Switching all devices to "none" scheduler did not help
"

So this issue should not related with io scheduler.

Would you please share the entire dmesg log or backtrace you got on 4.18.3 ?

Thanks
Jianchao
