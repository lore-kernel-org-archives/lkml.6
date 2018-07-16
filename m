Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E45ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5952098A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PJH/my7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5952098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbeGPK2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:28:06 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52407 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbeGPK2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:28:06 -0400
Received: by mail-it0-f66.google.com with SMTP id p4-v6so20004062itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ytCXDJ5cA1fpKfx69kXxfPQrxzXcVx3fvZmWr/KCvbE=;
        b=PJH/my7Ll9OkLBdCBhkShrlxYEMXSENkxuiSsfWHFejBCtbcqGlx3Ajf4Mi7GXSVmO
         4Fr9sFIARKJKvUt6K6PpSpfMHkkMNaO4HUzSa7vDljqb+Pl9ETwEwDI6lzp9mtVkfcRN
         Q5J+dxuDBr+m1+3PyYD92dJGJ6RMxvYx5w+E4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ytCXDJ5cA1fpKfx69kXxfPQrxzXcVx3fvZmWr/KCvbE=;
        b=l7531zIFxWvBZDCy5P07SB0ucKPC5X/oq7X2TMhDxmnCxcQrGt87rQ7FQ0nUi53mEq
         7FOlix9CPI0XuDX/OC7o+2hCk5TkgewAwukPE47nKu6o/Or7Fm3aylktBVu/BZDwbwYr
         GND9PIJ7ktxqdNKEPpRK8OZeylDAU57tsILfwcg3/svZgwwlVf6QcBP6SyTyrv/cWYwh
         Hr3T2iIbXXDoEUXR/nUA6MkkTLj4Uix1PKlk2KIzp0TlvKRId4egVdNejqMG7d19R6Z8
         UrKWFrVIxX0lqZX+aTkupCJkhABZDWCcZ8dtNKkFfkZ3qMujdYBkqYFj8XicKOycpzLn
         PHcg==
X-Gm-Message-State: AOUpUlHCTZt7fjrUc/cQ85IQ3RqsQh3fHpKHNbRJJ9XjcMUV+HdHYwHt
        o2qPsKwQS+2HelMgfcvPso4rfnQffYxzVHn5HbfClg==
X-Google-Smtp-Source: AAOMgpfOmyykKs9eyySI0mrkuywKrt4V8wRRkr3wEfpT1VUbGZkO4E5clQxk/ULo7rIpNpjypt6vezQMBhOm5oi4OCA=
X-Received: by 2002:a24:1c09:: with SMTP id c9-v6mr12672089itc.38.1531735287706;
 Mon, 16 Jul 2018 03:01:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 03:01:27
 -0700 (PDT)
In-Reply-To: <CA+55aFxONTOE8A+Mm=V2mieqnJ=Zypvu+NJeede2aR7kLu5SMA@mail.gmail.com>
References: <1530601587-160436-1-git-send-email-xiaqing17@hisilicon.com>
 <CAPDyKFrPw63KD5mESDmm2pya6bsz01jHiKguMP1GPhWDDZ644Q@mail.gmail.com> <CA+55aFxONTOE8A+Mm=V2mieqnJ=Zypvu+NJeede2aR7kLu5SMA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Jul 2018 12:01:27 +0200
Message-ID: <CAPDyKFoh8STtMC-5jOy+1xuWf=dBENbZJ9GCkYT0=-eRFNMzAw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: fix card threshold control configuration
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Qing Xia <xiaqing17@hisilicon.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Evgeniy Didin <Evgeniy.Didin@synopsys.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 July 2018 at 22:31, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Tue, Jul 3, 2018 at 2:00 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On 3 July 2018 at 09:06, Qing Xia <xiaqing17@hisilicon.com> wrote:
>> > From: x00270170 <xiaqing17@hisilicon.com>
>> >
>> > Card write threshold control is supposed to be set since controller
>>> [..]
>> > Signed-off-by: Qing Xia <xiaqing17@hisilicon.com>
>>
>> Thanks, applied/moved to fixes for 4.18!
>
> .. and during making my 4.18-rc5 announcement, I saw the odd name in
> the shortlog.
>
> Now Qing Xia is forever attributed as "x00270170". Very odd.
>
> Oh well.

Apologize, that slipped through, somehow. Will check more closely going forward.

Kind regards
Uffe
