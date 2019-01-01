Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4EEC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9200B218A4
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P6Pp+31N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfAAVf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 16:35:56 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39598 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfAAVf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 16:35:56 -0500
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so25682610ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 13:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RrKXKuQDDGTYLHzfvWYJcBUvW3wfkTd45q/FZUKCT8c=;
        b=P6Pp+31NWyUPx+KB80THa8KbIh5SUdZqpjWJn0YK43qOLXu/JtnHe1LeQpK9ysUGSg
         sKApQtQQhp+altgSwjoZQmvgsA93Ub4Lft42/DOTu967kCaDuRHt15y+FKe+M5NU4HwM
         /F7tFlqhPK5k0ioafExJLKRQwBmIdAHMSSGV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RrKXKuQDDGTYLHzfvWYJcBUvW3wfkTd45q/FZUKCT8c=;
        b=ubU6hh588IvH0D7nxAWTX3+TjoKtfXoUqZtwFOBYbkF1rX8yoBkuFRzHIH7lIMvJRX
         EEieE0y5HuNsnOeUF1labB/4rMwIT8htDTyZ35I8TaqkjS98/yk63aSJdTg2awJOaUIM
         T7CM7bBu8SaU0bSd8Q+SkapgBAU30+/OWFrX0juOyTnkHvsSvNx1U8Ah25zIYXCaV0Rs
         diXt9f4B/W8Rz154n+vNkeNHoM4KBAwtJHov4H0TmYlzeqPER4920H7tFcuQ2GUEOypD
         cCt2vKau4Xa23shKHwuomYoYlYQ0XMHREzG6NiyuuMl4mpIgVh7yTs86QQAK6QxcHUXf
         RRLg==
X-Gm-Message-State: AJcUukeLOy3sX8Gcf3J553NFXavhYQy+4XpzR38kk51fMx6YQ4E3v4Wb
        SE1RMGVRSAWoaX3fvQm059yAysjTmls=
X-Google-Smtp-Source: ALg8bN68PMG5T0gdv09p4c0qOj4idSCAL+YW9XhWgd/NxUM2crkbvf3hjkchuFB1AzSqnyZGbntTnw==
X-Received: by 2002:a2e:9457:: with SMTP id o23-v6mr25479102ljh.7.1546378553653;
        Tue, 01 Jan 2019 13:35:53 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id c22sm9808376lfd.88.2019.01.01.13.35.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 13:35:52 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id a16so19933058lfg.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 13:35:52 -0800 (PST)
X-Received: by 2002:a19:cbcc:: with SMTP id b195mr21502264lfg.117.1546378552037;
 Tue, 01 Jan 2019 13:35:52 -0800 (PST)
MIME-Version: 1.0
References: <20190101160503.GA3306@localhost.localdomain>
In-Reply-To: <20190101160503.GA3306@localhost.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Jan 2019 13:35:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=whXWWXSMMPpm3eGV=PL12=K5LFM3didLBuGy1Y7vUbXVg@mail.gmail.com>
Message-ID: <CAHk-=whXWWXSMMPpm3eGV=PL12=K5LFM3didLBuGy1Y7vUbXVg@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal-SoC management updates for v4.21-rc1
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 1, 2019 at 8:05 AM Eduardo Valentin <edubezval@gmail.com> wrote:
>
> Please consider pulling from
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus

No.

I pulled and immediately unpulled again.

It doesn't even build cleanly.

                Linus
