Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7A1C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B36214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KtB4G10R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B36214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeHUXy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 19:54:59 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:39586 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbeHUXy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 19:54:59 -0400
Received: by mail-it0-f51.google.com with SMTP id g141-v6so106296ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 13:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jGVFauNwqtFOdwJTGD6V1ycBXrPpY4yd07N+EvqyXiE=;
        b=KtB4G10RfkXahMK9ueTX3x6Z8r+94WkfNon0ToBSyT0WY78u+FJ9xCjoon47CxknvY
         SMvePqasK4zJMHeWveMXU5VEfynLDNImc5vQd46IfRmCynWTgM0viomI+w8LNEM3Y5Dp
         ge9dZEk3Ua5wZwKvLXNxiDjaaP8jp8JCHOj3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jGVFauNwqtFOdwJTGD6V1ycBXrPpY4yd07N+EvqyXiE=;
        b=QLfVBpvdVaGy+2beEC4/zSXSGO6t+LiL6O1/D/WfbNY08uz3dfr00sZOfdMf+h/ANz
         TiBK0eGhkZgN6uAzs30iJQ41pRMiqBcNgwj+/Nq7VLJEL3FBObRFP3koL/P6KG0fa+hG
         y8JXirzo48irBdEtOJ8uwbxisukhSBQWX6edBAG6zDZVJL7kfHcw2EyHeBgUVeOBBW/+
         tZqv7hH3E5kyvquaPSTyIEIp3piKbpfzgNMnjO1Le+jJ0mrfh+/GV1ewzgpWGzfys8ZJ
         WksQTY5XYboygd9RKOybWNof7/to3RAS591F143GRSLpk0126/OiDRbtmqr+5BSW8UK2
         vBvA==
X-Gm-Message-State: AOUpUlE7wp7vlc6qYqBK1Ak7t5BkkhpQjviVbe1YAGNVkW2lJ2OyR6Gv
        OQ6SlGd0oBr/lxxvrW3nnoqYC31caUsUIkj5YDHqxcPd
X-Google-Smtp-Source: ANB0VdY5p0ebbundDSRV/EuMKo6oALdDjwLZy4qzTK6ZDFBqWDT9zqFOx/FifeT74j1ai+/7FAcfHkt04W1TtcFTWAs=
X-Received: by 2002:a02:9d45:: with SMTP id m5-v6mr5268695jal.72.1534883599954;
 Tue, 21 Aug 2018 13:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <8736v8dp6u.wl-ysato@users.sourceforge.jp>
In-Reply-To: <8736v8dp6u.wl-ysato@users.sourceforge.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Aug 2018 13:33:08 -0700
Message-ID: <CA+55aFxDWrndr0ZxM4kTJYC5ps+Hno1dCX==4071soSqcEjUxw@mail.gmail.com>
Subject: Re: [GIT PULL] arch/h8300 update
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 2:49 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
>
>   git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git

That actually just contains some very old garbage.

I think you may have meant for me to pull some "for-4.18" branch, but
there's nothing like that there.

> for you to fetch changes up to 724d2da5ebca23d7e7cc57d4ade5967c691c3817:

There is a "h8300-next" branch that contains that commit, but as
mentioned you used to have a different branch naming scheme, so I
really want to double-check.

                    Linus
