Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966078AbeBMXTQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:19:16 -0500
Received: from www.llwyncelyn.cymru ([82.70.14.225]:33728 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965783AbeBMXTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:19:15 -0500
Date: Tue, 13 Feb 2018 23:18:47 +0000
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode/intel: Use 64-bit arithmetic instead of
 32-bit
Message-ID: <20180213231847.36f87c0b@alans-desktop>
In-Reply-To: <alpine.DEB.2.21.1802131747290.1130@nanos.tec.linutronix.de>
References: <20180213164404.GA11664@embeddedor.com>
        <alpine.DEB.2.21.1802131747290.1130@nanos.tec.linutronix.de>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 	if (c->x86_cache_size >= 0)
> 		seq_printf(m, "cache size\t: %d KB\n", c->x86_cache_size);
> 
> which is silly, because that really can be done with:
> 
> 	if (c->x86_cache_size)
> 
> as there is no point in printing 'cache size 0KB', which means
> x86_cache_size can be made unsigned int, which makes sense because cache
> size < 0 does not at all.

Currently 0MB means "I know you have no cache" (early slot 1 celeron),
while not printing it means 'I have no clue'

Alan
