Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8D3C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A35208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtNRyWL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A35208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeIZIAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 04:00:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38201 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeIZIAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 04:00:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id r77-v6so7770132pgr.5;
        Tue, 25 Sep 2018 18:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Eaoa1jIwKvUqpGYuYJP6cUqaoeX2VSBALumixehSr7A=;
        b=MtNRyWL7bOMWAhTvZMdA8JguPd5qdeg5M9Xt4v6ICj47U88eo/S3kVSLX/oVkTCJX2
         mYP2twnw3bypaXsk9q9QfoN8cOkYV1+zH0hm68/2cP/0XyeSFJPGdvsT+5qXUmcfMzml
         vD5bwGc+VRshQOQgwpOxt7TRZ4HW61rL+ca6XBMJh4G20jqAQSsiymm49+F2E8wgF5/3
         kEhGFv2KVCsh77Dt9kcclJBYOtLl4bv8Ro7Sw6hVmqhoRzb3Uqoh4mbxmOJ4eHpCG5Eg
         vMMyBVh68w5qa3LUKET5EDasoZAduyYECskazjdudRTITG7RfH0qQg/bCfmCdQpHlcpv
         4LqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Eaoa1jIwKvUqpGYuYJP6cUqaoeX2VSBALumixehSr7A=;
        b=DCLcWsLyo3Rm+axKQDC4V8Y1LlRYgDri4u5QNrEjFwM1EPle3lggae/ORuvlcMPSuI
         d/HHoHtuqfnbIJqHAVnru2ol/fIj/YZZRUWsHIu6gu7yw9JMg2rGn7SyoJqSPryeFTNH
         2zC25/K3p0ZSIH8pwmSRw7ClQorUMsmg8r93vRKKyYAa/Tf3oCRVFp9nuMgzArfaBWI7
         9MEXxxm7Yx8Dog4cAZ0bVwLhIhbdCMtAnmzsXOkLTntDQ0iA/sPkWqM1mDT9aTE8tlmp
         m+OuaxqD+6xqs7pb63vEbuCRrFsu2UzxJZTvCbJrjinS/8V4yKS1PzXg0MgAf+HqIx/f
         3gmQ==
X-Gm-Message-State: ABuFfojuaqxPfa61MDh389++MlsIuEUX5AyJTr/YjeqMIqKn55vZmNSb
        7vBwbCwJKC213vWYton/dcc=
X-Google-Smtp-Source: ACcGV63YGEQp4kabLNy17dSZFcazgk24iXxZ9UjGooahpipD/ibZ/o8bItEpnikyA6zcuOPBCCNYjw==
X-Received: by 2002:aa7:83cd:: with SMTP id j13-v6mr3722191pfn.236.1537926598919;
        Tue, 25 Sep 2018 18:49:58 -0700 (PDT)
Received: from Eros (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id r205-v6sm4662416pgr.11.2018.09.25.18.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 18:49:58 -0700 (PDT)
Date:   Wed, 26 Sep 2018 09:49:51 +0800
From:   Song Qiang <songqiang1304521@gmail.com>
To:     Phil Reid <preid@electromag.com.au>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        rtresidd@electromag.com.au, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: magnetometer: Add driver support for PNI RM3100
Message-ID: <20180926014951.GA7094@Eros>
References: <20180925031724.21399-1-songqiang1304521@gmail.com>
 <20180925031724.21399-2-songqiang1304521@gmail.com>
 <20180925143054.00007fcb@huawei.com>
 <57d8a9d6-c402-068e-0a21-bbd6c20a7816@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57d8a9d6-c402-068e-0a21-bbd6c20a7816@electromag.com.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 10:36:54PM +0800, Phil Reid wrote:
> On 25/09/2018 9:30 PM, Jonathan Cameron wrote:
> > > +static irqreturn_t rm3100_trigger_handler(int irq, void *p)
> > > +{
> > > +	struct iio_poll_func *pf = p;
> > > +	struct iio_dev *indio_dev = pf->indio_dev;
> > > +	struct rm3100_data *data = iio_priv(indio_dev);
> > > +	struct regmap *regmap = data->regmap;
> > > +	u8 buffer[9];
> > > +	int ret;
> > > +	int i;
> > > +
> > > +	mutex_lock(&data->lock);
> > > +	ret = rm3100_wait_measurement(data);
> > > +	if (ret < 0) {
> > > +		mutex_unlock(&data->lock);
> > > +		goto done;
> > > +	}
> > > +
> > > +	ret = regmap_bulk_read(regmap, RM3100_REG_MX2, buffer, sizeof(buffer));
> > > +	mutex_unlock(&data->lock);
> > > +	if (ret < 0)
> > > +		goto done;
> > > +
> > > +	/* Convert XXXYYYZZZxxx to XXXxYYYxZZZx. x for padding. */
> > > +	for (i = 0; i < 3; i++)
> > > +		memcpy(data->buffer + i * 4, buffer + i * 3, 3);
> > Firstly X doesn't need copying.
> > Secondly the copy of Y actually overwrites the value of Z
> > XXXYYYZZZxxx
> > XXXxYYYZZxxx
> > XXXxYYYxYZZx
> > 
> > I think...
> > 
> > > +
> > > +	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> > > +			iio_get_time_ns(indio_dev));
> 
> memcpy target is a different buffer so should be ok.
> 
> But that raises the question of does it need to be?
> 'buffer' could be 12 bytes long and just shuffle Z then Y.
> Do the unused bytes need to be zeroed? or does libiio mask them anyway?
> 
> 
> 
> -- 
> Regards
> Phil Reid

Hi Phil,

This is interesting, last patch I submitted uses three transactions and
shuffles X, Y and Z respectively. You said it should be better to use one
transactions, I thought it makes point, and one transaction may reduce
IO pressure of the i2c bus. :)
And that's not necessary for unused bytes to be zero. I'm not familiar
with libiio, actually just been studying it, can't say anything about
it.

yours,
Song Qiang
