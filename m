Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D108C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA642084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yr1DZc8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbfBUSpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:45:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42803 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfBUSpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:45:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id r5so18410174wrg.9;
        Thu, 21 Feb 2019 10:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=injCcubPEjnAC0rncC1Cf8zMf/I/AbCBWfia6xN25+4=;
        b=Yr1DZc8CouQMcKSQkChtredKvDAqbUtX+GLrOTEh/IGFP0gWo582Tud0FBipXsygGP
         RM6ubHf1Ljklj+WlBgTWGW3F4FqCSiE7f86LvcKRtCJDOsz2HeibLhXqNFbHdmSXsGyD
         r0r69iS5+nctca/asbGE5hcZLvdC/sXd17fGLf6QHJL1k+KwWUoqiSqF8UwOfrQfQPBU
         hAtQ078tx/nh/l+c90p3iggNByld2Zg2A+dk2WoaKSyPutOSM3sPyJOwAxUa3hHRETXH
         opT4/bbkWJGZk/GrkWW8JSs4+hDamujolFJ26vB6Xdiyv8XQtlP7wkpsUxkdwnusOOsr
         Wm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=injCcubPEjnAC0rncC1Cf8zMf/I/AbCBWfia6xN25+4=;
        b=b7XsEdWP0NapOYfvzapW/T2ijQhNEpdeqNWHClLcvp8S21kimElIu/IZIgBdjTN7Jg
         VmvgLjYAEGt9z3dJk6VOOHSbAjPNSICEg+BXCTCNiJJhIWYdS1QUGUNle6zKwoQjrU99
         gonh85gx1dACGzUIVRFswLbWBd3ZPjhBuXTszDLl1QWGCg+Yck72CYSRT2HJ9IflSNu1
         bnwbO1kaZucMQqtL3GnJtdiGqDsjVx+fvK92nIUB37t+x8o+3r8Ezqm54z1UiPYWLp16
         GDA+HXPYLo1GTZA2PmPvAnnaT3Kh+mmvi7QYnNRIqeRbqXcU6windqtVgP0IXzvJrks9
         LDNA==
X-Gm-Message-State: AHQUAubg+tFsBthcmx4fzpcA7q9rkJUeUpXmezdAqomvFk6GjOeNG0eR
        EtmnJ4AfwMJpad0FAqwkVUTO2rbmKmCSwPtUjJU=
X-Google-Smtp-Source: AHgI3IY9EGGw8f6wzMHXAzovpudU+DNBYqYmAyjF2Oh/pJ71DySwz1UqL4bka+//l3jRjfmjhJvS9ouULbDiL+WqmhA=
X-Received: by 2002:adf:dd43:: with SMTP id u3mr28062144wrm.259.1550774751922;
 Thu, 21 Feb 2019 10:45:51 -0800 (PST)
MIME-Version: 1.0
References: <20190218191141.3729-1-andrew.smirnov@gmail.com> <20190221005246.GB31479@localhost.localdomain>
In-Reply-To: <20190221005246.GB31479@localhost.localdomain>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 21 Feb 2019 10:45:40 -0800
Message-ID: <CAHQ1cqFrTJeZStWJhnSEmzsHMV4a9+6E0+2YkhwFfJ+CG2TkgQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] QorIQ TMU multi-sensor and HWMON support
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 4:52 PM Eduardo Valentin <edubezval@gmail.com> wrote:
>
> Hey Andrey
>
> On Mon, Feb 18, 2019 at 11:11:29AM -0800, Andrey Smirnov wrote:
> > Everyone:
> >
> > This series contains patches adding support for HWMON integration,
> > multi-sensor support as well as a small fix and general improvements
> > (hopefully) for TMU driver I made while working on it on i.MX8MQ.
> >
> > Feedback is welcome!
>
> What branch is this patch series based off?
>

This was based on  v5.0-rc6

> Would you mind re-sending the series based off my -linus branch?
> There has been an addition on qoriq driver to support multiple sensors
> and the code has shifted and your series does not apply over there.
>

Sure, will do in v2.

Thanks,
Andrey Smirnov
