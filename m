Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABACC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374AC2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374AC2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeILMo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:44:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33791 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbeILMo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:44:56 -0400
Received: by mail-lj1-f195.google.com with SMTP id s12-v6so780228ljj.0;
        Wed, 12 Sep 2018 00:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2nqDRDklo2hT94SqpcHF61npXIkcSCVuv78W+0YVJR4=;
        b=rIKFt0ftz6A27iRE9sh9qRgEtXjgx9dIt1rPjCL4tINO6JAf1OXaOFaq8ULJLWuXdV
         zPtP/RbLzXzCUU7IUEv97Ish5aExPCGe2XS6RFsfBeS+K1Acggy2kTuWFtuhtfjTyuVD
         9WfZJzJAORMJcuN2/h4h1MgPkqVQvup5RN4a22MSus8OsE6ovboh82ih6hO6qpW5t3OZ
         ryzGB+dPQriCMfUJ54xmrOgpEWVaV0QGXHN46q+WLAfxe+l8a5LAEo221LAbcvaCWiHL
         9kM3NtOaMSmgeofsRgsHbtYCTZduQ20fvO1xPJWVrRdeFx3Q3zzWPdZnM4mpod5dF7yq
         DQIg==
X-Gm-Message-State: APzg51DVBAsFsUu3hNy/1E3gGXEaONP29ELOkM9PKW8HIkta2J6f/HU6
        1iUwr2BaRybydXA08mPmkdI=
X-Google-Smtp-Source: ANB0Vdac44m3O3UMZ6dx9THgXzZU7IrgeJYVfbEptRUyjaVF/sbazKFTqBZuPixGGExaSDBFDTnBgg==
X-Received: by 2002:a2e:9057:: with SMTP id n23-v6mr486197ljg.44.1536738098150;
        Wed, 12 Sep 2018 00:41:38 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id z17-v6sm53913lfb.21.2018.09.12.00.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 00:41:37 -0700 (PDT)
Date:   Wed, 12 Sep 2018 10:41:35 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: Re: [PATCH 7/8] regulator: bd718XX use pickable ranges
Message-ID: <20180912074135.GB2381@localhost.localdomain>
References: <cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
 <6fa8728de34a18623736d3b01537930eda2dd54e.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
 <20180911135549.GS4185@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180911135549.GS4185@dell>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Sep 11, 2018 at 02:55:49PM +0100, Lee Jones wrote:
> On Wed, 29 Aug 2018, Matti Vaittinen wrote:
> 
> > Few regulators in BD71837 and BD71847 can output voltages from
> > different voltage ranges. Register interface is arranged so that
> > used range is selected by toggling bits which are not next to actual
> > voltage selection bits. Then the voltage inside selected range is
> > determined by voltage selection bits (as usual). Support BD71837
> > and BD71847 selectible range voltages using new pickable ranges
> > helpers.
> 
> [...]
> 
> > diff --git a/include/linux/mfd/rohm-bd718x7.h b/include/linux/mfd/rohm-bd718x7.h
> > index d1730b97ba52..4cc617047d5f 100644
> > --- a/include/linux/mfd/rohm-bd718x7.h
> > +++ b/include/linux/mfd/rohm-bd718x7.h
> > @@ -7,13 +7,13 @@
> >  #include <linux/regmap.h>
> >  
> >  enum {
> > -	BD718XX_TYPE_BD71837,
> > +	BD718XX_TYPE_BD71837 = 0,
> >  	BD718XX_TYPE_BD71847,
> >  	BD718XX_TYPE_AMNT // Keep this as last item
> >  };
> >  
> >  enum {
> > -	BD718XX_BUCK1	=	0,
> > +	BD718XX_BUCK1 = 0,
> >  	BD718XX_BUCK2,
> >  	BD718XX_BUCK3,
> >  	BD718XX_BUCK4,
> > @@ -31,31 +31,27 @@ enum {
> >  	BD718XX_REGULATOR_MAX,
> >  };
> 
> Even though I don't care enough to NACK the patch, the above are
> unrelated changes and should normally be contained in a separate
> patch.

Thanks. But as I am going to modify the patch set anyways I can do this
change in first patch for the series. You're right that it is more
appropriate place for this change.

> 
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
