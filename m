Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54544C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C9B214C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vNTthPfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C9B214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbeLDIPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:15:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33897 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeLDIPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:15:11 -0500
Received: by mail-wr1-f67.google.com with SMTP id j2so14880717wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 00:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GrvPlTg2darvT1roMVfmrgjxwCHPD2JV89EdUGSvoDM=;
        b=vNTthPfvFuPuv1D6ct6LfQcVLiT8FvLa9bkd/13eAHwvkAfs4LJaD+eaTA9obxO9bc
         0o0Idt0SVaKjSjxGABbnb/xpP/zZGI5KBCmanFHeOhSlrsdWOfYOcdBaXEJpL/1tlamO
         TuC9RQpYCdLIU2okcjilZcWtForwsN9x7JOhX9+OXS0qEJmT1eClXyeCppzeBpLgfgNv
         EcbCCkY/9BN9J6DCIakEvDT6c/22kBzz95n4CprUN3m8ZpbN2m4/sEkXcrTJUKd+q989
         wgiDutFB0Cq9/SVCfoKHZ4DHsSngFwnrUdzgblp85w2tx3Amcl3EYmDTRKI7geApQ/cQ
         PmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GrvPlTg2darvT1roMVfmrgjxwCHPD2JV89EdUGSvoDM=;
        b=EhBrgVT36zl2el32PvTkM8z++KThgrrdYsD6os3FajAK6oPHEo3lMLmNIdtmVyhUUn
         ZYHrGexeMmkemncuIjex6nSr+bKlSNpi5mWL2I/2ohYCWcGqI4UL880H6e2Vg/kxocUc
         1SN7wQzl1gJ36Sw+FwildUoNq/sZcyHIagkLT+cbUVOcz9gpElbXh/4Gx2ez3DO902MP
         470pivBhxdKy5x0OdzcxVTqywCob3FyQlvfNgN1Bmwk7veBQTTYWvlOB+vt2prFKMWn5
         Kyy20eje1pfIOmhjA6TmL0NVgQHkFwkud0VIgrAYo08MMmhaiyAWhNZO3jUBM1mqAzFj
         NgiQ==
X-Gm-Message-State: AA+aEWaSMVgCsjudncvFREqFrK6amH/lSeanx2rCOfaOWzWar7SaT/Me
        XhkT4iRZg7suNMvaV78c4mE=
X-Google-Smtp-Source: AFSGD/UfFTdSVpa5X4su2bm+FJwbOsJPIpI62BY2HqvSVaPR3SsEXQruNwqc9+CTUcogsRnBC6sl2g==
X-Received: by 2002:adf:a211:: with SMTP id p17mr13687201wra.179.1543911309046;
        Tue, 04 Dec 2018 00:15:09 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c14sm5073254wme.13.2018.12.04.00.15.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 00:15:08 -0800 (PST)
Date:   Tue, 4 Dec 2018 09:15:06 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: Strange hang with gcc 8 of kprobe multiple_kprobes test
Message-ID: <20181204081506.GA73770@gmail.com>
References: <20181203211807.17e03384@vmware.local.home>
 <20181204164007.956a3458c9fd301b3d173eba@kernel.org>
 <20181204170229.4442d43ce956d48619c1d232@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204170229.4442d43ce956d48619c1d232@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> I remember I have fixed this, and actually WE did it :-D
> 
> https://lkml.org/lkml/2018/8/23/1203
> 
> Ah, we hit a same bug...
> 
> Ingo, could you pick the patch? Should I resend it?

Indeed: I just picked it up into tip:perf/urgent.

It's my bad: I missed the original submission due to Steve's feedback 
which I mistook as a request for another iteration, while he only 
commented on the reason for the original breakage and gave his 
Reviewed-by ...

Thanks,

	Ingo
