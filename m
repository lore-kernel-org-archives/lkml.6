Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225E1C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 09:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64A220665
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 09:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64A220665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbeJ0RuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 13:50:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58014 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbeJ0RuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 13:50:11 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hhj8QxL2PV8M; Sat, 27 Oct 2018 11:09:54 +0200 (CEST)
Received: from nazgul.tnic (unknown [185.30.24.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CC3AA1EC068B;
        Sat, 27 Oct 2018 11:09:53 +0200 (CEST)
Date:   Sat, 27 Oct 2018 11:10:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     Petr Tesarik <ptesarik@suse.cz>, lijiang <lijiang@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, mingo@redhat.com, tglx@linutronix.de,
        dyoung@redhat.com
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
Message-ID: <20181027091007.GB1046@nazgul.tnic>
References: <20181026093630.8520-1-lijiang@redhat.com>
 <053CC83A-9A95-4C12-9627-AABD1427DA9C@alien8.de>
 <1263471c-a27d-a698-15f0-b5947f13ea93@redhat.com>
 <20181026182440.20a4b107@ezekiel.suse.cz>
 <20181026222517.GB26927@nazgul.tnic>
 <20181027081343.GA1884@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181027081343.GA1884@MiWiFi-R3L-srv>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 04:13:43PM +0800, Baoquan He wrote:
> Yes, agree. So sme_me_mask itself or the encryption bit number, both is
> fine.

You need the encryption bit position and it better be properly formatted
and extracted into a vmcoreinfo-specific variable because we don't
expose arch-specific details like sme_me_mask to the outside.

>  we may use cp to copy /proc/vmcore to a file directly, then analyze
> it in another compupter. This often happen when there's something
> wrong with makedumpfile, we need debug makedumpfile with the complete
> copied file.

So for the analyze-on-another-computer scenario you absolutely must copy
anything from the first kernel decrypted because you can't decrypt it on
the other machine.

Which means, in a sensitive environment, you probably should copy and
*encrypt* the dump again with gpg or so.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
