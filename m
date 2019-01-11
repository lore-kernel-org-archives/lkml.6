Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF89CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99BAA20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z9AYmH9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732991AbfAKRU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:20:26 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:37450 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731663AbfAKRU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:20:26 -0500
Received: by mail-vk1-f196.google.com with SMTP id 197so3450506vkf.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eilXPrM1bet/yXcit9P7et+DS/MOprkwQ8X8yqllx9c=;
        b=Z9AYmH9Es+Ishxy4c0WoA7CyG/uHj4Z+TKHmlwUS5OlrcjAfcyxX9SVJPpAmDZ8f3y
         LgSF/f5of9wVspAxMb1yrO+gKIH4sV1gnhW2i7vJ/IM26pxo00tNcc0995gGVLElSbYF
         faHqGmkeUDfnfA93qLtRPrntSiO5/1lAzNJSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eilXPrM1bet/yXcit9P7et+DS/MOprkwQ8X8yqllx9c=;
        b=uXpUaJw+jxPPTzlQAh3fui5wkUeUBwWsrNIIZpExAWhzILO2rEzFNMBqbqT26SDrnq
         dLeL1v8FZ8TaIkUBeDKLjdRWDldgwjYGJV9V5s4iuzDTluLlx3pJNnvHqa3yle+UoEPH
         q0kARawKbRl49kZrDp4+8Co2kcn99bt/hdPB7Y7bXe3ch8JWv+2U6+lpmpzNAoKDvmDk
         reR00D/WbhrjoKr2vCqd1taRurMV2kbZ4DffNjFCwGU+/sk1u5DbecZF0Uf267uneB/b
         Vz7GrrfL7vbwOjiui8c4+jED+jajJmkPSPkGefphGsT8zN86lxdmpaqhlknO+saiWL6v
         Td+w==
X-Gm-Message-State: AJcUukcQEwTTZV76+kuOCidPE7FPzMfgbC9scxvDSXbJ/RKwLU+9TJxq
        md46D0S9sszikP+jMeWxaYXvu3LjCc0=
X-Google-Smtp-Source: ALg8bN5usuobUq1UnGrwN7Fv8RPLWhf2OeBR//pCpHGraqRmUiaSC9D7tgOOrkmlYxa6WzmOJZA6Bg==
X-Received: by 2002:a1f:9f0d:: with SMTP id i13mr6135830vke.6.1547227224358;
        Fri, 11 Jan 2019 09:20:24 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id k200sm32693839vke.9.2019.01.11.09.20.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 09:20:23 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id y27so9694723vsi.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:20:22 -0800 (PST)
X-Received: by 2002:a67:2c13:: with SMTP id s19mr6332893vss.172.1547227221935;
 Fri, 11 Jan 2019 09:20:21 -0800 (PST)
MIME-Version: 1.0
References: <1547198328-26359-1-git-send-email-yamada.masahiro@socionext.com> <1547198328-26359-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1547198328-26359-2-git-send-email-yamada.masahiro@socionext.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 11 Jan 2019 09:20:05 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJCZ35qM6y8p+J=1Z58cGM-ZZTpbcke46uQmCNBpptRmg@mail.gmail.com>
Message-ID: <CAGXu5jJCZ35qM6y8p+J=1Z58cGM-ZZTpbcke46uQmCNBpptRmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kbuild: simplify GCC plugin build rules
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Emese Revfy <re.emese@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 1:19 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> GCC-plugin is the only user of the shared library build rules in
> scripts/Makefile.host. Hence, those rules do not need to be treewide
> available.
>
> The build rules in scripts/Makefile.host are written in a too generic
> way. I guess the main reason is because commit 24403874316a ("Shared
> library support") revived the code ripped off by commit 62e2210798ed
> ("kbuild: drop shared library support from Makefile.host").
>
> Currently, every plugin is built from a single C file. So, all we need
> is a pattern rule to create %.so from %.c.

What'll it look like if we get a multi-file plugin in the future?
There are existing out-of-tree plugins that this change may make
porting more difficult...

-- 
Kees Cook
