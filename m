Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47348C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115C9207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dUfRMq5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115C9207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbeJWT6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:58:14 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:35605 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbeJWT6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:58:13 -0400
Received: by mail-lf1-f44.google.com with SMTP id d7-v6so859141lfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 04:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lM5nwY/tgT8WNyrCcF3somnqKe5F7iGrBfSe7NCOgu8=;
        b=dUfRMq5GyutSF0nndGOX0T2QFYP+dHMJ17CnA2iVQ0LXyRzUqkmPvjofj9OtwsPKxx
         hp6bcOWOGKIIhhAfr+OSj8Cb/rYzvlcjsQSjGaKofPv9S/WeE/yejaS612+solzPuBEh
         xK34uaymoMyTQ7i0xfCjsoY28sP4Gqr7EwG/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lM5nwY/tgT8WNyrCcF3somnqKe5F7iGrBfSe7NCOgu8=;
        b=AAjqI907oFogDonvec51VnkcFAbKcFuHcSf3yP4Ssr8/gFKomcespRP241BVSkpMTq
         6cdRdNzKkJDVZZKQy/EMssT2EFDqnQCdWdS4/9tMnszetZv/kKuoRfIDNKY1cwENMKbo
         ewgGprAF7DeYDMU8NG5mfPIFO+hdqtR+X6hDP6nnod9UQZl4OKuteJ+UvmBLEnhV838G
         9YNA1h+EYww5F6/qA3iZNb87GZQP4lGYIQ/58SyWYFIxJ+O2pNqWIXBLU9AEJROTh7X4
         eDRuvDs0ncd+GJZA27JpDzMAXToainzRSXG377mHMrS5NQVGtFUDm9nmertSPA2qTe+W
         NoKQ==
X-Gm-Message-State: ABuFfohtBLQWeeoxyFGEVB604o94pK6vlqiTDCaD/oWV16luhXAvu94C
        LFtI7Z7WRW6fxcYhdimxGsQw5HgOLIWH7zl9
X-Google-Smtp-Source: ACcGV607CA6M4KpLmegCg8TH6hP5ch5RSuQ/H+s4XKP3Kpy2YAkIsCYk3AM5jYdhdsX49N7gJbOaAg==
X-Received: by 2002:a19:8c1a:: with SMTP id o26-v6mr11715321lfd.90.1540294506356;
        Tue, 23 Oct 2018 04:35:06 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id g64-v6sm174389lfe.87.2018.10.23.04.35.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 04:35:05 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id p34-v6so836438lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 04:35:04 -0700 (PDT)
X-Received: by 2002:a19:288c:: with SMTP id o134-v6mr13045157lfo.124.1540294503873;
 Tue, 23 Oct 2018 04:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181023094800.GA75275@gmail.com>
In-Reply-To: <20181023094800.GA75275@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Oct 2018 12:34:48 +0100
X-Gmail-Original-Message-ID: <CAHk-=wg27Snp1tM6fpP84zdPYWLcwisRBwin=7VtPS_3dcq=vg@mail.gmail.com>
Message-ID: <CAHk-=wg27Snp1tM6fpP84zdPYWLcwisRBwin=7VtPS_3dcq=vg@mail.gmail.com>
Subject: Re: [GIT PULL] RCU updates for v4.20
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        paulmck@us.ibm.com, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Greg KH <gregkh@linuxfoundation.org>, tglx@linutronix.de,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 10:48 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> Please pull the latest core-rcu-for-linus git tree from:

I have now begun pulling the "Ingo series". Just FYI, I'm not going to
send "Pulled" emails for all the individual emails as I get to them.

                Linus
