Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBB4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D7720684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LY7Qsbk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D7720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405634AbeKWB2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:28:43 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37897 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbeKWB2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:28:43 -0500
Received: by mail-it1-f194.google.com with SMTP id h65so14152600ith.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 06:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hdmYRzRkycEKXJUjjwKh54JmajNDjYg3ZJaYZTXuZG0=;
        b=LY7Qsbk2EvfEc7A42k0J4V/JmXxnedCjdl6JY37GI1HRHE63HfiZJtOtZVDmXUQX61
         hyRKxGXc5Kt5ckwGvjXm67SXLQA2e9btcpm36nI07Syyi1Mg2xBop8ME+L6VtznRPnky
         Xkr+61QIFwgXpxYmU9X5cm+2qqbytK8UOkvkshU/21dmFQeT15dty1mDcLm8EgVt7foH
         pzXcy7EDX26He2JLInyz/8UPtTTE0hneizqO8tVdnzR/rWQX8N3Pf37aJQOuDs8i0slh
         MMEvccX2h3tPB6aUE0CAZvl4CwDyMMpav2U3xx/xu16MrGdnYh7dB4mIZzt7CUan0BQ1
         yfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hdmYRzRkycEKXJUjjwKh54JmajNDjYg3ZJaYZTXuZG0=;
        b=gDImGqjuxhSCHJDyu5W+eCqxQuBQDgUaKkHoJ37sBBqg6GU5K76DZYroM5Hu+XxZgK
         s/pCeALQGJU1/g8UygcMkeflONPwjvTg+1+dzoCAvcapW6B8R0qI/TBSBlG8/p9N4gN4
         ZbQx4s3JFNwtEpkO9RSVuQ2s/SboA8OjFgjMJUMCCZCjN1sJqLqy/eQp0reFQSCZoiBq
         Fm6mApRLFK++6VKtKNDhF0WZ3h3J+1PgIORiP3nqPg8PHc8wGDSVRYHl9kXbpPUus0WH
         FGqRSKB7ICuadbH+sOT1q2oQFRy+02/r/Hqh8DVoM2g/HkJCwSIxoJLQCKBwjZZyR7Ep
         zHeQ==
X-Gm-Message-State: AGRZ1gKccYNRpxyTQHHrX5/OgEohkrUjX2y/91BKyPJY8I559vnHcWwO
        hbb9CMtm8AvFaxLWraTppSDSGpS9PyJwBQASs38=
X-Google-Smtp-Source: AFSGD/W/2SVGMAKR5ermhGu4AHGXMaLI6xm8LX2LB/QXneizZ1e4tpm5BncH3X+//oa0FaeDtqzWlVlZDlIaXRfAurE=
X-Received: by 2002:a24:648f:: with SMTP id t137mr9481599itc.95.1542898141490;
 Thu, 22 Nov 2018 06:49:01 -0800 (PST)
MIME-Version: 1.0
References: <20181120131853.19710-1-tiny.windzz@gmail.com> <5ea4da1e-65de-ddc3-5ca6-eb83c2347930@linaro.org>
 <CAEExFWsOh1gixoC4bbSkbawC-ybz1YUA-tmw5FW5W-GFyFGs7Q@mail.gmail.com>
 <54a66dbf-df0a-8cec-cb60-0603a52dad99@linaro.org> <CAEExFWvTCJ-k+54PGv7Ov5FRMpD1C2ZzzUxi4=Kbn_hrkmBmqw@mail.gmail.com>
 <2cbc73df-e1b4-21bc-c226-38b69ebe9f08@linaro.org>
In-Reply-To: <2cbc73df-e1b4-21bc-c226-38b69ebe9f08@linaro.org>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 22 Nov 2018 22:48:39 +0800
Message-ID: <CAEExFWvOG9YmUdJjJ-d-acHLU9DrS9ccRWs-u1wMOJocQhXZSw@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/integrator-ap: add of_node_put()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 10:43 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 22/11/2018 15:39, Frank Lee wrote:
> > On Thu, Nov 22, 2018 at 10:37 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 22/11/2018 15:33, Frank Lee wrote:
> >>> On Thu, Nov 22, 2018 at 10:26 PM Daniel Lezcano
> >>> <daniel.lezcano@linaro.org> wrote:
> >>>>
> >>>> On 20/11/2018 14:18, Yangtao Li wrote:
> >>>>> use of_node_put() to release the refcount.
> >>>>>
> >>>>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> >>>>
> >>>> Applied, thanks!
> >>> Hi Daniel=EF=BC=9A
> >>>
> >>> This patch is a bit small, I will resend=E3=80=82
> >>
> >> What do you mean by 'small' ?
> >         pri_node =3D of_find_node_by_path(path);
> >         if (node =3D=3D pri_node){
> >                 of_node_put(pri_node);
> >
> >                 /* The primary timer lacks IRQ, use as clocksource */
> >                 return integrator_clocksource_init(rate, base);
> >         }
> >
> >         sec_node =3D of_find_node_by_path(path);
> >
> > Under my revision, pri_node and sec_nodeare the same thing.
>
> Oh, right. Missed it :/
Daniel ,

Have you mde the patch merged?
Which git is the patch in?
I hope that you can revert it and I=E2=80=98ll resend new one
or I'll resend patch based on the modify.

Yours,
Yangtao
>
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
