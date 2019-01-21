Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEFEC7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF542085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="eXPOkjcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfAULkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:40:11 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40842 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbfAULkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:40:10 -0500
Received: by mail-qk1-f195.google.com with SMTP id y16so12042118qki.7;
        Mon, 21 Jan 2019 03:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JfuSLmVSNWwqf6V8Z/eT2SQCRLTZcPBlUJjuClSObG0=;
        b=eXPOkjcuzJUUMeRuOR3FB9Fe2XIVQgLvpRQj9Ui3oc1R/8sBtAJkSu3+adyLHLJgad
         Swy2w5RGwzls6HMLHrwrdKGReLDdz50I+Tq7tMMTYofJC7neljsPQtqRyUtpG7REJCFd
         cv8Zfe/6AaIMGS9hqqnJGEWzCQB03do8PD8hpih1HKLEmplsm5WIMQcynvMac1Srh169
         NJFJbbHYuK5LBR/0WIxN0zFzcQlwZZzOUrpBbUYDjttyhCgo4kSerLeg4uicAmwkfQFu
         QRMqsvRZ1kv2LLhIHh/rWMcPD651CUJsHSam8oel+teFE2yXDEnCsXqUSyr4cA+ZTZLx
         Or1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JfuSLmVSNWwqf6V8Z/eT2SQCRLTZcPBlUJjuClSObG0=;
        b=QasLNQ2/Jp1oaXOuKcZjn9Fqd9jiW/F8HTGVFAH3JH/LqJ8dOecdGuZkBEPIlxh+98
         uVQUjZ5DG6u2lwQJITW/jROFCOkM+39uBUR6QUCxpwtfHQiaH7vwGY1gJb01S2Vv579b
         uCO6MM51r+ESrTzF0ghDCsuSQ77Jj/2V3cjtO7IrEMHAZt/VeHFrq3M+YQVn+jIsDO6w
         2V+9QSMxpSkox99wqBAf4ZMnQAov8WNYdsBlPWWiMn+mVI9RwipGdpVwrTjrc5mD1Jxv
         ph1NLqqKIMxAGjStthmc5RUpCOg+SxirIXoXqyb4KLuuqK00U1VjvMS3tr8vjK4cMp9p
         dGsA==
X-Gm-Message-State: AJcUukeES46eqdYbxhcb6dsREJXuu7VYFU1b/uXtrjBGJGiVhwP/m2gN
        HaOKzFHM9U+lKMlaEP0CJI9S2Ls0Npiat4qwNMD0xA==
X-Google-Smtp-Source: ALg8bN6AIST+KhxGoux3aSm+bQ8ysLDGgLro3JJ//QoDBVrJYlw4laJB6SOlVSBGrTfTU7FOBg1X4BsJsbkK4crH3wc=
X-Received: by 2002:ae9:eb94:: with SMTP id b142mr24016587qkg.227.1548070809449;
 Mon, 21 Jan 2019 03:40:09 -0800 (PST)
MIME-Version: 1.0
References: <1546173604-26066-1-git-send-email-minipli@googlemail.com> <20190102202938.GA26600@linux-8ccs>
In-Reply-To: <20190102202938.GA26600@linux-8ccs>
From:   Mathias Krause <minipli@googlemail.com>
Date:   Mon, 21 Jan 2019 12:39:57 +0100
Message-ID: <CA+rthh87tutLV=857g-Nrd6gAYK8xhRJX8MqpjC+CnmsjTqqJg@mail.gmail.com>
Subject: Re: [PATCH] vmlinux.lds.h: drop unused __vermagic
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rusty Russell <rusty@rustcorp.com.au>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2019 at 21:29, Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Mathias Krause [30/12/18 13:40 +0100]:
> >The reference to '__vermagic' is a relict from v2.5 times. And even
> >there it had a very short life time, from v2.5.59 (commit 1d411b80ee18
> >("Module Sanity Check") in the historic tree) to v2.5.69 (commit
> >67ac5b866bda ("[PATCH] complete modinfo section")).
> >
> >Neither current kernels nor modules contain a '__vermagic' section any
> >more, so get rid of it.
> >
> >Signed-off-by: Mathias Krause <minipli@googlemail.com>
> >Cc: Rusty Russell <rusty@rustcorp.com.au>
> >Cc: Jessica Yu <jeyu@kernel.org>
>
> Thanks for the cleanup.
>
> Reviewed-by: Jessica Yu <jeyu@kernel.org>
>

Arnd, will you carry this patch through your asm-generic tree or did
the MAINTAINERS file mislead me here?

Thanks,
Mathias

> >---
> > include/asm-generic/vmlinux.lds.h | 1 -
> > 1 file changed, 1 deletion(-)
> >
> >diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> >index 3d7a6a9c2370..530ce1e7a1ec 100644
> >--- a/include/asm-generic/vmlinux.lds.h
> >+++ b/include/asm-generic/vmlinux.lds.h
> >@@ -332,7 +332,6 @@
> >               __start_rodata = .;                                     \
> >               *(.rodata) *(.rodata.*)                                 \
> >               RO_AFTER_INIT_DATA      /* Read only after init */      \
> >-              KEEP(*(__vermagic))     /* Kernel version magic */      \
> >               . = ALIGN(8);                                           \
> >               __start___tracepoints_ptrs = .;                         \
> >               KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
> >--
> >2.19.2
> >
