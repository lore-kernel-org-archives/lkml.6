Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB004C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8B1208A1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZoHifRun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8B1208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeHVVJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 17:09:07 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:36943 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeHVVJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 17:09:07 -0400
Received: by mail-io0-f170.google.com with SMTP id v14-v6so2107304iob.4;
        Wed, 22 Aug 2018 10:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NIJlMIgsUHTqF26I42Ulp3qqgTcejI7TJPSGkPwLa/8=;
        b=ZoHifRunOrAjenTxuFVT5KFONxWcHyifjznrJA3c5utfiR23rGNjlJHD+5Fxkz2fMv
         9mDaTusiN9b6lvS7DdEWfR3Lpi5DQhNYWJQ832m9vA3Ys1EYBFK4iv7RH/UO6DftDAEc
         aVoKCCxy61oTzyfetZLqFe5DarT3x6ELAwqug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NIJlMIgsUHTqF26I42Ulp3qqgTcejI7TJPSGkPwLa/8=;
        b=WV2Dr4PEqKd80MhXPHyKuOFQP7/RrnDXZCssQ4ZTBkP0rL4posDC9l96OToGHHcmK5
         55bSL2/Xp0eGC/2n1JCKWSHZJ73EY9411VTsMmyLsi2HAbnoSTpswhNDruhfZhFFhZrt
         IYWtiAhvDE0DE0DY9QNS3CJrb1Pe8hG7WE8foCvqJTA62XnOGRTunYMIPQhlzHTWnWya
         mNuUa27qww2Zpt3RqjJgIoRwuDlnqEUdKftM/OAhH+Wfb5+VIm6x64L+wku3z1IvIpSU
         /QvBhsY0lEwgK/GTbW1Oqr099l6salpPtBMKsf6+vwPCwz+fG+EPpjbIJ51wsgJDA2Y8
         A+GQ==
X-Gm-Message-State: AOUpUlHzFwie9G1LfO4tss4Pc/ysiOILSIQlCaah0ZVfhbfZbiD46nXV
        LIXHePtkB8z0Fuwz84fWTNVsqAZ8x0+XufFf5yU=
X-Google-Smtp-Source: AA+uWPyplnXZkkNoevta6cOrR1gnq6s8Lh+VKWqc89x3Ri232jB9ct88YZg8+1DOSDlnQ99TtIim1lS5R6F6ec+Lx6w=
X-Received: by 2002:a6b:f609:: with SMTP id n9-v6mr30988653ioh.259.1534959796448;
 Wed, 22 Aug 2018 10:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180813161357.GB1199@bombadil.infradead.org> <0100016562b90938-02b97bb7-eddd-412d-8162-7519a70d4103-000000@email.amazonses.com>
In-Reply-To: <0100016562b90938-02b97bb7-eddd-412d-8162-7519a70d4103-000000@email.amazonses.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Aug 2018 10:43:05 -0700
Message-ID: <CA+55aFzN3aq1P8ykE1+XuAR9pbH7nETOyMoBi-N52Ef=WjrFLA@mail.gmail.com>
Subject: Re: [GIT PULL] XArray for 4.19
To:     Christoph Lameter <cl@linux.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 10:40 AM Christopher Lameter <cl@linux.com> wrote:
>
> Is this going in this cycle? I have a bunch of stuff on top of this to
> enable slab object migration.

No.

It was based on a buggy branch that isn't getting pulled, so when I
started looking at it, the pull request was rejected before I got much
further.

               Linus
