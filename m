Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D1EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B93321720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ftWZxabR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbeLZBsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 20:48:12 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42278 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLZBsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 20:48:11 -0500
Received: by mail-lf1-f68.google.com with SMTP id l10so10075801lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 17:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dAxzPJk2gWqSyzfmcd+C8/dL6RfZa0QYIbGXGr2SG0c=;
        b=ftWZxabRfgqWvjOrArSWeXWM+WF1WOTeFkPB4X+H7d3RT516rLzgxAyHmIhG5lPG3V
         9alG2ocl9Y4DD960RWGyjyKqb1N0qIqh03qaBIHJDCHokMd8pS9+ieGB0mfntX4+yzE8
         lxg6iD9C+9lnHlXFMaCKFRRKl41NzsLFD/lac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dAxzPJk2gWqSyzfmcd+C8/dL6RfZa0QYIbGXGr2SG0c=;
        b=JyVZtqsKjWMfVoR46rBwC6U4GeoBgm/lD1L8xL6d34DN/QyZdgO6XXJ0iWFg5UaXhT
         1MQjZf0aCSfc/T96FZYygaOtjRpvpLLIPyRMt9i8t8cogld4JtATAz6TLrDGp3NOs/vM
         SnbqPXdnUjlQtcwcEHyUfFVZa5BTq3eyYNIDkA5Ly+7j6ZSvc74neBXxtGltlFTZ5dDx
         b4d8OdgXNGQVcIQLUitvEuoC1Fkpce64QTwoMo/YJdj+aP37efTCoSung245GYcf9rb+
         xkT3dofN3BwI1siprwZGcKifXKGlKkwNiIVD3XEMBWDzn0Y+rzhPrhSoOHetybU8xzrc
         WrYw==
X-Gm-Message-State: AA+aEWYqDYylXPvrMqW4qL6EJPTn813ABA1bJntZZ9mBDT+SCFRUpZLG
        ZR6LafR/M56aMibthGo+LcgXVCJvtYQ=
X-Google-Smtp-Source: AFSGD/UE/tsmqFraw7adjaI9X+RTU7+6iKv7wmJDGY2e1JwxfNFT8jueZ7uhZMk/5EGSTltrOe96lA==
X-Received: by 2002:a19:f115:: with SMTP id p21mr8611975lfh.20.1545788888858;
        Tue, 25 Dec 2018 17:48:08 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id h21sm7050387lfk.41.2018.12.25.17.48.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Dec 2018 17:48:07 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id z13so10054786lfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 17:48:07 -0800 (PST)
X-Received: by 2002:a19:cbcc:: with SMTP id b195mr9439374lfg.117.1545788887326;
 Tue, 25 Dec 2018 17:48:07 -0800 (PST)
MIME-Version: 1.0
References: <20181214161412.GB8148@edgewater-inn.cambridge.arm.com>
In-Reply-To: <20181214161412.GB8148@edgewater-inn.cambridge.arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Dec 2018 17:47:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiYb72J3F7=X1KBRQwOkd_rJPNmRmHF9QaM+-K_6K1eBw@mail.gmail.com>
Message-ID: <CAHk-=wiYb72J3F7=X1KBRQwOkd_rJPNmRmHF9QaM+-K_6K1eBw@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: updates for 4.21
To:     Will Deacon <will.deacon@arm.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 8:14 AM Will Deacon <will.deacon@arm.com> wrote:
>
>   * The A76 workaround for erratum #1286807 landed in mainline after -rc3
>     ("ce8c80c536da"), so there's some shuffling needed to accomodate that
>     in conjunction with the workaround for erratum #1165522 here. I've
>     included my resolution at the end of this mail.

Yours dropped a "If unsure, say Y" that should have been in both
config options in the Kconfig file.

Mine? I don't know, since I don't do cross-compiles, but it looked
sane enough. Somebody please holler if there are problems.

                 Linus
