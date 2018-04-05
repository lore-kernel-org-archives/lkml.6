Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2880998-1522936208-2-17421892017547219424
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522936208; b=td2Oa6YOTObyuFEdN0vZsb1TuNoJgvLnOkTpgKHJHcISkLyUHR
    V0If9hkt2yl+EyJyZtPOz512yE9bewYAI5E40SZNNHj7o9rPw0p4n67k6JSs298S
    jjb9IrSTZSnAywquRn6uibtntRYqMih4RHbCIUj8QMsYYwN0liqe4pLKfcqc4rdY
    bmVKPY10hBHYBa+il+ty/GxTbLuUh0FD3QrGZdwIk3mDNV1nA4pgMzzms3DMjioH
    Vl6r7iOoLZFly6dSAqoXlptKiUyINPDDkTXcbT39SZF61iJACZm4Bb3mugR1L4ZS
    tx+jgMy/UIfFN8nBOvf3h6ptoc3AwZ/WNTFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522936208; bh=yyRnqebxchf1pqJBXeBvL285XG456I
    R6OAmjNOFV2tA=; b=JQz9GzwWKPMJFaVZvKnfREBRNoXGD1430YZ4pNicmXlZ8M
    MVXbTJz2Y6kSV8tdPBBEBRDqxUwWSNFbkA0XRp/rAhblL1YGuhyv9/UjTPMQy9fN
    u997PIjYnsUjzCOcPRKMJUgdibRgwsgkodYlP3rLSwD9Nl7VKwN9GatjDJqad0ig
    U+AVJxkj/6L3L19mA07Dhdba2E7ilmXFEfOyxw23YhPj1mJLUUAf421P5zWu3B4u
    8PEj5mTaK2k8JpmGYryqHhOee1vfNHrtHymgyI49YIqWGfhsWYseGUTe9Lt3cNlJ
    UdS2cPPX2vpC7cRCh4lP+mUu5aBs5Nn702RpZr2Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=D+ob4/8f x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=D+ob4/8f x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOa8d1ZHYC7L83jwRaiyPwQe4dpvOLwSrVFFQY4VIVq5+C6cQOoN0NSFDHwD/LDzNy5jpCzLE34my1CxFiJZOuTsVhSCQYStTuaj9tvOB4Sa/Nbo9WZO
    BB23M3uk3/ldCgdw67JpGH91bybI3b8+0i81TWY8SoGqGqW8LVn1sjSMJ21/LoNCG/Fq3+AIeC3bWPKgirpTv9tiR8qO89GV768ezAwP5ti5dPbCxcc3c4UN
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=uumCjD83CAN6e9AYI3YA:9 a=CjuIK1q_8ugA:10
    a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbeDENuF (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 09:50:05 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:58765 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751165AbeDENuE (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Apr 2018 09:50:04 -0400
X-ME-Sender: <xms:iynGWjmlNNT-0drhwNQchtTM9GRycu7arzvwD7Bjl2W56Hm_s4tUMg>
Date: Thu, 5 Apr 2018 15:50:02 +0200
From: Greg KH <greg@kroah.com>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        aarcange@redhat.com, minchan@kernel.org,
        kirill.shutemov@linux.intel.com, linux-mm@kvack.org,
        hughd@google.com, borntraeger@de.ibm.com,
        gerald.schaefer@de.ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mm/ksm: fix inconsistent accounting of zero pages
Message-ID: <20180405135002.GA23486@kroah.com>
References: <1522931274-15552-1-git-send-email-imbrenda@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522931274-15552-1-git-send-email-imbrenda@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 05, 2018 at 02:27:54PM +0200, Claudio Imbrenda wrote:
> When using KSM with use_zero_pages, we replace anonymous pages
> containing only zeroes with actual zero pages, which are not anonymous.
> We need to do proper accounting of the mm counters, otherwise we will
> get wrong values in /proc and a BUG message in dmesg when tearing down
> the mm.
> 
> Fixes: e86c59b1b1 ("mm/ksm: improve deduplication of zero pages with colouring")
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> ---
>  mm/ksm.c | 7 +++++++
>  1 file changed, 7 insertions(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
