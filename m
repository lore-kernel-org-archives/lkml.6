Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D32EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FF42087A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrWfTRli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04FF42087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932960AbeGDEkX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 00:40:23 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38029 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932344AbeGDEkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 00:40:22 -0400
Received: by mail-it0-f68.google.com with SMTP id v83-v6so6238359itc.3;
        Tue, 03 Jul 2018 21:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KeRifuRjAfDvCZxhdXIRqxDCMEXH4ECn039BSt29dXY=;
        b=FrWfTRlioeXGjrm7ianZgs0WRhk6aScHYbV49rhK42F2RicIaE2XLm7Ob30VCIGxdM
         GjawEnYYozRwMxjSBmHIFm4jeR7ZsUNBsUuS2skmGAugBBcTxmvVL5fVGJzMpPpOJVCH
         tfXekSJixAZ3fQxiNW8lgYo1PDH/9UU4epIdC/qFvL2T9Wuz0V50ibBLGyuniPe3wzzL
         t6neEldAyO5wFdrY7owDl/cqDS7Ck4AGAtJoqejfL+wtL6/+P1+40fLcX8qnUabyNDJy
         Uol76db8vmZJjMJhdOApYhavmfMXOb61Pd0mv/uHHiQ+sHLTmOASvZwcSpUH487z4j2X
         YfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KeRifuRjAfDvCZxhdXIRqxDCMEXH4ECn039BSt29dXY=;
        b=ILPdMM3nRxpAKzX7TnNIr6NCVEe5sdeXuk/gLt2SIKyVzCcbY6S5Bz5/rSEvpaE5aw
         IcQkaE6Qs9kHIviuZJaLxzXtrdNooSInrgqDy83U8DPcxeRf/COaGuToXmEOZoqFVqNm
         WbvDiu+/yp+jG7BjftZDMQS8ogsayw9F1v+15FnIS3wmYRXrLUmQepc96wX2QQ+aEmpO
         5B45O2FNTrcKa3j7JxnetOhmpHakfTiL7EFBWq5K94LPJXUAnnK9zznj9/vO6OnjIm0G
         IFSIe5IxvZ/b/fuSJvo5HcYePcxHKwlgm0UCW6PEjizYaCNohErXDsMYTpWU6uBhacCO
         hLFA==
X-Gm-Message-State: APt69E1Tt+k6m0k/4r52xQAbEZ9nQuCZhMDxon+gZ31thCxlMZ2Y/Qss
        9h6rj85+G14SWOYfgW3H2QqAZ461890XITGqX6UZqc0=
X-Google-Smtp-Source: AAOMgpfYmDlDc5w2yoV7U38PbGRLb38mUyl7+OOnPXKAqMPJKwbKODRHcpkAlnJccuzmofYqsANpB9YYxLaY8m6RpFk=
X-Received: by 2002:a24:1fce:: with SMTP id d197-v6mr584084itd.52.1530679221436;
 Tue, 03 Jul 2018 21:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <1530600642-25090-4-git-send-email-kernelfans@gmail.com> <3375966.ydPZj5TMVj@aspire.rjw.lan>
In-Reply-To: <3375966.ydPZj5TMVj@aspire.rjw.lan>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 4 Jul 2018 12:40:09 +0800
Message-ID: <CAFgQCTtu7jaUfWV4xq8CfWb7vuS5=+HuNpNxeMm9UawoUZ2CBg@mail.gmail.com>
Subject: Re: [PATCHv3 3/4] drivers/base: clean up the usage of devices_kset_move_last()
To:     rjw@rjwysocki.net
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 10:28 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Tuesday, July 3, 2018 8:50:41 AM CEST Pingfan Liu wrote:
> > Clean up the referring to the code in commit 52cdbdd49853 ("driver core:
> > correct device's shutdown order"). So later we can revert it safely.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > ---
> >  drivers/base/core.c | 7 -------
> >  1 file changed, 7 deletions(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 684b994..db3deb8 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -127,13 +127,6 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
> >  {
> >       struct device_link *link;
> >
> > -     /*
> > -      * Devices that have not been registered yet will be put to the ends
> > -      * of the lists during the registration, so skip them here.
> > -      */
> > -     if (device_is_registered(dev))
> > -             devices_kset_move_last(dev);
> > -
> >       if (device_pm_initialized(dev))
> >               device_pm_move_last(dev);
>
> You can't do this.
>
> If you do it, that will break power management in some situations.
>
Could you shed light on it? I had a quick browsing of pm code, but it
is a big function, and I got lost in it.
If the above code causes failure, then does it imply that the seq in
devices_kset should be the same as dpm_list? But in device_shutdown(),
it only intersect with pm by
pm_runtime_get_noresume(dev) and pm_runtime_barrier(dev). How do these
function affect the seq in dpm_list? Need your help to see how to
handle this issue.

Thanks and regards,
Pingfan
