Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9EAC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86236214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uCldSUWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfBLBVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:21:35 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36388 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfBLBVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 20:21:33 -0500
Received: by mail-ot1-f66.google.com with SMTP id k98so1704898otk.3;
        Mon, 11 Feb 2019 17:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OdJwvr0RjqaUv1039MMAoWFcWZONCzVzZATcqFdsWwo=;
        b=uCldSUWkLa5iuTtgDJ7lGIW+BS4uYUw0oW/l6z24LIswm+MZbzvtMuZ9U1rQAInEry
         AbBPIoUtgPbzQTAskw1+TEwQdBryS6gGxnfeScILSpOkjTU3IF/zP8E91wSTfN2zn2m1
         OKzenHADQWF5e4c/q3P6kFeDehXtesVXxmIK/rXbGx6CtXy/4o3zu1T8A4NK0h4W2rhE
         2Vd+I1+RZWk9W6LuUidIPG2u67VFvbYsLakg46fjHOOUl9hxYvW8WZ+gRf5Y22cIyiSp
         /oR88EOXrjqNR8Zjg2doElOqzire0WqY8utkQubJbq8JCx1bUBIyPbIpikwwarYpQ6T/
         O+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OdJwvr0RjqaUv1039MMAoWFcWZONCzVzZATcqFdsWwo=;
        b=bCAgEg6p/MdrlNnq3j/lUyllku+LwODnXgxLYn32z+siIYOCXSBn4f3+VPnG7SquYL
         MVgjxqmG0IkCL1vz2FiQH/Y2l4uiffH9pHrIV8qIC0k3BLBEcMlegKi5YA46dwD6fF2g
         BU+rJwqyxjM4cjFqrfjtOYDoxlnZ+Igy2yQNjhOmqZx28hNqy5rrdLan2k62sM4hwlU7
         At1FD25GQNqzkB+e4VsUg83o6rHjPaYhYrMa1kmeo8fJkq6oB73gj1OtnAp3JO/QqDYD
         Onaf6yqmJcDE6mpemKR1G9F+JhIRfurXapczZPTi8YPvoOQy7N4WNM0jIUhhsDHo/50q
         HwPQ==
X-Gm-Message-State: AHQUAuZIIg5RI1iqjZ0rCyuB9KWarXTEJfjSU5m5pMIuHwy2ghOYIFs/
        4GvY8rHCNQ62Lcp3PhVR3oNZPRavWw3YjZ++vseuHw==
X-Google-Smtp-Source: AHgI3IYpxa7dxVoFw8ySJWCHbXjWSt63Kajy0DdY5EpslRBC/Hy3T46FwQ7gZ63wQY9o1vEqEDuZQulqpsyuGlvOxeE=
X-Received: by 2002:a9d:6a50:: with SMTP id h16mr1048506otn.95.1549934492796;
 Mon, 11 Feb 2019 17:21:32 -0800 (PST)
MIME-Version: 1.0
References: <20190211224729.GA199018@dtor-ws>
In-Reply-To: <20190211224729.GA199018@dtor-ws>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 11 Feb 2019 20:21:21 -0500
Message-ID: <CAGngYiWSTubWWWgm7mY+ux8NronYXekmZBqpGZCh00T4krnuqg@mail.gmail.com>
Subject: Re: [PATCH v2] Input: apanel - switch to using brightness_set_blocking()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 5:47 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Now that LEDs core allows "blocking" flavor of "set brightness" method we
> can use it and get rid of private work item. As a bonus, we are no longer
> forgetting to cancel it when we unbind the driver.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> v2: get rid of led_bits member (Sven)

Looking good !

Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>
