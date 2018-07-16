Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAE9ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3756F2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRIehX0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3756F2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbeGPVv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:51:27 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33188 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbeGPVv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:51:27 -0400
Received: by mail-yw0-f196.google.com with SMTP id c135-v6so14727823ywa.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 14:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uP6e0Z0pvJvyUAQDYAM/zoFR5JtkAnySkd70fHejRhU=;
        b=lRIehX0YWEM/kEZJD6rCjjPfqxpQ2+YMkjDnRTHNBR+vTRFdQcLylIs31IOqJnbT2Z
         cWGrjKoMnPNSRJ0pIWAlAoZIn2Mx5387dPZxmOkapWbC372xlLLeh2jtBXGlQG4pG8C3
         n6fVCvOI8hz2+4gLRFm7XHIAc5GeSJ8G26NWkx6veurjhsB17RXQB77T6MyXygsvA2V6
         b0nG0MP5huGqyQl7ac0aebS4iUPnKTCQSyhvhkSO84zPzpxOmcIlVNK+1hmj+cEM+OcC
         XTHuTZXLFtiyngBLNn+zd3yN9XatVpclKvj0hgmiunutpggdejVMA7lw0xzsetJ8eR3d
         2s0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uP6e0Z0pvJvyUAQDYAM/zoFR5JtkAnySkd70fHejRhU=;
        b=nbp6f2qJgCnxjxVMxB4xiH2fehybS9ctFiiBXxXWtu8y7cg4ApfxgwR2Tc2Sgmzq3s
         qn4ckrdkVFOKsk+m1MjHxfU9F75fR0SjNSXqhZMPzkOc51KRc4bLTecIM4UbrPVf2k13
         zSnZ4S5SnAqMiloBRlR0rpCVFFmjUcLNiE+VlPBrAcZo9FQaJFYJF/j6i7vNns8sOz1q
         9ISUEdIwdo7ixnv8AnXQ3tUINYsj+NLa8E3b97D8X5LZNd5zvze8H4LBKPShklZBoKfj
         1nz0gkY2+ayqYRiQhhGq6MxLApOw6ucGmBoOgbE3HVe6skTlbx64ehaJ7LPfvKiW7Vty
         0s4A==
X-Gm-Message-State: AOUpUlEsfq33LSfAJ67JhaPueUcJAooCOb2RPjcRLuzIC4BG22f6DTiJ
        kE49tNRMMKhWS/uSPNYFTlQHCr0i2kuy4AJACcM=
X-Google-Smtp-Source: AAOMgpfpFoeuUGGd+XRL+GggrbcttsYAtqAx/OtZMKeIzVBJ6GzQO0qJRNh2Of/CZVyG8LfW0Bi4q4dDY/kj+jHeVgg=
X-Received: by 2002:a81:2309:: with SMTP id j9-v6mr9146942ywj.261.1531776132647;
 Mon, 16 Jul 2018 14:22:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5e42:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 14:22:12
 -0700 (PDT)
In-Reply-To: <CAE_wzQ8GSXb=6Jt1imJyLKSfspVnjOuYb+YOuGenr6R916G4Vw@mail.gmail.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com> <20180714055816.223754-12-toddpoynor@gmail.com>
 <CAE_wzQ8GSXb=6Jt1imJyLKSfspVnjOuYb+YOuGenr6R916G4Vw@mail.gmail.com>
From:   Todd Poynor <toddpoynor@gmail.com>
Date:   Mon, 16 Jul 2018 14:22:12 -0700
Message-ID: <CAO3upoYuwq8V1hSHFHB5KKosCyuVd5PoOxmmb9haLtWcfGZKUA@mail.gmail.com>
Subject: Re: [PATCH 11/18] staging: gasket: always allow root open for write
To:     Dmitry Torokhov <dtor@chromium.org>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhongze Hu <frankhu@chromium.org>,
        Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
        Todd Poynor <toddpoynor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 1:25 AM, Dmitry Torokhov <dtor@chromium.org> wrote:
> On Sat, Jul 14, 2018 at 8:58 AM Todd Poynor <toddpoynor@gmail.com> wrote:
>>
>> From: Todd Poynor <toddpoynor@google.com>
>>
>> Always allow root to open device for writing.
>>
>> Drop special-casing of ioctl permissions for root vs. owner.
>>
>> Reported-by: Dmitry Torokhov <dtor@chromium.org>
>> Signed-off-by: Zhongze Hu <frankhu@chromium.org>
>> Signed-off-by: Todd Poynor <toddpoynor@google.com>
>
> I think this patch is good as is, but as a followup you should create
> a patch that supports user namespaces, i.e. replaces
> capable(CAP_SYS_ADMIN) with ns_capable(...) in gasket_open() so you
> can allow containers to control the device, if necessary.

Thanks, I'll add that to the list.

>
> Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
>
> Thanks,
> Dmitry



-- 
Todd
