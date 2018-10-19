Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DB7C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CB42145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMyJdPwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CB42145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeJSKzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 06:55:12 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41244 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSKzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 06:55:11 -0400
Received: by mail-oi1-f196.google.com with SMTP id l197-v6so25696244oib.8;
        Thu, 18 Oct 2018 19:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CKxY9T2BzjRi5jEeEI3LjDljEdGfMbkYwDfEz44PNWE=;
        b=LMyJdPwaPKE+PIMo/cu1i1zth8TWyu/LQpQHGzkH+zrfAFGCulso1EQhIhpQVS6AA3
         XM0tv7c6RLT3IDWF7N+QHGpUHp/POj8luamZn9aczMBhPt+soclUuWgpqX5T6vWZDdMX
         BFGXZ0n/HWUdS4S9BE6HFMEJhggP3EWIgvBZPkpOdtWeQ48HQ5DOt/i/jmdEu5T8zt/5
         ZGZ69Cjk2JBTwdXkftRfztkabZMBsAt9CKk1tmChAdZee8TmR1YCo7QwXvMIAlz2YUKR
         9a0pqZUNpVXosJ+JyIIgi6tYpnAI6vcWuIW1zZBGuO6VEZQkYGnthLuEQXf3SO7fXImC
         JP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKxY9T2BzjRi5jEeEI3LjDljEdGfMbkYwDfEz44PNWE=;
        b=EixML83H5yT6VjRuve7/3gcZUdGVN9A50aUgBU0IknQwx6S3ykQmsfESMdyFtRPmM2
         BAowAEzsRIAAqg7Dq1kDqez2pe+q4icpf2xfn2rb19ndCq8uGLy+qqVngXPSCpt8OAe4
         SMjlsTXRat51BEoxmwzSYe7H5H0C3bQlZnCvlUKF2FEAvtEkZ7cWM4Sr79Bq2abWAubx
         FVakkQhoHA5ZI+F/hf/e06Y6pAif+PSDt7aAoP/gdpTa2qmJWfUcW7+v/oxhQqF2OhTy
         +GysairpvyVAJOng4Tt1gtDWOeUlJoXoXrCGC5W9HjeF4/Vij47R8HJYVFE7tSuh/+by
         0RWQ==
X-Gm-Message-State: ABuFfogC19SFTWSziup8S769mHRk9utKPBPuHnqO9jj/NADSFAHzOhTd
        q0G1Jw8ssuZ4jMrAG0IeZqbvOg0rVEnxsiAlGH8=
X-Google-Smtp-Source: ACcGV60SI/bA032sMs9p9RebBQ9SLhNf1wlMM1HfQX1feJQh8CVeXGn9E8YQysLlpNPygSWW+COTZJi4fMmwihOa9uk=
X-Received: by 2002:aca:a5b:: with SMTP id 88-v6mr16865020oik.324.1539917469581;
 Thu, 18 Oct 2018 19:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181017000809.GA21292@WindFlash> <20181017081115.GA22535@zn.tnic>
 <CAK7LNASVn7CB5uL9tCtNC2u4Ary5eb-vyiB_sS2ey5AZNweKAA@mail.gmail.com>
 <20181017083126.GB22535@zn.tnic> <CADvQ+rFa=XEuxLb=yPmtJE2QepBNjCVzjEY5urVzCaSF1tJBYw@mail.gmail.com>
 <20181018091606.GA20831@zn.tnic> <CAK7LNAQq7aE_2QYwqei7M9fg8Yen7-ucjz-t2E_hq2xkznKsQw@mail.gmail.com>
 <20181018165057.GH20831@zn.tnic> <CAK7LNAQhbn-qZg_Bywk8rf0+oZhVbDjJ=PtcKGCL+k4Fp-ijSw@mail.gmail.com>
In-Reply-To: <CAK7LNAQhbn-qZg_Bywk8rf0+oZhVbDjJ=PtcKGCL+k4Fp-ijSw@mail.gmail.com>
From:   Leonardo Bras <leobras.c@gmail.com>
Date:   Thu, 18 Oct 2018 23:50:57 -0300
Message-ID: <CADvQ+rHRaoAME=tJBzkTg74K237SNm2hFN8mxFemDwa3CKQibA@mail.gmail.com>
Subject: Re: [PATCH 1/4] Adds -Wshadow=local on KBUILD_HOSTCFLAGS
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Borislav Petkov <bp@alien8.de>, lkcamp@lists.libreplanetbr.org,
        Matthew Wilcox <willy6545@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 11:42 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Adding -Wshadow to KBUILD_HOSTCFLAGS emits another warning in Kconfig.
> Of course, it is easy to fix.
For v2, I already replaced '-Wshadow=local' for '-Wshadow' and fixed this
warning.

> But, I just started to think this option is a kind of harsh...

The v2 it's almost done. You think it will be useful, or should I drop it?

Regards,
Leonardo Bras
