Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92460C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A5F214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NQU3XENP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A5F214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732291AbeHBNcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:32:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56422 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732126AbeHBNcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ijbEhmpxwkpZkOPKenTjQE02EV/4P0JsXYWDsjbaXEo=; b=NQU3XENPejSXM/cXRn+uBtLl+
        4IamX6REAWRFKJ40T95PYcG7EdTX+j9tGE1ng6pxaQrHfumg/8jEGmdlOChzQsS2mmavSpg68s/Om
        +ma/xMKghwW/51UtoYeB7Ko3o3Dd4lR86IRed7wrJcI7AVMGmBY/pdtHf8pXapjprBCDQKo99IsDJ
        txV28+6oPRl0f55euD4JUthdiYrQ4kcr/eOLbMcOBQeFrRtpFYLbIvDtKszjwDKNab8rFkI7uG1lG
        AtSFpq6onDTrSDQT+Hrvo66lskpwae6uXngySIyF8tLN+7Ks6iEhQvukrQhvae7/XTxe2K2nfixvt
        QL+6/AIzg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flBzI-0000aS-IO; Thu, 02 Aug 2018 11:41:48 +0000
Date:   Thu, 2 Aug 2018 04:41:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alan Kao <alankao@andestech.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darius Rad <darius@bluespec.com>,
        Vincent Chen <vincentc@andestech.com>,
        Zong Li <zong@andestech.com>, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <greentime@andestech.com>
Subject: Re: [PATCH v3 4/4] Add an option to support no-FPU systems
Message-ID: <20180802114148.GD17108@infradead.org>
References: <1533188391-5932-1-git-send-email-alankao@andestech.com>
 <1533188391-5932-5-git-send-email-alankao@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533188391-5932-5-git-send-email-alankao@andestech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 01:39:51PM +0800, Alan Kao wrote:
> FP codes have been separated from common part in previous patches.
> This patch add the CONFIG_FPU option and some stubs to support
> no-FPU systems.

I think the subject should be 'allow to disable FPU support'.

As discussed in the other thread we should be able to detect
systems without FPU and handle them fine even with FPU support built
in.  Even with that I think this patch is otherwise fine and the
detection can be layered on top.  One more nitpick below:

> +#else
> +#define save_fp_state(task, regs) (0)
> +#define restore_fp_state(task, regs) (0)
> +#define fstate_save(task, regs) do { } while (0)
> +#define fstate_restore(task, regs) do { } while (0)
> +#define __switch_to_aux(__prev, __next) do { } while (0)
> +#define DEFAULT_SSTATUS (SR_SPIE | SR_FS_OFF)
> +#endif

Please move the stubs for functions that are static in signal.c
into signal.c as well - you already have a CONFIG_FPU ifdef block
in that file anyway.
