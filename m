Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A20C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F3720883
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dm+4VPqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbfACIFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 03:05:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41286 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfACIFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 03:05:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nOckVns+kiW/76IMyM6PpxivuXXEqTn34twSBRWcBH0=; b=dm+4VPqyMSZujqu62FPF7duuc
        F3UNiNGV6DUDCP5ad/zkkd3k1AExFgntsoE04Als5sekbJhtE9og0MA9JLuf9WMiprUhX9aWF+oMM
        1MA4axOyMYemldRkUlFnyEtqM2WcPIHeL0zpGQ1OEQefcSHy5rcybg4Kx4PXzFsYmF/N4uUgI69CT
        Rp0xbw63qjJ29DKi+eqg1KPApMLo2gVtzqwl8R/Tb4LuPENJrMrA+NExnNKqZ0A2VYgPxFLxXtweR
        27KIAJdLs9gNTHh7yL6UPVn4hcvk14pbt4AG64y6b7qDNqm/Hk51KQFNMBbw229SIn9ZsSmnlYaxt
        7G41Auk3A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gey0A-0007lb-4a; Thu, 03 Jan 2019 08:05:14 +0000
Date:   Thu, 3 Jan 2019 00:05:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 22/25] powerpc: Remove CONFIG_GENERIC_NVRAM and adopt
 CONFIG_HAVE_ARCH_NVRAM_OPS
Message-ID: <20190103080514.GC11147@infradead.org>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <22b3299016531a7a05c9c45b36d43565c794e67d.1545784679.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22b3299016531a7a05c9c45b36d43565c794e67d.1545784679.git.fthain@telegraphics.com.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  # All PPC32s use generic nvram driver through ppc_md
> -config GENERIC_NVRAM
> +config HAVE_ARCH_NVRAM_OPS
>  	bool
>  	default y if PPC32

Symbols like this really should be defined in common code, and then
just selected by the users.
