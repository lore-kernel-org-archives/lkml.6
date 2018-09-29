Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32875C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0227206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0227206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeI2PVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 11:21:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51822 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbeI2PVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 11:21:31 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BqKSjPa0Hqbg; Sat, 29 Sep 2018 10:53:52 +0200 (CEST)
Received: from zn.tnic (p200300EC2BD81000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd8:1000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7C0FC1EC04A6;
        Sat, 29 Sep 2018 10:53:52 +0200 (CEST)
Date:   Sat, 29 Sep 2018 10:53:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com, bhe@redhat.com,
        jroedel@suse.de
Subject: Re: [PATCH v7 RESEND 2/4] kexec: allocate unencrypted control pages
 for kdump in case SME is enabled
Message-ID: <20180929085354.GC11115@zn.tnic>
References: <20180927071954.29615-1-lijiang@redhat.com>
 <20180927071954.29615-3-lijiang@redhat.com>
 <20180927165323.GC19779@zn.tnic>
 <ef91c6cd-03dd-1a72-eea8-97d05d0ad370@redhat.com>
 <20180928075654.GA20768@zn.tnic>
 <2c5000d8-9f20-cc85-6d41-d6ece314c6ba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c5000d8-9f20-cc85-6d41-d6ece314c6ba@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 06:09:04PM +0800, lijiang wrote:
> But there are another cases, we might load or unload the crash kernel image and
> initrafms, maybe again and again for test or debug, we don't reboot at once. For

I don't think this qualifies even as a use case - this is what you do
during development.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
