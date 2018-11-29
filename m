Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80746C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2DA2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2DA2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbeK2WVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:21:41 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40122 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeK2WVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 17:21:41 -0500
Received: by mail-qt1-f195.google.com with SMTP id k12so1469970qtf.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 03:16:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YlcC0aGHswOfoNMeGr5j2xZjAIH275T4vL4O229VZj4=;
        b=KsSQKCZ3IwbprbGUmUxEYn0x9Qgp/V1O6tFsePc77AqfLxBTAkWYC70LeHj8qGR9G2
         BWVnwVlxWN4S807rsG7S2QG6wI6I+Tx7woDT6XeS5AsA5K+h9g6pzc/KSb4ubuMEJVcq
         uuMPFADOyyX0rVunF4++Y3dXZf4wIUE/EeMNMeNu/mpqxFxkKJDWs/uP946MvIb0DRvF
         650biIh6zIjuLbozF7MZeGR0QP4tdGEg2pxOphfZSX7xxVjKhV2WuCLN5uV8stQ7iVf3
         19gDGvbN1mB3AiFizWOq4JYEFh/3lf+2Z2gyaMz8MIgEa8tgbkXtBJSFhHEYJniyeHpO
         pp1g==
X-Gm-Message-State: AA+aEWb3YHEKhic226p9IxofHiZlFacEdYJdVl7+YnokkTGtRd7NJtCw
        lFkKqv/EiuImQGge3gttPBXRLNu+xDL5OKyp22c5bw==
X-Google-Smtp-Source: AFSGD/Uzi/YIF0dBfG3jMaiSxCmXT0gRUV/TBQWQd9X1ws7DThaXwkxHkW4nldo85ak5RNiKlZU4DAUSY7UTL/XP6go=
X-Received: by 2002:ac8:101a:: with SMTP id z26mr923663qti.184.1543490200087;
 Thu, 29 Nov 2018 03:16:40 -0800 (PST)
MIME-Version: 1.0
References: <20181121201622.20815-1-lyude@redhat.com> <20181128034720.GB21318@jelly>
In-Reply-To: <20181128034720.GB21318@jelly>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 29 Nov 2018 12:16:29 +0100
Message-ID: <CAO-hwJKLaM=RgfdR_c_MF_rCdJ=CPrbFRRST4KYb6czqsAORBA@mail.gmail.com>
Subject: Re: [PATCH] Input: synaptics - Add PNP ID for ThinkPad P50 to SMBus
To:     Peter Hutterer <peter.hutterer@who-t.net>
Cc:     Lyude Paul <lyude@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>,
        edvard.holst@gmail.com, arkadiusz.hiler@intel.com,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 4:47 AM Peter Hutterer <peter.hutterer@who-t.net> wrote:
>
> On Wed, Nov 21, 2018 at 03:16:20PM -0500, Lyude Paul wrote:
> > Noticed the other day the trackpoint felt different on my P50, then
> > realized it was because rmi4 wasn't loading for this machine
> > automatically. Suspend/resume, hibernate, and everything else seem to
> > work perfectly fine on here.
> >
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
>
> Acked-by: Peter Hutterer <peter.hutterer@who-t.net>

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>
> Cheers,
>    Peter
>
> > ---
> >  drivers/input/mouse/synaptics.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> > index 5e85f3cca867..c42813d50591 100644
> > --- a/drivers/input/mouse/synaptics.c
> > +++ b/drivers/input/mouse/synaptics.c
> > @@ -170,6 +170,7 @@ static const char * const smbus_pnp_ids[] = {
> >       "LEN0048", /* X1 Carbon 3 */
> >       "LEN0046", /* X250 */
> >       "LEN004a", /* W541 */
> > +     "LEN005b", /* P50 */
> >       "LEN0071", /* T480 */
> >       "LEN0072", /* X1 Carbon Gen 5 (2017) - Elan/ALPS trackpoint */
> >       "LEN0073", /* X1 Carbon G5 (Elantech) */
> > --
> > 2.19.1
> >
