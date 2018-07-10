Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B420BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB7C2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkdbNSpS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB7C2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934245AbeGJPWT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:22:19 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33770 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933443AbeGJPWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:22:16 -0400
Received: by mail-yw0-f194.google.com with SMTP id c135-v6so7970420ywa.0;
        Tue, 10 Jul 2018 08:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jd0STiNOIPEjJOCCp/llyQFtGHEO7r0N9zhQTHvVqLk=;
        b=KkdbNSpSYXuxQQczLnaM2Fc1gQkB7pnXzozryP0E5b+6xwWS4zK1P2/PnCPdIk3TZJ
         dmveewEpAIG+gfJGqyJcpJFDxQpt8Rr+sqxSjZNWwMTocQYmufKFWdSv+KGRKxUTs+io
         wrHiDZoaFe0yUIKwMQUyCw30WTxk42RVhyX+cJ53BGTfXF0RYfAVBK6NVye/jsHel27Z
         CdOEejC3yo0CvWefDh62Fm2UrJxtU/Agwr3FuDGtYjY4+kuWOrD76EN1YsrUtV50u9LJ
         JYIg/KtqpYmG4Yy/NL60RRIzn7kOQ6kcSoSkNVCZcTLuEdGYkGVInW1ysnBRznl0BiCx
         KL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jd0STiNOIPEjJOCCp/llyQFtGHEO7r0N9zhQTHvVqLk=;
        b=KTMgG+ytJfeMteHKZNwkqSXrBpASwS5yd+QJ9iA5g6pJ90TUN6CjEMisg2FzWgwv7c
         VjOnBNdDZ8gEXoZlw7nUigGZAg5At3wZ+y64oOAYBQGLXh7J08HXyNGUut3x5N9ohR4K
         qVgHu7qmsLvy+ngDVmzttI68l77JDbmcc4RoHO15ynDXzXyLPlM8B49PdPA1HkbFSNyF
         MFLhbYciIu2mdbpgu8UKvsyXQZDTsDoNyTf7idCfKx21ZA7uq1JDv2a4k7oWuu8E5knt
         ZglN9UvCzrbv71H3FN0XD8CbjNKGsKuIUqnIWn0uK6/IWwWiqtVWKusKCrVmxEOwT1Fq
         yjOA==
X-Gm-Message-State: AOUpUlHh3GxowBlgnZZeqam6pjTGhTkQBylqeBukePnaewDEQ8hAMGv8
        QIs/FXEQ7yrL1pbz9/Der/5yYgRdXNZMMLNTtb8=
X-Google-Smtp-Source: AAOMgpdHcgUJjVjtuKbVo51hx67QA1I7uOvT0F43hk3Y2xtXSOJidkPWpJ82+uMOo9L93ymjRqRNUEaGKwqZ7bkCQoY=
X-Received: by 2002:a0d:fb44:: with SMTP id l65-v6mr4240530ywf.422.1531236135513;
 Tue, 10 Jul 2018 08:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180611155001.3506-1-peron.clem@gmail.com> <CAJiuCcf3g2fzrR2_4mthjwKRcyZ8KVPX+EZ5_Uifh2E6TkzusQ@mail.gmail.com>
 <52591c2d-e9df-7078-7cdf-0fd8d06c9ee0@linaro.org>
In-Reply-To: <52591c2d-e9df-7078-7cdf-0fd8d06c9ee0@linaro.org>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 10 Jul 2018 17:22:04 +0200
Message-ID: <CAJiuCcc-eGRr_RT01dNfhQso5PbXfWy+YZS4PHHcL=_yhA-3Sw@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Reintroduce i.MX EPIT Timer
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?Q?Cl=C3=A9ment_Peron?= <clement.peron@devialet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Tue, 10 Jul 2018 at 17:12, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
> On 10/07/2018 16:55, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi,
> >
> > Is there still some remark against merging this ?
>
> How do you want this to be merged ?
>
> Shall I take the two patches related to the timer ? Or Ack them ?

I'm not an expert on how submitting patches works, it's the first
driver I submit.

But as this has been tested and no NXP team member seems against I
would be happy to see this patch merged.

Thanks,
Clement

>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
