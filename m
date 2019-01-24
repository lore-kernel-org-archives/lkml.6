Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3074C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF8B218D2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bbyo4Yy2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfAXVQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:16:01 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44224 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbfAXVP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 16:15:58 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0OL8w4U005289;
        Thu, 24 Jan 2019 21:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=6sCEOip9mnoitxSgQhvI+NentecHeGKw1mpsyDGgvRo=;
 b=bbyo4Yy2WsEn5To+u1MfnPNVigQ+WdGlW6Ayd9Ma3e6tZVkOt4zlT2yE+PnQxzKypzX2
 VDGtB5BANDr4FmjqYRKmASeiVW903UL536nlu8W4ozeqoCMEYbyaBYPOdYMU/ek2YuFG
 R8gI9YtdQbDKc9dlAbbDjNIk2n8g0Uhhr2WDvTjX0ztmJPMueOZixoo886IDCq58OPya
 u16LSp+NqJ9+q+vY6+hSjy4dq8DMOoglfMmlIR/z31eIZdLpYcu3kGPqU6FK92j2Cd0v
 G5aDZ6QgWlafba1JcXG6yfeVUQ9SvfIER6GbpYj5DvapmS84o+XxHlc84CDQA6p6dsxC jw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2q3uav2c2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jan 2019 21:15:51 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0OLFo7l009689
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jan 2019 21:15:50 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0OLFofP031996;
        Thu, 24 Jan 2019 21:15:50 GMT
Received: from [10.39.238.27] (/10.39.238.27)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Jan 2019 13:15:50 -0800
Subject: Re: [PATCH v1] ras: Use consistent types for UUIDs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, Tyler Baicar <tbaicar@codeaurora.org>
References: <20180713131027.77362-1-andriy.shevchenko@linux.intel.com>
 <20181005073305.GB24224@lst.de> <20190109160759.GI9170@smile.fi.intel.com>
From:   Thomas Tai <thomas.tai@oracle.com>
Organization: Oracle Corporation
Message-ID: <55579a78-85d3-ff03-86a8-79021230f141@oracle.com>
Date:   Thu, 24 Jan 2019 16:15:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190109160759.GI9170@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9146 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=960
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901240144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/19 11:07 AM, Andy Shevchenko wrote:
> On Fri, Oct 05, 2018 at 09:33:05AM +0200, Christoph Hellwig wrote:
>> On Fri, Jul 13, 2018 at 04:10:27PM +0300, Andy Shevchenko wrote:
>>> The commit
>>>
>>>    297b64c74385 ("ras: acpi / apei: generate trace event for unrecognized CPER section")
>>>
>>> brought inconsistency in UUID types which are used across the RAS subsystem.
>>>
>>> Fix this by moving to use guid_t everywhere.
>>
>> Looks good,
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Thanks, Christoph.
> 
> Tomas, Tyler, any comments from your side?

Thanks for asking. I have no comments on my side.

Thanks,
Thomas

> I can push it through my tree if it looks abandon, or if Christoph is okay
> through UUID one.
> 
