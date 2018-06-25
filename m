Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36AFC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC645255CA
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhOSa3gH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC645255CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754264AbeFYIU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:20:59 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:45731 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbeFYIU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:20:56 -0400
Received: by mail-ot0-f196.google.com with SMTP id k3-v6so548963otl.12;
        Mon, 25 Jun 2018 01:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kX3BEvfJ1dm99UbUcDiQfNqwfKVPN6ayJA/GHX7RFZA=;
        b=PhOSa3gHWvjn7mXCCeX+pEvTZxWmLamX/4fJR7vC2/rNSiJTNAh+1qFKBELeKFBjIs
         CGN+7jXQc7pYeXbialRPcirYVSsaNoe4JRaQ2HjoPNQxeBRnmrnCIFlEpHEtaxtBE0TL
         EDgB6KRmF9W8WXJCrepcLrvU5xW7zrAROTpVEJcJv7hfrkhpcxtnqdiC+cbjTGy7K88t
         r50N9kk1zKKm4ou7cBHIu+mEo9zjNCY4CBrhqvGBJSmJyOujDbRIYzosy5+b4YYObXIr
         A+5FlSO6ERZIh8Li23kfmXPcS22F8VWqix6iNoxtgV7/J6hSKUr9mooBMk7UyuxW1ZXt
         TCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=kX3BEvfJ1dm99UbUcDiQfNqwfKVPN6ayJA/GHX7RFZA=;
        b=qlVMAPuM8lMHDN9v5sHINB04NntX95cBagIjjkb6+bEhTD6zF2VHdczsIhGWUHTpJX
         NhS27VN3Vy7wnhNH+fk7r47QJ3YsAPhCHJdpyBYuVjfLmkIu3w47wyfvSQML0AFjZC38
         gQCtngiu2tziq6xP0YSdFsFRQzfD9Jhzwqo3VvJS1DYa2wc/JopvNGnG2WB5XiMiY9Tt
         uNCtdicsg6kivazGPTNcn0xxvsca0c9yU2Edzd0e3Am8EaCDv4EZd7f2gcvigvqTI97d
         JEgdVkBU+yLsnQy+WAXa6yUpMGScSewOpowWyqFj2UBO6v4ip/sdrW+zL1nzQ1r+/dQ5
         VVyg==
X-Gm-Message-State: APt69E35kcRaMKdnzHzr8EGmvLrOub0clysVSp2Mz58nhTHDOvMngIyl
        n/cBxE7H1+MuZz90aWnBedlAE9+knlovu5CL8n8=
X-Google-Smtp-Source: AAOMgpeuX5wlPoHDlRkH8Dy4iVl9liAA5IAQa9jDYnhlRzxT+daLBYy2JpUuzJhlkmGnoVwIDf7fJm/BdTVDmwZ27kA=
X-Received: by 2002:a9d:1012:: with SMTP id h18-v6mr6381061ote.364.1529914855822;
 Mon, 25 Jun 2018 01:20:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 01:20:55
 -0700 (PDT)
In-Reply-To: <fc2ef4e9-7ec8-c644-9495-e33f000531b2@linaro.org>
References: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
 <20180620043415.57yvgzlye4l7wdqy@vireshk-i7> <fc2ef4e9-7ec8-c644-9495-e33f000531b2@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Jun 2018 10:20:55 +0200
X-Google-Sender-Auth: 81lq_wQ7gV8dVRVlOUb6FQjLb8A
Message-ID: <CAJZ5v0gBC_ZzUBJcNEmeAbDLrJA6K9SqohS0GXtUANKc4o+T_g@mail.gmail.com>
Subject: Re: [PATCH V9] powercap/drivers/idle_injection: Add an idle injection framework
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Mon, Jun 25, 2018 at 12:40 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Hi Rafael,
>
> do you think this patch is acceptable for merging ?

Well, it needs a bit of work still IMO, but let me comment on the patch itself.

Also, can you point me to the code using it that you have, please?
I'd like to try to switch powerclamp over to it.

Thanks,
Rafael
