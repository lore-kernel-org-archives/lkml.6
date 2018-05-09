Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1147974-1525908688-2-15804097425877690658
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
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525908687; b=R9kOPvd6Ilz+m0Bvwov/VsKPgyolovUV23ZF1jOA/ink2Mkkkl
    0cT54SxsRKhg4UvL0mNrpiC2dAZWSvbypYPApmGhiS3STbqh1VkldQevPPnlC9pe
    8suF3WXyOpeeI5NR7oir0kM8jMSsX+JSNQRoZ1bs3JmY06Dr2ShE69lvfe2QQ+W9
    rF+45bA0tstGag+nl9zX0UaEtJUsxoWxGvA6yGWGqe8YLQDwNR9Lgctfc75B2GeY
    b6QivZ0054Ml3qS2qoyvH0+baaK+L2AOxv59PPVnvKCRzAJpS0PtJk7cT6ADos+N
    Vrlu3dP/TXLhQAsoB83I4sG8nWIiPX1pSE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525908687;
    bh=LLO4WQVRsuBmDpJANedBAdF6UblYZBIaZQQ27VoaWok=; b=L5Zkxl1Bd8B5
    oPb5NcHdzY9U0W9idp7IqACtTsvD7S5s9mTYksFEfvGbtuGEZqYulk3bSzncR/zN
    HbeGLa6YC041HFRpRlrJFVn/YHe1ZUdqvdBU3xiq4A0D5nHR1VzLrxQOPLPySGj1
    wDzJ4BqUXx/o5PBbKPUNw0vvxVunWlw65yqm+nIrjWJDTNsuJgIPvKanrSK19VEG
    HFW7NOA0lEuozSg8QTve2wL1M6DNi77Q4c4RlG+L+MfhLZLijwnz4UxmTtd5EtzP
    G56HpInuTOiIKtkfH/HMaJfm7uA7ns+lxGydJZWEgxq+UrcpeuU2JbzraD+j6953
    CzKm4ERKYg==
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
X-CM-Envelope: MS4wfCfUdQdY1qU0Abbvetzuo7zk8gbPbyevGYki9t37OEYDRqkKS7a9e28w3lzF73dkSMef0ZOPd9i0AW2+KEpQj7Cpmwa00eq08C1EFCSZ6aBkQ6HieIOx
    MXPt5dUqyULsBfybzQF5YTI6jWyARVtm2ogVX+aKCWFUnOgaSlndXhUJDvCS7s1La7MFmVG/pYoraeQV0MFX8vT0mv0bBvNnsAGB+vjRrgsuVmtLSmZhRtSD
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=PuSqZo3tm0pXUj2qVRMA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966007AbeEIXbZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 19:31:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:24195 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965408AbeEIXbY (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 9 May 2018 19:31:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,383,1520924400";
   d="scan'208";a="49629107"
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
 <c72fea44-59f3-b106-8311-b5eae2d254e7@intel.com>
 <addeaadc-5ab2-f0c9-2194-dd100ae90f3a@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, n-horiguchi@ah.jp.nec.com,
        drepper@gmail.com, rientjes@google.com,
        Naoya Horiguchi <nao.horiguchi@gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
X-Enigmail-Draft-Status: N1110
Message-ID: <aaca3180-7510-c008-3e12-8bbe92344ef4@intel.com>
Date: Wed, 9 May 2018 16:31:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <addeaadc-5ab2-f0c9-2194-dd100ae90f3a@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/07/2018 06:16 PM, prakash.sangappa wrote:
> It will be /proc/<pid>/numa_vamaps. Yes, the behavior will be
> different with respect to seeking. Output will still be text and
> the format will be same.
> 
> I want to get feedback on this approach.

I think it would be really great if you can write down a list of the
things you actually want to accomplish.  Dare I say: you need a
requirements list.

The numa_vamaps approach continues down the path of an ever-growing list
of highly-specialized /proc/<pid> files.  I don't think that is
sustainable, even if it has been our trajectory for many years.

Pagemap wasn't exactly a shining example of us getting new ABIs right,
but it sounds like something along those is what we need.
