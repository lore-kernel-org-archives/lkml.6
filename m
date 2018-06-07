Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KsTbItecGVtxRQAAmS7hNA
	; Thu, 07 Jun 2018 21:00:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6FBDB6089E; Thu,  7 Jun 2018 21:00:07 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R9kAhxHD"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DC5DA601C3;
	Thu,  7 Jun 2018 21:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC5DA601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933186AbeFGVAF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 17:00:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51284 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932351AbeFGVAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 17:00:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w57Koxta007551;
        Thu, 7 Jun 2018 20:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=b2EOFKlkzYbJtAU7toAOslOIHWH7o7NjJ/7HqWyDcUk=;
 b=R9kAhxHD/GckBAhymcE3jMHvOdczhtqd6JouOwRku5WbABd61wo2XIb90vmgUgJGU0OP
 n0UsptT8vDsS+Pm+jX18FqJ36bdwKLnnzF+lDNFotrrbv194ilvLI4cJpMp0sGoGalq+
 eq+zOU34h41jl6eKHYlxgZW3if7Is/uv1rE+b+EZ9sKBJvNSkPbHih1duoc9+2HTEfku
 q4JnBk7NEe24Ez7c4xgl73hWSFnrBsxkMwIuDGLxJPDmrBDvfnybgNU3BFRFLSLqAXff
 uclMQ+zULXQgrmcXbCzQaeXbMFy17vuJr9+jjZyvticltT9bNk0tGtd85si1+o3F2/id sQ==
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2jbvyptm8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jun 2018 20:59:51 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w57KxoOH007449
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jun 2018 20:59:50 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w57Kxoqh008486;
        Thu, 7 Jun 2018 20:59:50 GMT
Received: from [10.211.203.83] (/10.211.203.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Jun 2018 13:59:50 -0700
Subject: Re: [PATCH 4.4 010/268] xen-swiotlb: fix the check condition for
 xen_swiotlb_free_coherent
To: Ben Hutchings <ben.hutchings@codethink.co.uk>,
        John Sobecki <john.sobecki@oracle.com>,
        Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20180528100202.045206534@linuxfoundation.org>
 <20180528100203.277622038@linuxfoundation.org>
 <1528403323.2289.84.camel@codethink.co.uk>
From: Joe Jin <joe.jin@oracle.com>
Message-ID: <90be58ac-fd9a-abb1-3bf6-8f5001c39a0b@oracle.com>
Date: Thu, 7 Jun 2018 13:59:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528403323.2289.84.camel@codethink.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8917 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806070221
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/18 1:28 PM, Ben Hutchings wrote:
> On Mon, 2018-05-28 at 11:59 +0200, Greg Kroah-Hartman wrote:
>> 4.4-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Joe Jin <joe.jin@oracle.com>
>>
>> commit 4855c92dbb7b3b85c23e88ab7ca04f99b9677b41 upstream.
>>
>> When run raidconfig from Dom0 we found that the Xen DMA heap is reduced,
>> but Dom Heap is increased by the same size. Tracing raidconfig we found
>> that the related ioctl() in megaraid_sas will call dma_alloc_coherent()
>> to apply memory. If the memory allocated by Dom0 is not in the DMA area,
>> it will exchange memory with Xen to meet the requiment. Later drivers
>> call dma_free_coherent() to free the memory, on xen_swiotlb_free_coherent()
>> the check condition (dev_addr + size - 1 <= dma_mask) is always false,
> 
> I think this was meant to say (dev_addr + size - 1 > dma_mask), i.e.

Hi Ben,

Yes you are right, sorry I made the mistake, thanks for catch it.
Is there any way to fix description from git repo?

Regards,
Joe

> the condition that is replaced by this commit.  If that's always false,
> the new condition (the logical inverse) must always be true.
> 
> [...]
>> --- a/drivers/xen/swiotlb-xen.c
>> +++ b/drivers/xen/swiotlb-xen.c
>> @@ -359,7 +359,7 @@ xen_swiotlb_free_coherent(struct device
>>  	 * physical address */
>>  	phys = xen_bus_to_phys(dev_addr);
>>  
>> -	if (((dev_addr + size - 1 > dma_mask)) ||
>> +	if (((dev_addr + size - 1 <= dma_mask)) ||
>>  	    range_straddles_page_boundary(phys, size))
>>  		xen_destroy_contiguous_region(phys, order);
>>  
> 
> So now we will always call xen_destroy_contiguous_region(), whether or
> not xen_create_contiguous_region() was called during allocation.  Is
> that really the intent?  If so, the entire condition could be removed
> to make this clear.
> 
> Alternately, if the commit message is correct, the condition could be
> simplified to range_straddles_page_boundary(...).
> 
> But I'm not at all convinced that either of these is correct.  It seems
> like you need to either find a way of distinguishing between memory
> allocated with or without the use of xen_create_contiguous_region(), or
> to use it unconditionally.
> 
> Ben.
> 


-- 
Oracle <http://www.oracle.com>
Joe Jin | IT Director 
ORACLE | Production Engineering and Operations
600 Oracle Parkway Redwood City, CA US 94065
