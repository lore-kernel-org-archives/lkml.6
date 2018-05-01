Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3031880-1525174954-2-7719901454049879037
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='COM', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525174953; b=f9GQmMmuL+PdWqTFV9nUYg/roq6Qh2PvfGABmbaK8ue3fqSXiD
    FC2nBzR8sgxfCtrtePKBhxX8OXFppZgMX3gtnZjP6EfyvPMXMHCUkzeBUcZC7/vK
    SeICltMWKGp00tshTpUa0PJLbWg/uA3qCe8sTtllIrWFo8NN4vKrsirLMsea5qiT
    tNCiYTwUnZZxE4Fd8KIJHknjxEHHaPqo53NaurrX6IUcKFy15Va4yRbDmqV4I24i
    1RKSz9mqAvOk60wztgnI0sKqMuWP6eJ0whYoW/6yX4y1PIMfonNNhBKz1fdWD4DS
    n13Vr72uDq5ZcIvMqO7fpUEX5+7TqGXAr0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1525174953; bh=vQ8tT/Euq3
    XKKKeajpV9kk7dlT3WxjKVtnn1KiLEuC4=; b=bBsD1fRLg+x16pogouWS4f3DI9
    D6LHVgPw3NheYgG9XM08zmJCeSWgn6gklCEycCeEaXCEm7CiDIcat5ET+9T6TXQy
    8bYYoJ8x/B+OQEUNsj0EPumMTlwbqWk86IysAVePgDJisuR7rrIi0ECIXlWwW3+p
    gI8HchGEnSMpBJZ+G+eoRpU1IMtV6zCrEDIV0pYU31dtq8vnTYyou+VEAqkaLhma
    qpMfuNZaNAH4UDtpdp04j/VmGfBg46k2TLJL6S1XnzZMyyhgZv0Vm2bpqEcbLqC9
    jmQqV8rS5ofxOrPtiJjBlwdvDJBKav34mpnzsSxDCEtPZs8hoYCkkG+STS5Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=aculab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=aculab.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=aculab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=aculab.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPd5R7W5fCJh6L2uQJAhpo8FyTVbismJPF10mXX7JrL5nQuSw1Pq9qtaGzHFRcUt53VmKfb7yRjuFKFt7ZkomnB2T0rFuvhBaO5+3Wn4lmfQnN85B8aj
    du+oIRn7/FKEUG7aEZNb4cETpAwTTrzEiX7Pd7FLKt4gf1TjwK8W8BimMNfLD223ebOnfp3VLKeHTSONR+OQMvz3FEDj2j8uZYA5wykkbiLKAbvia8IUkFU9
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=tAi6d84QYPMA:10 a=kj9zAlcOel0A:10
    a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=cWRNjhkoAAAA:8
    a=iox4zFpeAAAA:8 a=vSs20nPzsOeNIgY-z1gA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=sVa6W5Aao32NNC1mekxh:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754856AbeEALm3 convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Tue, 1 May 2018 07:42:29 -0400
Received: from smtp-out6.electric.net ([192.162.217.181]:53500 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754283AbeEALm0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 May 2018 07:42:26 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: 'Boris Ostrovsky' <boris.ostrovsky@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
CC: "jgross@suse.com" <jgross@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/4] xen/PVH: Replace GDT_ENTRY with explicit constant
Thread-Topic: [PATCH 1/4] xen/PVH: Replace GDT_ENTRY with explicit constant
Thread-Index: AQHT4J+edp3W52PX8E+Fwckpc18TM6Qavd7A
Date: Tue, 1 May 2018 11:31:16 +0000
Message-ID: <70673793884c4eba857970359f9f5158@AcuMS.aculab.com>
References: <20180430162339.17143-1-boris.ostrovsky@oracle.com>
 <20180430162339.17143-2-boris.ostrovsky@oracle.com>
In-Reply-To: <20180430162339.17143-2-boris.ostrovsky@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Boris Ostrovsky
> Sent: 30 April 2018 17:24
> To: linux-kernel@vger.kernel.org; xen-devel@lists.xenproject.org
> Cc: jgross@suse.com; Boris Ostrovsky; stable@vger.kernel.org
> Subject: [PATCH 1/4] xen/PVH: Replace GDT_ENTRY with explicit constant
> 
> Latest binutils release (2.29.1) will no longer allow proper computation
> of GDT entries on 32-bits, with warning:
> 
> arch/x86/xen/xen-pvh.S: Assembler messages:
> arch/x86/xen/xen-pvh.S:150: Warning: shift count out of range (32 is not between 0 and 31)
> arch/x86/xen/xen-pvh.S:150: Warning: shift count out of range (40 is not between 0 and 31)
> arch/x86/xen/xen-pvh.S:150: Warning: shift count out of range (32 is not between 0 and 31)
> arch/x86/xen/xen-pvh.S:152: Warning: shift count out of range (32 is not between 0 and 31)
> arch/x86/xen/xen-pvh.S:152: Warning: shift count out of range (40 is not between 0 and 31)
> arch/x86/xen/xen-pvh.S:152: Warning: shift count out of range (32 is not between 0 and 31)
> 
> Use explicit value of the entry instead of using GDT_ENTRY() macro.
...
>  #ifdef CONFIG_X86_64
> -	.quad GDT_ENTRY(0xa09a, 0, 0xfffff) /* __KERNEL_CS */
> +	.quad 0x00af9a000000ffff            /* __BOOT_CS */
>  #else
> -	.quad GDT_ENTRY(0xc09a, 0, 0xfffff) /* __KERNEL_CS */
> +	.quad 0x00cf9a000000ffff            /* __BOOT_CS */
>  #endif
> -	.quad GDT_ENTRY(0xc092, 0, 0xfffff) /* __KERNEL_DS */
> +	.quad 0x00cf92000000ffff            /* __BOOT_DS */
>  gdt_end:

It has to be possible to fix the GDT_ENTRY() macro.
Even if you end up with one that generates two 32bit values.

You've also changed the name in the comments.

	David
