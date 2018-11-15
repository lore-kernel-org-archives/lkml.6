Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C272BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D0B22419
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRcYi+IN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D0B22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387912AbeKOWD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 17:03:28 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39581 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbeKOWD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 17:03:28 -0500
Received: by mail-it1-f194.google.com with SMTP id m15so28820920itl.4;
        Thu, 15 Nov 2018 03:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G8Y5W7rc30RQqIF5Pik9YN0alb5dkx5ewzntHywNtZw=;
        b=gRcYi+INg2y+WboP7xR74ve4nXnLsk0/pjfsJH2e10fu0K2bnKWHkyY15VSeNjMQXS
         hTu2Ze5qyCycLYOH2gEzZu9uX20xqdsPOPh3+wSKBh4k8bK1HUmSBmxaDAoSlzqErdGW
         ImY1SoelcKQl3oUe+JJ8ZeaopsG204jMecVCmY9Eo6dEvvy6ojSncU3qFUFjfGOQfCP1
         b6xsRgZtWV9bf6MQsc+AvGKoWKu55ofj7KpuLRnrdWDjqex5cZacPI5A0TTSgTeivHR8
         FMioyxuiAd58gAoVPe6GQabADgqOFB1oyBkPkA7CyPTwrwG525DlizW3aaeWEeYw+iwt
         qkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G8Y5W7rc30RQqIF5Pik9YN0alb5dkx5ewzntHywNtZw=;
        b=BGJHrd2O4N0UnBd+utM1yHWy5VuOJsjxWJrEle1oT/5X7NTNuuNfeYmRI+UEOmst4H
         LvgJLKWx7x7mkV1Xkx1UDqK7CvqEBj/Pc3OVDMvL2a7j+94L20GIP6ELKU775TA5Dna5
         ap8WSJBhPGRGW9upecLB8Nq21ZnMVjaUYPp/ZVe6Gq9bMUMhSsnZUM/5rTTfWv+XDara
         vYcChAT+O74/WJAVncboP2LcTyf/QzqLQV8OaBySkyG+6S1xoNS/EKgmG+WbF2sbX5Cj
         pNQcxpmHa72bGJQmco2TY1r4QDJsreLhLCZET0SU6IpwT1pA660P7w1VNj3W87hEFPD+
         5/wg==
X-Gm-Message-State: AGRZ1gK4haX665cxnG33GRZwtyf1IuG6Ps/PxG1+3bmZepvc35ngItsc
        zda+BGkHnaT0ZCuoB8zwlVa/XClwr+abuuexw0s=
X-Google-Smtp-Source: AJdET5dQUT9zwcFDn32FBTMJk+P7jPzc6WFGVHn6ATNLmuPwJyiFQQrmOG8+0CVstxioUxknl1E9rQ5OlaqvxqOJd1Q=
X-Received: by 2002:a02:ba01:: with SMTP id z1mr5494861jan.100.1542282955397;
 Thu, 15 Nov 2018 03:55:55 -0800 (PST)
MIME-Version: 1.0
References: <20181114131642.21425-1-dh.herrmann@gmail.com> <ea944fb3-0cd9-e6e6-5449-faab7c9603c1@redhat.com>
 <CAGXu5jJJGg5_crJ3v+AG5JZWVGLpDvZGr0UVyurzFxcv9Fwa5A@mail.gmail.com>
In-Reply-To: <CAGXu5jJJGg5_crJ3v+AG5JZWVGLpDvZGr0UVyurzFxcv9Fwa5A@mail.gmail.com>
From:   David Herrmann <dh.herrmann@gmail.com>
Date:   Thu, 15 Nov 2018 12:55:44 +0100
Message-ID: <CANq1E4T6rKjVPwGd-4CDWZzFYz1ohzPSpKGd2kK+O4BNSe--Hg@mail.gmail.com>
Subject: Re: [PATCH] Revert "HID: uhid: use strlcpy() instead of strncpy()"
To:     Kees Cook <keescook@chromium.org>
Cc:     labbott@redhat.com,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        xiongfeng.wang@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Thu, Nov 15, 2018 at 12:09 AM Kees Cook <keescook@chromium.org> wrote:
> On Wed, Nov 14, 2018 at 9:40 AM, Laura Abbott <labbott@redhat.com> wrote:
[...]
> > Can we switch to strscpy instead? This will quiet gcc and avoid the
> > issues with strlcpy.
>
> Yes please: it looks like these strings are expected to be NUL
> terminated, so strscpy() without the "- 1" and min() logic would be
> the correct solution here.

"the correct solution"? To my knowledge the original code was correct
as well. Am I missing something?

>                            If @hid is already zero, then this would
> just be:
>
>        strscpy(hid->name, ev->u.create2.name, sizeof(hid->name));
>        strscpy(hid->phys, ev->u.create2.phys, sizeof(hid->phys));
>        strscpy(hid->uniq, ev->u.create2.uniq, sizeof(hid->uniq));
>
> If they are NOT NUL terminated, then keep using strncpy() but mark the
> fields in the struct with the __nonstring attribute.

They are supposed to be NUL terminated, but for compatibility reasons
we allow them to be not. So I don't think your proposal is safe.

Thanks
David
