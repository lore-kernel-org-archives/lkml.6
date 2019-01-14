Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A581C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174BC20651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="on3iahu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfANTOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:14:21 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:43797 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfANTOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:14:21 -0500
Received: by mail-lf1-f44.google.com with SMTP id u18so80334lff.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 11:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sdb3n8hW+RezyveEVPqgqXLkFpEMEzB1s5elBfxOWkQ=;
        b=on3iahu6vJZCloHdZTQhB/A2g3CLRWf9oqz1p/VCsO6d98gA9FlL0ccauTbDUsXOEn
         pL65RgrycOXwZH6afVk6ZmahEyHmgb/2dI1ZyRnrZEUd9zuabDdOdu74cxX5iTsZRw3V
         Qt/JaVrpPYsxh3tZy4EngcDqkJk+7vxSYxe8CrhQs0f3eDXMI+b4vAzPqjIvAE8hR3WC
         IQ7oszuM95lngOcTwAfvbnwPMJ57BsjtX9LJwgLbV6sGkHlCEqa+aEVxn0RZZo2BHEmx
         Ri1GhJd+MHiqIhKbB8NRrgmn+Y7tA3Mh45wMmBKol0h2vOoQSDCEPDbgoirAniU+Hjg1
         xOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sdb3n8hW+RezyveEVPqgqXLkFpEMEzB1s5elBfxOWkQ=;
        b=Cx4AttIpVuLuhqBt3GzhtsC51GXeVRdClN+TDY44ljoTze31sFqOU81c5ib69/aWh2
         vQp7guPvDMu4MVHov2HsCraFnp3YUR8ztNCaoC11ewnxotPFzkrE7wbtz6Z/2YvPDUHk
         S9kldfz6TW0Xiu1NIlbOEGhGC63EjLOilDBe44//Ead3JS7o+QZFlp+MftwCJycGK1/x
         oJIs/vQISBbUFoiPZAjAhACanBq/QaRGMIfS9I0aCWECK/7u2QVZrHcZ2m0SYQQOZpf0
         sN+icKZqhG0jN3vsr3k+GpPZ2W2px+NzBww6xNVO/WY2z0gkMLeM5GYvSHZlZwUY7rVe
         UkTQ==
X-Gm-Message-State: AJcUukey7i5QTqpuquhQrCs4vbYsQusxyF9X2PTzRcceTyRi5eiKEtoV
        dyaT5hsnYySQBGeu3HrmU5U=
X-Google-Smtp-Source: ALg8bN5kg3/iPY4/tK2XsJJbDL2Oe2J/sU/pKZrtB8t7+U8N53ytSd3cSW6PnwwfZUYlvQMWArkmwg==
X-Received: by 2002:a19:4dd0:: with SMTP id a199mr7282lfb.42.1547493259194;
        Mon, 14 Jan 2019 11:14:19 -0800 (PST)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id q2sm236278lfa.63.2019.01.14.11.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 11:14:18 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 3E35A4608DD; Mon, 14 Jan 2019 22:14:18 +0300 (MSK)
Date:   Mon, 14 Jan 2019 22:14:18 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: xarray: Fix potential out of bounds access
Message-ID: <20190114191418.GG17906@uranus.lan>
References: <20190114184741.GF17906@uranus.lan>
 <20190114190119.GZ6310@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114190119.GZ6310@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 11:01:20AM -0800, Matthew Wilcox wrote:
> On Mon, Jan 14, 2019 at 09:47:41PM +0300, Cyrill Gorcunov wrote:
> > Since the mark is used as an array index we should use
> > preincrement to not access the XA_MARK_MAX index.
> 
> But XA_MARK_MAX is inclusive:
> 
> include/linux/xarray.h:#define XA_MARK_MAX              XA_MARK_2

Indeed, I misread the variable name.

> so we actually want to access XA_MARK_MAX.  Now, we don't have a test
> in the test-suite that fails as a result of your patch, so that needs to get
> fixed.  How about this:

Looks great. Thank you!
