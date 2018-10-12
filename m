Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C84C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D342075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D342075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbeJLRSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:18:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57644 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728027AbeJLRSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:18:37 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2Q43Y0Y3agTF; Fri, 12 Oct 2018 11:47:00 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCC2400329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:2400:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C9261EC00E5;
        Fri, 12 Oct 2018 11:47:00 +0200 (CEST)
Date:   Fri, 12 Oct 2018 11:46:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, rjw@rjwysocki.net,
        lenb@kernel.org, ard.biesheuvel@linaro.org,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v8 1/3] x86/boot: Add acpitb.c to parse acpi tables
Message-ID: <20181012094655.GB12328@zn.tnic>
References: <20181010084119.17539-1-fanc.fnst@cn.fujitsu.com>
 <20181010084119.17539-2-fanc.fnst@cn.fujitsu.com>
 <20181011105708.GB25435@zn.tnic>
 <20181012093638.GA1898@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181012093638.GA1898@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 05:36:38PM +0800, Chao Fan wrote:
> Prefer to compile out entire functions, rather than portions of functions or
> portions of expressions.  Rather than putting an ifdef in an expression, factor
> out part or all of the expression into a separate helper function and apply the
> conditional to that function.
> 
> So I am puzzled. If my understanding is wrong, please let me know.

If you do it the way I suggested, you simply have one ifdeffery branch
less. And ifdeffery is ugly. So less clutter. Also, this way you do
compile out entire functions too.

HTH.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
