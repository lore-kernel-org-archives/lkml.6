Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-536962-1524060479-2-15806224735184185344
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524060478; b=FlMuGdojXpwMGClMFfg/i3+f1zbtmuVNbkpq8/TfhtuO6wWK0c
    LwG9McvB2LPyBamklXcHz6P8QmS9KZ3FBX/2+9uUINSyjq5Y3ldnfWWw58t2PJpX
    DLldsXozBES15IsNGQS+jdkllz6hExXSjp4x3eQ2nHNZlFENVPy4uYLm3PTsVHFb
    WSF+oEmBkxCVQDyT1j+9AWJtFbLCCU2LsOAq5q7WBMU0mT6Nm1accCEj/0VwYzU8
    x8LngJzgE3EhlF8LeEIwOYZlhcttRUA575Deof+MeW6R/4HxmCmLus1NPHk3NwLf
    U+96uKQhzrqYKuL2FMyXrwgU2K6zAFGxcIWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524060478;
    bh=YZkGtt14xabkZUwdBCYMGWTKPzn1WHFHg1/KFNNt3kg=; b=kQNGsRqRYDco
    /Xtyzv2MPI/LG+OVazpwbGXdtZwXVAeEE90P4uTU3LCwESOCRoc3NJ47ORgV0EBD
    czIorWY8XsvGVR7yVxAxnZBruZar4+ypiHqKQt6iMk0biiYk6H1hAiUkkhN/Cgpu
    tEL3SVDkU0kSTDlRTWmwFE4Dl6V/LRZUNjAPJMfx4dN41+qRPrcZtUDD8nwiKZPE
    0IxZ7kckq5LtumuKVYpWlv9jtXSPC934fMifLNZo7Aq+L1HQd5gE4MQPXLxI2PO9
    uaSzNsbUyOW0m5i7gV51HSbP7/3WBoCzgOVNhpWURH3WD/SHQedPXvIU7Hfuh6XC
    9svNqA0B5g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=talpey.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=talpey.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=talpey.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=talpey.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMMyn4xsmiV0efIhaoDiTMMwy6B2DBx58hQUv8E1PrrwpBCKbrag0TsXOksK6bqOghOxUJrgLZ7MOCuujLqqtXsdExwyGD1kcetbGmkY5yQaXMLHxKMG
    PiF85hYQfyew0phxYj863iON8gI3Ex/RymMmlNBa0CwTr3nPLNpJFUDZebHE7DNRGyg/9YPbbqIdrRQpZAUqxSJHEDpk9UPSo0SxZ6EeM8Q7hfZzKiubmf2D
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=h6HYFqFZYC0A:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=yMhMjlubAAAA:8 a=gPGC_3YKaFPG8NRITf8A:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbeDROHz (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 10:07:55 -0400
Received: from p3plsmtpa11-03.prod.phx3.secureserver.net ([68.178.252.104]:59920
        "EHLO p3plsmtpa11-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752687AbeDROHy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Apr 2018 10:07:54 -0400
Subject: Re: [Patch v3 2/6] cifs: Allocate validate negotiation request
 through kmalloc
To: David Laight <David.Laight@ACULAB.COM>,
        "longli@microsoft.com" <longli@microsoft.com>,
        Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20180418003358.25098-1-longli@linuxonhyperv.com>
 <d7e569b6-d268-b8c1-e91d-d6dc0e7cdfc2@talpey.com>
 <e9e7f77032c5402e848de0293e4db3ee@AcuMS.aculab.com>
From: Tom Talpey <tom@talpey.com>
Message-ID: <b8e56b14-a746-2a22-cb8d-94f1ba7d646b@talpey.com>
Date: Wed, 18 Apr 2018 10:07:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e9e7f77032c5402e848de0293e4db3ee@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNiT0LOFN6e1EYCziSDzy+NTJi+27YOwi1IgGnqj3WIJvKFMam0XAe068TMV64q5oF/RNikHXHe94nhCrAnhQpuJsr84dKajj537xIB6NRGU8/KcmU2n
 Lr7FE3nMQBIhy7F3fwlh0pvi0LaMd1yF0xN+q4kCRAMDx/H0KzO5ZNykmmn/CemRILwkjiRn7YBd65AY24qO+w4vC106IjxQ1PJYvuBxHgeekhGZjnEchBnS
 BVmwMvnRNXO3ylGxTC6TDcM8SJlq1Ey1OtgcoSaCnHHaItEEWwG5gTUFNTtvROl3UvutY+ZAs3GywGG4Rdp70bzQSB8zZ8ifq43xCnLP89g5K4WsoXUAIGJy
 iYZTEa2vOHdA57OK21m9xHuLfIWmwJDEJLCoQQa3rf7n3bw0iH/YvP+LMpt99heAvhKrWTz0uzxpgbupzziIv86BNsXfkQ==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/18/2018 9:08 AM, David Laight wrote:
> From: Tom Talpey
>> Sent: 18 April 2018 12:32
> ...
>> On 4/17/2018 8:33 PM, Long Li wrote:
>>> From: Long Li <longli@microsoft.com>
>>>
>>> The data buffer allocated on the stack can't be DMA'ed, and hence can't send
>>> through RDMA via SMB Direct.
>>
>> This comment is confusing. Any registered memory can be DMA'd, need to
>> state the reason for the choice here more clearly.
> 
> The stack could be allocated with vmalloc().
> In which case the pages might not be physically contiguous and there is no
> (sensible) call to get the physical address required by the dma controller
> (or other bus master).

Memory registration does not requires pages to be physically contiguous.
RDMA Regions can and do support very large physical page scatter/gather,
and the adapter DMA's them readily. Is this the only reason?

Tom.
