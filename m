Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B535C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7B820672
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCpG9qcE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7B820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbeLFKGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:06:36 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36968 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFKGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:06:36 -0500
Received: by mail-lj1-f196.google.com with SMTP id e5-v6so21139987lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 02:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1bofkhlfWdL4WfFFsWtppVoQ/QWoInh66kz5/QCowCw=;
        b=hCpG9qcERl2yMZwg24XjOeZS8ytUvoWpK0t6ZCPq7Ncd/V3EXZY9Dd3DrGlwnPZcnC
         ToXQhdzWtfRDtR1r7nCipNOYTsq1l0f7h10pRhDNvMT9i90peIkNHoJJPL5Ky/frFS5Y
         3vy+IaNHc9t1duKISgCnSroth3UYtsboDq7oIu6ToiseYToN3Mjf4T2B9YmvGmweeXZF
         I26vynPhJF+XczTu+6pO+Ep4+fxPAzg8BIDdoWjePJuHjzm5RWM3H/22C1h77PnWrqr9
         m7SSBRATffyitX1oSP3ckqncPP/07UVqnxdjJWcdt8IOzVbPbqyblaNZMhcWouSu3Wak
         0SHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1bofkhlfWdL4WfFFsWtppVoQ/QWoInh66kz5/QCowCw=;
        b=SwtDjV9Co/4xxfaJ8D4Ff/z/PtVl5hyq2Eiy2jwgp9ZwOzd8bQJ9hpCbuU3oVgDOTW
         Enf0Y5YBzhH/vHgKTt7ZKt0sh3I+mcShMBrourAtjuDjfKmq+e2jzsRxLZrDoBpFJvfX
         WYMupkJutfdpwwB9sA3dLLtwi6cUrdFH3+av9qDrUPO47JYgniu0FZn1h5HSUNIEZ7HW
         8UR5/SClHouhYyz7n2xZePnUZk4i1vx7jmjC6GFLE1hFwFfir5Xi12kxGt0FF+5QOUCx
         u1I0xUNx+df/6muwO/K6KsOlf6f5yM25Pi+xQ7doUuvnfbSQxbo7mCv2MI5w4C5q9Lcv
         plAw==
X-Gm-Message-State: AA+aEWbVub5h9svkUTPLXefNV67tb1dJlebrDt35RvibtybpKAC7qBHg
        JPVqhwIR8pLk1AukaoExQQDAZCUhhqbF6rmXhIE=
X-Google-Smtp-Source: AFSGD/VAiHCpxTJ0bPp/sSvnxZ9+LMv5C09a0BhysV/D9BRe347zQuRjb9BMtZ5v1Y9YDHyZ2ssjmnoqIGgm2xV/iOw=
X-Received: by 2002:a2e:974a:: with SMTP id f10-v6mr20298287ljj.61.1544090793861;
 Thu, 06 Dec 2018 02:06:33 -0800 (PST)
MIME-Version: 1.0
References: <20181205135247.7964-1-mans@mansr.com> <CANiq72=Xg--8vG0+JLsPykOUfXpo89R2H-pBLuMROnQjMui7qA@mail.gmail.com>
 <yw1xr2evkg8t.fsf@mansr.com>
In-Reply-To: <yw1xr2evkg8t.fsf@mansr.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 6 Dec 2018 11:06:22 +0100
Message-ID: <CANiq72keqco3F=8YDHFqoeBRFsrs1Cbd1aF1owf90Hbncv40mA@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: charlcd: fix x/y command parsing
To:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Robert Abel <rabel@robertabel.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Willy Tarreau <w@1wt.eu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 6:58 PM M=C3=A5ns Rullg=C3=A5rd <mans@mansr.com> wro=
te:
>
> Suppose the command "\e[Lx0y0;" is written to the device.  The
> charlcd_write_char() function adds one character at a time to the escape
> sequence buffer.

Ah, yes, that is much more clear. Indeed, parse_xy() expects the
entire command; the strchr() should still be there.

By the way, if we are going to move to a direct check, I would also do
so in the generator command too if possible, to be consistent (in
another patch, possibly).

> BTW, the parsing of this command has been broken since 3.2-rc1 due to
> commit 129957069e6a.

Thanks for checking! Are you able to test this?

Cheers,
Miguel
