Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52DEC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E8F20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E8F20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeILN4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:56:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35587 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeILN4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:56:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id p10-v6so937855ljg.2;
        Wed, 12 Sep 2018 01:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Zje0ppeSodSCa2FdkcsAT+t7TQPXTt8YTQMUdMUzGOQ=;
        b=AIOV4zqiJk+NyHi4BDFPHauIRedbEAD/p7kj9YsPnLxkN/RfHXuk70zaKdVCvPs9ky
         a7dmS2519PwrxLe0Oqy2EW/mLEAaDUzGElW/Du/atOwdWyuAQDoRIQhqHy/GgvoXt9vy
         aWaseI6j9A+zmLry5EZ+zfeWyytDIB5WIC05l3FZNr2QjzgOeLd8+aIkIX9yhRsk0FOV
         YUf5oZrvbxYbFJXxR/UKECj9XZN6A7dZ+WxFYrygPYTFILoUP2yZ9jzqDGmbkTA2eenZ
         cSEobujo5Sewv+YQKJVVFgK2D5T+SWRdSqEpN1uZf/4LB0Vhw/tycTD03PY0SuoQtaGm
         X7uQ==
X-Gm-Message-State: APzg51DzgmM872vGtnH/Yk/cyVKGiqHEShjK12eXVQwGRsEsZmW1rnDo
        ZbvioJ7OtTvzNLEA/liswSU=
X-Google-Smtp-Source: ANB0Vdb5sWVovxUWJ10qTGaPoh1t69hZyyA3webIAMLVwtzfLs9zxoeC8v56hAXUCd5fJoknXDO3lw==
X-Received: by 2002:a2e:9113:: with SMTP id m19-v6mr678108ljg.23.1536742398253;
        Wed, 12 Sep 2018 01:53:18 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id z15-v6sm80279lfi.52.2018.09.12.01.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 01:53:17 -0700 (PDT)
Date:   Wed, 12 Sep 2018 11:53:15 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: Re: [PATCH 1/8] regulator: bd71837: Disable voltage monitoring for
 LDO3/4
Message-ID: <20180912085315.GE2381@localhost.localdomain>
References: <cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
 <cad2e7baeb7af2d6efbc6afba831b0513087d832.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
 <20180911124029.GO4185@dell>
 <20180912074745.GD2381@localhost.localdomain>
 <20180912084251.GO4185@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180912084251.GO4185@dell>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 09:42:51AM +0100, Lee Jones wrote:
> On Wed, 12 Sep 2018, Matti Vaittinen wrote:
> 
> > On Tue, Sep 11, 2018 at 01:40:29PM +0100, Lee Jones wrote:
> > > On Wed, 29 Aug 2018, Matti Vaittinen wrote:
> > > 
> > > > There is a HW quirk in BD71837. The shutdown sequence timings for
> > > > bucks/LDOs which are enabled via register interface are changed.
> > > > At PMIC poweroff the voltage for BUCK6/7 is cut immediately at the
> > > > beginning of shut-down sequence. This causes LDO5/6 voltage
> > > > monitoring to detect under voltage and force PMIC to emergency
> > > > state instead of poweroff. Disable voltage monitoring for LDO5 and
> > > > LDO6 at probe to avoid this.
> > > > 
> > > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > > ---
> > > >  drivers/regulator/bd71837-regulator.c | 19 +++++++++++++++++++
> > > 
> > > >  include/linux/mfd/rohm-bd718x7.h      | 33 ++++++++++++++++++++++++++++++---
> > > 
> > > For my own reference:
> > >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > 
> > I m not sure if it is relevant but I think this was already applied to
> > Mark's regulator tree.
> 
> Where is Mark's acceptance email?

https://lkml.org/lkml/2018/8/29/644


> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
