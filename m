Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A901ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97C420827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsLZnGI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97C420827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeKIB73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:59:29 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44448 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeKIB73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:59:29 -0500
Received: by mail-yw1-f65.google.com with SMTP id k6-v6so8204608ywa.11;
        Thu, 08 Nov 2018 08:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6UV5rKx0JWAL8nhbHyTsgN66oDJ3QeL3SQOwfYJ7n1g=;
        b=IsLZnGI/TBl5xtgZZwkzMeKOAvqhlXTTVXaDVBohW0tG0SxLb7G9OzmEcdtpxshQ9h
         p8Mrxcewg2h55sz4E3K0KjMJ+x45IaDL1z0AHZ8zfbr8m3ttZ+0FPh7xI2Q8evc2iB3F
         wgL3ybNyV0Q6UOAxAhIRkYG+Xf0qiDsIGiGLPYavHTgS1y1RtOraMBx5nLg6TZ/bAxMb
         KVV9WN5toGZ9cWNWCbuvA3+AC/TbUUHb8L5FZtIXLpbyueZNX0S1eTMNB4aoekF8NGWe
         bm0DsPryQA/UVMCEbS/+f7c+K0MlImNZK3S9Td89guwwml0IyVnGbIREvESIHsuarCqK
         9J5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6UV5rKx0JWAL8nhbHyTsgN66oDJ3QeL3SQOwfYJ7n1g=;
        b=OsnvN5IYPRBzfFDA4/a+C/2EPwntj+7+hPsGibQk0cUWgNrwDA18WGQEtZX/+guGIb
         4I1qqFI4pdyz4oSKLODSPxt4qTh0Nee5yBFqSqMauwaw37pGrSstxmvunYkwmpLLPptX
         a3VKQPkmQUw/D96sVOGUWHphdCFs10rRAfReG2oeyC3av6vVEqy9dCc6jpz4xBf5+lP/
         7dAVZalJlcMuigQsoYkXryOdOePhabx8CvV5nmynSTRT0+/5gT6GVpg49FsfVhJOxZ8v
         7ql741WvQHeTIzKLmpE36Nyh8WbTfkAydsymOjH8FkXITRPjYnnAscrAELwyVlRfQ5lp
         +QhA==
X-Gm-Message-State: AGRZ1gL43OUTIORv+VDTCSvNJgJAxJpM1TFv2uL0XT2tNbjXX6z2qp7Z
        6phjAoOvM6SqQiR3qzF5TaeLaEcLgbB8Ar5LNGE=
X-Google-Smtp-Source: AJdET5d1jiZKRzPaLkB472To3Gvmxtm3ilvzsjZm0/6qDKhxClfy889nDm8rZCaXAgPAIZnaC6sXROlNvDxQwhfoucw=
X-Received: by 2002:a0d:e810:: with SMTP id r16-v6mr4921126ywe.36.1541694193723;
 Thu, 08 Nov 2018 08:23:13 -0800 (PST)
MIME-Version: 1.0
References: <20181009112021.756-1-peron.clem@gmail.com> <CAJiuCceqyPY+dYr+1xdSyUh5x1Fr=M_p1nsMF9h52v5CXt1uYw@mail.gmail.com>
 <20181023085208.GL30658@n2100.armlinux.org.uk> <CAJiuCcdKFKmwB5mqW-bP+4A4HtVr=1z9avxoDPrD3NL9X9i8MQ@mail.gmail.com>
 <27e04998-8e67-e543-d717-2ac7e47b1732@kernel.org>
In-Reply-To: <27e04998-8e67-e543-d717-2ac7e47b1732@kernel.org>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 8 Nov 2018 17:23:02 +0100
Message-ID: <CAJiuCcfzPRgmq9rytE5rcg7XPBL9LvTSs6FV5ys0hhLMMVH98g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ARM: socfpga: Clean unused functions
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dinh

On Thu, 8 Nov 2018 at 16:38, Dinh Nguyen <dinguyen@kernel.org> wrote:
>
> Hi Cl=C3=A9ment,
>
> On 11/2/18 10:58 AM, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Dinh,
> >
> > Could you have a look at this serie ?
> >
>
> I've applied 1/3 and 3/3. I need to look over 2/3 to determine if that
> patch is still valid. I think a better solution would be to set a clock
> as critical so that it doesn't get gated.

Ok,
Thanks,
Cl=C3=A9ment

>
> Thanks,
> Dinh
