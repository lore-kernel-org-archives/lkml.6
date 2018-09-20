Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA7FECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015672083A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fjloqi9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 015672083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbeIUAva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:51:30 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41296 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbeIUAva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:51:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id l26-v6so9334113lfc.8;
        Thu, 20 Sep 2018 12:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E0W0KBJtbbOM886y6xFZI2zEICxBxA+C9wS7zXIzQiU=;
        b=Fjloqi9AIh9bDhpoeK3YDi1eVPANKuW+189IEmTT4/PjPKrfmaiWOuKWkTNbvBH6H/
         zHA+2weEmlZD7ryR7k1OhnXR04CWR+m9wIwepwpQpAKgH40zfEXvyxuXA1U5NwJATdpg
         mFYL8xbzy4ltHXlMkJFPIBB3OsluwFRKiB4vmmpmmwWUXolWVT7UDdy8wLlAwlmOK4ah
         AozfO0lWZdIGM79yVNzlEpeGX0bRjptotYoF/VwMe/W4OdUPO3XzJLRGut3HYHyYYgwC
         NkwhulS80G9KBZXyesVzr+yNBzhLoX6MaXbvsewt5jbQrBZodG1Kf8KnJZu2YIa7iIR6
         kjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E0W0KBJtbbOM886y6xFZI2zEICxBxA+C9wS7zXIzQiU=;
        b=XkV3/UhSQ6vq9wA7sjV2HwNDdhIpAb27u4H0Yy6taqsMbYZbxGJYsKwvlezRGWZSyx
         NTXEralumIDeUWyNZC4dRjm8ARqiDlKHazlrpPAZEoMPEf4fELSLHFSWAvtUQ6kNZe3y
         p1HxWc2vuFQnFCi0A79M55VTQnLTAuCP6UrsNB/s36dKbvCSBpofWAnWY1mqCW+5QrSx
         X6QpQ2fdbsgMQwx/01Mz/SL/z/aZQeMCObdY1Q8cxlPGnTMy1rDgx++Ic0Zvbpmn/w4C
         rK4knofQaG5Luzv80tbl2E76CEpO3ku2HUyI9Zaq68HiW8Wc29oVTFHPUjRubMTpA1pX
         yb+Q==
X-Gm-Message-State: APzg51DIsBaSgxD8E2Q1m7nl350dI8VlRvmpSBY05Huh4iwV34Su+Foq
        GzlgzaOAy5FvhyV3Za7jvtfuPqxGx0vYvf3GVtA=
X-Google-Smtp-Source: ANB0VdZ6wqFwyj/DRpggd2wYEJPyMqzQs80hQEIqL5sbPU5JCPq4fImdoSqYj4eg43oThinRONcS058UJPV6AE/3rn8=
X-Received: by 2002:a19:9f06:: with SMTP id i6-v6mr27308514lfe.149.1537470392761;
 Thu, 20 Sep 2018 12:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180920161912.17063-2-ricardo.ribalda@gmail.com>
 <20180920184552.4919-1-ricardo.ribalda@gmail.com> <20180920185405.GA26589@amd>
In-Reply-To: <20180920185405.GA26589@amd>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Thu, 20 Sep 2018 21:06:16 +0200
Message-ID: <CAPybu_2hjrq=r+kpAHKxX59gOXfbqGf9CUPh9CNqv7WGqJsrQQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] [media] ad5820: Add support for enable pin
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel

On Thu, Sep 20, 2018 at 8:54 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Thu 2018-09-20 20:45:52, Ricardo Ribalda Delgado wrote:
> > This patch adds support for a programmable enable pin. It can be used in
> > situations where the ANA-vcc is not configurable (dummy-regulator), or
> > just to have a more fine control of the power saving.
> >
> > The use of the enable pin is optional.
> >
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
>
> Do we really want to do that?
>
> Would it make more sense to add gpio-regulator and connect ad5820 to
> it in such case?
>

My board (based on db820c)  has both:

ad5820: dac@0c {
   compatible = "adi,ad5820";
   reg = <0x0c>;

   VANA-supply = <&pm8994_l23>;
   enable-gpios = <&msmgpio 26 GPIO_ACTIVE_HIGH>;
};



>                                                                 Pavel
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html



-- 
Ricardo Ribalda
