Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCFAC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A42421721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwIYtvH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfBGWsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:48:52 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51991 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfBGWsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:48:51 -0500
Received: by mail-it1-f195.google.com with SMTP id w18so4285838ite.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 14:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jzQzslJ11C0UlZoMvWBLrEA9sQ73JX0eKPxZpsC99rg=;
        b=kwIYtvH7qYzh2T2OOlLp1pjmK4TUAfz88JPIp+W+deQ2XdXeyLthomf2m6vweGw3T4
         TGp9My8VK0+jF8NFdKgxEExheM/IfJXexm+Q8dqqtkm976hMdnp70G5yqwI7OnQ+OxTJ
         gHlqG2Ph+/H3GylK4EwOXRxQTAtVzduWk0Oo4UdgL35FfhTQxLdS1YB6W5pyCYJP7+Bd
         PaJkqRJVJKHUWAXD+25G/0A3bX3pAx+A/MGIIHbXAJyL8FSUPAzE+Th9Xro/ns+l74jx
         6WToCEqCbYGQoaYkhGR05CXxoxkmiyKi3hH5cNVcbJo4s660VEphtYdS0m1FZhCKVlSn
         9Yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jzQzslJ11C0UlZoMvWBLrEA9sQ73JX0eKPxZpsC99rg=;
        b=d3IT8mR41Wo6Ezs0BHnSn8E0xRbINU9kOsL01JUIHRMAqpc/TILVbCFHhSY+wH4uM9
         V3pbmPfLUPll+tpxFHXZ25yJvAtqwT2JVuHQQxsg0SfwSXFx9GG13K/lMhpXXAb07i7v
         7Pd30HGkKa6mkVUc94o4shS5yTjoFGaAXv16V9nt3suyzAlYggn1Cwk2mQxr8jhZ34Un
         K5DTuGEEY4QktzGu9Jbc8vq2ydQ0VqZWj9zHfB8tUhqkSKDdAECqTcuEzvtLgFWVNLpf
         IYEJTNTekoDjZ3mp3HdTTmVSxryfqWyMU3/sw6TbKv10h0oTYeFohONwdedhBJ19vqiU
         OqSQ==
X-Gm-Message-State: AHQUAubq6Ec2PNvRP6cqJerwyV4JK+et+D/b0TT88zlsmuPEYuv+RI2N
        S32R0OO2Se4XhukIg2m1/QJ7Mqu5PqzxvguQ6ITDLw==
X-Google-Smtp-Source: AHgI3IbuoPXmZujoN0xgA+rXsEB+oIzkBme1ipeBVpqV5tKWplZQF014GIyy/HEWWx9/LibP/T4vew/hFE6Zr56/2Ak=
X-Received: by 2002:a24:d1c4:: with SMTP id w187mr6359655itg.141.1549579730721;
 Thu, 07 Feb 2019 14:48:50 -0800 (PST)
MIME-Version: 1.0
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <CAGXu5jJ0g1FUd3mX=RkJCN=BazaWWybAuapvjngpLcWtz3FQGw@mail.gmail.com>
 <CAGngYiUTJ0TjdTu=UB9yXRJ_mXG8LPmcuBQBDha+T5RHoRUvcQ@mail.gmail.com>
 <CAKdAkRS3mxXO9+60Lu7_3gqN9XN1CYQJGM5fcta1pG8qXm9wqw@mail.gmail.com> <CAGngYiWBdXc0VzpjBQmVyKi+E2rVaO2WsoiPLho0bxHnrdiDKw@mail.gmail.com>
In-Reply-To: <CAGngYiWBdXc0VzpjBQmVyKi+E2rVaO2WsoiPLho0bxHnrdiDKw@mail.gmail.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Thu, 7 Feb 2019 14:48:39 -0800
Message-ID: <CAKdAkRRbRjs9X78+V77YPo2Xrn=ZmtyfQgGz-RC12oK3G4c-iw@mail.gmail.com>
Subject: Re: [RFC v1 0/3] Address potential user-after-free on module unload
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 2:32 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> On Thu, Feb 7, 2019 at 5:21 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > > ./drivers//input/keyboard/matrix_keypad.c:512:1-18: missing clean-up
> > > of INIT_WORK/INIT_DELAYED_WORK initialized here
> >
> > This is not as simple.
> >
>
> PS If you change
> flush_work(&keypad->work.work);
> to
> flush_delayed_work(&keypad->work);
>
> then the Coccinelle script works correctly, and does not flag
> this driver.

Yes, I just sent out the patch as it was in fact a bug: we could have
missed work that is scheduled but not queued.

-- 
Dmitry
