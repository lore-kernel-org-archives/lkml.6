Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01069C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C434A20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C434A20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbeK0FRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:17:48 -0500
Received: from foss.arm.com ([217.140.101.70]:44442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725723AbeK0FRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:17:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A55731A25;
        Mon, 26 Nov 2018 10:22:52 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA3FD3F5AF;
        Mon, 26 Nov 2018 10:22:48 -0800 (PST)
Subject: Re: [PATCH v2 01/20] perf/doc: update design.txt for
 exclude_{host|guest} flags
To:     Andrew Murray <andrew.murray@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-s390@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
 <1543230756-15319-2-git-send-email-andrew.murray@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b5ba3edb-bc2a-225b-5a87-dd144104cabb@arm.com>
Date:   Mon, 26 Nov 2018 18:22:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543230756-15319-2-git-send-email-andrew.murray@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 26/11/2018 11:12, Andrew Murray wrote:
> Update design.txt to reflect the presence of the exclude_host
> and exclude_guest perf flags.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>

Thanks a lot for adding this !

> ---
>   tools/perf/design.txt | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/design.txt b/tools/perf/design.txt
> index a28dca2..5b2b23b 100644
> --- a/tools/perf/design.txt
> +++ b/tools/perf/design.txt
> @@ -222,6 +222,10 @@ The 'exclude_user', 'exclude_kernel' and 'exclude_hv' bits provide a
>   way to request that counting of events be restricted to times when the
>   CPU is in user, kernel and/or hypervisor mode.
>   
> +Furthermore the 'exclude_host' and 'exclude_guest' bits provide a way
> +to request counting of events restricted to guest and host contexts when
> +using KVM virtualisation.

minor nit: could we generalise this to :

"using Linux as the hypervisor".

Otherwise, looks good to me.

Cheers
Suzuki
