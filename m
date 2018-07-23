Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B5EECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6164320854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 23:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6164320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388244AbeGXAYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 20:24:24 -0400
Received: from mleia.com ([178.79.152.223]:41478 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388098AbeGXAYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 20:24:24 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id B8D3B409152;
        Tue, 24 Jul 2018 00:20:51 +0100 (BST)
Subject: Re: [PATCH] dt-bindings: remove 'interrupt-parent' from bindings
To:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>
References: <20180723221317.16394-1-robh@kernel.org>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <811b4c0c-7d9c-2bbc-5029-58a458a13f7e@mleia.com>
Date:   Tue, 24 Jul 2018 02:20:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180723221317.16394-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20180724_002051_774055_48C59B7D 
X-CRM114-Status: GOOD (  15.22  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 07/24/2018 01:13 AM, Rob Herring wrote:
> 'interrupt-parent' is often documented as part of define bindings, but
> it is really outside the scope of a device binding. It's never required
> in a given node as it is often inherited from a parent node. Or it can
> be implicit if a parent node is an 'interrupt-controller' node. So
> remove it from all the binding files.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

[snip]

> diff --git a/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt b/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt
> index 38211f344dc8..0bfb3ba55f4c 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt
> @@ -14,8 +14,6 @@ Required properties:
>    Reset value is IRQ_TYPE_LEVEL_LOW.
>  
>  Optional properties:
> -- interrupt-parent: empty for MIC interrupt controller, link to parent
> -  MIC interrupt controller for SIC1 and SIC2
>  - interrupts: empty for MIC interrupt controller, cascaded MIC
>    hardware interrupts for SIC1 and SIC2
>  

I would rather ask you to keep the property here, it is optional in sense that
its presence distinguishes MIC and SIC types of interrupt controllers.

--
Best wishes,
Vladimir
