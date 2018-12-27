Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34F0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 20:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774AC208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 20:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UaGiHvxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbeL0UHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 15:07:55 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:47063 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729510AbeL0UHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 15:07:55 -0500
Received: by mail-lf1-f68.google.com with SMTP id f23so13310466lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 12:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9biiqvLbgan2M46fa2TUhhLk+1qVcVSm4lWGhiXXsls=;
        b=UaGiHvxfgHhXTMzRdYdPWkujV7fyZp8Z9l/RUSrpnI1ibbiSS7XNLuDIODv63jL9s3
         6K3ltSCVnDIoH1dJ/abUlVT6+eHQMW3QJc75ICzRorku2hmccoJHDkNjD/HJR+wI78CS
         DDBbioR4W6QZqjq+TDWeitaykezcwhxfYPero=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9biiqvLbgan2M46fa2TUhhLk+1qVcVSm4lWGhiXXsls=;
        b=lWtQX0aiEKA1C+lB0LpFwmDT/M7JiHybX4QEJPnjsmEMDebXMRwfSKnt+ms/0uGmjg
         1if9+DLic/4Yd0jd58KEaJlwjLkYXczUumPBPq0vR6eiXBZkoTHwEacbk6xuv+dMiQvB
         DLxVdllRKhW2qxWO2YCWLFFm19ZLjTOTDGlsvxRVMdZpYnyBZXPoGuGJVZRR2Vu8HKz3
         SxMOsTVhFK7C+GB3UyeQ6+VLISGWr9YkgIth4h9NdLbwCn1M7UoiBG7CQZX5tmkeAcO8
         IQXQu6Kkm3JS6HZVeyiFT4y5cVUnSkbhxVy9ctagaVUiiz5OOFg0B3uv1lbzAGp8acYu
         fUmw==
X-Gm-Message-State: AA+aEWaCa5X+c9AvIF7pJlR3iadBqVxCmNixhgcAZXH6QDMq4+SPCm4X
        jy9tQl2PW79+4fmKK3Mk0PDDFKFaeg8=
X-Google-Smtp-Source: AFSGD/U/+9UualM4QsWYmr0WVoOG1XniAuUynBNK+zxZDkHpessANQ1ZZsm0CsdhU9RT4+fWfPd03A==
X-Received: by 2002:a19:9508:: with SMTP id x8mr13053546lfd.112.1545941272125;
        Thu, 27 Dec 2018 12:07:52 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id a19sm6808102lfi.57.2018.12.27.12.07.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 12:07:51 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id b20so13318184lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 12:07:50 -0800 (PST)
X-Received: by 2002:a19:7006:: with SMTP id h6mr9006323lfc.147.1545941270513;
 Thu, 27 Dec 2018 12:07:50 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1812250652420.2714@namei.org>
In-Reply-To: <alpine.LRH.2.21.1812250652420.2714@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Dec 2018 12:07:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiUaA4sZ=8UnT+q6eXE29K+XGVX=kZPR6gG-Z4UhO3p+Q@mail.gmail.com>
Message-ID: <CAHk-=wiUaA4sZ=8UnT+q6eXE29K+XGVX=kZPR6gG-Z4UhO3p+Q@mail.gmail.com>
Subject: Re: [GIT PULL] security: general updates for v4.21
To:     James Morris <jmorris@namei.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 11:55 AM James Morris <jmorris@namei.org> wrote:
>
> The main changes here are Paul Gortmaker's removal of unneccesary module.h
> infrastructure.

I will point out a merge with a horrible commit message:

    "Sync to Linux 4.20-rc2 for downstream developers"

that tells nobody anything.

Why was that merge done? If you can't explain the merge, just don't do
the merge.

                 Linus
