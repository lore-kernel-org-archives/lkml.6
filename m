Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D881C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF6721855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JeovQ4LB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfAWUSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:18:14 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:39715 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfAWUSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:18:10 -0500
Received: by mail-lj1-f182.google.com with SMTP id t9-v6so3130827ljh.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 12:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CWykzvzCQwylrNwqIbdvs72zhwcxoZy4LS2dPA7HKIY=;
        b=JeovQ4LBeWj1Q2WOgu92A92JTokTDzD34hxhC4pn4Wjd/sy9+Z3i1ev5bNT+Z5U3uI
         cg/OMYJ13gYoGjnVwnilj+q18r/E9f2K3POtP5Id0m4+k/0kiKjUyQ1t8g3tFHsRzveK
         pLdbV2eHqT/MacF2As+kdYbT/c2GpcXGBt/e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CWykzvzCQwylrNwqIbdvs72zhwcxoZy4LS2dPA7HKIY=;
        b=bcK26PiV5Rx4XsfNjgRQE5rWL+xL2SIHiX6pYA2d6BcP5Vf3+gRmiRuFeikfv0sytC
         A1C5yvHGeKhh4OsogkU4n9XaoCsPoy3UjEiY0TiCvjS+xL1rj7DvlLEq7r8z7HIAHcRY
         ukRfr9ZeONebyBldLx9miu43vjOqvLTnqlh1CTwdC+7T7LAQ2C70+im80h/PfvOSA9IH
         V9xuoHpZpOija5j89lPuDKApN17QkwxLIFOpHikkog8PqgziurUH9P8E+KcSH7YQ43EQ
         D7x4cKChXXtFkDE0fZkpB6fx6uQyMBs2kPmpus9TShFRzB4XqwbLJ+/eKD9RRpOf8/zi
         duWw==
X-Gm-Message-State: AJcUukfP8RgBwSAA9rK6bdl9O76M/ciZ1I/LOUq8WD9x/kpElhIsejVK
        i5gxAYj+lIU0YcDBwO3SlWSQteRHNjI=
X-Google-Smtp-Source: ALg8bN4qeYuDy4WFBF189iWWf2yFFSk9zBZbEMTY838UMARC4S6Sx0ra+Ed0N9+WYfEdPYYs129e+Q==
X-Received: by 2002:a2e:4784:: with SMTP id u126-v6mr3128828lja.124.1548274688070;
        Wed, 23 Jan 2019 12:18:08 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id v5-v6sm681426lje.78.2019.01.23.12.18.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 12:18:07 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id s5-v6so3108940ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 12:18:05 -0800 (PST)
X-Received: by 2002:a2e:990e:: with SMTP id v14-v6mr3179622lji.60.1548274685042;
 Wed, 23 Jan 2019 12:18:05 -0800 (PST)
MIME-Version: 1.0
References: <1545373748-1416-1-git-send-email-jshekhar@codeaurora.org>
In-Reply-To: <1545373748-1416-1-git-send-email-jshekhar@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 23 Jan 2019 12:17:28 -0800
X-Gmail-Original-Message-ID: <CAE=gft4vYvqi3cqJTb8GhMo4dGbNzTi4txqfkMi7Ky1hZiwfvA@mail.gmail.com>
Message-ID: <CAE=gft4vYvqi3cqJTb8GhMo4dGbNzTi4txqfkMi7Ky1hZiwfvA@mail.gmail.com>
Subject: Re: [v1] arm64: dts: sdm845: add interconnect DT entries for MDSS on SDM845
To:     Jayant Shekhar <jshekhar@codeaurora.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>, seanpaul@chromium.org,
        hoegsberg@chromium.org, abhinavk@codeaurora.org,
        jsanka@codeaurora.org, chandanu@codeaurora.org,
        nganji@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 10:29 PM Jayant Shekhar <jshekhar@codeaurora.org> wrote:
>
> Add interconnect properties such as the source and the destination
> ports for MDSS on SDM845.
>
> Signed-off-by: Jayant Shekhar <jshekhar@codeaurora.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
