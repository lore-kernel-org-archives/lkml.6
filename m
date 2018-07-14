Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CE9ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 04:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B675208CE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 04:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qUmPRRY6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kn0i4sIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B675208CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbeGNFBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 01:01:54 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:39025 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeGNFBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 01:01:54 -0400
Received: by mail-yw0-f193.google.com with SMTP id r184-v6so7127183ywg.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 21:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=aQHsyx1Nte4fpKoux+yLig37fd8DcXMVXzLHv04tjsY=;
        b=qUmPRRY6I9smXV+PCC4cBhPRTp9OnsItlpnHdYMnkuhQhTy0i9JxDVXt66YgDVJmP0
         aN+RVv7HGw/wOLxzB3cHOupEGqpaUGN3hVAPvggQa+2Pt6KS4a/JdNjFmI2FqdWmRJP/
         Bis5OUfTCSAn7sQWO0AoM98bo/mfy9XtBQQ9KgjumnV8QIX+Lke2agOFO6XUMqLDr0UM
         0lWt2dzEundc+mjn06u7QtoBrcJc0CQg8mdqZ0ywTT+sVANt1OLhYgGB3RSD11kMAT2E
         pbH3gXErOeW1Qhq2akJQb1rRsk28cENoVa8Ffjk2FVuVTG8OZ/z3wdlZiUpk+y5T3tb4
         m1uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=aQHsyx1Nte4fpKoux+yLig37fd8DcXMVXzLHv04tjsY=;
        b=Kn0i4sIfreHr7ylOJGnEafaEMGH7Y0l9QiSAWAq7atZIig+UxjJiQXznJ0d/9KPtsw
         BzMg5hIryCdVaAYb/y9dzZUlusnw8emomu2b2OEOvIVbYO2ncMLNX3SF5tsnTk5DemZf
         L0ySnHUUiOyJNSTC9CpMcpzBu+Iys08Z1pu9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=aQHsyx1Nte4fpKoux+yLig37fd8DcXMVXzLHv04tjsY=;
        b=Zcyze2aP2gF/pYxMB0QXfQxm+tMXRjuwk8hzRmY5gtMiKDQaeTlDQ8biXmCvv1W5tg
         cu/wGZ0+yexbESNlFGyDtHfdqP2bNJBDKtYOW+3HH2KYzpiY2zflQt1fI8jzbx5sl8Jz
         +lvW0U60NKxzoyeu5+2e2lj7AWMgyqGLWcOxB6GTxJq9B0/IPgFZQvQ7BhbRZdDTCYhi
         PeCaWVEACHCL1ujuXgDHVSnqQGfTNi3iZ5JpFP3KN1tThXU1U+cSh+LuXOhvO9lRI28W
         VMgXdCjJ8GAMz4yavWbzsU/5azkfF5BLbOvL98MXmnGtMT0yNFwu3FsuA2aYhRspM7Oc
         u5gA==
X-Gm-Message-State: AOUpUlGXBBrAYpiaSZ+7zhcI6o+/GrnDWinpMi+Dl0XlYjMl8ykxZ0Gv
        KJ+3eODcZ5qLao/V+Ushzq2hgDem08ee+H4ZrjTNOg==
X-Google-Smtp-Source: AAOMgpdFBIFySUq9BmPGfqTbjI0EeUwwkWWS8fil1RLyrIs7/5STPWjQzYSSpSfo5nqAGIBDyYpFyH+JWCbs/4xGviM=
X-Received: by 2002:a0d:d287:: with SMTP id u129-v6mr4597619ywd.95.1531543456545;
 Fri, 13 Jul 2018 21:44:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 21:44:15
 -0700 (PDT)
In-Reply-To: <20180713135541.7ada72437862c32f4563a9a8@linux-foundation.org>
References: <20180712130733.11510-1-adrian@lisas.de> <87sh4o5s82.fsf@xmission.com>
 <20180713135541.7ada72437862c32f4563a9a8@linux-foundation.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 13 Jul 2018 21:44:15 -0700
X-Google-Sender-Auth: YI6AXLyNpF5tjP8Yr2AAzcdPeU8
Message-ID: <CAGXu5jJMBDd3-Yab78aYwQ1N6VG7=BjARoTF1pDygPhaWA9VNQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig: remove EXPERT from CHECKPOINT_RESTORE
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Adrian Reber <adrian@lisas.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 1:55 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Thu, 12 Jul 2018 11:33:33 -0500 ebiederm@xmission.com (Eric W. Biederman) wrote:
>> What is the value of disabling this functionality ever?
>>
>> Is there any reason why we don't just delete CONFIG_CHECKPOINT_RESTORE
>> entirely?
>
> For the vast number of Linux machines which aren't servers?  Check out
> some defconfigs - only one of arm's 119 defconfigs selects it.

Right, and I would bet the minification folks would like to keep it
out of their builds too. I think we should keep the config.

-Kees

-- 
Kees Cook
Pixel Security
