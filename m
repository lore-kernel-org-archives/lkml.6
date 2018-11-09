Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0D5C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9F320883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="je0eOtFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9F320883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbeKIQ10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:27:26 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33424 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbeKIQ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:27:26 -0500
Received: by mail-yb1-f193.google.com with SMTP id i78-v6so667408ybg.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 22:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=N/wFaDrlPzh4S5JJG/PG/MM8T0NQQ7fLYTiNlZBGUsw=;
        b=je0eOtFxi7sMiph87vNjstc1aOK/spszrYS8UjUtBm1FbeoDvr5zyCwxhfltzDRwuM
         cTn68dlZ/lUqsq+W3pl8vdEEFMII3YusydwBhyrraWAe91deXWK0GcvFWLYKE4kDblHg
         9BcJ0JaLBs2M43QlvlBcZQq7lQTdrAQ1lXYrkuYZwqXeQ3bWuHZZEPkV2IV0qnfnWOZ8
         3+P3DkUqVKfE1p29XUWLywYi8c4MYCBlwnxjAg/RQpB4bxr2ZtuFrnaktvkyMtWxVCoU
         5uV+16OKBA0n9H+f6Z+x94HDfTYrXl2ftE19RaQ/1gN73HoPwsSruoFPboYyWaXaOl+x
         OcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=N/wFaDrlPzh4S5JJG/PG/MM8T0NQQ7fLYTiNlZBGUsw=;
        b=Ly5+5YjwSiJAsoK0Did+I6DDwk2T+SSk3Zh29dZYwBgFVb5UHThL/XWk0rH3XewB91
         PihrJQCUClS/a94EH8x0+N12cOqyFFGPNZalJ/YhRAiQ3zWfx6QmbQLSbFRWaPOORLFU
         QBVfnEfQcAki/V4YSZlsMpR1EiqUd1tph4/CfZQwEYuZZOgr+3kN46SY80jE0EITK12Z
         tcIAeFxByXWncsX8ZOAcoPUdD0tfC5hYYfDcCZaC4I9QfVZtz0alIsF39dIuetqk7qcg
         GOaWivi/iJ6K/2VHjiERVgwpDR72OLKpve3XWDt7Wcw6X/+2yChLeYp33n4aJy1qdPSP
         kjsw==
X-Gm-Message-State: AGRZ1gL7rBIB26hd85Wrk06ZXCa5SaXuSCd4yzjE1z6gnUzP5UcVSkrw
        UpaWOtOhxIpl1r+PsEVL/8OhPbwT1FEEpCHqLpw=
X-Google-Smtp-Source: AJdET5cCaff00+Kprn0iV7d0z+LYJl0R/E5wgwmGJWx0vfAubXjX+oASYGk+P9ZJeZHBBhgJ/jXdIdlx6/RUUYKnpLA=
X-Received: by 2002:a25:c186:: with SMTP id r128-v6mr7565307ybf.84.1541746096987;
 Thu, 08 Nov 2018 22:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20181109031303.GA20906@altlinux.org> <20181109031730.GM21511@altlinux.org>
In-Reply-To: <20181109031730.GM21511@altlinux.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 8 Nov 2018 22:48:05 -0800
Message-ID: <CAMo8Bf+R4t1+BW9mobuTpjw5dkuMYRpQRsJeGEJvb+OwxrX46Q@mail.gmail.com>
Subject: Re: [PATCH 13/13] xtensa: define syscall_get_arch()
To:     Andrew Lutomirski <luto@kernel.org>,
        Chris Zankel <chris@zankel.net>, paul@paul-moore.com,
        eparis@redhat.com, lineprinter@altlinux.org,
        linux-xtensa@linux-xtensa.org, linux-audit@redhat.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 7:17 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
> syscall_get_arch() is required to be implemented on all architectures
> that use tracehook_report_syscall_entry() in order to extend
> the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.
>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>  arch/xtensa/include/asm/syscall.h | 7 +++++++
>  include/uapi/linux/audit.h        | 1 +
>  2 files changed, 8 insertions(+)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
