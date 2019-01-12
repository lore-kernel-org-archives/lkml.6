Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E03C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581582133F
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547283298;
	bh=SXPoPTa84r8uB2CPYWNNiCfqAtrJzJrKef6rFQW8Dx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EVkwtBhDi0Pqmye2fnpgOI5TfvV7WOxX3yg3rjfKneOIVdIWsikRH2D2LM/npfodZ
	 Me5BjPNqYKmCmU10CK9P96pe0/UOpz5zydd1LjIhhKuHUYfRLAEsD3zd9ILzqX8l+5
	 Uuhrr5eQGXGoWLfDuWOqDGwGt2RJRKgB8UvuslPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfALIyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 03:54:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44992 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfALIyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 03:54:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so17563804wrt.11;
        Sat, 12 Jan 2019 00:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6ACrcjoGuLrVpIFQUrVx3CnbXizvBtHaRSu5ux5eqzU=;
        b=NIfeAu+NF+ed2XFweoX/GZl4U0QfgKzDN3/QqZDx3QM/i0AXOrdGIKnMha3K85GaHp
         TjKkzDNlumfY3ziy6fdiau8k7MSwj4tPBzMUv1dyP985o5qNvSUsznoreB4zkQ8V4qGr
         /5tC5N3AuPqphWl5MqNmsgCB4OVltf1Ig8kjJcJ8fPcw6TbCX45vDBX3LUhMYNIAVUyP
         K2u1rjQfwYCKJuJ+C8f8XLSu0UMimtsUG28yJKtVtV197H5vs9zw0/uDUYPRShS9oLVv
         KdLOpk33nXcetlP9XrovcoNbwog2vN49wqzZjPVYFX0R9zriiOrxpD9YjX2CV1bOzqd0
         jrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6ACrcjoGuLrVpIFQUrVx3CnbXizvBtHaRSu5ux5eqzU=;
        b=CeD1NCuwOwwPv+uMaaFl1r/9bWQeWiGTHnYjvatmIxDHoOYH3xjyaUbnJBPoEp6aww
         T6J1ZxM5qEtMDM16DxEXtiRzUYDsT2axjcxiFgcfvqctNFy4wyyFgqri0BcDHNy74Q9P
         ak6Vw95mLlTsGBlYERmfmdN63VT88XgbNLbvm2xiHRc4H/dhEhx4eLDTLNDf2CwMRy5N
         i+JJdGbQ69mkTeLh2VRpp6GHNZhrk4AAHeG2cgV0bPFpmVWz0jywgjfosVgOMTXaYXw0
         VOY1S/9e9E7ZSd0jZmkD4hj6oWd9f08NSYqHzkFyaiHbYVCpp2xmHiDWkADK+6rGpOuR
         Fjjg==
X-Gm-Message-State: AJcUukf8m7Ybnt6Uml+T95D6ivzDJNXPxWeVlcIrGRvmtEq/DMQexx+V
        fnTlyxhJ/fsP60CLYGu6keg=
X-Google-Smtp-Source: ALg8bN7X3ZFsD2kJ3KHBxjFUS/mYEIciGc3gV1Kbywxi9Y53zFjSNRcHM9AvU/DW7KJ9qZhtiKc7dQ==
X-Received: by 2002:a5d:46cd:: with SMTP id g13mr17315432wrs.49.1547283275453;
        Sat, 12 Jan 2019 00:54:35 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m4sm14029835wmi.3.2019.01.12.00.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 Jan 2019 00:54:34 -0800 (PST)
Date:   Sat, 12 Jan 2019 09:54:32 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] EFI fix
Message-ID: <20190112085432.GB119110@gmail.com>
References: <20190111074614.GA68053@gmail.com>
 <CAHk-=whU4L4qzCmKhGGSthCGWkSSVFiP-0v16fpZTUzWgp39hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whU4L4qzCmKhGGSthCGWkSSVFiP-0v16fpZTUzWgp39hg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Jan 10, 2019 at 11:46 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > A single fix that adds an annotation to resolve a kmemleak false
> > positive.
> 
> This one is apparently obviated by commit 80424b02d42b ("efi: Reduce
> the amount of memblock reservations for persistent allocations")

... and it turns out I mis-merged it in tip:master not realizing this 
connection (hence the pull request) - so good thing that Ard warned about 
this and you double checked it!

Thanks,

	Ingo
