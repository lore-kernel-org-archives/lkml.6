Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E88C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D384921924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uOqY3eAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfBHHbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 02:31:07 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46688 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfBHHbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 02:31:06 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so1189220pgp.13;
        Thu, 07 Feb 2019 23:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iV2Rbp3l+hI6xVrlNmRRpoa1Z2cO+ueEmwD5bnxk40E=;
        b=uOqY3eATbtPJt2Ba8aGINKT29iQfNm3jKe603Z+nc8zqJI7F5AGACWH6gWkIRa2Sdc
         nXDq5na0e1RvHyI3eLfYlDR339u5kgtOX9YRlACS4uN3Y7naZvc17C6HIxX3rNcbFaIi
         1xJwb5POxMHmfndOTEUx/n/VrBqDiUEbV2NFoOHJEJAQ0wy3mPdDQP4a6E4NEBfFmVxx
         Jn9gR+Axi0t5tXCYXD96MX9fR/n1fgyZXoxKqyd4TfQ3AadrfJpqJGI3uEXDwtqp4GvZ
         bS2HZo66qDzkmfsqDcjAIf+II7ocDdwqYEbXdy6k4s569QMDcC6wEvWFD+A87+HNrMoE
         V8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iV2Rbp3l+hI6xVrlNmRRpoa1Z2cO+ueEmwD5bnxk40E=;
        b=FRtTA6DlQWsWMvcHfgd1SrjB6zSyjVkeN8KwWGil8hHuDvIAykkRR+LkPHdXwe7/Ym
         x7j+yTH0jXXiUPbF35Ut0o/23PiGc4HIaLHG0de3rrn2hi6+3zLdwRUCYRk/bMe0+8qz
         qRstwM5Fdn6fly2yrfNFxAYyx+fw1OxZyB6KDoDZW+EsjvOIAhFTbADudh+oNT3nS0vD
         lJ0CPAt7vZsXJOfxdW12rS4zdLoCCjp/oA3ITpC9EEvmKIt42h7uoNQGRS7i6a1DnSpX
         j9ilwbYRxNhNhHrrWD2SBEYInaO+aHScSAG/MggqziPxgpxveaOwSxaIyJio4CnXuTJh
         U8+g==
X-Gm-Message-State: AHQUAuZZFnKwSROXwW6KGoMGaqFFx4UdFkMmHfyE6AOCQ1TLYH6i42Lt
        aYggBfIIFu7mdBSIhbpHcqw=
X-Google-Smtp-Source: AHgI3Iaer57bgUs0l4yqpB/SG7K6/U9APHgtGGLDvlgXURSZkb9yUWTwXR6sTfDQv6MFA+M4GhRvcg==
X-Received: by 2002:a62:9917:: with SMTP id d23mr2210779pfe.88.1549611065477;
        Thu, 07 Feb 2019 23:31:05 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id a10sm1484583pfi.138.2019.02.07.23.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 23:31:04 -0800 (PST)
Date:   Thu, 7 Feb 2019 23:31:02 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     linux-input@vger.kernel.org,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: ps2-gpio - flush TX work when closing port
Message-ID: <20190208073102.GA31622@dtor-ws>
References: <20190207222740.GA38612@dtor-ws>
 <CAGngYiWzC92Lw+Z-BAtPfEHgys0vcQOxdxo7g_JHKHF36-Hm7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiWzC92Lw+Z-BAtPfEHgys0vcQOxdxo7g_JHKHF36-Hm7Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 06:03:03PM -0500, Sven Van Asbroeck wrote:
> On Thu, Feb 7, 2019 at 5:27 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > +       flush_work(&drvdata->tx_work.work);
> 
> Would cancel_work_sync() be better than flush_work() ?

No, because we want to have interrupt and gpios in a consistent state.
If we cancel then we need to see if we should disable it or it may
already be disabled, etc. This way we know it is enabled after
flush_delayed_work() returns, and we need to disable it.

Thanks.

-- 
Dmitry
