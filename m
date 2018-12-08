Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99382C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 11:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE0320892
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 11:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="IBGzD+Xt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE0320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbeLHLMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 06:12:40 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44950 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeLHLMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 06:12:40 -0500
Received: from zn.tnic (p200300EC2BDEA700C0511CCA78411630.dip0.t-ipconnect.de [IPv6:2003:ec:2bde:a700:c051:1cca:7841:1630])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6AE041EC094F;
        Sat,  8 Dec 2018 12:12:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544267559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5qf5Vl8AUTbCbfUx0cOvrapGS4yBZ3qqqPsjx1Lc+w8=;
        b=IBGzD+XtWJdXebUoTQV4kn2E5OJ8O6XBO1ce1Z+hzBvQKCXFAwpGJ8UjJKCcXbkClT4Z1o
        yxMUXBshBosJq7Q7Wqoo9kn8o20Mqzsgi7u97qrqdS7WvbEyg4C4/yUP54jyS9p8YHKLBS
        sDwMXYZhIbqeIqkuCYIQzJfIxUiY9Jw=
Date:   Sat, 8 Dec 2018 12:12:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpu: Avoid endless loop to get the number of cache
 leaves
Message-ID: <20181208111232.GB30399@zn.tnic>
References: <1541422425-5855-1-git-send-email-puwen@hygon.cn>
 <20181115172155.GB25056@zn.tnic>
 <1544237214-18766-1-git-send-email-puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1544237214-18766-1-git-send-email-puwen@hygon.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 10:46:54AM +0800, Pu Wen wrote:
> How about define CTYPE_MAX like this:
> #define CTYPE_MAX  4

How about you look at the definition of CPUID leaf 4 and think about it
a bit and realize that this is the wrong thing to do?

> It will return CTYPE_NULL when accessing the 4th CPUID leaf in most of
> the cases, but in certain case it will not.

Well, that's certain cases' problem, isn't it? How about fixing xen
instead?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
