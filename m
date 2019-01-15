Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECD2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66BB120651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SE6sE3Jm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbfAONwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:52:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbfAONwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:52:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zcMRAuiMYv+98ytEt1DsxejZ9FTrmzgcBdjl2i2EjyQ=; b=SE6sE3JmQJmxcJy47MAEwbalG
        6f4ZR3K7RDxhpBpV+TzFYRceTyqPNpc80GD8Cg98feth/KhQwHr6usbT6k6DNhUiFmm91mUstB5EV
        Tp3oF86pFPg71EBhYMWJAU4OGXMH1VRMlNmZR6N/J5KlsVLddMAQ8OdEyEZbL7IZBIqM57O/vVDhs
        jJLk3bxPU31LaoFkEYK5dVguxX97cUemJamNPNj2kNuaCTC+9l7ypykEYI9hLOLIfx2aOxLz0eeb9
        x0h9jzmgQ8+n6/JLRPEW6ZmprOaIs1Iag8rEyxxm2LbvM1uLQdGU3xvBeghFVpg3MsS8Sf5JHbDms
        rXaoT6DzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjP8n-00011l-5e; Tue, 15 Jan 2019 13:52:29 +0000
Date:   Tue, 15 Jan 2019 05:52:29 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-riscv@lists.infradead.org,
        Patrick =?iso-8859-1?Q?St=E4hlin?= <me@packi.ch>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jason Cooper <jason@lakedaemon.net>,
        Alan Kao <alankao@andestech.com>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org,
        Michael Clark <michaeljclark@mac.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Andreas Schwab <schwab@suse.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zongbox@gmail.com>
Subject: Re: [PATCH v2 2/8] RISC-V: Move cpuid to hartid mapping to SMP.
Message-ID: <20190115135229.GB28946@infradead.org>
References: <1546940318-9752-1-git-send-email-atish.patra@wdc.com>
 <1546940318-9752-3-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546940318-9752-3-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (hartid == boot_cpu_hartid)
> +		return 0;
> +	else
> +		return -1;

No need for an else after a return statement.

> +}
> +static inline unsigned long cpuid_to_hartid_map(int cpu)
> +{
> +
> +	return boot_cpu_hartid;

spurious empty line above.
