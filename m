Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFBDC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D98C2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D98C2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbeJ3XNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:13:47 -0400
Received: from ozlabs.org ([203.11.71.1]:46031 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbeJ3XNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:13:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42ktsK1JKDz9s8r;
        Wed, 31 Oct 2018 01:20:05 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 01/21] of: Add cpu node iterator for_each_of_cpu_node()
In-Reply-To: <874ld3jz6v.fsf@concordia.ellerman.id.au>
References: <20180905193738.19325-1-robh@kernel.org> <20180905193738.19325-2-robh@kernel.org> <874ld3jz6v.fsf@concordia.ellerman.id.au>
Date:   Wed, 31 Oct 2018 01:20:03 +1100
Message-ID: <871s87jz3g.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:
> Hi Rob,
>
> Sorry I missed this when you posted it.
>
> Rob Herring <robh@kernel.org> writes:
>> Iterating thru cpu nodes is a common pattern. Create a common iterator
>> which can find child nodes either by node name or device_type == cpu.
>> Using the former will allow for eventually dropping device_type
>> properties which are deprecated for FDT.
>
> Device trees we see on powerpc generally don't (never?) use "cpu" as the
> node name for CPU nodes. And many of those device trees come from
> firmware, so we can't update them.
>
> So dropping support for device_type is a non-starter from our POV.

ps. presumably that's what you meant by deprecated *for FDT*.

But anyway just wanted to make sure we are on the same page.

cheers
