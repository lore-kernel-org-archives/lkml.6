Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DBCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1612245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="fF+4mxuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1612245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbeKMEW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:22:27 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36927 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729730AbeKMEW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:22:26 -0500
Received: by mail-lj1-f196.google.com with SMTP id e5-v6so8504242lja.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 10:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qhbr0DicCnLu+Jvt+3de0FwaRYeiN2sEbimHuaBvChE=;
        b=fF+4mxuJkR2AUUhfUs1729NytTnYGfKTjpYCAnkNNu0Xqu9XrrbfiwNfb0pHAz8LEt
         DyPcgPdOj2BPdeygE912E2aa2VJ4rbIO/7+BfjlaZE9B0zCOZc5sxDYEdNFvdqVCQbi4
         juYlDtulcU0pgdwROXoV4CCniyoVMGAnX72Zf7RgBZhlhWiiZvPyyXJ9PCgWZmGqcy3z
         aDs7Tf5Jx+IY0HLemx3yXcNR9zzPUGs7wvvjB9++LiWk+eKT0Gosrhp7f75tspHKLE7I
         zLS4QyLzSUy/2JejOahJYd00XBOg77q0sJWEH7Oq4sJ+W0P4a1wkYj6HboTeXZoenfwu
         F7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qhbr0DicCnLu+Jvt+3de0FwaRYeiN2sEbimHuaBvChE=;
        b=F5x53YQ9kvTixc3Bl34V6EzL6Hlc0O8IBKVLFBkRQLAu1GWwFrcQtzUQ4q8vqRgYM1
         SalRp6nTRKXbeA/1f2Ss7ocflxZyWlJJ+y+LXXU5KdQNmwkZHLA5VSCstyLY8eNwaOqK
         Xb15vifTD9Kl554qg/fymrFGyevxGxHMdNuezv70xzvHCIP+ePmZ3xxTR7tb7ZMY10oK
         qFgdu8g3uVtnr44Rd8vrShWBSCU01fK9JrTYufbfF8QppqX16WyYvRDd2ydxEElKI6h0
         7uWCxW4MsiPEKF/NnjM/XMA6HQLBKeCgK7a9F+t1m+Gztnb7bF+ZDqUTKOqM+zu6N3Z0
         BWhg==
X-Gm-Message-State: AGRZ1gIBYd7Zv3QZo8BgqGSM/+4JL3uguDSrK0wK3I+OHBYLa2IgyQHJ
        qy5BiDXl0LvLWNNB9h4VH5l1Yw==
X-Google-Smtp-Source: AJdET5fk0wDz/9pjRA7wp3uX4n0JwvMWk286AavCXYjF0BhZm2gGYkEaYbr75azLv+Dc8yV/rmxktQ==
X-Received: by 2002:a2e:131a:: with SMTP id 26-v6mr73750ljt.107.1542047280299;
        Mon, 12 Nov 2018 10:28:00 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id u5-v6sm3054255ljh.66.2018.11.12.10.27.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 10:27:59 -0800 (PST)
Date:   Mon, 12 Nov 2018 10:22:36 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Bich HEMON <bich.hemon@st.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Gerald BAEZA <gerald.baeza@st.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: stm32: debug: add low-level debug support
Message-ID: <20181112182236.s7cs6dol4dmxkp7u@localhost>
References: <1501174209-27550-1-git-send-email-bich.hemon@st.com>
 <1501174209-27550-2-git-send-email-bich.hemon@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501174209-27550-2-git-send-email-bich.hemon@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2017 at 04:50:20PM +0000, Bich HEMON wrote:
> From: Gerald Baeza <gerald.baeza@st.com>
> 
> This adds low-level debug support on USART1 for STM32F4
> and STM32F7.
> Compiled via 'CONFIG_DEBUG_LL' and 'CONFIG_EARLY_PRINTK'.
> Enabled via 'earlyprintk' in bootargs.
> 
> Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
> Signed-off-by: Bich Hemon <bich.hemon@st.com>

Hi,

This had fallen between the chairs it seems. I have applied it to arm-soc
next/soc now, for 4.21 merge window.

It ended up being patched up manually to consolidate the version in
Russell's patch tracker with this posted version, and I tweaked whitespace
a bit. Let me know if I missed something.


Thanks,

-Olof

