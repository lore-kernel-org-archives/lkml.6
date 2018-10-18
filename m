Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD370ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC98F20866
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC98F20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeJRWc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 18:32:56 -0400
Received: from foss.arm.com ([217.140.101.70]:38978 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbeJRWcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 18:32:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5D43A78;
        Thu, 18 Oct 2018 07:31:38 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12C373F71A;
        Thu, 18 Oct 2018 07:31:34 -0700 (PDT)
Date:   Thu, 18 Oct 2018 15:31:32 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Nickhu <nickhu@andestech.com>
Cc:     greentime@andestech.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, deanbo422@gmail.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, arnd@arndb.de, sboyd@codeaurora.org,
        geert@linux-m68k.org, zong@andestech.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, tglx@linutronix.de,
        kstewart@linuxfoundation.org, devicetree@vger.kernel.org,
        green.hu@gmail.com
Subject: Re: [PATCH 5/5] nds32: Add document for NDS32 PMU.
Message-ID: <20181018143132.vhhc6qpz4sooljlj@lakrids.cambridge.arm.com>
References: <cover.1539745993.git.nickhu@andestech.com>
 <c0a80d2db642b1d9547ff412d91baa9927b68aac.1539745993.git.nickhu@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0a80d2db642b1d9547ff412d91baa9927b68aac.1539745993.git.nickhu@andestech.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 04:43:17PM +0800, Nickhu wrote:
> The document for how to add NDS32 PMU
> in devicetree.
> 
> Signed-off-by: Nickhu <nickhu@andestech.com>
> ---
>  Documentation/devicetree/bindings/nds32/pmu.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nds32/pmu.txt
> 
> diff --git a/Documentation/devicetree/bindings/nds32/pmu.txt b/Documentation/devicetree/bindings/nds32/pmu.txt
> new file mode 100644
> index 000000000000..02762b850e59
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nds32/pmu.txt
> @@ -0,0 +1,17 @@
> +* NDS32 Performance Monitor Units
> +
> +NDS32 core have a PMU for counting cpu and cache events like cache misses.
> +The NDS32 PMU representation in the device tree should be done as under:
> +
> +Required properties:
> +
> +- compatilbe :
> +	"andestech,atcpmu"

Which CPUs have this PMU?

I expected more specific strings, e.g. "andestech,n13-pmu" and/or
"andestech,andestech,nds32v3-pmu".

> +
> +- interrupts : The interrupt number for NDS32 PMU is 13.
> +
> +Example:
> +pmu{
> +	compatible = "andestech,atcpmu";
> +	interrupts = <13>;
> +}

The driver tried to find multiple interrupts. Is there only a single
interrupt in all cases?

Thanks,
Mark.
