Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C420CC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C8620882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544196087;
	bh=CBmvM9B8HsliP+38KZIT+a/6PVCZqZNIESDfqE2moLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=M8iUZgATGZXpZk6nsDeHS/DbjTZLFbCw35lrorBF04VMBTGTaH2xX5P+/N7/rRxvl
	 FKDDQ4mVSKLWoCx00LwklpgQs2CzqRaMcMqc6M2g4X+oedX6vMZCnwOWxcHbn9hn3V
	 m7F+GnVYd7Hjl/IbGtmNz+iAaUqQRg2OU1+HE8Pg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C8620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbeLGPV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:21:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:48896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbeLGPV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 10:21:26 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04F7520837;
        Fri,  7 Dec 2018 15:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544196085;
        bh=CBmvM9B8HsliP+38KZIT+a/6PVCZqZNIESDfqE2moLo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iNTC3c4B/cZZvrCxrp4pk/OodbYuMBOPRUUHTjX7zuxk8+zjW71I/Xp2WR02DZkds
         V5iU9gmMkdoMkBaLJJWt7PB4s4/cEoTTWz4wXEvDgZt4Xg28ncVpRfPxxNJ5mKSWXm
         02B4I+6stPsOvJhGrNPCE3EZlVYaDF5QQECM5914=
Date:   Sat, 8 Dec 2018 00:21:22 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Banman <andrew.banman@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mike Travis <mike.travis@hpe.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yi Wang <wang.yi59@zte.com.cn>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] x86/kernel: Fix more -Wmissing-prototypes warnings
Message-Id: <20181208002122.b84a40b86f4225c9e0795ff2@kernel.org>
In-Reply-To: <20181205142448.GH29510@zn.tnic>
References: <20181205101131.28996-1-bp@alien8.de>
        <20181205224906.824483ea3c5d1d5b7712c99a@kernel.org>
        <20181205142448.GH29510@zn.tnic>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018 15:24:48 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Wed, Dec 05, 2018 at 10:49:06PM +0900, Masami Hiramatsu wrote:
> > I would like to put this prototype inside arch/x86/kernel/kprobes/core.c,
> > since that is locally used.
> 
> Done.
> 
> > Should we declare prototypes for __weak functions? Anyway, we should remove
> > __weak from the prototypes.
> 
> And done.
> 
> Thx.

OK, I think it is good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.


-- 
Masami Hiramatsu <mhiramat@kernel.org>
