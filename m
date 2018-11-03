Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A212C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 16:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3094520833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 16:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="zjWs5bMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3094520833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbeKDCGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 22:06:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37801 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbeKDCGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 22:06:24 -0400
Received: by mail-lj1-f196.google.com with SMTP id e5-v6so254451lja.4
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 09:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EMor0NdrpgL6yqrFYKPg91jhsk2eWtYuGIven9mHULc=;
        b=zjWs5bMgMNiTLIuV+RZepD7shHDxg0HDZYi9WDIj/0M/nHz9GyiO0+iFZ76L01zntI
         /INoqYA1eb1u4OolRDQDiScKyrYAanucHK+wBxtOwoX/ljonJXIMdgCidxbhIm+CGlRP
         gFUVeN4uzG6Zx0oixD20FWRJ+6U0tOHU+1s/74tH1Ik1FTAkQ33kWqQ6jnsPIQ+WaHWw
         1KDGtczHvyRulNFgfOEVegI7tCHxEx/96j3oxKY0CXmRriFF2sJtOZ6/LLXiJCB15DzF
         E9ueHpP7wea3tMvdn++s2I9h4itVEmzKTgJ3oMmm8DEuapbey95JvTbvsRE3Sh19Xwv6
         rwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMor0NdrpgL6yqrFYKPg91jhsk2eWtYuGIven9mHULc=;
        b=NOR9UJOV0KjgPUudylcQa5h4hG8ZW3uGh0nLTi9Sr8Fy/W+SM1Ysh4NLJ262mTi9/F
         0em0TYWd2XMefPBbk1utodq1lRCdykhmEbRw4CJFTApOgqR573m4h/E7gFTQmVnXkTJt
         BPIrHmyO/CrXW1UjCi3NoW6ZS38VHCb68SJ2IRiUjUhnZGzlO4mmDcFoIMvLw5mI8Qka
         gK8F7kGYoBqxYrLzXjJt/HsczMkLmqW28EdOsj+gyqD8af+Zb7TO08wLxm8lmjA46mzV
         +lPYajU8OQ0bMY5VWl1W7rrci/toHSsLh3ZNKFR486ui32WH/WjlHd6bkPKrLJSh1fqw
         +ZkQ==
X-Gm-Message-State: AGRZ1gKbnSulrST8w0h1AF0AeDsXMUm/dOHxWgPH+V3AAEwZ7FK4tcgO
        dYzzu7EIgdOKaDgADvMP6yNPvwkl20uBa921IthiIQ==
X-Google-Smtp-Source: AJdET5fKmc9UfGjTFCLI6m1/iVf6DmZldRtBKPtv6854rIXh2HcxvwzKelXz4p8tl6Fot6SJ4uYvyJBBgIeEi/HDQYk=
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr10534619ljg.23.1541264073861;
 Sat, 03 Nov 2018 09:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181102212405.5911-1-olof@lixom.net> <20181103153925.ozyb4pqnixu6hw4z@holly.lan>
In-Reply-To: <20181103153925.ozyb4pqnixu6hw4z@holly.lan>
From:   Olof Johansson <olof@lixom.net>
Date:   Sat, 3 Nov 2018 09:54:22 -0700
Message-ID: <CAOesGMjW0Ekbo0HmJak81zytLkSMeZq7=Mk8oTT8eVEED9=gEA@mail.gmail.com>
Subject: Re: [PATCH] kdb: fix strncpy warning
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, prarit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 3, 2018 at 8:39 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, Nov 02, 2018 at 02:24:05PM -0700, Olof Johansson wrote:
> > kdb does a strncpy(a, b, strlen(b)+1), which makes no sense. Might as
> > well do a strcpy at this point.
> >
> > Fixes this warning:
> >
> > In function 'strncpy', inlined from 'kallsyms_symbol_next' at kernel/debug/kdb/kdb_support.c:239:4:
> > ./include/linux/string.h:253:9: warning: '__builtin_strncpy' specified bound depends on the length of the source argument [-Wstringop-overflow=]
>
> I think we already have a pending patch for this:
> https://lore.kernel.org/patchwork/patch/989013/
>
> When we looked into this there actually is an unchecked overflow here so
> Prarit's fix adds infrastructure to keep track of the remaining length.

I'm not surprised that there are more bugs.

The above patch was posted a month and a half ago though, why is it
not yet merged? Can we get it in by -rc2, please?


-Olof
