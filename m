Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2600153-1526585566-2-17760446848931692857
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526585566; b=C18UGA0HqDYOqpybdqqxuwm7W9/I3kz7TkHDCOPOiixV5KrDDl
    JvJ3udwaong6jyZFMHjeg3MXlMMhZYFmM2cJhPSr9oe4V23GWyXV9bs86zkwy0k6
    vQ5LOCeQzsOaMUKYfqjvC4h82ho8Mk+mdCKH6gmplVL2W9FOUG7RBuXDvxrKSy0L
    b89PysHaMMVtGdik34NvHu92rACElOdaRwC/Sz7pZAj6ExehRjtqL4aVDyIIbqbm
    JoPpCMypVj/Ll/SS727KpCNrdLdBti2c3Zq8M9iBPo7OV3qOePKx5B/DWLjerZZF
    XQ9QTORmmvK2fpivRsQlMvjukBG6j6fSC3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526585566;
    bh=XewMa5pgCkGw5TPcT5MYlXFXcHdR/S7BlhMXTHpcAnY=; b=U1tWXv4s/xej
    5zN4Jgh/FVCNtd3qfFOK4S4FpJh5lYfgFsg0auOgGU5fSZbEtnuDUunoYXJX5vEA
    U5YXCJndpsarubmMmme7XismzpYFKuUcW9O17mIxLSFaPURpz6u1HeUcoSRStC/Q
    qR/NwAk9gJNbo5+l4CdKutQye7ciXK2zCt68liLNHdUEwgUn8FE5hqR+yroLvnWO
    th0eJyshFH8usB3SbuTUwSBmj2Nlcg20gZylYBZsTPF9w/LAWTZJxVGP/SPYRyff
    UGLbL4JalNvD2wurkYB0zRbYYWjhClg7Hnrp81gXGBC4ip52r/s7729QjpfJxKwq
    ECXy7XTapQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com
    header.i=@oracle.com header.b=ffccTOXV x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com
      header.i=@oracle.com header.b=ffccTOXV x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKANRXoHTCLGhk7Z7qHaLJHXwm2uG6AE4qcPyvLno3TmOK2Kc0njPVh485kAI85QxQ2TELFXnllnXFNNryvXaIfH9GbYL8qLCvCkXtC3f7YO+6GxidHp
    nCOQejAe64WUikHrCFs1sBvIZstzSf/TqMJtjN367cxspyvNy1jzjYApUwS6UebThT+MDtEh3evJWb5TqGrn/F9eSUSBGDVeXtNqdUrN0yCIqur92GEdxbAS
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=vGkxw8iG5YUZIngbkwYA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751564AbeEQTco (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 15:32:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56102 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeEQTcn (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 May 2018 15:32:43 -0400
Subject: Re: [PATCH UPSTREAM] xen-swiotlb: fix the check condition for
 xen_swiotlb_free_coherent
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        John Sobecki <john.sobecki@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        ASHISH_B_SRIVASTAVA <ashish.b.srivastava@oracle.com>,
        stable@vger.kernel.org
References: <25d8a709-9f2f-fe09-f66c-2a0704ddbbb0@oracle.com>
 <20180517191003.GD504@kroah.com>
From: Joe Jin <joe.jin@oracle.com>
Message-ID: <d9a6cc08-3d9e-978c-e6c3-cbcb4fb92900@oracle.com>
Date: Thu, 17 May 2018 12:32:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180517191003.GD504@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8896 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=868
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805170182
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/17/18 12:10 PM, Greg KH wrote:
> On Thu, May 17, 2018 at 11:45:57AM -0700, Joe Jin wrote:
>> When run raidconfig from Dom0 we found that the Xen DMA heap is reduced,
>> but Dom Heap is increased by the same size. Tracing raidconfig we found
>> that the related ioctl() in megaraid_sas will call dma_alloc_coherent()
>> to apply memory. If the memory allocated by Dom0 is not in the DMA area,
>> it will exchange memory with Xen to meet the requiment. Later drivers
>> call dma_free_coherent() to free the memory, on xen_swiotlb_free_coherent()
>> the check condition (dev_addr + size - 1 <= dma_mask) is always false,
>> it prevents calling xen_destroy_contiguous_region() to return the memory
>> to the Xen DMA heap.
>>
>> This issue introduced by commit 6810df88dcfc2 "xen-swiotlb: When doing
>> coherent alloc/dealloc check before swizzling the MFNs.".
>>
>> Signed-off-by: Joe Jin <joe.jin@oracle.com>
>> Tested-by: John Sobecki <john.sobecki@oracle.com> 
>> Reviewed-by: Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Cc: stable@vger.kernel.org
>> ---
>>  drivers/xen/swiotlb-xen.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> What does "PATCH UPSTREAM" mean?

Oops I forgot to remove UPSTREAM, the tag for internal review.

Sorry for this, will resend it without the tag.

Thanks,
Joe

> 
> confused,
> 
> greg k-h
>
