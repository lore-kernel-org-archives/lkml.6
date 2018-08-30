Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6451C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7DE20647
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="UpozgOT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7DE20647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vanguardiasur.com.ar
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbeH3Ew3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 00:52:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39142 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbeH3Ew2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 00:52:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so3054453pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8+EEe6Fw5F0ObP3yokdb/YCnQIcXrtVXrmbnvXvPMgw=;
        b=UpozgOT5lpvuKGlrwt2oTi5opw2BRr65Hw02XbKm1Y6wl8OX435eJRg9GylkB+lXT6
         0EVvc9q7NktSl770ZXDL67afRNq5lpzIOajwb8GI59rWVscfueEyeG004CBOExqddoRW
         80+1KDUn/lTDyOnYZnNnJ9saevwy1XC9sgGp0N8AXbWN58efKppXpjjexq+yPeldj9UJ
         62rhRrUkeDXRg/FGYbdO8aJha2e+RMJPmQY5yKdsOJKvcA60+ieGdJXXrE5qG8xii6YE
         b5Le1qo2WnOzRR0yuOrdBPN8sa8SwXMtrwH5cdaAFotVFg2MLf0W5uk/LvGCVuEiCkWj
         eCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8+EEe6Fw5F0ObP3yokdb/YCnQIcXrtVXrmbnvXvPMgw=;
        b=VelcX9fJpeHIRvJQqxCbDU1qeE4Fw970kTLZz5Ll+vMx28+lmJ2D/vrutSMlAfRRYJ
         9w1ERO62eCrvWoLxQpFvuTz5ZdmXboiD8dlYWo7Mm0ZDBXWhjOylB5JgCy0UShOqArd2
         UNCZypEizx7nWHssRLgoGhYPNt/x+2y04yhNwDyz+bW0A6wlEOc1gHHl2gVy21FJpHgz
         P7Yy6tUsls8oCBNtRzBMntwi1f8gBMuv6gv5PwNWda5rT95N6af4aZ9NYGXyov+goRgt
         hpT68DdArYc5oBjEpmLtP4FE4bkL0d0vyYhIs4aIFD/KPkeyDTOwtA3k+9A6sKoxIZuJ
         7j5Q==
X-Gm-Message-State: APzg51CECJtTf8o+W3yqxhoeLzQJoEJZdO1762oN6NQNLELD7YBqDORP
        7c5djMZDixqKVhuDlglNhEFEo6RPi7mhZYjTbebdXw==
X-Google-Smtp-Source: ANB0VdYj2v6fVPIZcBcd46d5Y/9VTCgdGSspyqisz1qxPTig4Xi0rgPKAb52Fv1XNrY3brjp8l0kvAZw8Gi6uyrxV6Q=
X-Received: by 2002:a62:6781:: with SMTP id t1-v6mr8174358pfj.200.1535590378313;
 Wed, 29 Aug 2018 17:52:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:5d02:0:0:0:0 with HTTP; Wed, 29 Aug 2018 17:52:57
 -0700 (PDT)
In-Reply-To: <1535576973-8067-5-git-send-email-eajames@linux.vnet.ibm.com>
References: <1535576973-8067-1-git-send-email-eajames@linux.vnet.ibm.com> <1535576973-8067-5-git-send-email-eajames@linux.vnet.ibm.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Wed, 29 Aug 2018 21:52:57 -0300
Message-ID: <CAAEAJfBpmFPLTMAr+Azc-53JXHPkCU4bjtwqE6nDWUvm=J_x-A@mail.gmail.com>
Subject: Re: [PATCH 4/4] media: platform: Add Aspeed Video Engine driver
To:     Eddie James <eajames@linux.vnet.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        andrew@aj.id.au, Mauro Carvalho Chehab <mchehab@kernel.org>,
        joel@jms.id.au, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eddie,

On 29 August 2018 at 18:09, Eddie James <eajames@linux.vnet.ibm.com> wrote:
> The Video Engine (VE) embedded in the Aspeed AST2400 and AST2500 SOCs
> can capture and compress video data from digital or analog sources. With
> the Aspeed chip acting a service processor, the Video Engine can capture
> the host processor graphics output.
>
> Add a V4L2 driver to capture video data and compress it to JPEG images,
> making the data available through a standard read interface.
>
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
> ---
>  drivers/media/platform/Kconfig        |    8 +
>  drivers/media/platform/Makefile       |    1 +
>  drivers/media/platform/aspeed-video.c | 1307 +++++++++++++++++++++++++++++++++
>  3 files changed, 1316 insertions(+)
>  create mode 100644 drivers/media/platform/aspeed-video.c
>
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index 94c1fe0..e599245 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -32,6 +32,14 @@ source "drivers/media/platform/davinci/Kconfig"
>
>  source "drivers/media/platform/omap/Kconfig"
>
> +config VIDEO_ASPEED
> +       tristate "Aspeed AST2400 and AST2500 Video Engine driver"
> +       depends on VIDEO_V4L2

It seems you are not using videobuf2. I think it should simplify the read
I/O part and at the same time expose the other capture methods.

There are plenty of examples to follow.

Regards,
Eze
