Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3209358-1525384526-2-8368294483784107121
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525384526; b=TZN8fdLyNY6VkF3iQc4B+VVQTfaV0DMhQFFCZf150jKTd5JMZH
    nWSZaWYelSkIf+kx3fwgxH9QKKy9UUZwRG8yAdzWbF8PeKSxWLktOUT1CMeldqOQ
    IcpDD6IvvSJs4bunJnRfOyi/QeCir4KNHEwITpRYZWckoxoTNnrfSab39g77n8fa
    yIPgoWU+srAR+ZhvOpd88fXd4XTjQs02c7Qra1NBnoifD5/Mb9Z89OVFq14xradR
    Xo9uPADgfwDhozTkCFezztB/RHvUfZ/0AXRcAfrOI7cPp77ZimdzUmQBkiNTE/yN
    7stO03a3m+m82QSm7r8mUT0ku1x7AYb3Qo7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525384526;
    bh=5PTGqyPZh04WT0J22EpmMsZUGMjfleWojJnvlXqkpwY=; b=hXAowDX8P3gD
    vhdvxJqUel9ocN6fTHfR06u2tfSPKNZ3bRcxYloAxQ/shdxLnqUe4E6l4qi1AGQG
    XY8iQ97aluNiGFl3mvdnRLmMi5PCo4gR7VA8Aqb/MGIHd5HCwhLRdIoFGt7ZTebW
    ENSniNiZyTfut46s8z3/ssIHm6wBR4OuQhbAbkyvT5LS+UjcptYZCPaZre4xu/Rn
    t65XlzYZLJUk+z0oCOV0YdlQ0OZFVeIMvQlMX9Oy8hgJmacz3b/dr32SNzpAMKhO
    qzy93Clv3ZHvmhUGi60x+6cHXOjJcR48M3BqUUVZLoZNzK06e5kTp8TuGKYM0nVn
    WNUeZXBj/A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCIv8yq2BULxPrryCtyzpfguACTFETdFOdT2USq4uQDJRxN0TMiGtITv0a2vRTJOkLEjqpO9WUJxMckhPGPtyUt5w3OMY+9oR3+f7Z2ot/M755KkJg8U
    3WOTVaeOGahnMyWhML3DoQpQL0xTyjJ/QL22/R6W975X8jRBurx2Urm8wKZwZz3MUhcEHVaFONm1RF9J3j7q40BPKfWjDDqriHf5/86JJ6VuFwIvrKM1xiAc
    LtCO5y9vunUUGuwPN57nQw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=6nUXITN49fC6jhMlmTEA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751108AbeECVzZ (ORCPT <rfc822;linux@kroah.com>);
        Thu, 3 May 2018 17:55:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:12701 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750911AbeECVzY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 May 2018 17:55:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,360,1520924400";
   d="scan'208";a="48118855"
Subject: Re: Correct way to access the physmap? - Was: Re: [PATCH 7/9] Pmalloc
 Rare Write: modify selected pools
To: Igor Stoppa <igor.stoppa@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20180423125458.5338-1-igor.stoppa@huawei.com>
 <20180423125458.5338-8-igor.stoppa@huawei.com>
 <20180424115050.GD26636@bombadil.infradead.org>
 <035f2bba-ebb1-06a0-fb88-3d40f7e484a7@gmail.com>
Cc: linux-security-module@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Igor Stoppa <igor.stoppa@huawei.com>
From: Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Message-ID: <ef116557-1fb1-780e-2480-3eef9052b609@intel.com>
Date: Thu, 3 May 2018 14:55:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <035f2bba-ebb1-06a0-fb88-3d40f7e484a7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/03/2018 02:52 PM, Igor Stoppa wrote:
> At the end of the summit, we agreed that I would go through the physmap.

Do you mean the kernel linear map?  That's just another name for the
virtual address that you get back from page_to_virt():

	int *j = page_to_virt(vmalloc_to_page(i));
