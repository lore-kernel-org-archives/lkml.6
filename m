Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210E6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64122080A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DMKlEP2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389001AbfBNR7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:59:40 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40038 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730119AbfBNR7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:59:39 -0500
Received: by mail-lj1-f196.google.com with SMTP id w6so1274030ljd.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 09:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1jkg1HtRKb6eeVoTIpsSIkPKOayQCEyaaF1jv8lXRM=;
        b=DMKlEP2iHxxo+fiiyrO5gPf7jg9ycsk+KUBwKF5pZzz/vS10hK9zWFkUOs/eMxa7G/
         FsJWPD9FNCLlhoVMjqRrIteWuykwVGGEMRc/4cCK3DenY2ZXmnip0JLO8IszFtKhti6s
         J9++vLKH5lCIMJnv1IactNuq4IvAGv9cScq1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1jkg1HtRKb6eeVoTIpsSIkPKOayQCEyaaF1jv8lXRM=;
        b=SVWNSK+NNpqxqNWxFgZl12MOiyJDLCR1yRmyagwR+DmoUO4DxMJMW2LMFNrsG4bHBr
         MttBV2ovLI07a01M62wNpySQXyD35T6xDAwB4NrTcZMpsGFtrRL0e1CYUGi0Ei1GfqkF
         IbYMfzHAguEX5A7GQFtUiGwARjkeOfabIKpXgbkQ1mIU8NDWI3Y6lec7mS1cPw1CphtS
         pYsDa1HYLZcySaSSw8SnnRVsnblc9/1An4oh9zYR/kBqBDVEIx63GBE+sHMJffFSB9Ut
         asoB+CE/NkFS4sOb5my6bFvqLNXgeOmITQUWOo4tzHw82Rb/ep9XzrO+MMVDU7FWdMBj
         LDqA==
X-Gm-Message-State: AHQUAuarHHS/R2T3lpBuvLmnWWAXatUlY4xV9EiTrHNP4m6yUdCgA4IP
        b4ete8fqX1p6majlYjSvKhmD4DivfcU=
X-Google-Smtp-Source: AHgI3IZuzrNyFk7bon1GKrjSn8e2FqXaFGJResH73qt30ua3bS8Z/59s65/BkU3D7zD/1tU2R0GVYQ==
X-Received: by 2002:a2e:5cc7:: with SMTP id q190-v6mr3248171ljb.160.1550167176530;
        Thu, 14 Feb 2019 09:59:36 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id e17-v6sm561483ljb.43.2019.02.14.09.59.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 09:59:35 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id j1so5199943lfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 09:59:35 -0800 (PST)
X-Received: by 2002:ac2:4191:: with SMTP id z17mr3043187lfh.117.1550167174823;
 Thu, 14 Feb 2019 09:59:34 -0800 (PST)
MIME-Version: 1.0
References: <20190214164331.GA33450@beast>
In-Reply-To: <20190214164331.GA33450@beast>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Feb 2019 09:59:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg+Bc1Qmp0VBqPQq=_4=SgbN6jRvPtrme8-ieobpM16iw@mail.gmail.com>
Message-ID: <CAHk-=wg+Bc1Qmp0VBqPQq=_4=SgbN6jRvPtrme8-ieobpM16iw@mail.gmail.com>
Subject: Re: [PATCH v2] exec: load_script: Allow interpreter argument truncation
To:     Kees Cook <keescook@chromium.org>
Cc:     Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Graham Christensen <graham@grahamc.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 8:43 AM Kees Cook <keescook@chromium.org> wrote:
>
> This documents the parsing steps, and will fail to exec if the string was
> truncated with neither an end-of-line nor any trailing whitespace.

Is there any reason why we don't just revert 8099b047ecc4 ("exec:
load_script: don't blindly truncate shebang string").

That revert patch would seem to be much simpler than this rather
complicated thing.

                    Linus
