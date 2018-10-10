Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D53C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2114F21479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2114F21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbeJJRTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:19:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49640 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbeJJRTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:19:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7354D80D;
        Wed, 10 Oct 2018 02:57:49 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAC683F5BC;
        Wed, 10 Oct 2018 02:57:47 -0700 (PDT)
Date:   Wed, 10 Oct 2018 10:57:41 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Wendy Liang <wendy.liang@xilinx.com>
Cc:     jassisinghbrar@gmail.com, michal.simek@xilinx.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
Message-ID: <20181010095741.GA14472@e107155-lin>
References: <1539155912-29760-1-git-send-email-wendy.liang@xilinx.com>
 <1539155912-29760-3-git-send-email-wendy.liang@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539155912-29760-3-git-send-email-wendy.liang@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 12:18:32AM -0700, Wendy Liang wrote:
> Xilinx ZynqMP IPI(Inter Processor Interrupt) is a hardware block
> in ZynqMP SoC used for the communication between various processor
> systems.
> 
> Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>

[...]

> +Optional properties:
> +--------------------
> +- method:              The method of accessing the IPI agent registers.
> +                       Permitted values are: "smc" and "hvc". Default is
> +                       "smc".

You are mixing the hardware messaging based mailbox and the software
"smc/hvc" based mailbox together here. Please keep them separated.
IIUC smc/hvc based mailcox is used for "tx" or too keep it simple in
one direction and hardware based is used for "rx" or the other direction
for communication.

You *should not* mix them as single unit. Also lots of other vendor need
SMC/HVC based mailbox. So make it generic and keep it separate.

--
Regards,
Sudeep
