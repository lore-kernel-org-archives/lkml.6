Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3953EC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DA520879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="EHMI0xel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DA520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbeLMN0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:26:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48700 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729289AbeLMN0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:26:11 -0500
Received: from zn.tnic (p200300EC2BCC68007DC7AAB4AA45A2DC.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:6800:7dc7:aab4:aa45:a2dc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0B22F1EC0AD8;
        Thu, 13 Dec 2018 14:26:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544707570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4KZJHpX+qw00q6RaH189D4A1xSBUH0BxYBZuQ7/cPP8=;
        b=EHMI0xel5/OEG7vdb3/WpqwkcGr5sBujzFcBemrwLn+ATiwDYEEeAkFD4qExDnhFHzNRja
        sSB6Yh7YG1ymq6i2F56I5+QNqYp6GvFx4qKswnXwwzFmgDvwjHVerS/k0EXxqUQPPrZjGS
        4ggBwwv4N+E4iQ3VlyZPqrxDclfhVZY=
Date:   Thu, 13 Dec 2018 14:26:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     Chao Fan <fanc.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, keescook@chromium.org, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v13 1/6] x86/boot: Introduce kstrtoull() to boot
 directory instead of simple_strtoull()
Message-ID: <20181213132603.GD25287@zn.tnic>
References: <20181212031053.1815-1-fanc.fnst@cn.fujitsu.com>
 <20181212031053.1815-2-fanc.fnst@cn.fujitsu.com>
 <20181212041218.GA28286@localhost.localdomain>
 <20181212080312.GP17340@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181212080312.GP17340@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 04:03:12PM +0800, Baoquan He wrote:
> Surely, using the old simple_strtoull() is fine too, we can take its
> replacement into TODO list.

Yes, that would be nice.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
