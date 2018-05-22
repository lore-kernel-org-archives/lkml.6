Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2783972-1527007378-2-16060696735170317737
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527007377; b=Xfy8D4BOgeH32TWKW0NwQvzdERDFsCXCYkYH1L44H9QdrnQE65
    5NT81a447vbnKCKiHntuwjt2C3pgLiopF2i56wfMIXyFl1Uy9SOgKBrogsGL2fDh
    DGpRy1mIQdrH3sBjdesvkzqMV55NWKfLujDJueiSvBlgvD0ZN2vxl79Wj6ntw0eV
    rUVd2z6EQ9BVgs3dREq0DcqgpPqp/8O/DNXlcUo/YSY0A9ZOdH08Rh8Ouvy1DEk1
    vdKAe6XK6U3sgoDpRV8AP3mF7DNJ6fyn4n0k4CBpu6An7thQkckf/r3EHGjcptLs
    VLDw+5bjs55RP+CepakOcoRASOmFiz8Yxqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:references:from:message-id:date
    :mime-version:in-reply-to:content-type:content-transfer-encoding
    :subject:sender:list-id; s=fm2; t=1527007377; bh=ZxrlYXhFOI9fpKl
    +zdw9e5j0CY2YOynrIeIYd86uvWg=; b=gVc9lNoTtWcCD/Nm8dazPcns9rnuObC
    2O34yUpEykbfPXCixRJCGTJBs8fHPK/R0A9LPZxirZVrRSuEEMjeiTnuDtTuxEq7
    YnYokAps/AFInp0C/txYtkp54xdBwucUmM4PeS1bXH8rzZuknhg2t82z4o93DbAC
    VEcmv2W2NA3uY5BTPYkGknKaUNqQ2WMPjXu8SaP/4rfP/39qRC4qKw7f3JT9nZRC
    6fnkIdxhOU2xzZ9viRHqyzH/GZ6lMs+8jJUsmb1Ua0lJ5l5MNAmaund4bIkEBniB
    o+JmuXKxkEKWeITGgRf8dEztW5iInCeoJSUBkGyg69h5OV/toAmQGmA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=deltatee.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=deltatee.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=deltatee.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=deltatee.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLZT4GFaqKiAAcmp2TnEJILaj+SvSeACTQDrne0EKDGU70tCN0yXVQ1cWPWo5JNfEQpS467zyk+PVqMaH/7rCyryBsOBcgQiCv8Ztb1DL7ntnrLYmUC4
    SmiP2u5Thl6UK0w8F6eu5C+pCO/ZPtPLLf/3iWVuAlI5vUIofWr+4hQhjr64Ydoooqrz34U80zXT+sQrCf3CTctgt2jQ09tZ7E6qDHHINttu9NFdnDZXArYf
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=BNFy-mg5u_7Wa7pgxd4A:9 a=qxBapa05JyZtLNvH:21 a=1fHX-vsoyKx0h9Jp:21
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751196AbeEVQmq (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 12:42:46 -0400
Received: from ale.deltatee.com ([207.54.116.67]:47940 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751291AbeEVQmn (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 22 May 2018 12:42:43 -0400
To: Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: stable <stable@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <152694211402.5484.2277538346144115181.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152694212460.5484.13180030631810166467.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180521161026.709d5f2876e44f151da3d179@linux-foundation.org>
 <CAPcyv4hMwMefMu3La+hZvN6r+Q6_N5t+eOgGE0bqVou=Cjpfwg@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <860a8c46-5171-78ac-0255-ee1d21b16ce8@deltatee.com>
Date: Tue, 22 May 2018 10:42:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hMwMefMu3La+hZvN6r+Q6_N5t+eOgGE0bqVou=Cjpfwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com, hch@lst.de, stable@vger.kernel.org, akpm@linux-foundation.org, dan.j.williams@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on ale.deltatee.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.1
Subject: Re: [PATCH 2/5] mm, devm_memremap_pages: handle errors allocating
 final devres action
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hey Dan,

On 21/05/18 06:07 PM, Dan Williams wrote:
> Without this change we could fail to register the teardown of
> devm_memremap_pages(). The likelihood of hitting this failure is tiny
> as small memory allocations almost always succeed. However, the impact
> of the failure is large given any future reconfiguration, or
> disable/enable, of an nvdimm namespace will fail forever as subsequent
> calls to devm_memremap_pages() will fail to setup the pgmap_radix
> since there will be stale entries for the physical address range.

Sorry, I don't follow this. The change only seems to prevent a warning
from occurring in this situation. Won't pgmap_radix_release() still be
called regardless of whether this patch is applied?

But it looks to me like this patch doesn't quite solve the issue -- at
least when looking at dax/pmem.c: If devm_add_action_or_reset() fails,
then dax_pmem_percpu_kill() won't be registered as an action and the
percpu_ref will never get killed. Thus, dax_pmem_percpu_release() would
not get called and dax_pmem_percpu_exit() will hang waiting for a
completion that will never occur. So we probably need to add a kill call
somewhere on the failing path...


Logan
