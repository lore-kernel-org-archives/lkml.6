Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F98BECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D013720875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5LGFE2Ot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D013720875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388203AbeGWSpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:45:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60172 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388125AbeGWSpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:45:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6NHYX7l150089;
        Mon, 23 Jul 2018 17:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ezrmf+IZwqNJPU2nQqPkKq6CGe3asCx31/C4j2rF1eE=;
 b=5LGFE2OtW0y5HgvvfBeXiW90tDN/m+53UJcKmqSrKdHMon5O1dhFNyM8S7R0arA9piAH
 86vE1DcsRpsTa7JtR7T0eoT3O+x0l/Hlb5oZeS8+ZU1Cd7D805nY9+yXc5znNBs2mvAT
 clkxdEIm7RnW3GAtQrtJEgW6KuNNJySlXM7k82WGHIkCk2U2jQZEHRo/jg7Bu8Anfz1w
 0WAw/Lj0PPcYyJ6mTHzuNldVaCHoIo1gtSUefstHJ+FUcnia6NVE27pNLFNV4EzQ+Gj8
 w8Eca54zdxdz6pJ9DTr4Z0VBhIOBWVilLfMNfA6CIfu7/gMZrq6+jB9DInEQKycDupNC XA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2kbwfpnk8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jul 2018 17:42:53 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6NHgqqd001799
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jul 2018 17:42:52 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6NHgpL3009040;
        Mon, 23 Jul 2018 17:42:51 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Jul 2018 10:42:50 -0700
Subject: Re: [PATCH V2 0/2] firmware: ti_sci: Add host-id as an optional
 parameter
To:     Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org
References: <20180716171328.11674-1-nm@ti.com>
 <20180723133303.ijekyffgnmesrhhv@kahuna>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <ea7691ab-db22-bea0-9753-b7a2765a22b8@oracle.com>
Date:   Mon, 23 Jul 2018 10:42:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723133303.ijekyffgnmesrhhv@kahuna>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8963 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807230197
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/2018 6:33 AM, Nishanth Menon wrote:
> On 17:13-20180716, Nishanth Menon wrote:
>> Please find attached series to enable host-id as an optional dt property.
>>
>> This is a minor update to V1 -> Mostly to pick up Greet's feedback and Rob's Ack.
>>
>> V1: https://patchwork.ozlabs.org/cover/931822/
>>
>> The series is based on v4.18-rc1 and is available here:
>> https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.18-rc1/k3-1-am6-tisci
>>
>> Consolidated all patches (including all series) are available here:
>> https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.18-rc1/k3-am6-integ
>>
>> Full Boot log (integrated of all series for AM654) is available here:
>>     https://pastebin.ubuntu.com/p/bBFmnzYtCd/
>>
>> Nishanth Menon (2):
>>    Documentation: dt: keystone: ti-sci: Add optional host-id parameter
>>    firmware: ti_sci: Provide host-id as an optional dt parameter
>>
>>   .../devicetree/bindings/arm/keystone/ti,sci.txt    |  4 ++++
>>   drivers/firmware/ti_sci.c                          | 24 ++++++++++++++++++----
>>   2 files changed, 24 insertions(+), 4 deletions(-)
> 
> Santosh,
> 
> Apologies, I see you have already send your PR for v4.19. Was
> just wondering if this is something we can consider for rc
> cycle OR if you'd consider a followup PR for the same.
> 
NP. Patch(s) doesn't look RC material so don't plan to send
it as part of RC. Please let me know if its o.w

This will have to wait for next cycle. Will merge this
early once v4.19-rc1 comes out.

Regards,
Santosh
