Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C78FC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0315720989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CvQhIsZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0315720989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbeLGLvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:51:13 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:39873 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeLGLvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 06:51:13 -0500
Received: by mail-it1-f182.google.com with SMTP id a6so6590915itl.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 03:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=rZAIGP7O5fNoD9bmI40Nayj6bpWKGU7dUMFK30ASYDQ=;
        b=CvQhIsZ9hkaXvZJi9Dv+jU4pmh1zIrA8WD+cBMxesGjAusQDjclxTKNnMbRDT0z4ty
         uKLdP8AgD+lWb25+L+ngkMD30MM99Mbs8aGxU2xvYBt2m/goiWToMZcYpGUKa29b0nSY
         PFIB+u4h12RlYCMNiypz/5bzE9ElapwMJUono=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rZAIGP7O5fNoD9bmI40Nayj6bpWKGU7dUMFK30ASYDQ=;
        b=Ly4CYHlSGsGeBMV/GRDkq0nFUoFWoyv5N4lLhcCbsRO/8KD63m2uGChaHVs+GPC30G
         SitQsJpWryVqKc+eVa+LStndR4F/HDYbC75sdLFZ7mWjyJMEFRE5H/t2f1XOisca9x/1
         bF6WAHvo8SZ5ZnWPOGjxHJqwgO7mfXPUKKztlmQew/AfqR0ZcQLaEF3HIpfgz2hiLJIw
         jcQfjEkQHeXPPzyQz8bgOKA+MIA4FJAFDpzYVcbPcc67HCEqTChGs4AhFu131s+4g9gf
         4a4iOqVpvmVkxBuEg8uypqP+VwWMLDpOBZUQb1dXxpoViUGGVj4gD0MaBn2J9jPXz5oY
         3n9A==
X-Gm-Message-State: AA+aEWZKpID9CsyAJRkSMkYKWJ1tVkdcMAHHpdfk0uQ3a5nnPDGxfHKQ
        Ltrcjvapdxt49gEKzZk7Li0670MBZG+5w+ola5rsnQ==
X-Google-Smtp-Source: AFSGD/V6Svpu+ETLTsRUIN8ETWlGaePetDm+fEsQroXGk1tcxQiVWKkUkhE6APiV6btXN3V9eBRybZ03LW0GSbAf/Pw=
X-Received: by 2002:a24:4f07:: with SMTP id c7mr1792635itb.107.1544183471967;
 Fri, 07 Dec 2018 03:51:11 -0800 (PST)
MIME-Version: 1.0
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 7 Dec 2018 17:21:00 +0530
Message-ID: <CAMty3ZAa2_o87YJ=1iak-o-rfZjoYz7PKXM9uGrbHsh6JLOCWw@mail.gmail.com>
Subject: Configure video PAL decoder into media pipeline
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have some unconventional setup for parallel CSI design where analog
input data is converted into to digital composite using PAL decoder
and it feed to adv7180, camera sensor.

Analog input =>  Video PAL Decoder => ADV7180 => IPU-CSI0

The PAL decoder is I2C based, tda9885 chip. We setup it up via dt
bindings and the chip is
detected fine.

But we need to know, is this to be part of media control subdev
pipeline? so-that we can configure pads, links like what we do on
conventional pipeline  or it should not to be part of media pipeline?

Please advise for best possible way to fit this into the design.

Another observation is since the IPU has more than one sink, source
pads, we source or sink the other components on the pipeline but look
like the same thing seems not possible with adv7180 since if has only
one pad. If it has only one pad sourcing to adv7180 from tda9885 seems
not possible, If I'm not mistaken.

I tried to look for similar design in mainline, but I couldn't find
it. is there any design similar to this in mainline?

Please let us know if anyone has any suggestions on this.

Jagan.

-- 
Jagan Teki
Senior Linux Kernel Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
