Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C5CC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF962083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+l/LWdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbfBEPbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:31:15 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44253 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729510AbfBEPbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:31:15 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so1607860pfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 07:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=42t26Vl1whRvSVA0hskv/fdLmnBBfdLda3UY0e15Ujo=;
        b=U+l/LWdqRPjlqpX0ZRgn1OQBxNSPTledJ9TxgSkGOcQhRIhupjMvQZQppNYt/f8lKy
         tFtpXom3Ei7Gu0p+4apsn9IDKXOGRA7DVKz8pULqb6tksG+rPyIK/iM302LEdCLZdit3
         Uv+YcXLTefPDzrPVKtbaTBPF0u9Z1DTKoySDtl2v6kLgy2l597LKy/8FJ+x55T4DyX34
         29OjCPLRd3qec8ZxmQKnq2qzSLtWNnklp7zvg7ypJliVuXGhPIUWgN1aj2pCDUltGopZ
         fJG9thrk93Fk1R4r7AvVy/Z4ub3wUeNj1WSULJPagFUiXW523yiwEtni6xGn0muaJGUS
         ZZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=42t26Vl1whRvSVA0hskv/fdLmnBBfdLda3UY0e15Ujo=;
        b=CXWK9ICK9eB+LdS+1JDQhRtBpq975PrkVz3dRc6pDGm18fjaQTOv4ND63BcPoO0lD2
         26AWhVMwFzDICwO4VDI72RTjy2ptDZW3b+EtkbMeUD44P+CpZ2WuGejffWC5+xjcNDAI
         WWY3RajkYB+yHkmJrUUSLEkP/X79xfT4w9lXs4Udx6AzLoed8NTWvfGMhkHtIfJ+lH99
         MvfbZ0KLyPZ6Rkp9AjK+D8JdzUexcvY4PHBqpqoB7uYSVyCcUiOh/UwKFpOCmapkCn8m
         3wEQLtL8w/QHvfMjWOvL/MOOzTOKABXNrB/VqGUFAjhvQSgLJKuN6ZTDOsQoOAiwc2Od
         5m5Q==
X-Gm-Message-State: AHQUAuZOLZ5jpyxmbBDDQ85RjhyFhHOr4TwhGrYZNkZtKNQBQ+oxATOm
        AVcgDtifeQWYGxUG1gAzxwkawx+w2Zway0VFY/Q=
X-Google-Smtp-Source: AHgI3IaxFYFyJwk9+pFOBfgY56tNqku1mUPJyGNSGuO6GT3oHj++Ovx1ePOWm/6TpAljy5AE/Xg0u6s5/gXAlqNSGnQ=
X-Received: by 2002:a62:d005:: with SMTP id p5mr5571050pfg.175.1549380674507;
 Tue, 05 Feb 2019 07:31:14 -0800 (PST)
MIME-Version: 1.0
References: <CAHp75Vfh26ija7trPts0U8OfmPAMQzcbj4Y7wdcxb18yYQiCZA@mail.gmail.com>
 <201902031723170231588@zte.com.cn>
In-Reply-To: <201902031723170231588@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Feb 2019 17:31:02 +0200
Message-ID: <CAHp75VcHNP+j1ArLzEOU3piFBR4Do05exd12b_ijx7hZVvjmgA@mail.gmail.com>
Subject: Re: [PATCH V4 0/6] add pvpanic driver framework
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 3, 2019 at 11:23 AM <peng.hao2@zte.com.cn> wrote:
> >> QEMU community requires additional PCI devices to simulate PVPANIC
> >> devices so that some architectures can not occupy precious less than 4G
> >> of memory space.
> >> Previously, I added PCI driver directly to the original version of the driver,
> >> which made the whole driver file look a bit cluttered. So Andy Shevchenko suggests:
> >> "I would recommend to split it in a way how it's done for ChipIdea USB driver,
> >> for example. (drivers/usb/chipidea if I'm not mistaken)".

> >Thank you for an update.
> >
> >The series has the bisectability issues.
> >
> >Try to use the following approach (if I got your idea right):
> >1. Convert to use common probe() etc functions inplace

> I think there is no "common probe" for acpi/OF/PCI .

In that case a careful split would be preferred.

> In this driver framework (like chipidea driver framework), acpi/OF/PCI
> driver's probe trigger the  driver framework's probe. In the driver framework
> it create a new platform device as the acpi/OF/PCI device's child device.

> I don't understand how  the  bisectability issues happen.

IIRC you have a gap in between of couple of patches where in first
some functionality is removed and reappeared later on.


-- 
With Best Regards,
Andy Shevchenko
