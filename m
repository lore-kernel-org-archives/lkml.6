Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D497BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B9521841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GzJh7nrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbeLRQIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:08:21 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43750 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeLRQIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:08:17 -0500
Received: by mail-vs1-f68.google.com with SMTP id x1so10298640vsc.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 08:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BdfJ+4DyoW3Qx6DAyUz7xJsuguagkYhdstLBjsTJHZg=;
        b=GzJh7nrrb6DmvfVvRFVLpqff8GnZ0gsahnlT3q5sPAI3rH9qbb7WC24iUG31ZCHSfd
         Q2eBaXdttz9ysp2BBCAMmTgn8u8Qxx1/dGq8Gl9VYmSeKkid5DCz6p2EpoYlTJW6qODe
         sYTOUZ8Lj8xQ5c64EWbDgp0AbY9eB05pNonnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BdfJ+4DyoW3Qx6DAyUz7xJsuguagkYhdstLBjsTJHZg=;
        b=qM9V6vnTBp5/Zi7KcP5eoTY6uvLMcbGn0M+pjR8+cmuBl4tgbbTIMUoykLg8urhu4N
         tqewVlvoRUDwGXpY8tl32EJ4ZCfeDUZklqdf4a5VFE6+0jiXfS5e0avj4IBnNLf2+p9R
         /nkE1k4DIehQGPprGYkVmwACBQOIbiNz8xaMjagn67BkzGv3SGdyXgxdFDFDrqPvrS9d
         BBFnuwSoM5hYvyoD9ib0ae5Mxft9trStWn5+EAFnP0nQimfTxYerrSP9TaiguH/SCQ/2
         OpHdZeBsowfNfuYmcy5RvJ7tlu0s4qlWB/kebqZ68UJVXdOTV9Kd7oJcsvFnEjZQSVCE
         vZZw==
X-Gm-Message-State: AA+aEWYUU9JpwQ3p2ADGNyptdwarNkpeydQ7eSRwLbL/xPbkPTF8LQIS
        l2Y0+nLOC1desFoAy8cxZk5PnWB4TE8=
X-Google-Smtp-Source: AFSGD/Va7YWuhW6RAARs8rnAMz0lDaYNYvSMy/+vYoYl6yWaoxwrzq/h3THYYIeQDFHRN+KVVpX7AA==
X-Received: by 2002:a67:c584:: with SMTP id h4mr4640243vsk.142.1545149295100;
        Tue, 18 Dec 2018 08:08:15 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id b131sm6377700vkf.45.2018.12.18.08.08.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 08:08:14 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id z24so5896175ual.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 08:08:12 -0800 (PST)
X-Received: by 2002:ab0:45d4:: with SMTP id u78mr1931386uau.52.1545149292131;
 Tue, 18 Dec 2018 08:08:12 -0800 (PST)
MIME-Version: 1.0
References: <20181217100724.4593-1-sibis@codeaurora.org> <20181217100724.4593-2-sibis@codeaurora.org>
 <CAD=FV=Ui6ys4R3nenix3USeRPAd_vVdrArXxdf-iEc=4QRhE+A@mail.gmail.com> <8decd38d8e28c6657949f3c140947977@codeaurora.org>
In-Reply-To: <8decd38d8e28c6657949f3c140947977@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 18 Dec 2018 08:07:59 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xuh0pUTcKOGPANmgfeGxQfHwN5RWg+E9srzuGq2_AmAQ@mail.gmail.com>
Message-ID: <CAD=FV=Xuh0pUTcKOGPANmgfeGxQfHwN5RWg+E9srzuGq2_AmAQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: remoteproc: qcom: Add clock bindings
 for Q6V5
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 17, 2018 at 9:52 PM Sibi Sankar <sibis@codeaurora.org> wrote:
> >> @@ -39,13 +39,17 @@ on the Qualcomm Hexagon core.
> >>  - clocks:
> >>         Usage: required
> >>         Value type: <phandle>
> >> -       Definition: reference to the iface, bus and mem clocks to be
> >> held on
> >> -                   behalf of the booting of the Hexagon core
> >> +       Definition: reference to the list of 4 clocks for the modem
> >> sub-system
> >> +                   reference to the list of 8 clocks for the modem
> >> sub-system
> >> +                   on SDM845 SoCs
> >
> > The above is confusing because you don't list the SoCs that are
> > supposed to use the 4 clocks.  How about instead:
> >
> > Definition: reference to the clocks that match clock-names
> >
>
> AFAIK, only the exceptions are captured. I am fine
> with both, I'll wait for Bjorn/Rob's preference.

Sure, waiting for Bjron / Rob to chime in sounds good.  If you are
going to document just the exception, though, IMO at least reword it.
AKA:

reference to the list of 8 clocks for the modem sub-system on SDM845
SoCs; reference to the list of 4 clocks for the modem sub-system on
all other SoCs.

...the key being the "on all other" to make it clear.  ...but I still
like my original suggestion of using less prose and more lists, so
hopefully Bjorn / Rob are OK with that.


-Doug
