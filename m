Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9653C67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9945920685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nsXLSIH4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IXs+FbL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9945920685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbeGZC7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 22:59:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33384 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbeGZC7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 22:59:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6238160328; Thu, 26 Jul 2018 01:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532569500;
        bh=uw50wi2FW31v8GsHzM4FK1Wn0Li8mrNElKlsY3Pspbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nsXLSIH4PIalvaJdIwvZP0tV2Pkh2wqnIf9HISPUAyw9nR74AqIY47r2hkfHisPnT
         H6NenKdZSLqxBtkZXPcOblbXTvYdVQAoeIDpPQ6p2JtYrnoD0sMditLZ/jOTr4MQg5
         KmEtSy/VONOo4eK3E4nqLX3ZmcPRJqbvnlHbO4og=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rkuo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 53B7B60328;
        Thu, 26 Jul 2018 01:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532569499;
        bh=uw50wi2FW31v8GsHzM4FK1Wn0Li8mrNElKlsY3Pspbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IXs+FbL9qJIDvwdKy0U3TCPfC2v0CfvvZuEnrQkyuMnAHnEuDDl9p4wbqN1Bx9O3q
         WMHIqCmQFwlRIn2k61FvQiL3tXPy0vPhmNZDjIaB9z5fwQceiTaY8cxQ7PwuKr/6Lr
         p2Xa1zwWvHTpFJ7RYJ+4gEru72OOEJ1OFl6Z+d5M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 53B7B60328
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rkuo@codeaurora.org
Date:   Wed, 25 Jul 2018 20:44:57 -0500
From:   Richard Kuo <rkuo@codeaurora.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-hexagon@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hexagon: switch to NO_BOOTMEM
Message-ID: <20180726014457.GH12771@codeaurora.org>
References: <1532496594-26353-1-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532496594-26353-1-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 08:29:54AM +0300, Mike Rapoport wrote:
> This patch adds registration of the system memory with memblock, eliminates
> bootmem initialization and converts early memory reservations from bootmem
> to memblock.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> ---
> v2: fix calculation of the reserved memory size
> 
>  arch/hexagon/Kconfig   |  3 +++
>  arch/hexagon/mm/init.c | 20 ++++++++------------
>  2 files changed, 11 insertions(+), 12 deletions(-)
> 

Looks good, I can take this through my tree.


Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
