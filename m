Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF8DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CAD20671
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOfdkR+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CAD20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388155AbeIUAcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:32:51 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35866 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387773AbeIUAcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:32:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id v26-v6so9350665ljj.3;
        Thu, 20 Sep 2018 11:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RGN5POnzkK2GHMVl2m++1Tn9i0Yy97pcgg1/ixPuOS8=;
        b=GOfdkR+7PeZuTIZlRcbLpIjXWrSl3QoedtbhIdUzT9rJG0QFuH9MNyrdWn2rXQovAu
         IKevPqs0TI0FljP/EBSKoVyH1S+2gfPSw6JEj55Tx4uA43HP9o+utcelmgH+Fqh25qAt
         qRt8Lmmxy3RlHr1LHw/Qnn7it1ykFqnDCHrSqX/6y30/L4wp4PZcXtXccMCyBt17T3Ut
         rCbMK0Fc1oPxqazClvD+33W8LNoj16JRprjbtAwwqKuoY7VSNQYy9JTuEcAF7Pi5rFg/
         MMW4cJR1+Xf72wPvnuI2+eJOTp8AP0R+nFj5PNL+vWmKcAFX6JHsrTGX6q6JVqUVZV+3
         SEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RGN5POnzkK2GHMVl2m++1Tn9i0Yy97pcgg1/ixPuOS8=;
        b=OGj46vbux3ClJDIjKJWFf4CDBE8xHf7b/+ZYFLTlClLxY/IFu05Y/6vFjSzan/0D/n
         CbHY3h1yN/OYsUC0aafaKrnug9HL4bmAD+g/h7kuNvGWB2izrJrb9ruCeqyaoMQDKQmy
         QKDEXAore1PJUjXt7zGXYWqR1OHWdoCPD5j8CRVtEM776rYh0GSIO9K4SKECOomcCO6z
         OiB46y3I+q+yQR1NzYzy1wMaoNOTQbSxH/foCFAyra5lXuniKLcp30iDNk3+0n57/CgI
         6mHLdUSwyKUnWKraEu+iZ5lJ/eCq9KzbbSE+tRjgAlO9iB0A6aYxDeS2RHn4tPenLFRV
         1khA==
X-Gm-Message-State: APzg51AFPWL0YN6mzL8oofT47VQzBcT/+TjPa4aU9pOm0U7TJtMeJ6i9
        /6XI7LeKXhwh3FfgemUffrV3O0yCclrCpwg+hEs=
X-Google-Smtp-Source: ANB0Vdb6V8UOKwVDju1o0su0YINEiTmenCW8gO6Jxfe3IyLH5WjNmqNEzuSZ3OGvDVto9HjqTiAdcNBnNAz2W0Iev0o=
X-Received: by 2002:a2e:9883:: with SMTP id b3-v6mr5753376ljj.80.1537469278831;
 Thu, 20 Sep 2018 11:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180920161912.17063-1-ricardo.ribalda@gmail.com>
 <20180920161912.17063-2-ricardo.ribalda@gmail.com> <20180920184054.lbd77a3w56cflfym@valkosipuli.retiisi.org.uk>
In-Reply-To: <20180920184054.lbd77a3w56cflfym@valkosipuli.retiisi.org.uk>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Thu, 20 Sep 2018 20:47:42 +0200
Message-ID: <CAPybu_2teux1qHpL2F+-uojMP+GDVMOaH87vLB1DCmC+gQKTTQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] [media] ad5820: Add support for enable pin
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Pavel Machek <pavel@ucw.cz>,
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

Hi Sakari

On Thu, Sep 20, 2018 at 8:40 PM Sakari Ailus <sakari.ailus@iki.fi> wrote:
>
> Hi Ricardo,
>
> Thanks for the set! A few comments below...
>
> On Thu, Sep 20, 2018 at 06:19:10PM +0200, Ricardo Ribalda Delgado wrote:
> > This patch adds support for a programmable enable pin. It can be used in
> > situations where the ANA-vcc is not configurable (dummy-regulator), or
> > just to have a more fine control of the power saving.
> >
> > The use of the enable pin is optional
>
> Missing period at the end of the sentence.
>

Thanks for the superfast response.

I have just sent a patch with your comments and also resend 4/4. I was
missing a comma.

Thanks!
> >
