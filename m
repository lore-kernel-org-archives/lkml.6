Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4FFC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2074C20838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2074C20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbeJaTI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:08:27 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59570 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbeJaTI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:08:26 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1kq5Fyvu_-DI; Wed, 31 Oct 2018 11:10:57 +0100 (CET)
Received: from zn.tnic (p200300EC2BCE6000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bce:6000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 68A061EC00EB;
        Wed, 31 Oct 2018 11:10:57 +0100 (CET)
Date:   Wed, 31 Oct 2018 11:10:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Young <dyoung@redhat.com>
Cc:     lijiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>,
        Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com,
        tglx@linutronix.de, Kazuhito Hagio <khagio@redhat.com>
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
Message-ID: <20181031101054.GB15955@zn.tnic>
References: <15897206-c1a6-ced6-3a1b-f71da8fc9c83@redhat.com>
 <20181029114414.GA11408@MiWiFi-R3L-srv>
 <90385882-7fd1-a674-ec5a-19bd42471a5e@redhat.com>
 <20181029134918.GB32150@zn.tnic>
 <699ab34e-1373-582d-4e58-e76bd57ec34f@redhat.com>
 <20181030050900.GA25987@dhcp-128-65.nay.redhat.com>
 <20181030091542.GD32102@zn.tnic>
 <20181030092314.GC14493@MiWiFi-R3L-srv>
 <dcbc925f-6935-6a34-fde1-7aa1ea378891@redhat.com>
 <20181031024748.GA2058@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181031024748.GA2058@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 10:47:48AM +0800, Dave Young wrote:
> It is a mist only a few kdump people know them, documenting them will help
> people to understand and review. It will also be clearer instead of
> digging into code?

Wholeheartedly agreed. Especially if people start using vmcoreinfo for
other stuff, like live debugging:

https://lkml.kernel.org/r/1540593788-28181-1-git-send-email-bhsharma@redhat.com

> The document can briefly explain what is vmcoreinfo, why we need it, and
> some background info.  Then list the exported values with some
> classifying by core kernel, arch related,  string or number etc.  For
> most of them like Baoquan said no need more explanation, but add
> explanations for something if needed like this sme mask.

And add explanations for *all* of them!

If this becomes an API, then it better be documented.

> But I think this can be done separately instead of blocking this patch.

We have three months to the next merge window - I'm sure you guys can do
both. :-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
