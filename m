Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72547C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 246C723DA8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="O4k2uG6e";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nvDFMg5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246C723DA8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753895AbeGCCZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:25:31 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:34416 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753819AbeGCCZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:25:28 -0400
Received: by mail-yb0-f196.google.com with SMTP id e9-v6so153228ybq.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 19:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KovnlIiW70oLUaOBUZSpNenzcGtxJiE9BAafXTqhjB4=;
        b=O4k2uG6eU7k9gFIeuUSm/FoGXzMopz9qnXlXqArVJItQ+SCqG3XQpDKEGJRTP8gulr
         OA7f+hhMCWb5fuc6oJlGLo6MXDjHCwVdeI5n9N3hjqTCRKJAh7lFDkYDTS6nEHLBZ/Ji
         xy2PP4VPpdiYrffIxkHDQ/B5iP4R2IIbFmyY8jKEngfOrgVenYiqlYVjIiZOfF9rgOWg
         CgroUiB/hrhCvegNEl2FBOA95HowTyi9WGBTVfwlIRYXH+lUpgMKofO6ArCq7AFP+26+
         SxPv3uAfWa1nwEok9jEbA4/iIWx34rMqr+jrCU3eCDM94B8MkanAvgHN0X51Llx5bS1k
         7MDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KovnlIiW70oLUaOBUZSpNenzcGtxJiE9BAafXTqhjB4=;
        b=nvDFMg5jw0SG5ro3qEGeIAtBrgQgDlVL6nuVKYbF/MJ2AcuTCSWQkqCtwqsficndSl
         1VnF2nr7vAgKbLbRbSbvrF0OYuqDjBFcdjM4W6aZ37OrIBtdh3O++Akmzg0AwYRGKgLv
         mWocwKgdj/tO8W1PxEeAZlOPcAtcsEdIwXFXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=KovnlIiW70oLUaOBUZSpNenzcGtxJiE9BAafXTqhjB4=;
        b=QKBE+52qLLr6qSzVTAXhQAjqctw1CyMYMTjwIZarTtgyrEH9hab4CUpt9ywMi1e35W
         NvPWkkd1Apf9+4uCwcECcjftQMxFY9vXKWooC2cCVjPX/ZQXDauVecrEr3liAYBhUot4
         a/3NnRQ0Zu2xT1KOzKiV7FQ9NkBoT3Q1M95x3UNkXXFYp15g3eiLYvDh9adIyAAr714G
         12xNhgHVAg/2suEmcJIv/T2H9OtfYaAt/NVIOc57GxdB01vcFtYLkL2EEcptpwMpz8T6
         yACPwojf8rt0BSf36trrjETyGGuRwOcNepwjwBqRegjHTh+d/9cwgo6fDflLh7ushBrk
         ld7w==
X-Gm-Message-State: APt69E1S8Q5aP9VUPLpvkEIiabyo5RxS9nCjXPU9KFq1DIJoW+93Ukqz
        DrCv5CeXYeDuhvhwkSb/vFfGrX7fzCiCumU7no1/Qa+3
X-Google-Smtp-Source: AAOMgpestSDm3CadzClHP/lh5MBmtQh5Bx15Eknt1F+t7WBy9mncu2/RSFDy78e+NRk8K61p63O+wsnuLst+pJn2cMc=
X-Received: by 2002:a5b:b44:: with SMTP id b4-v6mr4028685ybr.463.1530584727463;
 Mon, 02 Jul 2018 19:25:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 19:25:26 -0700 (PDT)
In-Reply-To: <CAK7LNAT13TrEbq5YR74YA1Snimn53MLjZFbHhbS2jLuvXn9a=g@mail.gmail.com>
References: <1530578352-18613-1-git-send-email-yamada.masahiro@socionext.com>
 <CAGXu5jKcWjm-56VRj=0kKU0Fb1ZrGgJ8WgesD0cN2x9WHTGwDw@mail.gmail.com> <CAK7LNAT13TrEbq5YR74YA1Snimn53MLjZFbHhbS2jLuvXn9a=g@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 2 Jul 2018 19:25:26 -0700
X-Google-Sender-Auth: 9rWGZoamVWQnRoHxcng1_2YR2eY
Message-ID: <CAGXu5j+sQ9Fz+zYW8AXyDjuKtOSh-e7b_02N5nkD_DV7Voj10g@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: remove unused GCC_PLUGIN_SUBDIR
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Emese Revfy <re.emese@gmail.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 7:23 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi Kees,
>
> 2018-07-03 11:18 GMT+09:00 Kees Cook <keescook@chromium.org>:
>> On Mon, Jul 2, 2018 at 5:39 PM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>> GCC_PLUGIN_SUBDIR has never been used.  If you really need this in
>>> the future, please re-add it then.
>>>
>>> For now, the code is unused. Remove.
>>>
>>> 'export HOSTLIBS' is not necessary either.
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>
>> Acked-by: Kees Cook <keescook@chromium.org>
>>
>> Is this going via your tree, or should I take it via the gcc-plugins tree?
>>
>> Thanks!
>>
>> -Kees
>
> Could you pick it up to your tree?

Happily; thanks!

-Kees

-- 
Kees Cook
Pixel Security
