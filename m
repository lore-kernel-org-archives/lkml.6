Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0FAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB1E206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CP/f+nZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB1E206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405660AbeKWBcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:32:05 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45429 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbeKWBcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:32:04 -0500
Received: by mail-io1-f66.google.com with SMTP id w7so6768114iom.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 06:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sl6MnUjiOMYUoENfsq/jEjGAoBqRZz4ixAv9A/YHCSU=;
        b=CP/f+nZSkFHEWimlsJ/nEZQ1P1a8EVit/CfKcLY4fzfDkDf/l+H/nhoj+Mban6B/2F
         Nlva4A0+UwdsKKGDA/3ZD8naUNwTrVvAzCNA+GrmKtZefuR5Hq6RtSWKdmyYRiy1KAo1
         pmG6RM3mUI2ZJdjF7+9csAYM58z5xYD7zB0JDb762zr3INHVUEHOeUZ4SriqClNsu3DY
         oCMeU3KG2SIfEvW1BPF2f4hOfXWLTx30oiV+o436PQWbdBGeWHZ9+EAWSa3eM7rTA84q
         h1OZHS/UQT1YHzmdZ4cDNLogl5GZ0jtqrKd9zso130E1LDDnJkJhjZQXqGO78QdbSrtb
         770Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sl6MnUjiOMYUoENfsq/jEjGAoBqRZz4ixAv9A/YHCSU=;
        b=KG/7uZuMvW0kJh494QcdzSlJa8ax9igthjWjkl5mV1JJ73BnP/EeBFYdP3+a0gmzEE
         WNEWcuVZJQNjG6m0Mrdowmwi/Iv/q0hx/NUKPfzf/gawSB0mCXXPV3l84X6YjGf8zRJF
         EwOpLLgdeAp/zHx1odQIpUaFz2CiiW5g8iGFFRFk0mDkZfwwgcB56katcRsqEoqiFee5
         0ztjRKn6Gsdgm+oHzQe845CJl9hfqEo/5k9QwqUCBfEOgxFYtFXvinPLdI5EB6sbo3BA
         DR6e/UKep9A4p4+tXURuh7/Vcrc5C6vQLCYPyv2Sz6qSbLgAPHtMIPrzHuoAxxB8BNOL
         OHMA==
X-Gm-Message-State: AA+aEWYv9Uc7AnovpAXa5D0zEH9Hd6KTNshZfS3DOVU/yfJcR/wYkrrX
        Rkb8fCjYMLzaPxk9YNEo0gXZGoemRRBrYQK5rbg=
X-Google-Smtp-Source: AFSGD/UIllH0h3w6V4lbUqs2B+9elAUmRete1zTRDTbCtUjaziXSX5ixs+EH5qMsVIDUlg+8+IUljh0iNg1pvSQqjPc=
X-Received: by 2002:a6b:ba0a:: with SMTP id k10mr8756736iof.40.1542898342664;
 Thu, 22 Nov 2018 06:52:22 -0800 (PST)
MIME-Version: 1.0
References: <20181120131853.19710-1-tiny.windzz@gmail.com> <5ea4da1e-65de-ddc3-5ca6-eb83c2347930@linaro.org>
 <CAEExFWsOh1gixoC4bbSkbawC-ybz1YUA-tmw5FW5W-GFyFGs7Q@mail.gmail.com>
 <54a66dbf-df0a-8cec-cb60-0603a52dad99@linaro.org> <CAEExFWvTCJ-k+54PGv7Ov5FRMpD1C2ZzzUxi4=Kbn_hrkmBmqw@mail.gmail.com>
 <2cbc73df-e1b4-21bc-c226-38b69ebe9f08@linaro.org> <CAEExFWvOG9YmUdJjJ-d-acHLU9DrS9ccRWs-u1wMOJocQhXZSw@mail.gmail.com>
 <b6c8bdc9-d43a-5884-0678-b34176292909@linaro.org>
In-Reply-To: <b6c8bdc9-d43a-5884-0678-b34176292909@linaro.org>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 22 Nov 2018 22:52:00 +0800
Message-ID: <CAEExFWu+xP1qOz4Ymoiz2AkDhSt_wfdu-gmPS9wkLSCbje16qQ@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/integrator-ap: add of_node_put()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 10:51 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 22/11/2018 15:48, Frank Lee wrote:
> > On Thu, Nov 22, 2018 at 10:43 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 22/11/2018 15:39, Frank Lee wrote:
> >>> On Thu, Nov 22, 2018 at 10:37 PM Daniel Lezcano
> >>> <daniel.lezcano@linaro.org> wrote:
> >>>>
> >>>> On 22/11/2018 15:33, Frank Lee wrote:
> >>>>> On Thu, Nov 22, 2018 at 10:26 PM Daniel Lezcano
> >>>>> <daniel.lezcano@linaro.org> wrote:
> >>>>>>
> >>>>>> On 20/11/2018 14:18, Yangtao Li wrote:
> >>>>>>> use of_node_put() to release the refcount.
> >>>>>>>
> >>>>>>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> >>>>>>
> >>>>>> Applied, thanks!
> >>>>> Hi Daniel=EF=BC=9A
> >>>>>
> >>>>> This patch is a bit small, I will resend=E3=80=82
> >>>>
> >>>> What do you mean by 'small' ?
> >>>         pri_node =3D of_find_node_by_path(path);
> >>>         if (node =3D=3D pri_node){
> >>>                 of_node_put(pri_node);
> >>>
> >>>                 /* The primary timer lacks IRQ, use as clocksource */
> >>>                 return integrator_clocksource_init(rate, base);
> >>>         }
> >>>
> >>>         sec_node =3D of_find_node_by_path(path);
> >>>
> >>> Under my revision, pri_node and sec_nodeare the same thing.
> >>
> >> Oh, right. Missed it :/
> > Daniel ,
> >
> > Have you mde the patch merged?
> > Which git is the patch in?
> > I hope that you can revert it and I=E2=80=98ll resend new one
> > or I'll resend patch based on the modify.
>
> I can drop it, resend a new one.
Thanks,
Yangtao
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
