Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE84CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 06:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF1C2173B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 06:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CIgeKqvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbeLXGbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 01:31:02 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51180 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeLXGbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 01:31:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so10440398wmd.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 22:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ytmBAISAr+PKbXGgvB/ac4sbCh3VBG1GAjJobOStGXU=;
        b=CIgeKqvxt+8QBrhEIeoGyFtXtwoYBsKuqy1e89amYP2XEV9fk/AU+GbzVJx7keuLRx
         99saQ+jxUCB1S+fnNFe7Epm0bVTBqYNNPiVTIZJzBQXHKU/pvDnU+7iWI0rd9m54xGX3
         Mu+ZfM9OXKE7nVw/QcHV8NKqHLq6TLkq7nkNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ytmBAISAr+PKbXGgvB/ac4sbCh3VBG1GAjJobOStGXU=;
        b=BgJFWujQRqjH/UMPEO6dOp69xyvNQOhoNKYZaIGkUClffiH+5wxj480eBTd47aXcow
         dpuMA9BP3M0xghP74zddyPXoH++YdZMLDJ7MS78V3JOa9Dh0c12XVZzxyO3Uo0s8DV1X
         6bJRVPQzwUsnzkULFQQ+/wMu1B5UqgF/kEqcodX9OJak5nstTFAnLHfB2q0UazwZq3Um
         aS+vMDHB7wx9DmbfrZpxYiTYXjtyrwuUscqnb1K1j5wcl0t5McJ6a/b4xzK60IUhsDM/
         05osmzLrVpx4L/7Wz+8AQC9sTxipNZPLaLlyrwgfa4IVr7rpb0fz8kYuCHW75WPPF77r
         H/Xg==
X-Gm-Message-State: AJcUukcvB3uH5HSlGSu2QfJ1brVPNO50+Z+AtRjeRMsd5o40z/Qd4Y0F
        JgL88aSvY6rG2In3tT527uMKJA==
X-Google-Smtp-Source: AFSGD/WD3Bpk1XhXRGT826kyWvyxloUO14dL5OuxoF1eRaszVV1d+8vKmqtZw8Jbfb3PxwGjo92AVg==
X-Received: by 2002:a1c:1f54:: with SMTP id f81mr11762199wmf.6.1545633060427;
        Sun, 23 Dec 2018 22:31:00 -0800 (PST)
Received: from dell ([2a00:23c4:49ca:fc00:514b:a89a:f1e2:7949])
        by smtp.gmail.com with ESMTPSA id h131sm23585548wmd.17.2018.12.23.22.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Dec 2018 22:30:59 -0800 (PST)
Date:   Mon, 24 Dec 2018 06:30:58 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Joe Perches <joe@perches.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Trivial patch monkey <trivial@kernel.org>,
        Andrew Morton <akpm@osdl.org>,
        kernel list <linux-kernel@vger.kernel.org>, tony@atomide.com,
        daniel.baluta@intel.com, andrew@lunn.ch, baolin.wang@linaro.org,
        rteysseyre@gmail.com, javier.martin@vista-silicon.com,
        sandeep_n@ti.com, dmurphy@ti.com, juhosg@openwrt.org,
        andy.yan@rock-chips.com, robdclark@gmail.com,
        srinivas.kandagatla@linaro.org, steven.eckhoff.opensource@gmail.com
Subject: Re: [PATCH][trivial] fix email address quoting in MODULE_AUTHOR()
Message-ID: <20181224063058.GA4846@dell>
References: <20181223192719.GA31367@amd>
 <b80c5fcd621e19255f824acb521984dbf845b9ed.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b80c5fcd621e19255f824acb521984dbf845b9ed.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2018, Joe Perches wrote:

> On Sun, 2018-12-23 at 20:27 +0100, Pavel Machek wrote:
> >     
> > Apparently it is quite easy to forget ">" in quoting of email
> > address. This fixes it.
> 
> It's good you do this, thanks.
> 
> Please use git diff --stat -p when you produce these
> or git format-patch so there is an easy to read list
> of files modified in this patch.

`git format-patch` & `git send-email` is preferred.

I would also suggest that you split this up into patch-per-subsystem
set for easy merge, since there aren't *any* dependencies between
them.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
