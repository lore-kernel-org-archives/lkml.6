Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2835C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB0620693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O8MSv/nz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB0620693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936747AbeFRWl0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 18:41:26 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51002 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935389AbeFRWlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 18:41:25 -0400
Received: by mail-it0-f65.google.com with SMTP id u4-v6so14461519itg.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 15:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GfcT24fxR3PvD7o103upN0eYGL+znYAqktNYi57wVAo=;
        b=O8MSv/nzltf5yydj1oOTr7sjoYbCC4YZdXYpctLLwYaA3TZyS2ZS2vGDpKZP0TeRes
         b0ycGn4uB0+I1ROZegBS7nmAbTdjvmgSF29YKwEn7mW2erP5frKcVNsR6zWqdXF2CKbX
         KefPM+ppIX2iL5Imn1u9rMfbX2e0zPhs5MCJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GfcT24fxR3PvD7o103upN0eYGL+znYAqktNYi57wVAo=;
        b=WkPQpqza6Nj/Qh/xhmPFb+9fSC7n4fmBbPwK0148EztxFMI4mSJi+0h/iYAu8xr6+X
         eEL542LBRFf/lMLJDyWKihJsfRn+ne0oN73tq0ro6PKD41rUlJrnhCGJqklLWTOA2T5I
         033Tvw1p3AF67dnF4DJjwXOotHBPYYojAtBk39vnLdkwj7bhjHOXqQH0vXFYTZuPCzc3
         N8BfMQYZgaztLk3bR0tOSCjCba/wwzfYI65SQebZHPxcIWsS4bVcF7LW4fHCROMc6hL7
         /sj65f7gd6Hi9dVpjcuVPbu9zdzrDTVNMKGcVO8a6Sytc8s7uTDHS62yVCHVKrPmO3hm
         LffQ==
X-Gm-Message-State: APt69E1skLpxBKRpX1qTCTcbEqXqNAtW6ifb5CY4Z1eIbP9apL08t9CF
        n6iFVtzsY4iicgZIuHjvlyHEF0VS9HAwGEtR8Dc=
X-Google-Smtp-Source: ADUXVKLw2BOXo1AI0A/TIGemDa5wuX0HTm2DSSB0h4clJLP6m+D1iZPqWKUi8TczHDq/wcWb3RVTClKGNaf5j+4OP+k=
X-Received: by 2002:a24:8046:: with SMTP id g67-v6mr10960248itd.16.1529361684363;
 Mon, 18 Jun 2018 15:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <c2394b008adfb6e7480f3b1193386537e96a6a69.1529358034.git.luto@kernel.org>
In-Reply-To: <c2394b008adfb6e7480f3b1193386537e96a6a69.1529358034.git.luto@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 Jun 2018 07:41:13 +0900
Message-ID: <CA+55aFyZm1+eoeiwitrw-aqhSBa+g_LpvWvJAhHpRQ=UTKwtqg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add me as an x86 entry code maintainer
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 6:41 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> Linus has been saying that I might as well maintain this stuff for years.
> What do you all think?

I invoked executive privilege and just applied it. It's just making
official what has been practice.

           Linus
