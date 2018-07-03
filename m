Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBBFC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9E5208A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvGU7w1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9E5208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeGCLrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:47:16 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46065 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752251AbeGCLrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:47:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id q5-v6so1280973ljh.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 04:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N0H+5Cnux2S7B9hfOa5H91RvHRE0YC/gGCCeoabzBfQ=;
        b=BvGU7w1//5IsinDXiqh16H97UxFvsFXvJHKdI9prWC6nC9B1vBc/jkcaub70fGME4r
         s3iwsAnD5SQ5aL978NzI9K9XTZcbeT5ERy8W0t+3sAI04ynl8kRBrBiRW0GUH3qQIJRt
         s4L2kcDZxMJmNfPvlSUu/TyU27XtY+14itvyHAg2aQOZFwaHih+KFapye70JgIHuxGXk
         VDsZ9FTgskWrm/RhQ/K/QdVBNmiMs/CJZ/zv0IWEjl+orZgCcNGVxT/5BcdsflONnMj/
         XXD/qZ0TBLKuaIFSn45I6nX2iDu3dYZkoJm9DXSsOe3QQGeconiD/XulsOMeGO0r7NJS
         DWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=N0H+5Cnux2S7B9hfOa5H91RvHRE0YC/gGCCeoabzBfQ=;
        b=WK7/i+hpOmrrnCBdtl9fWb4opEXs5SRt0fFjE6Up5S+snVhQ+XgMrf/tGGz+etBVzO
         Xzhp0ox64W3y5cd+fdKCFtlqWIAcEWRvndbW6iuAmX57cS3mY5cijsVgZxZSkP6qF7m/
         HjsU7NT7N0VqsH/TFj98Iw8oJ5mcTjZdWdP6ORD+CS/N14rAeyEMzXgiW1hLABYl+egF
         pE5AZzUfFZzKqWrxaa31Chn0FP54iig4qbpEJdgTugGpXu4fRKxRc8O0rteI7EjUNCEU
         P+VfdWRq7tKTKCkbVuuEYcoA69CvcvS03zZIxWklzsR4yUm02UXwW4Pe40ytKJ16DHmM
         I8xA==
X-Gm-Message-State: APt69E1I7jASdQ/NEa924tvtB7MIte51DreJ39KoBXgWI/RFB62QM5YQ
        y656/8R/cR0LRAnFmhbY75k=
X-Google-Smtp-Source: AAOMgpeNvjtVV2RJcmYdzd2QK3vrSzVP7GaVjSLwSmFuj8f0xUqC8kUJbygd/X1ZWc/ME9ZqxsR+vA==
X-Received: by 2002:a2e:6a04:: with SMTP id f4-v6mr1649709ljc.109.1530618432399;
        Tue, 03 Jul 2018 04:47:12 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id o128-v6sm216377lfo.69.2018.07.03.04.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 04:47:11 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1faJlv-0008AF-Rl; Tue, 03 Jul 2018 13:47:04 +0200
Date:   Tue, 3 Jul 2018 13:47:03 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] misc: sram: enable clock before registering regions
Message-ID: <20180703114703.GO9802@localhost>
References: <20180703100548.30214-1-johan@kernel.org>
 <20180703100548.30214-2-johan@kernel.org>
 <e736a83f-bdd9-d136-070d-7093f5e8be2c@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e736a83f-bdd9-d136-070d-7093f5e8be2c@mentor.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 01:23:30PM +0300, Vladimir Zapolskiy wrote:
> Hi Johan,
> 
> On 07/03/2018 01:05 PM, Johan Hovold wrote:
> > Make sure to enable the clock before registering regions and exporting
> > partitions to user space at which point we must be prepared for I/O.
> > 
> > Fixes: ee895ccdf776 ("misc: sram: fix enabled clock leak on error path")
> > Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> thank you for the change, however please note that the identified commit
> for the fix is incorrect one apparently.
> 
> In my opinion the proper tag contents would be
> 
> Fixes: b4c3fcb3c71f ("misc: sram: extend usage of reserved partitions")
> 
> I hope you agree to it, also I would suggest to swap the changes in
> the series.

No, I think I used the right commit in the Fixes tag as that was the
commit which moved the clock enable to after the memory-region
registration (at which point the memory could potentially be accessed).

Johan
