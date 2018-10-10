Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BECC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90402086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BNqOwy66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C90402086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeJJTLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:11:10 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:56305 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeJJTLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:11:10 -0400
Received: by mail-it1-f196.google.com with SMTP id c23-v6so7501756itd.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 04:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z79+SodGwoRONipENtk9FYQFrqs5OczfnVlZGmPHbOU=;
        b=BNqOwy66FMQ2ebTEbHw+Vn3OaxDjljFp3ba+qSPH7CbcDumwvBQoe7LdUZGzX9gArs
         ILwOJfCCPNmPUc5bB4xr7blDALBKh7DujhaYJhZnq3lqUU33zgkQyzQ7712c+r1eGHjC
         4jxKBx2YSpOYsNZ3OYsEcrXwN7u84TEVvI5rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z79+SodGwoRONipENtk9FYQFrqs5OczfnVlZGmPHbOU=;
        b=JndAMPLWBZR3mOTJJ5lMoEExtJ/yj/i5/I/sU+xZQS3/6iuSQF47/hlHQBbdgPJhIx
         vW4ZYZBrKDbhV9iEMIqOV+i8bs93TA4uRzxe/3YI3DjTNgtaxZhAMVkYxHZuJMginCdx
         aiFkdch1qCAdTMGT7srElbKAmTruv7T2uqRV+AgpRhTlbCMiIAoFoEDx+1H1NBHfZT/E
         cDZuHuJ9XH9xX+gN8LzkU4M5b6bmzQX9jYfWf10JtFviBH9lEkHPqZs8uef8I9FO2KIg
         /dfIreB6z01ObLi4ChHWUBqF8KlSSxB84H21Nj9gDi4yEig0I85jrasjfOsYWsbBdtrN
         jMoQ==
X-Gm-Message-State: ABuFfohwN0kBfj1hfxkl8Ntd5fYmEU8DnWH5HVjrMGEG0caT/YvJRIb+
        kH/Y/LkqumiZRytNj+jcAFXHtsXG86ek3F6oIimN2BeJ
X-Google-Smtp-Source: ACcGV635egs63oLZsgeMfN9GnqXei5cQCzplmKCpVFEooCOw/8dafYlv5A7ZuzHBwmjCYzxAbgYXeAdQMJmiEnJEC10=
X-Received: by 2002:a24:7b50:: with SMTP id q77-v6mr378575itc.154.1539172163284;
 Wed, 10 Oct 2018 04:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <ec1afc50-993c-c0d5-00e0-ab111579fca4@infradead.org>
In-Reply-To: <ec1afc50-993c-c0d5-00e0-ab111579fca4@infradead.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Oct 2018 13:49:11 +0200
Message-ID: <CACRpkdb4uh02_du4WPc9OPnzU7O6z8h3Mup1ibjKHTVGy0iXkg@mail.gmail.com>
Subject: Re: [PATCH -next] gpio: fix kernel-doc after devres.c file rename
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 12:57 AM Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix gpio kernel-doc generation after rename of the devres.c file.
> Fixes these errors & warning:
>
> Error: Cannot open file ../drivers/gpio/devres.c
> Error: Cannot open file ../drivers/gpio/devres.c
> WARNING: kernel-doc '../scripts/kernel-doc -rst -enable-lineno -export ../drivers/gpio/devres.c' failed with return code 2
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-gpio@vger.kernel.org

Patch applied.

Yours,
Linus Walleij
