Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE18C65BAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810EC2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810EC2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbeLGJrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:47:49 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37252 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbeLGJrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:47:48 -0500
Received: by mail-vs1-f68.google.com with SMTP id h18so2094544vsj.4;
        Fri, 07 Dec 2018 01:47:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ESyl+uwBAeIjWYjNFJ6GyndQL2JviXhwq1pKZ5nE6a0=;
        b=nQ0gizQqnEgUk8zPj3Qr8JkndCzqFSLlEbzY3c/dysrziRlPSNnHCAPFk/UWdn6Ykc
         pSCnJzV4G61v5suCDZU5lAity0Z7C/xXoeOXTEL16Y4Ke4NMbRdeCItZ9ZE4wLLkA/Zy
         VhMErMHrMidaj+PGZbB8Jl8t7KDbR/qTIWAWTlMMenu9k1fJl0psnlD89ms6JqNdwwg7
         JEb0fwiNVTuqdGUn1c7kudI2tqCp7VnWzU0APnYKLFNBprdr6UnJxiIw0V7Lyd0H9BAv
         0KUztte/5cBZroQw+u2ii42NEMSQgziIJKa7l6ezxpWyWk7qh4r/3Ui4vDBoeF5ScsjS
         Pabw==
X-Gm-Message-State: AA+aEWYQdKR/edQlUiq5+DtGq86QZXqelc5+C1/+D4L4En7CsSYWEjPv
        DE4rGPY9MusELGLKYd4hr7qTWzNigkYQfSicO8M=
X-Google-Smtp-Source: AFSGD/V2Eaj3dicO7Oa0sDS1FAKHYLKmQnHOWT58tWzXf/ERbAXG4UZ9fd+ChM6hozTyjH+nZsyayHggYcMI84LUFhc=
X-Received: by 2002:a67:d119:: with SMTP id u25mr554401vsi.63.1544176066905;
 Fri, 07 Dec 2018 01:47:46 -0800 (PST)
MIME-Version: 1.0
References: <20181111193114.24307-1-alexandre.belloni@bootlin.com>
 <CAMuHMdX9xZgAiBeXCXxLRSJYMefsFwhH3NGC7=EYteFd6kODMQ@mail.gmail.com> <20181207093356.GG8952@piout.net>
In-Reply-To: <20181207093356.GG8952@piout.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 7 Dec 2018 10:47:35 +0100
Message-ID: <CAMuHMdXHtUPKEFrWMrtDSZ1_n7c73L-g7t+OPnN7ctq9Cm8Nvw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: rtc: add generic bindings
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-rtc@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Fri, Dec 7, 2018 at 10:34 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 06/12/2018 11:36:59+0100, Geert Uytterhoeven wrote:
> > > +The following properties may not be supported by all drivers. However, if a
> > > +driver wants to support one of the below features, it should adapt the bindings
> > > +below.
> > > +- trickle-resistor-ohms : Selected resistor for trickle charger. Should be given
> >
> > Can this resistor be less than 1 ohm?
> > trickle-resistor-milli-ohms?
>
> Well, this is what current drivers already use so we are stuck with that
> for now.
>
> The value should be a few kOhm anyway. I think the lowest I know about
> is 250 Ohm.

OK, good to know. Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
