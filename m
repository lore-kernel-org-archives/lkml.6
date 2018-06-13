Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AE11AC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 03:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A39E2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 03:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="flWtiAnI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A39E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933693AbeFMDfG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 23:35:06 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:38054 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933290AbeFMDfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 23:35:05 -0400
Received: by mail-wr0-f172.google.com with SMTP id e18-v6so1096556wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 20:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OVUHN9dP2qoUBw/pR4ibfP3vS/NlyCWVxnEf9Iv3Q4E=;
        b=flWtiAnIvvT6KRXdXMrUnOJn70z9I1fS19w3UTYZxuFDZ6Tl75lWifC9AP791Usnnq
         hoGygMLLcopX0221gYjfjNuc8req+o3qZwC0UCUi6fEOFyeDjhKqZzxVntpIU3h3HBDL
         Ohbm6v1kAdEFWxc1hn+93UWbAV0XelxsmpcYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OVUHN9dP2qoUBw/pR4ibfP3vS/NlyCWVxnEf9Iv3Q4E=;
        b=O1Ipi3adUCpQ9+x6vM8IhhhyNckjPxTolIPS9tAoyIkHkl8BIJG0+jeWvEKHSJsL1w
         ou7qYpYXMtjpWx48dVyCuqkAodDebo7sMNCGqEydqiJWSLNVSvWI7wWVMY06JgxNnSuj
         /oOoHhp7wXxmJTxey7KzkrineGnbo1Ni4ga4DyK0kYDu6WOl+d4oXwTD1SJPHUPY/N1B
         pTh4OAIthNOmNfaBJ2MQx+4MvZR9C5NbKOHBf/VvtOeqk4k1mG96smEmzu0oiXiwjVwg
         czzm8vH+ha9fqgLlY5wyzTGou915BQUCkeqXUgCKOWMysbQbE9pNboqXSRjqzbvbxCRy
         kFBQ==
X-Gm-Message-State: APt69E2+qDp+sMqlWjRbXyWCANTSFoIHMuCxHHgQ5hSB/xvm/ZNITnYn
        mgpew6p1hm24uJVKTvGpsosgLWrcpp6zPUcJsgQC8w==
X-Google-Smtp-Source: ADUXVKITTJFy/MnoycZR3eCbgrJzDJUeiwOg92aycuYL87W1swTlnfKI+flwU2o1eNJtcSS9FQBUYUoJlRzR0YNzMHI=
X-Received: by 2002:adf:ab96:: with SMTP id s22-v6mr2748853wrc.90.1528860904206;
 Tue, 12 Jun 2018 20:35:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:8ac3:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 20:35:03
 -0700 (PDT)
In-Reply-To: <CALAqxLW=nrX-S9eibsTc+S_4YsZ166OJgZGj_1TZRWZ2ut7aFQ@mail.gmail.com>
References: <CALAqxLW=nrX-S9eibsTc+S_4YsZ166OJgZGj_1TZRWZ2ut7aFQ@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 12 Jun 2018 20:35:03 -0700
Message-ID: <CALAqxLXcF6qzYb6doFMLzRPAFeodm7dYvOATdX6RjF=q+VMQbw@mail.gmail.com>
Subject: Re: REGRESSION: "wlcore: sdio: allow pm to handle sdio power" breaks
 wifi on HiKey960
To:     Kalle Valo <kvalo@codeaurora.org>, Eyal Reizer <eyalr@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 3:12 PM, John Stultz <john.stultz@linaro.org> wrote:
> Hey Folks,
>   I noticed with linus/master wifi wasn't coming up on HiKey960. I
> bisected it down and it seems to be due to:
>
> 60f36637bbbd ("wlcore: sdio: allow pm to handle sdio power")  and
> 728a9dc61f13 ("wlcore: sdio: Fix flakey SDIO runtime PM handling")
>
>
> When wifi fails to load, the only useful error message I see is:
> [    8.466097] wl1271_sdio mmc1:0001:2: wl12xx_sdio_power_on: failed
> to get_sync(-13)
>
> Reverting those two changes gets wifi working again for me:
> [    8.754953] wlcore: wl18xx HW: 183x or 180x, PG 2.2 (ROM 0x11)
> [    8.761778] random: crng init done
> [    8.765185] random: 7 urandom warning(s) missed due to ratelimiting
> [    8.779149] wlcore: loaded
> ...
> [   12.945903] wlcore: PHY firmware version: Rev 8.2.0.0.237
> [   13.058077] wlcore: firmware booted (Rev 8.9.0.0.70)
>
>
> Any suggestions how to resolve this w/o a revert?

This also effects the older HiKey board as well.

thanks
-john
