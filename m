Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073B4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B67206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gfCXChxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfAJSsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:48:11 -0500
Received: from mail-ua1-f49.google.com ([209.85.222.49]:46399 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfAJSsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:48:10 -0500
Received: by mail-ua1-f49.google.com with SMTP id v24so3921089uap.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 10:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CgE9CgMkRGRCn2AEhFkh73okLj8D6tjsWaOby0PZoiY=;
        b=gfCXChxEeakZwapks/xNBbfTYCbsvkpBzUVw1n1CLvHksCpOzLnbKfrFq9OMtSG68c
         ixeuDKocWavACqDcPWX8TTgb8KbI3kzH+MWuytc4e7izj2U02Dzt67j2Fx+YdVQlfaQJ
         3f+OhIXFMCcztUDusAS7JLDUjLuCIrRF11BlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CgE9CgMkRGRCn2AEhFkh73okLj8D6tjsWaOby0PZoiY=;
        b=EAQeaBtdW9N0XS21772hn0Y4Eb3fGlT+YqNOjAR7/D9a+7GNggPwFtfsL0v6nm3UmJ
         w5AuUWgcY7e0xrWjwFlfIqoqMW/JPyKhgq7rNYhrgYGt+rQGck1H8G7Hldm6WGbl5Rnq
         /uM6pv+uWA78ArAlEcXM6n6TvnnL/l6kdeLCD7xKlfydEIIrEOYg3FljdFXwM15f0mtE
         No1GwzgFBozffAkKd97udVJx40tBxREdGd4Rqr5NqERppkqKWNbIIKtaa7p2m+BlhuNp
         42qzFxu+Q24okCQ909cEjfUheYlzwXdVyXXGEIsyzVfN9hfmV1z12K14P0VFQQDlB+U0
         GiCw==
X-Gm-Message-State: AJcUukewdI0PEKN1uEpkCJwXRlbMVX8eaxuMu0jwqndzf0ore9lPOrhS
        nD6sBMPGkyT72PU5zzjlskLT2oQn1zU=
X-Google-Smtp-Source: ALg8bN6/JrE323mhYkxZrg7oPCDCJ1a9tVd55as9K8I3+PsMybihim+KQnW6PuP+DmX6cZFTtmbj7w==
X-Received: by 2002:ab0:66d1:: with SMTP id d17mr4388238uaq.89.1547146088026;
        Thu, 10 Jan 2019 10:48:08 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id r130sm36649569vka.55.2019.01.10.10.48.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 10:48:06 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id z11so3927600uaa.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 10:48:06 -0800 (PST)
X-Received: by 2002:a9f:2709:: with SMTP id a9mr4344546uaa.10.1547146086162;
 Thu, 10 Jan 2019 10:48:06 -0800 (PST)
MIME-Version: 1.0
References: <76013c9e-0664-ef5e-b6c0-d48f6ce5db3c@i-love.sakura.ne.jp>
 <20181022134634.GA7358@redhat.com> <201810250215.w9P2Fm2M078167@www262.sakura.ne.jp>
 <20181025111355.GA3725@redhat.com> <b0ac67e6-4279-91b3-0178-3176876abe70@i-love.sakura.ne.jp>
 <20181025121709.GD3725@redhat.com> <20181025130129.GE3725@redhat.com>
 <CAGXu5jJDkt0vR28Rzhi2gmb=9S7BwWkiMuVrN98AOABgngYY4A@mail.gmail.com>
 <20181029122356.GA29883@redhat.com> <20181029150546.GA30959@redhat.com> <0fc3493d-a50e-f386-20a8-28d348c19544@I-love.SAKURA.ne.jp>
In-Reply-To: <0fc3493d-a50e-f386-20a8-28d348c19544@I-love.SAKURA.ne.jp>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 10 Jan 2019 10:47:52 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJqG+UMb8L79rYTGgEN0HALmcmi70KOXrt=CqV0xgzDBQ@mail.gmail.com>
Message-ID: <CAGXu5jJqG+UMb8L79rYTGgEN0HALmcmi70KOXrt=CqV0xgzDBQ@mail.gmail.com>
Subject: Re: yama: unsafe usage of ptrace_relation->tracer
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 3:06 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> syzbot is hitting this problem as of linux-next-20190110.
> When a patch will be proposed?

Hi! Sorry, this got delayed over the holidays. Let me finish the patch
I was working on and get it published.

Thanks!

-- 
Kees Cook
