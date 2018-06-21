Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA5FC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346FA20846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5pW+xHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346FA20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754533AbeFUK5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:57:23 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52197 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754501AbeFUK5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:57:21 -0400
Received: by mail-wm0-f66.google.com with SMTP id r15-v6so4431966wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 03:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CQPITbkJUf90LDuMxTk4C381WP2kWECAhObazOYvEUU=;
        b=j5pW+xHgwbtAw86Xxs5cB1Wm7eanhUgdQvb37308BVwJ9W2F4u2AG6+BGT+vqZNQW9
         SS97KdWtSixgSMy3GMGG9uCb9pZ3rDG9nsKQS35VQ10WmilG1qyB5ZzwXyHPdecrL45I
         XdsIFem+9ufkqgM6e5QD3MeetXLjWhRSenNOhPd3UPhrh//uLkGKbRlROcbw6P0jcrrS
         yR53d5Xo5vJbj7Ir4DGtgQ0/Sn7rwoKtxXhtD0GEFSgUj7nYt88dsCZfWHtVEPOuU+P+
         ZFUFbwOgY2cHWPxG67AKC3cWyVLprm2uAEw1GDj1Hs0F4fiRPhjF5HWjggEiCMRusWDD
         VKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CQPITbkJUf90LDuMxTk4C381WP2kWECAhObazOYvEUU=;
        b=RVlQG2TRHHxnd+QZLglhVMhXdgYAFW7xFl1B4b4+lQLW/RLnJ8G9xdOFIQ1h/acQyf
         KCl1Ofkas9Lu1srcgDr/wzE+KDjqx7hV8Usx+ic+/flxAl/BCUPA+PdZp2DQlY3ede9h
         zk3frtZTyaQIoeOOXUj6w7LXsGgQL3Dy6Ue1sYhaG87Hyn1TjdqSjga69Km0P0MPNA8Z
         iZ+vf+UNCbm8vwp8XdAfJyeacIBqZ6KWdA/TZyST7WJI84ih1faK6Dwr/SsdFDpFRKI9
         j+UQcIKiCo+XW8Mqgv4J7rPXuEO437edekQtNFST3NAnCwAbpDSMw16DU8sYjjTsiQfn
         lBTQ==
X-Gm-Message-State: APt69E2/NzNqCUz/sfuswYefXUnOQZzp1wiydWiaz8dsQ2k/7flAmfwK
        PTObIumM8RGS8c1BjzfTo6H39w==
X-Google-Smtp-Source: ADUXVKIzUbuwDIIkTQPtZxmsn6d5TSdU0ndnP7rQ3dwvI2regZPr4aJyuKCqROgd7Df0B4OkRYktcA==
X-Received: by 2002:a1c:8f8b:: with SMTP id r133-v6mr4647031wmd.1.1529578640856;
        Thu, 21 Jun 2018 03:57:20 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w24-v6sm3586389wmc.15.2018.06.21.03.57.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 03:57:20 -0700 (PDT)
Date:   Thu, 21 Jun 2018 12:57:18 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Peter Anvin <hpa@zytor.com>
Subject: Re: [PATCH] MAINTAINERS: Add me as an x86 entry code maintainer
Message-ID: <20180621105718.GA31979@gmail.com>
References: <c2394b008adfb6e7480f3b1193386537e96a6a69.1529358034.git.luto@kernel.org>
 <CA+55aFyZm1+eoeiwitrw-aqhSBa+g_LpvWvJAhHpRQ=UTKwtqg@mail.gmail.com>
 <alpine.DEB.2.21.1806201029470.10546@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806201029470.10546@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, 19 Jun 2018, Linus Torvalds wrote:
> 
> > On Tue, Jun 19, 2018 at 6:41 AM Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > > Linus has been saying that I might as well maintain this stuff for years.
> > > What do you all think?
> > 
> > I invoked executive privilege and just applied it. It's just making
> > official what has been practice.
> 
> Indeed. Belated Acked-by-me.

Same here!!

Thanks,

	Ingo
