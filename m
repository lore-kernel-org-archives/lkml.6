Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488D0C5AE5E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0734D20823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ryqn7UI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbfARX24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 18:28:56 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:43573 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbfARX2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 18:28:55 -0500
Received: by mail-pl1-f178.google.com with SMTP id gn14so6980105plb.10;
        Fri, 18 Jan 2019 15:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LMgc9euKG4vaUInL1j5FFNgCuUfgfJc1iMpxvXuGAO0=;
        b=Ryqn7UI8AT2EiOaSIkXS3rcquV7NvF0COjzDMMbx6DyLBRr9b3V3nGg63eUc4aYC/Y
         1qIDimG6zpBU3SUTvFALQvKQZOhcDDCKGOKGlymIwYDBpdpgjcr4tU88VJiJXmfQWzvM
         QS3dW37UvLR7zLrdR8KqxM+8JeTJ6cey1h7DpP0hXmshJCPPpztCDt0yr4JSHOa/SBLi
         5jUIzBZGQ0s6GufkPBERYhcox8adIdbfRIX1TbYjP9RFMFjqoZBQHlywMF46mpQEUKGt
         POPrSa8CoPPFmF2pQ2OG39S/n+7/QduEpN7BgggailBKm7mp8ormSOGEVIkpMHeEnzsn
         l3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LMgc9euKG4vaUInL1j5FFNgCuUfgfJc1iMpxvXuGAO0=;
        b=A80WUlsKCaSjFqu69fB7Ig1jy5Pfp+Rm/chuAKBE2RLoAkGkdyWGMKQ7x8LWhMYPXi
         d8r+Wl7alWs1XpFLU+hm5EZ3ABAJrgHK7mxU21zoreA21Keib2EUax1ah02En4lEFM28
         iC/7pfZPGkM3JhQcKvGGDiO0Yn8EWBgQnZ8PXLp2VSrLjp/eVEeEeJ5XeKf3oT+hHnw6
         GWsiVplGyoN0ARt5J78qhudgWvjVdlTXmFU6QBeWO9ibN+0Fjue/YrT+jgOTcR0aOhv0
         t8Lqw9MkPIeAY+6oSCmUERbZmrQ6rwRL82VOJDkpwLAqdOGcw35zSiOvQPWrcU98LrXv
         I99A==
X-Gm-Message-State: AJcUukffNXOTdWKtQMLX4ZKk10BiflFsnqTBJYOjZYjUpe67vVVk7LVU
        hoyaObk+YPNqAwGEYcx8Mp8=
X-Google-Smtp-Source: ALg8bN7Aoe5YbpPvWnYyr8PUon+H3B9bN9Sd6TSwE9hVFIM8ZlM/eMk7K9IOG8iA9Rusp2bgH4ud+A==
X-Received: by 2002:a17:902:108a:: with SMTP id c10mr21193228pla.131.1547854134362;
        Fri, 18 Jan 2019 15:28:54 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:5ed2])
        by smtp.gmail.com with ESMTPSA id k15sm9617966pfb.147.2019.01.18.15.28.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 15:28:53 -0800 (PST)
Date:   Fri, 18 Jan 2019 15:28:51 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Roman Gushchin <guro@fb.com>,
        YueHaibing <yuehaibing@huawei.com>, Yonghong Song <yhs@fb.com>,
        Stanislav Fomichev <sdf@google.com>,
        Sean Young <sean@mess.org>, Jiri Benc <jbenc@redhat.com>,
        David Calavera <david.calavera@gmail.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>,
        David Ahern <dsahern@gmail.com>,
        Petar Penkov <ppenkov@stanford.edu>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        Stephen Hemminger <stephen@networkplumber.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Taeung Song <treeze.taeung@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        okash.khawaja@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch 8/9] tools: bpftool: Cleanup license mess
Message-ID: <20190118232849.jec4mipctsupgggn@ast-mbp.dhcp.thefacebook.com>
References: <20190117231416.111952141@linutronix.de>
 <20190117231501.560475279@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117231501.560475279@linutronix.de>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 12:14:24AM +0100, Thomas Gleixner wrote:
> Precise and non-ambiguous license information is important. The recent
> relicensing of the bpftools introduced a license conflict.
> 
> The files have now:
> 
>      SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause
> 
> and
> 
>      * This program is free software; you can redistribute it and/or
>      * modify it under the terms of the GNU General Public License
>      * as published by the Free Software Foundation; either version
>      * 2 of the License, or (at your option) any later version
> 
> Amazingly about 20 people acked that change and neither they nor the
> committer noticed. Oh well.
> 
> Digging deeper: The files were imported from the iproute2 repository with
> the GPL V2 or later boiler plate text in commit b66e907cfee2 ("tools:
> bpftool: copy JSON writer from iproute2 repository")
> 
> Looking at the iproute2 repository at
> 
>   git://git.kernel.org/pub/scm/network/iproute2/iproute2.git
> 
> the following commit is the equivivalent:
> 
>   commit d9d8c839 ("json_writer: add SPDX Identifier (GPL-2/BSD-2)")
> 
> That commit explicitly removes the boiler plate and relicenses the code
> uner GPL-2.0-only and BSD-2-Clause. As Steven wrote the original code and
> also the relicensing commit, it's assumed that the relicensing was intended
> to do exaclty that. Just the kernel side update failed to remove the boiler
> plate. Do so now.
> 
> Fixes: 907b22365115 ("tools: bpftool: dual license all files")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: YueHaibing <yuehaibing@huawei.com>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Sean Young <sean@mess.org>
> Cc: Jiri Benc <jbenc@redhat.com>
> Cc: David Calavera <david.calavera@gmail.com>
> Cc: Andrey Ignatov <rdna@fb.com>
> Cc: Joe Stringer <joe@wand.net.nz>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: Petar Penkov <ppenkov@stanford.edu>
> Cc: Sandipan Das <sandipan@linux.ibm.com>
> Cc: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Taeung Song <treeze.taeung@gmail.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Quentin Monnet <quentin.monnet@netronome.com>
> CC: okash.khawaja@gmail.com
> Cc: netdev@vger.kernel.org
> ---
> 
> P.S.: This patch is part of a larger cleanup, but independent of other
>       patches and is intended to be picked up by the maintainer directly.

Applied this patch to bpf tree.
Sorry about this mess.

