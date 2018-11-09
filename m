Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19ACC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB9820827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB9820827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeKJIPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:15:54 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45744 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbeKJIPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:15:53 -0500
Received: by mail-qk1-f196.google.com with SMTP id d135so4463996qkc.12;
        Fri, 09 Nov 2018 14:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d5b1sHamJErQlHBdiqqeqNmArA6ZPJTXRSbT7EBxxuM=;
        b=lKM68fqKdluzwJaeOVnt25VWWOB7x5iGKU8vfL5n3gfwToSPX4UDeZskp71WlQvyCw
         v5NkSgve3Rb8eSYNVX1h9cImjwtBMtNcu73ULPdqccne1hXce2lNesvhgQY5BtxMin/x
         08nJ+f+s6WasdmsiEbxMgN8ULbyDt0fqbP6Cv6NgfPb5MeTvcndvUvdvd2QHiGseQPN6
         EmqsdG5/iCNfmiEZz0H7UCdpRS/ZxqsWD5WWxqKVmeqorffZDlhK0XjtAqREHW8sRv0y
         37esO7WGyqsc5ixQQ1faV3WvAAdL3oWBn8oSrMzrTm/nX4jJfHLuv3CIoW7pPljJyd70
         +s8g==
X-Gm-Message-State: AGRZ1gLJ7Uobc7yf7GV1OZTYkV4NqfY2kHx0ktNtSZCGZlkucOm/x7mA
        gdaV0bgkvSRLCXhIVcaA3MN1RiNI+As7UtPQQB0=
X-Google-Smtp-Source: AJdET5cACwczp8E3S8n836ioPdZiiK4/ttinqSI+I2vVrEHd/rwNcPhWCgtvvEOVvz+cnW4bShWJ9+IVncLOPeQkqK4=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr10289092qtr.319.1541802795930;
 Fri, 09 Nov 2018 14:33:15 -0800 (PST)
MIME-Version: 1.0
References: <20181104155501.14767-1-TheSven73@googlemail.com>
 <CAGngYiU+8k4ZHYhFVQGKXW8mATEDi64Mi9PsVkX-5vn2PCY3ew@mail.gmail.com>
 <CAK8P3a1STE+vN_yF0Zyu8gGX_KCWZEV=muPxVE6M1EUqdhO4Pg@mail.gmail.com> <CAGngYiWtmHPShpbLOj4qYJCe6PvNT7ZUDd-0jRsRyxD+HWbByQ@mail.gmail.com>
In-Reply-To: <CAGngYiWtmHPShpbLOj4qYJCe6PvNT7ZUDd-0jRsRyxD+HWbByQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 9 Nov 2018 23:32:50 +0100
Message-ID: <CAK8P3a1zME8G0FjqLaL65F6yYOEuPLJLNs6Mdve7YF=Q2BpU5w@mail.gmail.com>
Subject: Re: [PATCH anybus v3 0/6] Support HMS Profinet Card over Anybus
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     svendev@arcx.com, Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 10:47 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> On Fri, Nov 9, 2018 at 4:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> >
> > As usual, it comes down to the user space interfaces I think. Designing
> > a user interface is hard, most importantly because you cannot change it
> > once anyone starts relying on it, as opposed to implementation details
> > that you are free to change at any point.
>
> Thanks for the feedback !
> I will rework v4 so it uses a userspace interface shared with other
> fieldbus drivers - uio.

You mentioned this before, but I don't see how this would actually
work. Isn't uio just a slim wrapper for allowing user space access
to hardware registers while avoiding a kernel driver?

      Arnd
