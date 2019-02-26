Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FB9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B50218D0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="baAToNqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbfBZXkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:40:49 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38923 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbfBZXks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:40:48 -0500
Received: by mail-ua1-f67.google.com with SMTP id s15so13615957uap.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 15:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YkWxVbFxHHYH54DP8/VSUr6kaRpJgeDAUIoawZOg9w8=;
        b=baAToNqFIKYuukIantg+RI/t5BWNL/W1qrHux3fjRzS3yPWWbKkYBe0G8rx87NG09n
         CCG/sV8u60JYXLtgOXtBnKelcxMeutCItCo1F1vw2d5jmFdmOuHuvVQ6NHXUmPsYKrWx
         3LNR/LWKWYc+XHivsc00WdGKXSdzd2rqtmPWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YkWxVbFxHHYH54DP8/VSUr6kaRpJgeDAUIoawZOg9w8=;
        b=dzWzF+mmU7d6wMXdlvVjyVO9p4PCCEyzuCYub+RZuh12+evAp4YCHwmRB+v20oUOdK
         j72N4uYdqau37Mqjmp+Py7Ljwq3n72XiSAjmWXaNIbqLcTrIDmx0YSioGGxnpKI6lmfS
         j8Z8B7pwkoe9SoJZoa3vbdr2PwjNRWWIRYcaEBsxuium0MS0tTl2UsRwbpr94W7/xU2u
         tEijaUqeDbiX9Qs4R3+zozY71L1HAP/ZdOdTOF4FycKxMu9YldPNS0pfnsDAwdT69zk+
         m6H8Udd6FGiU6lZ75/MuVO9JXpWIhA5/TOgeTNUxk7oZc8ULuqsoQP0132C+2jR1jxFA
         QYng==
X-Gm-Message-State: AHQUAubc3wpSOpJy28j/igtbBGQNTPFbv3RjZbaRk3jgDzO+LXg3brtq
        sPMO0C/vaNQCCiSvpKHCC9ing57jZB0=
X-Google-Smtp-Source: AHgI3IaIMeBmhJ67dRm3wLMzRpwZjbcIw34m7N71HkMUZ+dodHSqx4y3RIYHqba3yDKYUmc7yg5OEw==
X-Received: by 2002:a67:8d08:: with SMTP id p8mr200474vsd.147.1551224447297;
        Tue, 26 Feb 2019 15:40:47 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id d69sm2122431vkd.38.2019.02.26.15.40.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 15:40:46 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id j8so13584884uae.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 15:40:46 -0800 (PST)
X-Received: by 2002:a67:fa45:: with SMTP id j5mr236550vsq.48.1551224445914;
 Tue, 26 Feb 2019 15:40:45 -0800 (PST)
MIME-Version: 1.0
References: <20190226233647.28547-1-keescook@chromium.org> <20190226233647.28547-4-keescook@chromium.org>
In-Reply-To: <20190226233647.28547-4-keescook@chromium.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 26 Feb 2019 15:40:34 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJpeh5Ark4QG-UMUUkr-d+hWoBBb5eYzoGOCFXnW3xgkw@mail.gmail.com>
Message-ID: <CAGXu5jJpeh5Ark4QG-UMUUkr-d+hWoBBb5eYzoGOCFXnW3xgkw@mail.gmail.com>
Subject: Re: [PATCH 3/3] lkdtm: Check for SMEP clearing protections
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 3:37 PM Kees Cook <keescook@chromium.org> wrote:
> +       for (i = 0; i < 64; i++) {
> ...
> +       }
> +       if (i >= 256) {
> +               pr_info("ok: cannot locate cr4 writing call gadget\n");
> +               return;
> +       }

*brown paper bag*
Argh. I changed the depth of that search at the last moment and now
it's mismatched. *sigh* I will send a v2 for this with it fixed.

-- 
Kees Cook
