Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4917C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39DC206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jibAHz/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732523AbeLTQKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:10:10 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:40450 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732380AbeLTQKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:10:07 -0500
Received: by mail-io1-f51.google.com with SMTP id a11so460356ioq.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 08:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WASiI+LGr+j54QgtHqz/Mb0c0vmWaC6GIOI+FQCQgEU=;
        b=jibAHz/hWiGisigzXIHWT63sOyQ3Yo5LngmujgY08aJgD/3dKw1xfQjkD4ddfIIvO+
         gXPRicj8aSRaHyKS7onoovZ59mikIniaIdsynEzp/r8JMFmala/rz0Zg1d0/rQdjLhVu
         uVTaE9zkZ4wQSlG4Y/iB+AOysIerrHwFEg+tqaucITBcsU2xGtTur+dfGm5foFffjiuK
         8FcqrnkzexIxJ02ZEWRdoYsoax0jXxoVNA8FMNvg3Y81tEqCghzwKqO9TJqQm3dck8d9
         PDx0QrKYLF5LXQGFzlQK110xgSHU5meHyHwcwSdBSUxur+cXpVkhfQVZIKY+eEuho2xZ
         laBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WASiI+LGr+j54QgtHqz/Mb0c0vmWaC6GIOI+FQCQgEU=;
        b=hP2J1MLMj9+93k+u9aIa3zXktA0fJ2rz20uCZuzemBDewsIUXzyrGWJhDn+pDed0fV
         M6FiKe1PJPdK9GtGIuMiP+4fBSd5WiKvE9XfO7QmwAs6Z96cHa+1mXsNxLBCu1tCTNen
         PMFvu9QAkE7ZemUQ0GlcTnz3e5GFdp6T19tmad24gGirqe7F/Npzsogus8erw1eNpAQu
         fBzAdGExwunGLtw+6N6EEhdzqkKTPkGNlrYwqy32wxjB6QN8x63UQLEnn0tJAdu2O8bl
         O62ghgZVo82sm9PIDTrT2mioUn09G/y5nj++a+jYRPX+TT7pDOu0uK1Xe4oeZ35kSh2H
         1cyA==
X-Gm-Message-State: AA+aEWZZwNmDBa+QlkfSbmnOoJdtk4hHGSFlptWY3pLRAuQ8L/if1iij
        8KcqI8tBhvn0CgUmjPLX+svcLWQG7ewqt821YZ8=
X-Google-Smtp-Source: AFSGD/Xb54zM3zrjZTrzDO9vA+Ipy3Vcv0RE3PVhkibl9KaBlHgE00bJPoJ7axfBowYkV/QOLu4sOLq1PGpU4ZAeEEE=
X-Received: by 2002:a6b:9355:: with SMTP id v82mr22049626iod.40.1545322206627;
 Thu, 20 Dec 2018 08:10:06 -0800 (PST)
MIME-Version: 1.0
References: <20181202021710.9307-1-tiny.windzz@gmail.com> <CACRpkdahwmjED=BY715E+cpRhveqk32vCRpevyHF8SdcqC0kvg@mail.gmail.com>
In-Reply-To: <CACRpkdahwmjED=BY715E+cpRhveqk32vCRpevyHF8SdcqC0kvg@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Fri, 21 Dec 2018 00:09:55 +0800
Message-ID: <CAEExFWssZtWV3XnJpjwm8BXAE4duhrrvjaPWQhfRP3W4y-O1Rg@mail.gmail.com>
Subject: Re: [PATCH] mfd: convert to DEFINE_SHOW_ATTRIBUTE
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping......
