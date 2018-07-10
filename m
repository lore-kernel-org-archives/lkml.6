Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9897AC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421702098B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjCixFp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421702098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732347AbeGJVdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 17:33:11 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38171 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732261AbeGJVdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 17:33:10 -0400
Received: by mail-lf0-f67.google.com with SMTP id a4-v6so19549024lff.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 14:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=1LDw0ugQr0gRltouCqEWLhiI3f2z4BWp/qJAH+/YQn8=;
        b=YjCixFp4A6dzuSqz9Sb3q6gEwJLVmEiMuLKjeP+Hkj3AqHKBoKdQ+iik3HqB/X4JoT
         MMrpbc4n4iC3aIBiJiABseoFKL7u9D9CQWdizx11umxYq8Nb8kqxfB6c7nuYrOhXEylH
         wTuu9jpPmjzPCzUQ9MLYWxTezWFYmkC+OZE7QRdzuaws75mujhYqxV5o9EIWk0kGN8xS
         pTnPOtYQX2Do3yg6/IjvlWtkf9bhHEI0W24A1Rkfc+FKBYjL36oY2kB957MnGNSNkA2h
         OwPNqVTBE/tTLzhDUjZat+2a5azSJJTP5CHvMO+XQlU3quNp4Eq8BROeQ8g0k8OJ1wwH
         /OWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=1LDw0ugQr0gRltouCqEWLhiI3f2z4BWp/qJAH+/YQn8=;
        b=iAf8Lrn8Vuc0IWZ8MUH1qDyMEB61BGhMOuEh1p7B1SkQx91tL/LewrzcVwyBXessb8
         oZUg/aL0ruo73cmS5H24ILVmWjHm2HRmw1jnqZ+hWUnucMjQFusyTg/0YKXeSNScHfEh
         E+9kspamVxBBDcyVnDOxnl3zu0TxRlxtDiedYp4vI03492vQ6vE6ozm8GakXv1p3+oSO
         tzCGk8mB4yZ6Cn6WbHGgOLECOWzt22W6lEgxYW9wPAScGnCa0nwq96GapifNGqXHhHsP
         4Pak6ZtS69c+k3i7IJbHbuJ3JZkBuKP1J3xCKw1sB+aLoypAPLubjfAJ85wszt1SgRqh
         hsOg==
X-Gm-Message-State: APt69E2/UaUBSLfSh0qWd+tKPjXHNEhydtnSWUzGITfcBhD1lEeJzKLd
        6cyq1fsS7aKGyhbp+jZriXIOI22uXhZqHitRdKI=
X-Google-Smtp-Source: AAOMgpcDLZ0FlbvN09+lqu8Sv7D4MSqKl86xLhQtUorMaIbxRWDOX6GTYyokrY4tW75mCsu6v3cjKVhgAxzG41kcBMY=
X-Received: by 2002:a19:b24e:: with SMTP id b75-v6mr3744109lff.11.1531258330349;
 Tue, 10 Jul 2018 14:32:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 14:32:09
 -0700 (PDT)
In-Reply-To: <20180710175337.GD10177@arm.com>
References: <1531145985-3747-1-git-send-email-will.deacon@arm.com>
 <1531145985-3747-3-git-send-email-will.deacon@arm.com> <20180710175337.GD10177@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 10 Jul 2018 23:32:09 +0200
X-Google-Sender-Auth: azddYtRkqgfinPPZSdjrEMCz9l4
Message-ID: <CAK8P3a2oz0o+gi4W7OhU-2_55Kfk35MuHzhv+CgGAEWtWKF=0Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] asm-generic: unistd.h: Wire up sys_rseq
To:     Will Deacon <will.deacon@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>, peter.maydell@linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 7:53 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Arnd,
>
> On Mon, Jul 09, 2018 at 03:19:44PM +0100, Will Deacon wrote:
>> The new rseq call arrived in 4.18-rc1, so provide it in the asm-generic
>> unistd.h for architectures such as arm64.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>> ---
>>  include/uapi/asm-generic/unistd.h | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> Please can you Ack this, so I can take it the arm64 tree?

I just checked again that this syscall is compatible with
compat mode on all architectures that need it, so the
addition is safe.

Acked-by: Arnd Bergmann <arnd@arndb.de>
