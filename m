Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F49C2F3A1
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84012084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UF2COheU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbfAUMfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:35:16 -0500
Received: from mail-ua1-f54.google.com ([209.85.222.54]:42206 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfAUMfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:35:16 -0500
Received: by mail-ua1-f54.google.com with SMTP id d21so6842845uap.9;
        Mon, 21 Jan 2019 04:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k+MSaycj/9KITYA6lfk8QZCRSnahwfifAXAEb5FjW38=;
        b=UF2COheUoysXjsRSEAmwWvy5ArpkdNfz58fuMsj0CWoKN6ba9PggydnGg8dWNnxGdD
         6xNV8hqPBGouluqMMVwCAfevMbvLnz4CkE/80V/tbf82hpdrnJ2eOhqlyJ560TEoeviv
         hS1PZ5IowjEB0S8s0cb0k+voFynUWiRACHTllvcoiQXgdAeZwPkp0wmy15M9i8bzcj8f
         xpMDexfrQSPWWR5ZuTjWHqb6unZrPRJeCqMpfCJ0DER/WUX69ez/UNghdh4iwX5ulSQb
         +uvO8W9H7y7pfSdTKxQGFCs/6HBfoKY939BGG/zfFk/Rq1zuEq4iDiHE7nlofiqJJKaG
         j1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+MSaycj/9KITYA6lfk8QZCRSnahwfifAXAEb5FjW38=;
        b=C6qh315CR35CAmubadpJ+85Dqf5eQyM564FdPXGmSju1OjPpKxdmRxFeG3wk/YGAQt
         gHmZlPX+lzXKA3UCak3pRDAY//0IuUqBo5CP7NI1jT2EhNRi2yeuqtg7ECEoL3XXYDmO
         xr+v/vbL+gTpZb0GrpSHt/hTSNYb5Gr/jsEMT+QUmmt7ZgV7niZcTPPbwgR6BDqF4QnI
         3wEAO4h68leVT6pdnEujYaAlT/Lco1KdHhjmgwmaifcsfczS+j0bSyjGmslLb/Uq5bRd
         eDVw+r8SUxxkHODwvc46BeN4y9sO//B700tOdIvw2ZQMVr0aO6gvRoi0IfhQsRbX6DAW
         MOJA==
X-Gm-Message-State: AJcUukfTIN3KW4td1ExxTl4kxjE8fwKPlBvn5wvAUmoGrqwjx1EOMnBI
        tgev+VvpeB2YYbR/qwt0/R6VRYppuDAA9Q5i11o=
X-Google-Smtp-Source: ALg8bN7BTMgsv7iqj35UyxppTuxv/Y6UFsAvIzIcZL9zuwtmFozpjinsnmWFAZjBSG8GUGYxUb3A1UBWwOOmUHTeENU=
X-Received: by 2002:ab0:4802:: with SMTP id b2mr12152078uad.47.1548074114497;
 Mon, 21 Jan 2019 04:35:14 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLj4QzNDt0npZn2LhZTFgDNJ1CsWPw3=wvUuxnGtQW308g@mail.gmail.com>
 <bceb32be-d508-c2a4-fa81-ab8b90323d3f@codeaurora.org> <CAOuPNLiNtPFksCuZF_vL6+YuLG0i0umzQhMCyEN69h9tySn2Vw@mail.gmail.com>
 <57ff3437-47b5-fe92-d576-084ce26aa5d8@codeaurora.org> <CAOuPNLjjd67FnjaHbJj_auD-EWnbc+6sc+hcT_HE6fjeKhEQrw@mail.gmail.com>
 <1ffe2b68-c87b-aa19-08af-b811063b3310@codeaurora.org>
In-Reply-To: <1ffe2b68-c87b-aa19-08af-b811063b3310@codeaurora.org>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Mon, 21 Jan 2019 18:05:03 +0530
Message-ID: <CAOuPNLgM-aV51_L4WzwSGPQ4daVqWBgs8mQ8Gdw-f4Kdmadx1Q@mail.gmail.com>
Subject: Re: Need help: how to locate failure from irq_chip subsystem
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-mm@kvack.org, linux-pm@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 5:23 PM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> On 1/18/2019 4:50 PM, Pintu Agarwal wrote:
> >>>> Could you please tell which QCOM SoC this board is based on?
> >>>>
> >>>
> >>> Snapdragon 845 with kernel 4.9.x
> >>> I want to know from which subsystem it is triggered:drivers/soc/qcom/
> >>>
> >>
> >> Irqchip driver is "drivers/irqchip/irq-gic-v3.c". The kernel you are
> >> using is msm-4.9 I suppose or some other kernel?
> >>
> > Yes, I am using customized version of msm-4.9 kernel based on Android.
> > And yes the irqchip driver is: irq-gic-v3, which I can see from config.
> >
> > But, what I wanted to know is, how to find out which driver module
> > (hopefully under: /drivers/soc/qcom/) that register with this
> > irq_chip, is getting triggered at the time of crash ?
> > So, that I can implement irq_hold function for it, which is the cause of crash.
> >
>
> Hmm, since this is a bootup crash, *initcall_debug* should help.
> Add "initcall_debug ignore_loglevel" to kernel commandline and
> check the last log before crash.
>

OK thanks Sai, for your suggestions.
Yes, I already tried that, but it did not help much.

Anyways, I could finally find the culprit driver, from where null
reference is coming.
So, that issue is fixed.
But, now I am looking into another issue.
If required, I will post further...

Thanks,
Pintu
