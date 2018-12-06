Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62747C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BC520659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmEoGk8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BC520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbeLFQ07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:26:59 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41336 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeLFQ07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:26:59 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so797119lfj.8;
        Thu, 06 Dec 2018 08:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2MWDJC9TUg3jzg/3mHsO1ksyRggfIXZwoM5JchWKgTs=;
        b=SmEoGk8GhQPWMPJjDu8bP5CV/xyCdFcKEfgNsFqIrIkorxOzm/k+/vyLtSEukzeeiZ
         9QW4x3vcgkUJbaZOaxw+43ykNJs0kwQEqtxc8igxS4zRuaXuZZMG2HwDXV/JUp7cR34d
         CXixkjCvuqTg8q1VFagdF0JldFtOBFlhDbMbT5dCbpbS/5t07QraQ2vdAxo1E7csSkiG
         7lu7VwqCK3Efd1ibGa/fSnlMnR4RJ6WYHpyZkmluKQmp7ZAKf+C4/WuprVF9LpAkgXys
         K3FjAfWV69GU0zIpXnh8Ucf/gw7lGIY6KC0b7Bu9HjYJ0IsJ5qUTonMNfc9aQzemJt4j
         5dPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=2MWDJC9TUg3jzg/3mHsO1ksyRggfIXZwoM5JchWKgTs=;
        b=HjHyxT0v4OGOhsr7Xffdh7KZoDhX8Qrn87+ye0O87vqGpw/6ehvv2dauNO3BEQ5Q+n
         ozfOfTEEx2xAEnq5HEZCMDZF2/QM/boJ+fE2+47Q80sb4+J8rGmRvf5SuKrDKmzKBcA6
         M3iSOrFFeynDIthpxPqtozsSZFJU6ST0QjpwqzVLckBGBD+sfZVpzgRBFhX1Pjl4wxwK
         8f31MUXTAP/E9v43fBwJQdybFcJuwtu5HL+/RkpfEeY8Z+gQrMzZouCDkZc762Td6yHc
         T7jk2Dz+gw8vVhC+hmvluMznsI15d0QRbb3KM037H8QU+veNH+lnBPHqikTiDEm9Zfpv
         1Egw==
X-Gm-Message-State: AA+aEWbEWzAI9VANyli/He7Plk2UdXJop+5/BAaDpiz/AyyoVjgXDbMu
        4uMOVbDjXXmDdCJTAmc+3J+BxYQYaNU5J6YY+Ko=
X-Google-Smtp-Source: AFSGD/UXIdLIUULoa8VQjjz7w+MlysJo+35XjrtDzPjDqZ4ZvgfEMGMN+vPy84nlronmBpIFZNctL5cR4csiNVxGx7M=
X-Received: by 2002:a19:59c2:: with SMTP id n185mr16319333lfb.118.1544113616790;
 Thu, 06 Dec 2018 08:26:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab3:7f54:0:0:0:0:0 with HTTP; Thu, 6 Dec 2018 08:26:54 -0800 (PST)
In-Reply-To: <20180920044108.6606-1-deepa.kernel@gmail.com>
References: <20180920044108.6606-1-deepa.kernel@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Dec 2018 17:26:54 +0100
X-Google-Sender-Auth: cg3tdHeNP4YJcg7xusp4whD_wn8
Message-ID: <CAK8P3a1d6KnCoGLY4tfkZzNVYBuWpHcov0se1ymtCGRMWOeTWw@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] y2038: Make ppoll, io_pgetevents and pselect y2038 safe
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     viro@zeniv.linux.org.uk, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-aio@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/18, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> The series transitions the ppoll, io_getevents, and pselect syscalls
> to be y2038 safe.
>
> This is part of the work proceeding for syscalls for y2038.
> It is based on the series [1] from Arnd Bergmann.
>
> The overview of the series is as below:
> 1. Refactor sigmask handling logic for the above syscalls.
> 2. Provide y2038 safe versions of the syscalls for all ABIs.
>
> [1] https://lkml.org/lkml/2018/8/27/651

I'm sorry for dropping the ball on this earlier, so it already
missed the 4.20 merge window, and is getting almost too
late for 4.21 as well now.

I've applied your five patches to my y2038 tree now, so
it should at least be in linux-next as of tomorrow and
make it into 4.21. I'll see what other patches I have in
my backlog that we should get into that release before
I send him a pull request.

      Arnd
