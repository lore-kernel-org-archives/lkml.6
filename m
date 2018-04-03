Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-312551-1522723250-2-339671330455088253
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='windows-1252'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522723250; b=upDHOPR5OHdSgAqs4LZ5QcfY+j77/vHge90uYANcvFZ1kmSV1n
    NjQeScOA0tfCVQjMHxJaI3VE/euxc/tgGN0LW7n1YOtAiDlkw+Qu8zM8NvgZuG9e
    y+Yq5bxo9XO36QZvgbJXDj5G3PzZYzOpbwJut2t4O42ML5UOQOI3+ULE8Y9gu94V
    q/y5vJFqqeUUPrjAE58eWiu5+eDanANVotYZTmUAFObRWOPHUf72lEoD03cJyWtc
    nGec47XU79+xYMdJFOw80jkP1G34OAmk1ds/j4EeCcohCPghsOsCZT9SYFz46814
    X4S2ZVXLTDQcnL57AbkJyZiUULDPZYafc3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522723250;
    bh=BwCqBI+EADqXVjNEZhU5KFQDfqKaNE1mzTp9sK8IoXg=; b=PE4pQdUEacFy
    dwbYIu1s+rnIPntFoVAScGauIgAiksT4B9TgtdkSgCZ3JBciZabaBvEOLrdOsrS5
    IUAekeQ1pPHDIqeNiFmfQ1HaZ0nWBCi4yRNDF3rZNmEyDhZIic9x4BXpcY6hZBZK
    IeoShEgrLquDEJLWaEo9wX9bhIp/t6lgK/vnh4iV5YbRb0SYrr5Rl29n18tmpHKR
    GdXENQzg7b7VlzxqVypCFuPQqNtgoZMcANfAai7j3N2yhMvJTM39p8y4X95yZyAg
    cXvhrxBJoEigqfLkS1yahkkNhg8KIuhMh1uDlqA6baU80swxm6z9K41oamib7csr
    S+zL0Xea5w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAWh7wCEs6/GHGpjrLaOHd7cey+Sgu4gcalLNYv/BvZxdkubKwYanSltbY8qNO5TfFbQWOtY/y2gIMrxKtco+5jsqbl38uSa/9d04GSue37Mh0MnbePw
    cfk18Ab2XGGpf9DnRtPmtcUoWeaNIWzN8MGsLmONNDjFEKtaHFuW7yN3LuCjZIMbh2rVS5Xx+/99lLdHxce0ownqERyhjrBLu9noh/TTP7/BtvX8kY80AgHI
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=XbGvyVyP7asA:10 a=N659UExz7-8A:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=x0VAa1YciXoDysq5sPQA:9
    a=pILNOxqGKmIA:10 a=HUqATDVKn4QA:10 a=ijfnLEHhV9kA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751306AbeDCCkp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 22:40:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60255 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750905AbeDCCkp (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 2 Apr 2018 22:40:45 -0400
Subject: Re: [PATCH] f2fs: truncate preallocated blocks in error case
To: Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC: <stable@vger.kernel.org>
References: <20180331015710.72893-1-jaegeuk@kernel.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <62b2179c-655c-8246-6321-7ac8e5ea089e@huawei.com>
Date: Tue, 3 Apr 2018 10:40:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180331015710.72893-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018/3/31 9:57, Jaegeuk Kim wrote:
> If write is failed, we must deallocate the blocks that we couldn't write.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
