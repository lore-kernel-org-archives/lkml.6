Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70043ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2464B2089F
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="LjseaVra";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZOWa98CU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2464B2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732996AbeGOCsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 22:48:54 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:46761 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731985AbeGOCsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 22:48:54 -0400
Received: by mail-yb0-f193.google.com with SMTP id c3-v6so4689490ybi.13
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 19:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=QsV+btA4uJwLvESfcb7wiZTl597SRI18zc1gHRK4F2M=;
        b=LjseaVraG/dteYMHbW0vMmkuLJW5p/Up6EcD+74pGEx+Z8NfyamF7K57N9BQ+eYhca
         FLfUuFG8Y/W0tyqUGEWZ/S9KUZlgcADacXsQNXzAD8NlF+iaR1TYjxvc/uFPnett6U39
         llUw946vyLzZTCvSdbJvUfThvYv523sprrjaQZgZy9qFMVtui39f05MUsMfri/heydlT
         uZ5FogKsLVNF9wCNcSkkLe8qilq9zZfOlZYA+jEngg65JK66KUtk0WFxcJ91P/xpcUac
         WmMzm1QcCDmAMxwuLCZ/vdeH/m+tkUGq0Fx1O6jVONw+QlwUoIgGw6Y/f0Oru/d7e6nH
         vLQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=QsV+btA4uJwLvESfcb7wiZTl597SRI18zc1gHRK4F2M=;
        b=ZOWa98CUXqPLigmarGcye2Z8LXPc758AqboM9MAmajHLbxUbYDZrr8HHjvcvCgFQb7
         QfLFyHFl3ZrI7Z6xDg0wsWYaOUj1LYBmqYgZxtkrrb8lqyizjntOqOE/gEaXUPsn/PAP
         5MhoZlf8MYNNCTxzx3zudAs6gXHSIm5nt98VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=QsV+btA4uJwLvESfcb7wiZTl597SRI18zc1gHRK4F2M=;
        b=MW9UWpaQag2nbgzmi5I/e2t/k1nYHOjaz7+K3WLrIFPFh3OyYvL7Y6IGmNDBZu5M1a
         X9uQ/YBe359H5B0e+YRKLgUxrJg2xum2nEVgRqP/PHcQ/NL+S8bDGh+GIu40Cgr+g8eF
         p8jAwTlmx2tWL9gZD+IHxiqwSK5xa7WO8r3532jyzrDM2teHxkHnqp5ko08sYu0NY/FL
         4o9ZHlZZ8DwjaoR2ilEenXoMjoGZvIq8dd18M6yuGv/ipfadoo4Ye7Eyd5oUERxljr/O
         IWlASpuKriQrLjFpV6O4UPiwjz/zRvcbv9LflP3aS+IlxWBf8Z/POEvRPvnQLN5aBRZY
         kUYA==
X-Gm-Message-State: AOUpUlG5NmHzH5cQLAtcF/XCa6s6YdFXp/c8p79we/sLQV1MJqlg7usL
        oA6xi83KzeG6/y7R+Krnf6hLINNUPXgEuLhMLMrKlg==
X-Google-Smtp-Source: AAOMgpe8ueSnhstXVubupCZKqp2dTJa9ekXfTC0DgB1044ze8FBv1bSjV4EwtympWegIM8YY4nB7yYRGGEPVBC+uzMY=
X-Received: by 2002:a25:3445:: with SMTP id b66-v6mr6379363yba.484.1531621662873;
 Sat, 14 Jul 2018 19:27:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Sat, 14 Jul 2018 19:27:42
 -0700 (PDT)
In-Reply-To: <1531505163-20227-6-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com> <1531505163-20227-6-git-send-email-zohar@linux.vnet.ibm.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 14 Jul 2018 19:27:42 -0700
X-Google-Sender-Auth: BBB73tMICXFaURwiSUNEgE0N4j4
Message-ID: <CAGXu5jKWGONcAfxrU_vk4g=La24NDSzS=scZWxp27xJdO_R0zA@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] ima: based on policy require signed firmware
 (sysfs fallback)
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 11:06 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> With an IMA policy requiring signed firmware, this patch prevents
> the sysfs fallback method of loading firmware.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Luis R. Rodriguez <mcgrof@suse.com>
> Cc: Matthew Garrett <mjg59@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
