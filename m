Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7BA06C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168C2208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SGJEHlMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168C2208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932940AbeFLD1z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 23:27:55 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42506 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932499AbeFLD1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 23:27:54 -0400
Received: by mail-wr0-f194.google.com with SMTP id w10-v6so22420307wrk.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 20:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XNCVcbdb4Sc+pdW1MdrBwjBgvmtobgmvDr78EelM9mg=;
        b=SGJEHlMoqRzdZaI+T4YGa3vIAXG3Tg32YL7De96k33Y31C/Lr0oAstQ8ZTRJpoMm9u
         TmjXsiR/hRcshUG22PL7JazYB3SS+pkU4DT58xFTk2FsnvADG+OZTTXCsW2tByIS9wz0
         5Rn8Ctc7Ufu3wGTnSoelQe314TMhSV/D9+9Cm4xm0h7eKAbSfi+GBAvVlqiZs8uoLDoL
         o3pCUORdcWvZjUuQc54ldNHw4d7h0vq6eBduceGjDCLMwQg7AGLleDXwGyyLjvi0ACZd
         Wa9Fc6Xk944qLUPmUu8LOjvqwF68TmpCT1UrzfpcZws/iQD3FkA9DbZdgEgtmQNUT9pn
         pzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XNCVcbdb4Sc+pdW1MdrBwjBgvmtobgmvDr78EelM9mg=;
        b=ByDRWEUZjt9xmaGuy/vhUdcdNzTsB/Jdr534epIuiYNJi+Z4pBEV+9bV2ySZgDNSfK
         z9W/bPqKO7E9gdoB+gKYOOipO8xdfnAx1NB6Astb1ox2na6pMmxtaIkfV6r5BjUyC5nC
         WDaRA8ZzZtjgq56AAGYrlvBYPeSId6y0VU6QAvB5I53xRxRKzqSuFY6dEqci3AHawj11
         vt28tETBOrfm+9WQubaP3LsC85PMp9ech/LME/tF48eQiG36G1Kkc2S+obhsvW67gVVy
         zWmGOM0sl84twUTFNYXPmiitaOpdKdjiM9GvHHVHDlIODNSrHIHJDWq+4p8edNYIq2Xr
         W8BQ==
X-Gm-Message-State: APt69E13781ThT1y3Q6m1VdhvCUye8RKznazexYRy9CVL0xxFCY8dKVz
        UgSDjVuOVxEM07EyTXDIIghHJW23SgYWA4wtiFZAMA==
X-Google-Smtp-Source: ADUXVKICrlRSZftg+CzkJ1HEJOsn5okzRzkKOxu+sbHEG1j9DaesMSXNujaKKAyKWaAMmiEAAHkf/TN0AH0puIoBqII=
X-Received: by 2002:adf:b445:: with SMTP id v5-v6mr1091540wrd.67.1528774072836;
 Mon, 11 Jun 2018 20:27:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:f884:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 20:27:52
 -0700 (PDT)
In-Reply-To: <mhng-7a581ed4-d7ab-4188-92e6-3a8002f3c8d1@palmer-si-x1c4>
References: <20180611214822.8539-1-jimw@sifive.com> <mhng-7a581ed4-d7ab-4188-92e6-3a8002f3c8d1@palmer-si-x1c4>
From:   Jim Wilson <jimw@sifive.com>
Date:   Mon, 11 Jun 2018 20:27:52 -0700
Message-ID: <CAFyWVaawEbKmccfRsFiooJeGxX6P4xDXqvWiCyiJnfTAK2g0pA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Fix PTRACE_SETREGSET bug.
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org, Oleg Nesterov <oleg@redhat.com>,
        Albert Ou <albert@sifive.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 5:46 PM, Palmer Dabbelt <palmer@sifive.com> wrote:
> Whoops, that's embarassing :).  I poked around and didn't see this anywhere
> else, so I'm not sure where we managed to obtain this particular pathology.

Comment say it was copied from tile which I think was just recently
removed.  But looking at older copy, tile has "struct pt_regs regs"
whereas riscv has "struct pt_regs *regs" and so tile needed the & and
riscv does not, but only one of the two ampersands was removed in the
riscv port.  My patch removes the other one.

Jim
