Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-901495-1524073299-2-2734255900728554639
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
    1524073298; b=IkZerMqWPXuwdaSQbtK0kyJeYVjwBtQH/usUOOJWkL/F8Zq4N4
    LY26x6Zfdrmelo1+6GKCPSl4ecKQe2AQcWJSgNJJF26geJkqIcHgFpqxo8zNEpN0
    xdA+ZUDC+d0ptQqiMPJvr/67PkFiKBuoa8FoR34xQ+9Ir5iknHhS4tiPK8IOHXmC
    1C1gLaGS/Ds3R6nowUM3R0IjU1+ZTXIjSpUH9U8xA4ct1BbOyMHcJjHbYS8eCMNY
    VrQcVdWxYHuVbb7z+8vRHPOyXsUfxwcl10PK7MvhVT19d3Pp8cfcU1SzEJlKe7/w
    wbGXGipTj+z3q26Tu6PLSG9wrRT/w3XS6rRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524073298;
    bh=UHNvohN/jZrQxoQcYjy320BRJdv3ntXf5BqZZurTjdw=; b=VMSHrPVuITz+
    k4q8yp8lUSEfDOZC3cAW041Ay07Hv1KaYQ1lOMNjPxGFmVS4SQgWjArZ14Jis10O
    QzECa59BdrgdWMRyuqQQOMGuWpBChfUBWcZlcZkIbIo/NDgBREU62dPQowTLA+sq
    rbKFltydGb0uQWuAT+vDhf8DhU/XQWBJZTK+D69e7JNZGmM43jezsV6qKUmKfBYe
    MD3/zeF/py2y9uaBWwd65iQIKvqqo1mekFwdUH1PfmyUBkVD2Z2kDpN3GStQuxcr
    tjgQuZTO9IRFptSQqde/k1JL/VehWFQ+uIMY5WYN7V+LTxq2p9qRWMt49oDIpNNP
    6w+hoZO5Ew==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=talpey.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=talpey.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfE7xGYj8SzlUWtEHAYZxAyLxUHz/yLXr5Aew/gtJjZ/AI8YxYCcOfpfBOWe2jTP7kNpDPAxfgVokMEzFJ5/4gtidX/HnFNWDvgdJRW3zX9rxtXPzijgp
    sP2+CSd7GjKmlWutitZd+MInrsvimpMAUJMDlXJBy5fKX3rI/rbGVw1Iw3NR4skZTqQI0luhlwmqhL3C1qIcJGGfeFkesiPLo9xNIJqotrUb1TMpaCOUnY/O
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=h6HYFqFZYC0A:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=yMhMjlubAAAA:8 a=xk0tK3r5bMCEVSm9npkA:9
    a=Om4tYt4NDbV_yL5h:21 a=NgFTr-NKLRGYJ_7r:21 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeDRRlU (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 13:41:20 -0400
Received: from p3plsmtpa11-08.prod.phx3.secureserver.net ([68.178.252.109]:34688
        "EHLO p3plsmtpa11-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752441AbeDRRlT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Apr 2018 13:41:19 -0400
Subject: Re: [Patch v3 2/6] cifs: Allocate validate negotiation request
 through kmalloc
To: Long Li <longli@microsoft.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20180418003358.25098-1-longli@linuxonhyperv.com>
 <d7e569b6-d268-b8c1-e91d-d6dc0e7cdfc2@talpey.com>
 <e9e7f77032c5402e848de0293e4db3ee@AcuMS.aculab.com>
 <b8e56b14-a746-2a22-cb8d-94f1ba7d646b@talpey.com>
 <MWHPR2101MB072909460F3898C6D13B4D4CCEB60@MWHPR2101MB0729.namprd21.prod.outlook.com>
From: Tom Talpey <tom@talpey.com>
Message-ID: <568a36d2-29a1-442f-f725-58a02b8a90e5@talpey.com>
Date: Wed, 18 Apr 2018 13:40:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <MWHPR2101MB072909460F3898C6D13B4D4CCEB60@MWHPR2101MB0729.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPgBWDuBD5XQ88D54yWwuS+tFovkNURzjygH0nAJ2jgMXfc5Rg71QBv1oCepxrsSjvMHsDwAeKgm1PpzEWsmm7GJRKG6nNJ7bPVbXg64IZOT1ilYVZoo
 t/29TK7/WJzF97iyiCK7grWDjZWVefhYC6TLoK6/q5bt82y+MzkWVKgdcQdRbVdWVUhLjP/iti+l5MSMDTgsgrLJtk1yp/lKICeSDJhDHy7OuxuIYqMzoW88
 AZXa4d2lYwavHvYFsIMCoRYmeqs9VcE8RNeGebeZdU6Oj5YIIoxSKLy0GQSAJk5atyRPilUm1WJy8eOCF1xxGpt7jYWGYDVS56ErlsSDlPa+gjESaaNYwciF
 R68kLBEWuF0zw6suj4rLUXmFh2m/ioelY2T7I+wrRcN8dnIOVzcc6ObzIfRTOKCPBai7SGVPNU9WZw672Fk4kxzqVBZDtA==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/18/2018 1:11 PM, Long Li wrote:
>> Subject: Re: [Patch v3 2/6] cifs: Allocate validate negotiation request through
>> kmalloc
>>
>> On 4/18/2018 9:08 AM, David Laight wrote:
>>> From: Tom Talpey
>>>> Sent: 18 April 2018 12:32
>>> ...
>>>> On 4/17/2018 8:33 PM, Long Li wrote:
>>>>> From: Long Li <longli@microsoft.com>
>>>>>
>>>>> The data buffer allocated on the stack can't be DMA'ed, and hence
>>>>> can't send through RDMA via SMB Direct.
>>>>
>>>> This comment is confusing. Any registered memory can be DMA'd, need
>>>> to state the reason for the choice here more clearly.
>>>
>>> The stack could be allocated with vmalloc().
>>> In which case the pages might not be physically contiguous and there
>>> is no
>>> (sensible) call to get the physical address required by the dma
>>> controller (or other bus master).
>>
>> Memory registration does not requires pages to be physically contiguous.
>> RDMA Regions can and do support very large physical page scatter/gather,
>> and the adapter DMA's them readily. Is this the only reason?
> 
> ib_dma_map_page will return an invalid DMA address for a buffer on stack. Even worse, this incorrect address can't be detected by ib_dma_mapping_error. Sending data from this address to hardware will not fail, but the remote peer will get junk data.
> 
> I think it makes sense as stack is dynamic and can shrink as I/O proceeds, so the buffer is gone. Other kernel code use only data on the heap for DMA, e.g. BLK/SCSI layer never use buffer on the stack to send data.

I totally agree that registering the stack is a bad idea. I mainly
suggest that you capture these fundamental ib_dma* reasons in the
commit. There's no other practical reason why the original approach
would not work.

Tom.
