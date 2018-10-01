Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA8DC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CC82089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47CC82089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbeJATQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:16:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56088 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729181AbeJATQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:16:46 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vxMVWQbM4XfD; Mon,  1 Oct 2018 14:39:08 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC64F00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:4f00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B2F901EC01FA;
        Mon,  1 Oct 2018 14:39:08 +0200 (CEST)
Date:   Mon, 1 Oct 2018 14:39:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        H Peter Anvin <hpa@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Stuart R . Anderson" <stuart.r.anderson@intel.com>,
        alan@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/earlyprintk: Add a force option for pciserial
 device
Message-ID: <20181001123916.GC7269@zn.tnic>
References: <20180928094008.23138-1-feng.tang@intel.com>
 <20180929163458.GA25608@zn.tnic>
 <20180930131619.jecqh4umrkmifavb@shbuild888>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180930131619.jecqh4umrkmifavb@shbuild888>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 09:16:19PM +0800, Feng Tang wrote:
> Got your point. As the following [,baudrate] is also optional, and this
> "force" could be the last option for pciserial. The check may be
> 
> 	if (!strncmp(s, "force,", 6) || !strncmp(s, "force ", 6)) {
> 		force = 1;
> 		s += 6;
> 	}

You have !strncmp(s, "force,", 6) twice in there. I have no clue what
you're trying to say.

> Do you mean this? 
> 
> 	if (((classcode >> 16 != PCI_CLASS_COMMUNICATION_MODEM) &&
> 	     (classcode >> 16 != PCI_CLASS_COMMUNICATION_SERIAL)) ||
> 	   (((classcode >> 8) & 0xff) != 0x02)) /* 16550 I/F at BAR0 */ {
> 		if (!force)
> 			return;
> 	}

Yes.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
