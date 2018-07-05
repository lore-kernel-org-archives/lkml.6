Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B57C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6157F24049
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlB8YKIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6157F24049
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753592AbeGEWR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 18:17:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35762 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753346AbeGEWR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 18:17:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id h40-v6so2286308wrh.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 15:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LlPx6+mZ5UR/YP45nIl5Wb94/1nHvw220o3QLsECQhA=;
        b=DlB8YKIGB9lN91vTsQz5UfWI5SEj8CCQAomi6/9HQ7zc6BE2hgmME9JtUkvomJkYLu
         0MgaZ5b0s6MlVIxdjAnkvcv5Uc9+tR5ybKAn0fIDabdWKLoZFbHP8jAto7LKLGlg64Aq
         77WbDR9EdiaFShelR6o6/+lQWvhDXKujJAGG1jmGGbU/3TBa1IFC7h2tspxtrsRCb00j
         qn0//USuBQNp7mFRhiHnoTH8baNp82lnyVWt09jfg7hqxUSxv0I7gaDVWT2rM4THF5Jd
         YxbLcomYuLL3b0qPhcqmLhzlJXWQnI3K3+PE0sQTtD/ScABNbhZCvMWFKiUgAFn9C2mI
         Ms+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LlPx6+mZ5UR/YP45nIl5Wb94/1nHvw220o3QLsECQhA=;
        b=VsqiQD4po9i/H4fGczG9sA74QfplNngPrKrBswxpqt/F3dwq2+ksczmDZ565SGsnq3
         EWB2SK2LtC4FrrPSgR8LaTtnvclEpCcqtToFmVhqufKBejYHdd5k7XXYHf4wMOeeIhVV
         /A2EpfgpPZR1TV7+yRwwS6nDHRuoBEL4IqqfdF7XN4pzASS9ZtTxSOTgqA6XV8Oj3Whn
         I0XzGmp5EJxwTnlNa6QaJGNfVnxedcgeiYxwKdg3DldKDPYGHikH0kPfVrm+AvnJf7wT
         /lvFP4yiqnOklOnu9fmLruJq4z3YDA+4bg4FmKOhEOVV22Ckv76Xv1bMS8irfkQYa2RE
         sRbg==
X-Gm-Message-State: APt69E36vapp5xVuBezG64fxcEpDXo4eO31oe39HjXtZwVgXatF8UWBu
        H+LG5iJr2VOIx2gR08dgEiI=
X-Google-Smtp-Source: AAOMgpedztbfxORQR/+rxAOvt+qk2GIjYK/SQVicO8p8QwawIexRobQRJ4BDae7haIzqcWc2RzhbZA==
X-Received: by 2002:adf:f9c9:: with SMTP id w9-v6mr5622895wrr.105.1530829077365;
        Thu, 05 Jul 2018 15:17:57 -0700 (PDT)
Received: from debian (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id k188-v6sm10089320wmd.47.2018.07.05.15.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 15:17:56 -0700 (PDT)
Date:   Thu, 5 Jul 2018 23:17:53 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Matt Turner <mattst88@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Sergej Pupykin <ml@sergej.pp.ru>
Subject: Re: [PATCH] parport: Add support for the WCH384 4S multi-IO card
Message-ID: <20180705221731.fsrkt5zu453zs3b7@debian>
References: <20180526193523.3896-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180526193523.3896-1-mattst88@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On Sat, May 26, 2018 at 12:35:23PM -0700, Matt Turner wrote:
> This Multi-IO card has one serial 16550-like serial connectors. Here's
> the lspci output, after this commit is applied:
> 
> 01:00.0 Serial controller [0700]: Device [1c00:3470] (rev 10) (prog-if 05 [16850])
>         Subsystem: Device [1c00:3470]
>         Flags: fast devsel, IRQ 16
>         I/O ports at e000 [size=256]
>         Memory at f0100000 (32-bit, prefetchable) [size=32K]
>         I/O ports at e100 [size=4]
>         Expansion ROM at f7d00000 [disabled] [size=32K]
>         Capabilities: [60] Power Management version 3
>         Capabilities: [68] MSI: Enable- Count=1/32 Maskable+ 64bit+
>         Capabilities: [80] Express Legacy Endpoint, MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Kernel driver in use: parport_serial
> 
> This card was already added to the blacklist of 8250_pci.c in commit
> 72a3c0e4e662 ("tty: Add support for the WCH384 4S multi-IO card").
> 
> Cc: Sergej Pupykin <ml@sergej.pp.ru>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
> It looks like CH355_4S is similarly missing, but I don't have hardware
> to test.
> 
> This commit makes me wonder if I'm missing something -- how could
> anything have worked after commit 72a3c0e4e662 without support in
> parport_serial?
>

Is the patch still needed to be applied? After Andy's patch to tty tree,
the device (0x1c00, 0x3470) will be probed by 8250_pci.c.

--
Regards
Sudip
