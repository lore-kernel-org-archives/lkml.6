Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A74C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F7C214C4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vLcWDpk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F7C214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeJLUZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 16:25:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34960 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbeJLUZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 16:25:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id f8-v6so5922593plb.2;
        Fri, 12 Oct 2018 05:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TlG1E6uoFtOlufZqGcUyT+As3nYy/nnAv0hB8EwO71Q=;
        b=vLcWDpk6uNvfBe/LFe+kZdaYTooldgTmYskPZM190o4P+4NBIRaemhuSxfzwYL9eKV
         NVqmUUdL6nM/BfdtqnQzb92xiBDG0ccwynAxsL+xLZVH6AAWpnkKs6oBXOcHx6DgmdIO
         CNf2uHCxrQYh1psEF/xn6cqkfs9HSM+cRrX/Dg+/EVRrKDOGwk6JY+dzhoE781yrcIND
         4/YZ8sldTVcNCjZz9j4YyDm1c3j1TENp2FRPpH1RTEWif9yyN1KxrCNltxKhn3CXWWRG
         DgpeJV7WJJkrSxC3WijFmVHwIgxGK6OXMcPXJMHgHv4HlnsJlHwHkdvZXwVyk9w3m+uP
         AQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TlG1E6uoFtOlufZqGcUyT+As3nYy/nnAv0hB8EwO71Q=;
        b=UEla93uDE4t8of6cTab7+AuvN6Hgo5g+cLm2BCIaxYhJbuubywWUVlNpKbBNTMKmVC
         44pVRuB+bWGv2FS6lFL85VjYzCEPdrA0wK7lxCaEj2igs19AgzT3W9K19yuH1uHKKJM3
         sonEDdpJ/zjkfLHd+YS7KW4sCK4v2lznlKSynNYJ4Wh6bi79BaNeGYuKy+3p5jqZiPHy
         WivI6aCj8K7jenwf6xr4yy2y3lQCFTRAVLLw3lYqRClCYT66ko1gtSfDS8xgo5q0SYWx
         DsWYOgWVxjaFl41yAjL78XcrfGb9oJjO4VNIF0kgu4Fm+nCRvj1bYp027gdnRCabLyRM
         MPwQ==
X-Gm-Message-State: ABuFfogBORS9xRFi3WZxeOLZ92U7NS9XX7K8FA2dMh3OihpvFVG5Ej/6
        qFqd5dbJzH84NVOsbJsxFDs=
X-Google-Smtp-Source: ACcGV60+a2DkFcZcrx5pBy2YnuaA3UhwoBH8YVVZ9aNBXlTGyc5D6M7PiVuqyZyFDolFejifQoqlZA==
X-Received: by 2002:a17:902:3041:: with SMTP id u59-v6mr5715143plb.99.1539348805898;
        Fri, 12 Oct 2018 05:53:25 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id o7-v6sm5796578pgq.14.2018.10.12.05.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 05:53:24 -0700 (PDT)
Date:   Fri, 12 Oct 2018 18:23:16 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        preid@electromag.com.au, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: magnetometer: Add driver support for PNI
 RM3100
Message-ID: <20181012125316.GA6480@himanshu-Vostro-3559>
References: <20181002143812.3661-1-songqiang1304521@gmail.com>
 <20181012073536.20339-1-songqiang1304521@gmail.com>
 <20181012073536.20339-4-songqiang1304521@gmail.com>
 <436097c6-b32b-42e4-e704-a15280e13cb0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <436097c6-b32b-42e4-e704-a15280e13cb0@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qiang,

On Fri, Oct 12, 2018 at 04:36:01PM +0800, Song Qiang wrote:
> 
> 
> On 2018年10月12日 15:35, Song Qiang wrote:
> > PNI RM3100 is a high resolution, large signal immunity magnetometer,
> > composed of 3 single sensors and a processing chip with a MagI2C
> > interface.
> > 
> ...
> > +static irqreturn_t rm3100_trigger_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	unsigned long scan_mask = *indio_dev->active_scan_mask;
> > +	unsigned int mask_len = indio_dev->masklength;
> > +	struct rm3100_data *data = iio_priv(indio_dev);
> > +	struct regmap *regmap = data->regmap;
> > +	int ret, i, bit;
> > +
> > +	mutex_lock(&data->lock);
> > +	switch (scan_mask) {
> > +	case BIT(0) | BIT(1) | BIT(2):
> > +		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 9);
> > +		mutex_unlock(&data->lock);
> > +		if (ret < 0)
> > +			goto done;
> > +	break;
> > +	case BIT(0) | BIT(1):
> > +		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 6);
> > +		mutex_unlock(&data->lock);
> > +		if (ret < 0)
> > +			goto done;
> > +	break;
> > +	case BIT(1) | BIT(2):
> > +		ret = regmap_bulk_read(regmap, RM3100_REG_MY2, data->buffer, 6);
> > +		mutex_unlock(&data->lock);
> > +		if (ret < 0)
> > +			goto done;
> > +	break;
> Hi Jonathan,
> 
> I just noticed that these three breaks are not proper aligned.

Please send the new version of a patch as a *new* thread and don't
use `--in-reply-to` flag(if you're using) to chain into older versions
as whole thread of older discussion comes up and is often not required.

The changelog gives enough info of what's new in the revised series.


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
