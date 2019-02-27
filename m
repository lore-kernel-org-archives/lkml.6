Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2898C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCE1218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551229331;
	bh=aY8zCiSVr0bCiWxSgoiGBxDAl2+UJsTdtm2gTylSijg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fPvyX54u1zdcGsixMQJGchwSp8obrlTOj+Y3/QAt2o7CyhzijUuamGgE3LKpFTtdM
	 vGCqbGcHRd6rWq3qJagzfu7XBcd++Jkyssx03l2ormP5LVhGIMt51gfqg09sFfsbHH
	 9JhwYbQpBJywSKA8dm0xvKWaKLEnijvoOoffbNtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfB0BCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:02:10 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39222 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfB0BCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:02:09 -0500
Received: by mail-lf1-f66.google.com with SMTP id r123so2777912lff.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 17:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dTWiQIjZa8MYJDy9Rh9AX3cmmzL+saaM2HZk5Dzsfsc=;
        b=dxhTDwSPr4ot8OEjG65VC45kFflF8Raa+vcYkoULQhsqgYagCRrBQzVU9CnHrhQj69
         MCPp8VVpUwZyDVpJs2IFU2vP0ungscKYkBNeNshF7SPXHQaja8vjOmludNG8dUnT/4x2
         Nn8RCRycShziD1e22+akRf7vB+6yLqo/Tjn1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dTWiQIjZa8MYJDy9Rh9AX3cmmzL+saaM2HZk5Dzsfsc=;
        b=eHM+sFkx7aJ1RExDQzQElBCLYf+k1uSLhIR0gUTIL307ZnhuqxYrdp3YnclXXvSmIu
         B3pQ93VpFSWGkfMslVerE88A0md6a3AISlDMhWu09ZOYPGi74oSmJutHMJb7AY5zQFLr
         ujODhUnZSoFT+m6EeMMJrMjyn5sbkwIl5/Q8pEL7Kpsg3xkouWh+RyyyekNBhuLR//G1
         cqfX6/3M5guSAB46WkYM0QHL5+jBbujUaftY2H039eSCNVo+FCIwe997khpbjhejxxj3
         M5SctwWg0ejs+V3Je3SK080cEcfuzY51ZxS2WAinyaDVnUjf8QYlcb8XTqYHVxMLoaM5
         l1gw==
X-Gm-Message-State: AHQUAuZ+hpi12QKLSiRvZ+PsVUvL/2ktTYHuWUPAU6jkxJjbY23jPa16
        vrlxWGCyhxgp6/e6wGzhixpleY3KQ4E=
X-Google-Smtp-Source: AHgI3Ib0k3/OWlu3JCuv7R3w0Ocb+3jCucOSLvu/daRJjXRLDfnBCqz3hjWwulFSojHjgbiQGi3GFQ==
X-Received: by 2002:a19:c616:: with SMTP id w22mr14443873lff.31.1551229326693;
        Tue, 26 Feb 2019 17:02:06 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id y2sm3221066lji.46.2019.02.26.17.02.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 17:02:05 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id p1so11129891lfk.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 17:02:05 -0800 (PST)
X-Received: by 2002:a19:c744:: with SMTP id x65mr5771326lff.148.1551229324988;
 Tue, 26 Feb 2019 17:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20190222010502.2434-1-jonathan.derrick@intel.com>
 <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
 <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com>
 <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
 <20190225155501.GI10237@localhost.localdomain> <b35ebf928ed743cca6649a191c76957b@ausx13mps321.AMER.DELL.COM>
In-Reply-To: <b35ebf928ed743cca6649a191c76957b@ausx13mps321.AMER.DELL.COM>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Feb 2019 17:01:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgRdATtsBzo-LDkWn_sW-PJvq95SahZcsTxxDMPzLWxKA@mail.gmail.com>
Message-ID: <CAHk-=wgRdATtsBzo-LDkWn_sW-PJvq95SahZcsTxxDMPzLWxKA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
To:     Alex Gagniuc <Alex_Gagniuc@dellteam.com>
Cc:     Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, mr.nuke.me@gmail.com,
        Christoph Hellwig <hch@lst.de>,
        Jon Derrick <jonathan.derrick@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 2:37 PM <Alex_Gagniuc@dellteam.com> wrote:
>
> Then nobody gets the (error) message. You can go a bit further and try
> 'pcie_ports=native". Again, nobody gets the memo. ):

So? The error was bogus to begin with. Why would we care?

Yes, yes, PCI bridges have the ability to return errors in accesses to
non-existent devices. But that was always bogus, and is never useful.
The whole "you get an interrupt or NMI on a bad access" is simply a
horribly broken model. It's not useful.

We already have long depended on hotplug drivers noticing the "oh, I'm
getting all-ff returns, the device may be gone". It's usually trivial,
and works a whole lot better.

It's not an error. Trying to force it to be an NMI or SCI or machine
check is bogus. It causes horrendous pain, because asynchronous
reporting doesn't work reliably anyway, and *synchronous* reporting is
impossible to sanely handle without crazy problems.

So the only sane model for hotplug devices is "IO still works, and
returns all ones". Maybe with an async one-time and *recoverable*
machine check or other reporting the access after the fact.

Anything else is simply broken. It would be broken even if firmware
wasn't involved, but obviously firmware people tend to often make a
bad situation even worse.

              Linus
