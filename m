Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB29C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CED214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CED214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbeLFJpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:45:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:58640 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727763AbeLFJpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:45:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D293ACBA;
        Thu,  6 Dec 2018 09:45:52 +0000 (UTC)
Date:   Thu, 6 Dec 2018 10:45:49 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
cc:     linux@armlinux.org.uk, jeyu@kernel.org, dave.martin@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: Re: [PATCH v5 1/2] module: Overwrite st_size instead of st_info
In-Reply-To: <20181204141415.969-1-vincent.whitchurch@axis.com>
Message-ID: <alpine.LSU.2.21.1812061045320.17628@pobox.suse.cz>
References: <20181204141415.969-1-vincent.whitchurch@axis.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018, Vincent Whitchurch wrote:

> st_info is currently overwritten after relocation and used to store the
> elf_type().  However, we're going to need it fix kallsyms on ARM's
> Thumb-2 kernels, so preserve st_info and overwrite the st_size field
> instead.  st_size is neither used by the module core nor by any
> architecture.
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
