Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6465CC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369372080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfBEJ1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:27:47 -0500
Received: from foss.arm.com ([217.140.101.70]:38588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbfBEJ1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:27:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97A07EBD;
        Tue,  5 Feb 2019 01:27:46 -0800 (PST)
Received: from C02TF0J2HF1T.cambridge.arm.com (c02tf0j2hf1t.cambridge.arm.com [10.1.30.174])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B8B53F71E;
        Tue,  5 Feb 2019 01:27:45 -0800 (PST)
Date:   Tue, 5 Feb 2019 09:27:42 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     ard.biesheuvel@linaro.org, gregkh@linuxfoundation.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] efi/arm64: return zero from ptdump_init()
Message-ID: <20190205092741.GA51170@C02TF0J2HF1T.cambridge.arm.com>
References: <20190204210101.61733-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204210101.61733-1-cai@lca.pw>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 04:01:01PM -0500, Qian Cai wrote:
> The commit e2a2e56e4082 ("arm64: dump: no need to check return value of
> debugfs_create functions") converted ptdump_debugfs_register() from
> void, but forgot to fix the efi version of ptdump_init().
> 
> drivers/firmware/efi/arm-runtime.c: In function 'ptdump_init':
> drivers/firmware/efi/arm-runtime.c:52:9: error: void value not ignored as it ought to be
>    52 |  return ptdump_debugfs_register(&efi_ptdump_info, "efi_page_tables");
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/firmware/efi/arm-runtime.c:53:1: warning: control reaches end of non-void function [-Wreturn-type]
> 
> Fixes: e2a2e56e4082 ("arm64: dump: no need to check return value of debugfs_create functions")
> Signed-off-by: Qian Cai <cai@lca.pw>

A fix is already in -next (commit 67f52a9540e0).

-- 
Catalin
