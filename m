Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C525C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4335D21473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4335D21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbeJDNGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 09:06:15 -0400
Received: from ozlabs.org ([203.11.71.1]:45599 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbeJDNGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 09:06:15 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42QjK66drTz9s7h; Thu,  4 Oct 2018 16:14:34 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c417596d2409125b1814c05e994a21ef9282b894
In-Reply-To: <20180201175922.18930-1-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [v2] powerpc: pseries: use of_irq_get helper in request_event_sources_irqs
Message-Id: <42QjK66drTz9s7h@ozlabs.org>
Date:   Thu,  4 Oct 2018 16:14:34 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-01 at 17:59:22 UTC, Rob Herring wrote:
> Instead of calling both of_irq_parse_one and irq_create_of_mapping, call
> of_irq_get instead which does essentially the same thing. of_irq_get
> also calls irq_find_host for deferred probe support, but this should be
> fine as irq_create_of_mapping also calls that internally. This gets us
> closer to making the former 2 functions static.
> 
> In the process of simplifying request_event_sources_irqs, combine the
> the pr_err and WARN_ON calls to just a WARN().
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c417596d2409125b1814c05e994a21

cheers
