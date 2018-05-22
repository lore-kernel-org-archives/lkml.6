Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2689340-1527002179-2-6169590690352886814
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527002177; b=UZJ1jltRL55C1wbMtie0QBxDJxSRZJANAvFImh0uckKulfniAU
    iH9+5K9tyUj9mlKsAyw3mUWyt0qNYQa1BO2iILYJbQIgqQ2yHw7nPIC951Akv5cz
    xy3sXBnRrgy4bQH0h3Ig1Xst4Uj34k4Ig70HsoCZidRL4DfRmrpWGUbqsNJF7Xf7
    2HmNyHQMnGD1vWfgoSahhiYNrHO890HgqOPJneCDW2wjMITYhNVqaSBoECuwCcDo
    rLi0PTBMJE2CZm1lCO7tjhpJ4ybLYs/cJfKmf9i+SLHFhAzUvYlniI6svYW0V92p
    MXShHOXyMYbF+c4dHZqa31wgPvhx8jkJPkMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527002177;
    bh=ENvx7Lt4qHRx6GJJ60uX4YnXaI4ao8AHEjCWgr7mEW0=; b=m7Vw3zAmsnYl
    5JMNCP+PYWfzeoOUvHYENL79VBiHsfp/KbnrwMnhlptxjZuP+FAczJqpiuOXtclZ
    8qWrguVVcTtYpXuvzUFRi30t4wWIfRZsZNtTzAfuq5MUeuE9dKWgXBAX8eKWU9HF
    IFjyn1uIR3SYNhVdq4L9WuDS7LZGW5Hf37/VZ/nXrBYD/uzFy1GpbKrPfVLYRNIK
    PhqvuKImFItXUEN8rn7GFN+O2VHTgDohilax7BKaq+AA8zDhWLGOl110frzcyKdn
    bGjcKDlS1pxJq+QYzFOGpwJZIiqtUjkAln8O9sMmYQfK3r5OsDJmtDKvnI67Jx43
    8SRJX6sxuQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=nvidia.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=nvidia.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOEWea06OpsGNA9qxOf7oDf5h++qOD+bh+EI9r7NGfs3VWK3AnvfTOefFMulX22xjHIt44I+ATC9JaN6OSOMb0ocgoDh8uJidGsXwfy+UJowcVMUZZHl
    mzTCk429CKo8kuMC9o4fAeaFZwrHgz3ibJYpEgS+gF0F88NHO5rIntmIi+ttOgRDddCL1sU3S6xsGPpg3WR1NsWrRGUZ7etrw4U6oInSEXlrN74tyfjiP0fH
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=4Zbj-4zmMWkA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=31wicGnxRB5RIJUGi3oA:9
    a=l0unDIpmbD_pDAJP:21 a=3bCQJN_r5FIpERhJ:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbeEVPPd (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 11:15:33 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6246 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeEVPPc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 May 2018 11:15:32 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 22 May 2018 08:15:32 -0700
Subject: Re: [PATCH 1/8] dt-bindings: tegra186-hsp: Add shared interrupts
To: Mikko Perttunen <mperttunen@nvidia.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jassisinghbrar@gmail.com>,
        <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>
CC: <araza@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
 <20180508114403.14499-2-mperttunen@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <2bed23e6-19d5-66f8-774e-d613a91b1607@nvidia.com>
Date: Tue, 22 May 2018 16:15:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508114403.14499-2-mperttunen@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 08/05/18 12:43, Mikko Perttunen wrote:
> Non-doorbell interrupts are routed through "shared interrupts". These
> interrupts can be mapped to various internal interrupt lines. Add
> interrupt properties for shared interrupts to the tegra186-hsp device
> tree bindings.

Reading the Tegra documentation, although the doorbells have dedicated 
interrupts, it appears that the doorbell interrupts can also be routed 
via these shared interrupts.

> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>   Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
> index b99d25fc2f26..9edcdf82d719 100644
> --- a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
> +++ b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
> @@ -21,6 +21,8 @@ Required properties:
>       Contains a list of names for the interrupts described by the interrupt
>       property. May contain the following entries, in any order:
>       - "doorbell"
> +    - "sharedN", where 'N' is a number from zero up to the number of
> +      external interrupts supported by the HSP instance minus one.
>       Users of this binding MUST look up entries in the interrupt property
>       by name, using this interrupt-names property to do so.
>   - interrupts

How is the mapping of shared-mailboxes interrupts to the actual 
'sharedN' interrupt managed?

Cheers
Jon

-- 
nvpublic
