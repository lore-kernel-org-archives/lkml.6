Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0B4C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD622082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aHB4LJBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD622082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbeLDUZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:25:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40525 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeLDUZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:25:46 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so8850527plq.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 12:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/ZDhp0fgRT3pNh2H3Gm3zTA8garSUC7ThywMfgEQGUc=;
        b=aHB4LJBCh3YdEf3qLl5TElyJty8vPXnzRjE7npThJLPCmI1qW+ttiCax7wFQa3eZJu
         ed9+4t7etEnHVKH/Kc2ghcGiX5rsvwbe9hz7dbEUDXXoRBomiK00ZCBq6tQYo4l0DYxE
         c039jrVsYUvvHF4YLd6e3vEqOYKMF2JEaEyB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/ZDhp0fgRT3pNh2H3Gm3zTA8garSUC7ThywMfgEQGUc=;
        b=NGvS1pnULkMU455O6GzptAzi3FES6y61Jcci20SDRWuB0dZFgujiiJ7xORpWZ4Tsg4
         nzyJYxenYJmqr8EmLta4FNcWka/TCKR3uiTXiIGls8HD5xb/tgNTKA8MP5dDIT9kE493
         Gw+Wef8ky/X07ZfGpZEC/I+r7bkfZ/bJk5co4rDKkn9O3sw4p0Dxn8Bvao87zoFnoTka
         VxweEYSB6Fb9QgVFSENt6WfdhWtQAZM0s/aOIQJabEqa/kaT4BSf84O1dYO4YIy09o5x
         cQdKYOPK9IInIenjhiAAqQTkmIMTmAWrAHpnFJkXehYPrBmG/mcVtBsgIAoc7yL/Bgcb
         q4ww==
X-Gm-Message-State: AA+aEWbeqm9xxUF8VT02nR2uedtajxsY/HkCqZaoSpbjp8QAoSBsICq3
        +9EO4z5RJVjUI+JANwlLxBHt+w==
X-Google-Smtp-Source: AFSGD/WQrRqU6wc9MRVODF5QUOa/QFdiHqJRCUqVSaMwDdNON+EuG+hrB+r2iR8p9NJU9DIg4yLFcg==
X-Received: by 2002:a17:902:7b88:: with SMTP id w8mr21173964pll.320.1543955144987;
        Tue, 04 Dec 2018 12:25:44 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h8sm26511537pfo.162.2018.12.04.12.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 12:25:43 -0800 (PST)
Date:   Tue, 4 Dec 2018 12:25:41 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v2 1/3] clk: qcom: gcc-msm8998: Drop hmss_dvm and lpass_at
Message-ID: <20181204202541.GC12886@minitux>
References: <20181203183330.2073-1-bjorn.andersson@linaro.org>
 <20181203183330.2073-2-bjorn.andersson@linaro.org>
 <2f21e657-76f1-a05b-7861-11d7a5f1ea5d@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f21e657-76f1-a05b-7861-11d7a5f1ea5d@free.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04 Dec 06:37 PST 2018, Marc Gonzalez wrote:

> On 03/12/2018 19:33, Bjorn Andersson wrote:
> 
> > Disabling gcc_hmss_dvm_bus_clk and gcc_lpass_at_clk causes the board to
> > lock up, and by that preventing the kernel to boot without
> > clk_ignore_unused.
> > 
> > gcc_hmss_dvm_bus_clk is marked always-on downstream, but not referenced,
> > and gcc_lpass_at_clk isn't mentioned. So let's remove them until they
> > are needed by some client.
> 
> Hello Bjorn,
> 
> What about gcc_gpu_bimc_gfx_clk?
> 

The ufs clocks was updated because the ufs driver would fail to enable
them and by that fail. But I have yet to research what the appropriate
solution for this this particular clock is.

> AFAICT, it doesn't lock the system up, but the kernel warns:
> 

Right, so it seems to only be an annoyance for now. Let's revisit this.

Regards,
Bjorn

> [    2.171148] ------------[ cut here ]------------
> [    2.173740] gcc_gpu_bimc_gfx_clk status stuck at 'on'
> [    2.173996] WARNING: CPU: 3 PID: 1 at drivers/clk/qcom/clk-branch.c:92 clk_branch_toggle+0x190/0x1b0
> [    2.183475] Modules linked in:
> [    2.192554] CPU: 3 PID: 1 Comm: swapper/0 Tainted: G S                4.20.0-rc4 #23
> [    2.195509] Hardware name: Qualcomm Technologies, Inc. MSM8998 v1 MTP (DT)
> [    2.203389] pstate: 60000085 (nZCv daIf -PAN -UAO)
> [    2.210016] pc : clk_branch_toggle+0x190/0x1b0
> [    2.214781] lr : clk_branch_toggle+0x190/0x1b0
> [    2.219213] sp : ffff00000807bcf0
> [    2.223609] x29: ffff00000807bcf0 x28: 0000000000000008 
> [    2.227041] x27: ffff0000089db070 x26: ffff000008961378 
> [    2.232425] x25: ffff0000088da4b8 x24: 0000000000000000 
> [    2.237721] x23: ffff000009138a08 x22: ffff000008414990 
> [    2.243016] x21: 0000000000000000 x20: 0000000000000000 
> [    2.248312] x19: ffff0000090e9000 x18: ffffffffffffffff 
> [    2.253608] x17: 0000000000000000 x16: 0000000000000000 
> [    2.258902] x15: ffff0000090e9648 x14: ffff000089193187 
> [    2.264197] x13: ffff000009193195 x12: ffff0000090fb000 
> [    2.269493] x11: ffff00000807bcf0 x10: ffff00000807bcf0 
> [    2.274789] x9 : ffff00000807bcf0 x8 : 6e6f27207461206b 
> [    2.280084] x7 : 6375747320737574 x6 : ffff000009192c89 
> [    2.285380] x5 : 0000000000000000 x4 : 0000000000000000 
> [    2.290676] x3 : ffffffffffffffff x2 : 00008000f5251000 
> [    2.295971] x1 : e0dbf26541ede800 x0 : 0000000000000000 
> [    2.301272] Call trace:
> [    2.306491]  clk_branch_toggle+0x190/0x1b0
> [    2.308705]  clk_branch2_disable+0x18/0x20
> [    2.312890]  clk_disable_unused_subtree+0xc4/0xe0
> [    2.316960]  clk_disable_unused+0x3c/0x130
> [    2.321736]  do_one_initcall+0x5c/0x180
> [    2.325745]  kernel_init_freeable+0x198/0x244
> [    2.329469]  kernel_init+0x10/0x110
> [    2.333942]  ret_from_fork+0x10/0x20
> [    2.337257] ---[ end trace 57f62b628c127ef8 ]---
> 
> 
> Regards.
