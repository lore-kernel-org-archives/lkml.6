Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5478DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 16:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189FA21871
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 16:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DM81vOjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfAAQ4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 11:56:17 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46999 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfAAQ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 11:56:16 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so25350865ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 08:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4ZV9vRNCNAmFUnR6fwDcAXfnV7vxR8zwb/FEVRXMrqI=;
        b=DM81vOjJeBk2tdqciXTtuugI09M219TXY1Czava3aXH5Mh2y8lsd0R7h49nOBN6NVB
         NO6V19m8ebZSucguorKfsS7sefMlV25tCrnMGQO7IQahWmCiXvSf7HPfS7HT2SXFp+95
         V3f8/j7IrmBr3uCOCbItXbBm3uKC4TRFd6nqVVco54xi6lK3khM7Lt2CK0SUA2RAkHEF
         rreBbKvoyHkU3OxgkDzkUHNH5XbQBrBPvEGMO+m2KBKnwSE5K4sL0q052KPXEO8lkJ3k
         85mqUIyHV1kuix9Qg95edYIRwbngQSjkqHu58dS+fCgRjQxKzvT/bBZifGc0Rqz77TlM
         wONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ZV9vRNCNAmFUnR6fwDcAXfnV7vxR8zwb/FEVRXMrqI=;
        b=FWZe0wRs+WDBTK3d5EU7OE9CQ+O5310QgAV0YD33AWTxyAxFEzAEriF/n0O1vxjUcp
         sL0IhHDBmw5JUh/u9td/8Xy1p7CTvcZ79wa4teKNNWE5KzaM0zWRYgS/zFJXn47wIL2F
         X5gZR1K16eFFxBDox3FFia+F6ILQNREn2hD49XFqsC2JWlEIbC/XNm6n6hPwatYH4foZ
         2SJKbLxTj0GfWIjZD2fc4EBBmjvsUSwUYLyqGoTtqoBHRc3MEFUJPou5qPIl3XSFEjsw
         IsMsYWN4Tp3EPSAOpxo3fxRp+OCp2/t6HYNTXmnuz+2VXsjI6SD2rlsSYCkTeb171lhf
         EDZw==
X-Gm-Message-State: AJcUukdOyQTLy3EPiDSY9BrxQj9vEN5iTCyrVzT3GRfbTzyEJrYjWm6I
        6UfIAPUHTtUzlxxQvQG2FXA=
X-Google-Smtp-Source: ALg8bN45HAGxAh9Y9+6b52UpieI4ZUaLj06xda6f8x2x/7DqTG4D3gudXRNBNuw+kRO7y/qrHkMRRw==
X-Received: by 2002:a2e:8256:: with SMTP id j22-v6mr23444448ljh.40.1546361774345;
        Tue, 01 Jan 2019 08:56:14 -0800 (PST)
Received: from pc636 ([37.212.194.0])
        by smtp.gmail.com with ESMTPSA id x29-v6sm10748139ljb.97.2019.01.01.08.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Jan 2019 08:56:13 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 1 Jan 2019 17:55:57 +0100
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC v2 1/3] vmalloc: export __vmalloc_node_range for
 CONFIG_TEST_VMALLOC_MODULE
Message-ID: <20190101165557.z2ocf6fmjzh73dyp@pc636>
References: <20181231132640.21898-1-urezki@gmail.com>
 <20181231132640.21898-2-urezki@gmail.com>
 <20181231185022.GC6310@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181231185022.GC6310@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 10:50:22AM -0800, Matthew Wilcox wrote:
> On Mon, Dec 31, 2018 at 02:26:38PM +0100, Uladzislau Rezki (Sony) wrote:
> > +#ifdef CONFIG_TEST_VMALLOC_MODULE
> > +EXPORT_SYMBOL(__vmalloc_node_range);
> > +#endif
> 
> Definitely needs to be _GPL.
Will upload updated variant. 

Thanks for the comment!

--
Vlad Rezki
