Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F76C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD09C20657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RM6RbwTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD09C20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeKBTnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 15:43:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45869 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeKBTnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 15:43:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id j4-v6so1287581ljc.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 03:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dBd4WaJF9SfMubucz0LadHaVb7wtg2YLvoYGjdt3xsM=;
        b=RM6RbwTHxlImo57WnEbbIgprxoP7GX7KjePKQ/+I+1bH1DU49tlVmubCs1fNeA8kxu
         f2BpO1fdTWTVtZ/YWXxVRljq5pT3GJlUCqRooncV5O8dKeh4ogJlDbtW6XQZVXS5d3zv
         SRPR05iyHqawEtMoSPGKXFuLT3bl4KFEeVEm4a+RfONBzEkkMVRQxvSCqW6YKbZndt9U
         p00kbw2R32wXsSvjNnJs9hjcjT8ajay8wo0a4fcPiLp7IDrFJBx4NGnxVpp0IxcUjKfL
         kZeedqp1PSv/bk3lz75N0usL6tp6hHtbujV4aDxvsxXibhCOsfyjNWCGMaFvDfkNeDlW
         0cQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dBd4WaJF9SfMubucz0LadHaVb7wtg2YLvoYGjdt3xsM=;
        b=X/WwB4WVdU6vexldVeJbgCf/EP5OPdT+aMsceStC5JcSastF82PLDOVjxtt+iqA7g9
         ZZq2BikI3zd/PB4JCXattNdNgPEk1tMbJFwM1NxvbdGyo+WohsrvzaRrt/PJI55LCGWK
         dfrYgO6OSKzO2Tnunmk5l1dOS2iugPvYea6IUqP7hhDrgvdhUHDxUe3xMVabytied6vp
         VmtlCiGqOsKVGwGitDO1nDw/jgMiqmp3k2J5XXPim0UyN2jiUbyEfuihTeP/PNCIVGKS
         nwuU+fobIe0Nk3kwjEkp0WAh73WrWRLATYxomWCB7cFs+irHTOJb7oALeTBj7Un0EeX4
         zfmQ==
X-Gm-Message-State: AGRZ1gIY7FzOpAayPpuhUsE1Ob1jvTcnAKfQkOCnyJGqMvJbWOPThDRm
        FWwqPXPGrdvpRSFv+yE+sO8bPzYL55XdEtRdAns=
X-Google-Smtp-Source: AJdET5dMpwcClXdaK2ezDjRgzk2xfdzrZZUushUf65st9DeTKYo+6aahQrM90IBC9f3EMk2aycTnlM8Znp4Cl1vSM0Q=
X-Received: by 2002:a2e:83d7:: with SMTP id s23-v6mr3466736ljh.139.1541154985469;
 Fri, 02 Nov 2018 03:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20171108223020.24487-1-linux@rasmusvillemoes.dk>
 <20181026232409.16100-1-linux@rasmusvillemoes.dk> <20181026232409.16100-2-linux@rasmusvillemoes.dk>
 <CANiq72kEdD3hoHaxukkdzEJt+e_nptyO1GdgfUqWnSAog3k=JQ@mail.gmail.com>
In-Reply-To: <CANiq72kEdD3hoHaxukkdzEJt+e_nptyO1GdgfUqWnSAog3k=JQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 2 Nov 2018 11:36:14 +0100
Message-ID: <CANiq72=-2mrvBWHUcFCNsoQ_EbXQm4RmtOp061ngnGJx_Fyp0g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] compiler_attributes.h: add __attribute__((format_arg))
 shorthand
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

On Sat, Oct 27, 2018 at 2:06 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> I did quick check and gcc >= 4.1, clang >= 3.0, icc >= 13 compilers
> seem to support it (or at least recognize it, even if they just ignore
> it), so we do not need to make it optional, no? Did I miss some case?

compiler-attributes landed -- do you want to do the v2 of this (i.e.
#defining it unconditionally) or you prefer I simply fix up the patch?

(I will improve the docs as well in another patch about the "optional" naming).

Cheers,
Miguel
