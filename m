Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4928C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881DA21A80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549887795;
	bh=wK1lF7XwcPKQ4CFczxXPGo4mgyQms5QUaKdRInZ5Ymk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hy8zfJ+ubzefbjjWt5eOKUZ11NMR7EMuPRxvWf21G+WxZ4Yj4h1aWfFyKHFW5jStl
	 2WJj6j071NTPVhU0ik6p3oxGrYkzAKVhSabjCnGAmrn96jm7kSecbfQLp+CMaJv777
	 DZ0SsvAFNub+7JFMwDyyuPhRW4IkcebcGfYS681M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfBKMXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:23:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37116 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfBKMXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:23:13 -0500
Received: by mail-wm1-f66.google.com with SMTP id x10so11624677wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eh/TVc3vwawfZK3+n/VsTq2wbskK3TcfJruKTFJ09/8=;
        b=pttgxhEn4Fgdm5/rjgnK7Q5icBrpDT/5IkmcFmo/+id09nqF0EnUFG3QcBp+p0hJ1q
         CHRp0tMqAa7HFm1rgwTtDu5C7jtBbacnxRG2ajGAk3ecJ6tOBEGGVrl/eWmQw3dpwWPJ
         iRahTV5rQ0hxUvW0oro06QyuhHjeo04lq10ZAxsSWXA7WZXEtRKqjKbYi/YAQxS7bvih
         1qEaS8d4Ioi6ZaK6kf/RumCXd7aDwdafKGD6h7rUdIW6lWt1sLLNBHqdX0v9EFD2rfPS
         xwiPB+yl+5xS+9g2kydB8Oqu7bGtob9SKjmKRBfjK5ojPfAmVJsMBz3Vc3l6j65zTerv
         Qy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eh/TVc3vwawfZK3+n/VsTq2wbskK3TcfJruKTFJ09/8=;
        b=itL0vb/ywWMWH6wjbTl49oNeMWbXcl3uTU4//zYa1B8ruQ/GjjZn/1DbrvF1HXweUK
         OPFrW/YfYaDZRz5dm2gZGKNZFyAsvRUIVQ5Zl7gfoPUGWAOO+QRRnlYJTpzUe781+g+d
         1Rx1oTDRzPcTY3rup9dYl9UvlaOYuWZ/Tyvx1URx4LeK1YbKwbr1MzkwYZr6KV2hUyvN
         SRwj0G80/xvQ/vh9aZ7fLZwzIjJtXllFGdeBLOtoN9h8xdPPXDEI7ByDoF4BkfzBGyIC
         xifWFkIhKj86yUNnaWcl8KWy24E9eWyQklKSUMS/ksMBxbNt/UmlgHJcy3zyyswUyHXY
         qQXA==
X-Gm-Message-State: AHQUAuZ9xkdaxstRms67v5B2met6ExZT6Da/EYuCqEavsJUzA9pbj8UD
        QWhMTg6kxsM7Wz8xaGp/amg=
X-Google-Smtp-Source: AHgI3IZnuz6Zul0+8Aj5t56OGC7jOwt9WIlya8vDHbIy8ndFEqguVRTy/W0Vm8nAT0HL8NFcL0vsxQ==
X-Received: by 2002:a05:600c:2147:: with SMTP id v7mr9561541wml.41.1549887791911;
        Mon, 11 Feb 2019 04:23:11 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z3sm15386338wmi.32.2019.02.11.04.23.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 04:23:11 -0800 (PST)
Date:   Mon, 11 Feb 2019 13:23:08 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     sstabellini@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, tglx@linutronix.de
Subject: Re: [Xen-devel] [PATCH v2 1/2] x86: respect memory size limiting via
 mem= parameter
Message-ID: <20190211122308.GA119972@gmail.com>
References: <20190130082233.23840-1-jgross@suse.com>
 <20190130082233.23840-2-jgross@suse.com>
 <20190211120650.GA74879@gmail.com>
 <bd5863a2-291a-43e5-7633-c84c1026a31b@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd5863a2-291a-43e5-7633-c84c1026a31b@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Juergen Gross <jgross@suse.com> wrote:

> > If PCI devices had physical mmio memory areas above this range, we'd 
> > still expect them to work - the option was really only meant to limit 
> > RAM.
> 
> No, in this case it seems to be real RAM added via PCI. The RAM is 
> initially present in the E820 map, but the "mem=" will remove it from 
> there again. During ACPI scan it is found (again) and will be added via 
> hotplug mechanism, so "mem=" has no effect for that memory.

OK. With that background:

Acked-by: Ingo Molnar <mingo@kernel.org>

I suppose you want this to go upstream via the Xen tree, which is the 
main testcase for the bug to begin with?

Thanks,

	ngo
