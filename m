Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D393AC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 05:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2DC27820
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 05:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZb4UkoH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2DC27820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932933AbeF2FfX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 01:35:23 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33880 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751981AbeF2FfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 01:35:21 -0400
Received: by mail-pl0-f65.google.com with SMTP id z9-v6so3908127plo.1;
        Thu, 28 Jun 2018 22:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9enrT/DRCRPXOC2q8MRtGanpjY8tHZre62iZ3RKB88k=;
        b=eZb4UkoHEBCnaArDtBCDe5GH9PT3dKOVrqk1Gzo61Czqu9gwAmzOsrMIQIVOhc3KXV
         9+7OaKL0zfkX8692L08/vjvEobew6MPROJWQK5CHsNycabJ6EmYk3yMlccqIlhiiJ/DT
         MZdsrtUWOhWUy6TAKOfmGTqn3LykK/qRtv9oBMgEhcwlM/B61MPPRqyJuIxl0OU3JCIA
         DiChnC1jM8YuTGidmhC1zVRRu0/JkOoQ/hcBLxPbbE68AHGf+OTkVVQ7YGwbOG2+IfqD
         B3tnESWKCaRCIa+14srlGLbaRk7/OoEBqRTJHV5EFk9+7jkD+eVBHInGxu849FKS6Ivj
         BSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9enrT/DRCRPXOC2q8MRtGanpjY8tHZre62iZ3RKB88k=;
        b=EYvoO2sG8cPpYbVOD039Dom5OnEGR5SB/zessfOdes7tPpHecRNpQhLF171xQlnod7
         j4HT/8GLCRMImRMBBqsdFoURyjoCvDuRVzACNT51z/iON2CF5/wJMV3V56sLCB7glGPf
         Dz3zR0frFf5xudB43tTd6+ZMGAyJXoXXO99nye/Z0Kbyzvh4oPDxfCFtdaIk9T7m0RM+
         S7EtNzhQmtVBvEBQ+0aoCc4OjT3tvvaJB943ATVvodBJWTgtZnb6/9x5AdkwuEjdyhmS
         7g6hdoo6BKkn/jqCYQIBv4Y7/NTTyQGTFeoANAyFRHRBLFlLHRR3i2NSCg58tMol19WC
         VzHA==
X-Gm-Message-State: APt69E36JVgVgILn09jATwy8DGtWYhKaXEE/28sSO5R2kbqqd2p5pKI+
        C/bG6Gt+9qyXdVnwle+bh+eexgxw
X-Google-Smtp-Source: ADUXVKKTihhAldMj7T+DNOv07HleVg4nstbeOx7hqm38VRT3LIAVpaVJPy+n7HYU20v0mdTBgGY7LA==
X-Received: by 2002:a17:902:d24:: with SMTP id 33-v6mr13633296plu.22.1530250520869;
        Thu, 28 Jun 2018 22:35:20 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id g2-v6sm16514176pgn.92.2018.06.28.22.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 22:35:20 -0700 (PDT)
Date:   Fri, 29 Jun 2018 11:05:09 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, Michael.Hennerich@analog.com, lars@metafoo.de,
        knaack.h@gmx.de, pmeerw@pmeerw.net, mchehab@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        rdunlap@infradead.org, lukas@wunner.de,
        Ismail.Kose@maximintegrated.com, vilhelm.gray@gmail.com,
        sean.nyekjaer@prevas.dk, pombredanne@nexb.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: dac: Add AD5758 support
Message-ID: <20180629053509.GA2647@himanshu-Vostro-3559>
References: <1530188012-28253-1-git-send-email-stefan.popa@analog.com>
 <20180628214818.GA3577@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628214818.GA3577@himanshu-Vostro-3559>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 03:18:18AM +0530, Himanshu Jha wrote:
> On Thu, Jun 28, 2018 at 03:13:32PM +0300, Stefan Popa wrote:
> > The AD5758 is a single channel DAC with 16-bit precision which uses the
> > SPI interface that operates at clock rates up to 50MHz.
> > 
> > The output can be configured as voltage or current and is available on a
> > single terminal.
> > 
> > Datasheet:
> > http://www.analog.com/media/en/technical-documentation/data-sheets/ad5758.pdf
> > 
> > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > ---
> [..]
> > +static const int ad5758_dc_dc_ilim[6] = {
> > +	150000, 200000, 250000, 300000, 350000, 400000
> > +};
> [..]
> > +int cmpfunc(const void *a, const void *b)
> > +{
> > +	return (*(int *)a - *(int *)b);
> > +}
> 
> Since Kbuild hit a Sparse error in this function, I would also like to
> add that the above implementation of cmpfunc() is not safe.
> 
> For eg: https://wandbox.org/permlink/MqGnA3nVg7eAN4I7
> 
> The following will be safer:
> 
> static int cmpfunc(const void *a, const void *b)
> {
> 	int arg1 = *(const int*)a;
> 	int arg2 = *(const int*)b;
> 	return (arg1 > arg2) - (arg1 < arg2);
> }
> 
> [..]
> > +		index = (int *) bsearch(&tmp, ad5758_dc_dc_ilim,
> > +					ARRAY_SIZE(ad5758_dc_dc_ilim),
> > +					sizeof(int), cmpfunc);

I somehow realized that my argument is useless since we would not have
large integer subtraction, which could lead to signed integer
overflow(UB) and hence cause problems(as evident in the eg link I posted).

Sorry Stefan :(

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
