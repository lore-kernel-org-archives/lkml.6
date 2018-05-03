Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3227126-1525386416-2-10641238275027254085
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, BODY_URI_ONLY 0.999, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525386416; b=RxiSrcU8NZjHbAWCdw0BDOj++N70LhMuNm42d1o2T86iaVxNu9
    +TnUqtPlpgu3FqS/1MGHZVOEyLzVm5gXcacnEnNi+Z+gC5NHWf5w+hX7K/RMHBoX
    5ZSUSkdFbyEqZO3/nKWg4MWEYDBbDvXRojgW6fJo11NNUpRj/QPl0VbwqHWKHzcU
    NpQBRaOy30WVKghdzlgHjOAQ5up9WOBJ4h7zWckL/e55Xd9cIbtN6h1YWwU5LTJ3
    4H9o1jvs4i4VKNuH2SHhjCkVM3NEmBi8iK7LeMHAYXgnAd3FcwHxF2xyLrN4RbZp
    1GgDfWIlfXyXiTjrnXUwe+BKLpYx9Dvo9YoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525386416;
    bh=P3/ytREfeFPWVLsRvOaNflYcIDouqg8YFzpv1jyY/u8=; b=D1aOxVZgCjOL
    dGimmD64xESKrvMlCbLQqRCxSnwfJx5lff8m5kl5AggvCHtp9YDR1KZL4LFo3tU0
    CGUoCmm+IJ/SHYuVvnIhqENOjhUuUyMjLu9xLS2k4QrTHllOO9lpTFab3u3EizlH
    ZcfgpknL8/nDxY0pFUT4DH4lvVv5EyRX6BKpDPUaxcb253+pcm0+Jw0zxuIsx68O
    91m+A0CnysCyBI/A6VlFGG/ID/O/hEb1IrxQpbJLahAG1r1URCkX95UvtsW7vwLa
    DSytuSHa2J58LnRCwVfDwz8926HQnAFQJYT70JnVEt8jQ6DZ9X2xm54Bs6NLCkPh
    9FZBxvtGqg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJeVFKn6gvkvvIHUFXmnGqSFPrUB7cJLrp4Zb0kI8UCGUVNUpyIwQvi9TCecL3K5kM6GDzSgBfuKPe7VvNSiDnX+TXp2rDlI9074BwdqCCPHpk6bt0OQ
    VbHuTQ/HzxWgGLoFPTO2WNzmHgX4PntzSRTOIg6bfvBRJ5TLjIR/G3AYE8hnuNhWr1MaL3uEVFr/mkB0OHLhDJbMXyZtGclMsmMg2iXudL0Vb3HPB46sqR1n
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=rOzfZO9e7A6MWzQsI-wA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750911AbeECW0z (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 18:26:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:21544 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750829AbeECW0y (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 3 May 2018 18:26:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,360,1520924400";
   d="scan'208";a="53017137"
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
To: prakash.sangappa@oracle.com,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com>
 <20180502143323.1c723ccb509c3497050a2e0a@linux-foundation.org>
 <2ce01d91-5fba-b1b7-2956-c8cc1853536d@intel.com>
 <33f96879-351f-674a-ca23-43f233f4eb1d@linux.vnet.ibm.com>
 <82d2b35c-272a-ad02-692f-2c109aacdfb6@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, n-horiguchi@ah.jp.nec.com,
        drepper@gmail.com, rientjes@google.com,
        Naoya Horiguchi <nao.horiguchi@gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Message-ID: <8569dabb-4930-aa20-6249-72457e2df51e@intel.com>
Date: Thu, 3 May 2018 15:26:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <82d2b35c-272a-ad02-692f-2c109aacdfb6@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/03/2018 03:27 PM, prakash.sangappa wrote:
>>
> If each consecutive page comes from different node, yes in
> the extreme case is this file will have a lot of lines. All the lines
> are generated at the time file is read. The amount of data read will be
> limited to the user read buffer size used in the read.
> 
> /proc/<pid>/pagemap also has kind of  similar issue. There is 1 64
> bit value for each user page.
But nobody reads it sequentially.  Everybody lseek()s because it has a
fixed block size.  You can't do that in text.
