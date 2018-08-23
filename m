Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D049AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B99B208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B99B208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbeHXCcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 22:32:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51768 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbeHXCcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 22:32:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1ED767A9;
        Thu, 23 Aug 2018 16:00:27 -0700 (PDT)
Received: from dupont (dupont.austin.arm.com [10.118.16.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5B8F3F2EA;
        Thu, 23 Aug 2018 16:00:26 -0700 (PDT)
Date:   Thu, 23 Aug 2018 18:00:26 -0500
From:   Kim Phillips <kim.phillips@arm.com>
To:     Martin =?UTF-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     <linux-perf-users@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] Properly interpret indirect call in perf annotate.
Message-Id: <20180823180026.06e2e4dbca8954207f5ecf07@arm.com>
In-Reply-To: <bd1f3932-be2b-85f9-7582-111ee0a43b07@suse.cz>
References: <bd1f3932-be2b-85f9-7582-111ee0a43b07@suse.cz>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2018 14:29:34 +0200
Martin Liška <mliska@suse.cz> wrote:

> The patch changes interpretation of:
> callq  *0x8(%rbx)
> 
> from:
>   0.26 │     → callq  *8
> to:
>   0.26 │     → callq  *0x8(%rbx)
> 
> in this can an address is followed by a register, thus
> one can't parse only address.
> 
> Signed-off-by: Martin Liška <mliska@suse.cz>
> ---

Tested this doesn't incur any grievances parsing aarch64 code:

Tested-by: Kim Phillips <kim.phillips@arm.com>

Thanks,

Kim
