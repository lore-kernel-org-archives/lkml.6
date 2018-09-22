Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1D2C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4651021569
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xjdrg+xj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4651021569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeIVIh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 04:37:57 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38615 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeIVIh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 04:37:57 -0400
Received: by mail-yb1-f194.google.com with SMTP id e190-v6so6255161ybb.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yrRrYun0p1t9laLCKRji1sYubxXnqAmGv2Md1D0qHZg=;
        b=Xjdrg+xjZvYRBiI4EEJpXvkx44eRYtCgDxCol7HTFJ0r9dA1GLoa9t1lUeUDbWPq7q
         WYR5H3A2kM1ZdM//nwH9ifeupYs1yCRaihKNCHoTE4Z/BFEFpK6eRVNzFOTc/yr90LDs
         dV4HzXCZb8WG9614hFPVq/BN2bGhAZ/OnJzVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yrRrYun0p1t9laLCKRji1sYubxXnqAmGv2Md1D0qHZg=;
        b=qQwiJ5yvLqu0/acepEW8wKCLIzc6551kBwEdPKEQWC9d8wjzZBjO2I44ZZBOxVvYbw
         VhicAIqcQrgeHF3AptRg+u7nsFtov3ENuWISaNDKEFiOxSBzxHTwRfZXuh3V3kCcU8ji
         DJb3nKWTXaNXn1Z6Zs9eUlFvAtP/XhBQMWiKx3m/rK7/gAYoRjmBL3BVQNHnQ1ieVzVD
         He6Ljh6EzPDrB/nSg+oSnkQgdbz1Wzbe7rWTl3xpkD7uSwLAkhB6ImjZ9po1vPlltvf1
         sGzPh2LlilRW2jC2Ry2xp33gU/yW0Gc2ozoEIupRUX1Tht/1ICtqgM+3ymxC26vcRy+J
         d3Rw==
X-Gm-Message-State: ABuFfoj8LlBUJqs5DJEtMByr2SoYT7vfB77iTzx2RJX50C0oEghgEw43
        cHh9tZ3uUUiakOtFUFdQNNZGjWPIz00=
X-Google-Smtp-Source: ACcGV62oxnwHUsRfMEjL5BV1AzrXqVqrhXcV6NM4kQl1bdq44afqwfAcFaQhgtqV5KnIYftWJKCXaw==
X-Received: by 2002:a5b:8d2:: with SMTP id w18-v6mr209669ybq.330.1537584368422;
        Fri, 21 Sep 2018 19:46:08 -0700 (PDT)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id p124-v6sm985799ywc.42.2018.09.21.19.46.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 19:46:06 -0700 (PDT)
Received: by mail-yw1-f45.google.com with SMTP id 14-v6so5977393ywe.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:46:05 -0700 (PDT)
X-Received: by 2002:a81:1194:: with SMTP id 142-v6mr213044ywr.168.1537584365536;
 Fri, 21 Sep 2018 19:46:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 19:46:04
 -0700 (PDT)
In-Reply-To: <e9eb2c69-5175-d033-cb38-1cc84cf55bfe@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com> <e9eb2c69-5175-d033-cb38-1cc84cf55bfe@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 21 Sep 2018 19:46:04 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLpNvSSaJb=zPQfCq_wwBRnf3BXafZt9UHDdjK7JotbiA@mail.gmail.com>
Message-ID: <CAGXu5jLpNvSSaJb=zPQfCq_wwBRnf3BXafZt9UHDdjK7JotbiA@mail.gmail.com>
Subject: Re: [PATCH v4 06/19] AppArmor: Abstract use of cred security blob
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 5:17 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Don't use the cred->security pointer directly.
> Provide a helper function that provides the security blob pointer.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
