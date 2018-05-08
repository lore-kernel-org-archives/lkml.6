Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1840505-1525737947-2-2055074673506018722
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525737947; b=BfejN+KP+0gfjQEiXzUohrCzc7YXllNznlzh5Y3Fn/VNz49Jop
    nK07/zaY2vrtg164UQRUmWaXSyFh9vK61c93DSxtIu8IOXJ/3+wIs7GKj3lMGL3Z
    r/gaZAZAdDGjFVNGIYBMcIyKQgTTZW0cq2Z8THOn78B63Q2mB+3pUNhKFxzwgNpB
    auLy+LHWrsSrDQUAqLlsjka/oGrx68cuFYvA9eup/KbD6R8h5HDjCBivhiXfkGxL
    0TR01BoAVHf1K9/oqKiSEZ5CjjhOln2pg2Plyd5CUmzcqsuajDgPRxOfASvEmAhe
    AU2QUw32V2tc5A9pew1EsVDLAYhy38X9dHBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525737947;
    bh=nbFpGF353wRjlBya7/JWANI2unyH+6Kr8ytqkS5MVlw=; b=ZU0wF+O8NOyC
    NuFrWpsgxkGrCxVgdGQAEUSSJ2EBNjOwKhrZU0ZU3xgwyfXwY+/QXS8C1CzYQm9n
    5oUwav+BcM3mkN04TS7s1PrHwo2auu6BDk6HoX6lDFAFTtdDees4UA422c0yNIDJ
    RPty7PzOm2U0bi0rMG1CSBx/6/fbtZOg99YRZP695lnpPk3TGQ0RYmRCfhM40Cnm
    j5vKGGe833JWwPjYgJLBliGXhcR0YjNrswlLULG2BJ8EIsxVMSJbjAjJ+sCHevoc
    lhmTTzxhJFJM5Bz07VKdzWwQXNWSetLQPZZS3Uw+Lj5H4kTLKLV6bmC2+5Li3A6v
    6MdECwaJcQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfKesWGIX3aPwW8KqSMQoAg8eUcyPXD4+go4YGxN3q4np+gwwYM91Hf7OFoUNl/W9byTEOUbnMFfrvjY/77F0cKWYbD1nRyznY26ZyTJD+A97ANzEG8Np
    9nIAeSmF0HUC4cSmkTC2oaNBHfMth2XWWwi7ceudi2ua2ih1CIqyaGDVCzMkp4qDs3pc2LCzgmILLpIBY85DxNni5ejuOLPUfFepXe23GcLszQRgT4saszfC
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=OcfmxZGrQ0T_BaQIlZ0A:9 a=FY4hjkJ_7BsKNutE:21
    a=8TJ5gmFPevdcU0rw:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752920AbeEHAFp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 20:05:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:36957 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752848AbeEHAFp (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 7 May 2018 20:05:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,376,1520924400";
   d="scan'208";a="40003022"
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
To: prakash.sangappa@oracle.com,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com>
 <20180502143323.1c723ccb509c3497050a2e0a@linux-foundation.org>
 <2ce01d91-5fba-b1b7-2956-c8cc1853536d@intel.com>
 <33f96879-351f-674a-ca23-43f233f4eb1d@linux.vnet.ibm.com>
 <82d2b35c-272a-ad02-692f-2c109aacdfb6@oracle.com>
 <8569dabb-4930-aa20-6249-72457e2df51e@intel.com>
 <51145ccb-fc0d-0281-9757-fb8a5112ec24@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, n-horiguchi@ah.jp.nec.com,
        drepper@gmail.com, rientjes@google.com,
        Naoya Horiguchi <nao.horiguchi@gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Message-ID: <c72fea44-59f3-b106-8311-b5eae2d254e7@intel.com>
Date: Mon, 7 May 2018 17:05:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <51145ccb-fc0d-0281-9757-fb8a5112ec24@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/07/2018 04:22 PM, prakash.sangappa wrote:
> However, with the proposed new file, we could allow seeking to
> specified virtual address. The lseek offset in this case would
> represent the virtual address of the process. Subsequent read from
> the file would provide VA range to numa node information starting
> from that VA. In case the VA seek'ed to is invalid, it will start 
> from the next valid mapped VA of the process. The implementation
> would not be based on seq_file.

So you're proposing a new /proc/<pid> file that appears next to and is
named very similarly to the exiting /proc/<pid>, but which has entirely
different behavior?
