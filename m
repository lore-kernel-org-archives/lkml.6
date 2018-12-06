Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84F3C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB6420838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB6420838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbeLFQTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:19:31 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:59816 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeLFQTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:19:31 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=svr-ies-mbx-01.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gUwN1-0002oI-4W from joseph_myers@mentor.com ; Thu, 06 Dec 2018 08:19:23 -0800
Received: from digraph.polyomino.org.uk (137.202.0.90) by
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Thu, 6 Dec 2018 16:19:19 +0000
Received: from jsm28 (helo=localhost)
        by digraph.polyomino.org.uk with local-esmtp (Exim 4.90_1)
        (envelope-from <joseph@codesourcery.com>)
        id 1gUwMx-0004rO-7O; Thu, 06 Dec 2018 16:19:19 +0000
Date:   Thu, 6 Dec 2018 16:19:19 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Paul Burton <paul.burton@mips.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        <libc-alpha@sourceware.org>
Subject: Re: [PATCH v3 0/6] mips: system call table generation support
In-Reply-To: <alpine.LFD.2.21.1812061209220.7193@eddie.linux-mips.org>
Message-ID: <alpine.DEB.2.21.1812061618110.12167@digraph.polyomino.org.uk>
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org> <CALxhOnjSEp++W5T3Sf0eX+8hPt08ER22M817M-Vhd24_96a_EQ@mail.gmail.com> <20181205063436.kzxgnvgexcgq572k@pburton-laptop> <alpine.LFD.2.21.1812061209220.7193@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-08.mgc.mentorg.com (139.181.222.8) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018, Maciej W. Rozycki wrote:

>  I believe this file is used by the glibc build process to retrieve 
> syscall numbers for glibc's own use as well for <sys/syscall.h>.  Has the 
> change been verified not to break this process?
> 
>  Cc-ing <libc-alpha@sourceware.org> for information and possible further 
> input.

I'm not sure what "this file" is.  The glibc build uses the installed 
<asm/unistd.h> (the results of #including it, not any other kind of 
processing the file).

-- 
Joseph S. Myers
joseph@codesourcery.com
