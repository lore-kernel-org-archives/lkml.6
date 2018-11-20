Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BC8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F02520851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F02520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbeKTVkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:40:31 -0500
Received: from foss.arm.com ([217.140.101.70]:47168 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727728AbeKTVkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:40:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1906515BE;
        Tue, 20 Nov 2018 03:11:55 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2BB73F575;
        Tue, 20 Nov 2018 03:11:52 -0800 (PST)
Date:   Tue, 20 Nov 2018 11:11:46 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        Damien.LeMoal@wdc.com, juri.lelli@arm.com, anup@brainfault.org,
        palmer@sifive.com, jeremy.linton@arm.com, robh+dt@kernel.org,
        mick@ics.forth.gr, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 0/3] Unify CPU topology across ARM64 & RISC-V
Message-ID: <20181120111146.GA6497@e107155-lin>
References: <1541728209-3224-1-git-send-email-atish.patra@wdc.com>
 <07d92dd4-f943-47ee-e168-46bfaf4ed755@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07d92dd4-f943-47ee-e168-46bfaf4ed755@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 11:31:33AM -0700, Jeffrey Hugo wrote:

[...]

>
> I was interested in testing these on QDF2400, an ARM64 platform, since this
> series touches core ARM64 code and I'd hate to see a regression. However, I
> can't figure out what baseline to use to apply these. Different patches
> cause different conflicts of a variety of baselines I attempted.
>

Good to know that we can test DT configuration on QDF2400. I always assumed
it's ACPI only.

> What are these intended to apply to?
>

The series alone may not get the package/socket ids correct on QDF2400.
I have not yet added support for the same as I wanted to get the initial
feedback on DT bindings. The movement of DT binding and corresponding
code should not regress and you should be able to validate only that
part.

--
Regards,
Sudeep
