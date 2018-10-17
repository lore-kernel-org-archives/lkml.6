Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B708CECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870A321528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870A321528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeJQXeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:34:10 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40058 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeJQXeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:34:10 -0400
Received: by mail-qk1-f196.google.com with SMTP id a13-v6so16736499qkc.7;
        Wed, 17 Oct 2018 08:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XtqOi9bO2GYWQ15t2HKZ3ytuZ0JilaZMq8xk0e0v3mk=;
        b=AaOMVU8AVJ4CGIPbgD8je9nBcTnG+DwQcwudPK5Iw98TUMioQfaLJLspVufsAHlz+I
         ScamkAl8ScH0Wr3+Jlno9DWdQM7DMKlOfvTNEIT0ZnKC+pB422Ypj4161DROmjz92fUG
         V1YOQuDTg0RPjJJtjaAIx0xFMWTcpyaOSmXVTdvpJO1FMqyv9ENh11nPzmQW/ERUNi8/
         C0g1OD7acO+QYWhQaEOF82NC2iD4kkQ8nE0zy8HpFyIhju8SCX5dPZN2l1tmo6weqg0G
         M4gLbDXX+VKEJ6WnTsqGN3kjpmr6THzWCidiEBPNmwHupnnk1sicV06mMISQXDdp0uqZ
         HP4A==
X-Gm-Message-State: ABuFfogOWbiEmC7WtVbyek3EL0Q8Q04CX+gSzFC5LzwqlYQ8slTw9FZX
        EFEpL9WufeILmuoG3rSvxz82hNpl8Ugi8nZEEPA=
X-Google-Smtp-Source: ACcGV63S/Q9gNd6Og3GlbIiiSTf67X2ApeG1tltng5Zp4hSqLVTTCwbf+mnOMWa/JuHfwaROsP7cC2RfVQtevxi4Dbg=
X-Received: by 2002:a37:2b66:: with SMTP id r99-v6mr2922212qkh.343.1539790674450;
 Wed, 17 Oct 2018 08:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <1c0d8cddcdf15e5f397b3e42b76461e97d6e34ad.1539655732.git.ren_guo@c-sky.com>
In-Reply-To: <1c0d8cddcdf15e5f397b3e42b76461e97d6e34ad.1539655732.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Oct 2018 17:37:38 +0200
Message-ID: <CAK8P3a363-ucdqEtrkUah9NPrFtQV6eH=4G3fcQtHMyMStME5w@mail.gmail.com>
Subject: Re: [PATCH V9 14/21] csky: User access
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 5:05 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> The patch adds "user access from kernel" codes.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/csky/include/asm/uaccess.h | 416 ++++++++++++++++++++++++++++++++++++++++
>  arch/csky/lib/usercopy.c        | 262 +++++++++++++++++++++++++
>  2 files changed, 678 insertions(+)
>  create mode 100644 arch/csky/include/asm/uaccess.h
>  create mode 100644 arch/csky/lib/usercopy.c

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

The 64-bit __put_user() is usually what everyone gets wrong, but
your version seems fine. Also the access_ok() checks and
the copy_to_user() result value all look correct.

        Arnd
