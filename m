Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4A9C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5DB2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXCHqdQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5DB2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbeJEXoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:44:54 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43910 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbeJEXoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:44:54 -0400
Received: by mail-qk1-f193.google.com with SMTP id 12-v6so1445682qkj.10;
        Fri, 05 Oct 2018 09:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t31vgOUFuIi0P89eLi3g86NNKowENUCyHuwBv1c+YDk=;
        b=HXCHqdQ1oIwNaD9i4LZ1hNDmL7yO9YwEAHGznpmcQkYbCQgGac4wSNH+JWecFZd8ao
         pTlnJn9SfpBQDVL6CNbJZYowfOLRzaDFK5iu9w3x7w0hYWiLF4WMgaaqd2UutIlGZDKd
         iGbRF9ZSfWycg1GiC5Z4JR18TwRJi3+lGF2fHFgCh9Ows2lsQd5qoiId/wTXYlNHdjge
         DI8xO8mo+s0mZZ6hzNxtXURFerphP8VURKINmpv7ZqA+zaHkIh5nhiGmHm950zlbF1hX
         7mtFdmGDcqaC91hUvxT8Wswn7shh92+dekhtMV2dVYWTmqI5WXTcUAkPzCuH5uW6coE1
         FasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t31vgOUFuIi0P89eLi3g86NNKowENUCyHuwBv1c+YDk=;
        b=gffH+Aq7ZvghBmXSAXU7KNmnIgDslQv9EzSMjz6csGjpHvERPVgCRhVjKGO8Lr28q1
         7+72nGLC7OlmN2TUMY2++bYQbS7AMQzwCZjs7QUKZyduQS/KExEJ4+lYCN5dDub7M2RA
         pxeH54azZg7ilanbUau1QpAm0WnSbIygfmVskvaT8Qfae2KgnyLV/5npOmYLEXRRyo8m
         aaHuKchzV2zAb3K8VYb8VDuqFs39lMds3Kt3bZ2k/DNkxswy9u9gwPT8LYE17MjEw8Zw
         fDrgz5+b4DffdUVgtB383DzDo8yutlU4xZMJLnbCqz+Rw3YtcV4W+5t9XjFfYRrp1gij
         Sn3Q==
X-Gm-Message-State: ABuFfoihVuRM+0GuFPlOwsOtlui0hPAI+zfevm6oyvqF7wCY89+TfxyY
        lHLuQT5SrWYf+I2LJNq8e162a4hH
X-Google-Smtp-Source: ACcGV60COPAVApDaHew6sRMMtDylGSk8D4HeJJr15TLWbHeuKDEMsdGOMvmMD2xkugTObzOpMwNxAg==
X-Received: by 2002:a37:6a01:: with SMTP id f1-v6mr1827058qkc.8.1538757923122;
        Fri, 05 Oct 2018 09:45:23 -0700 (PDT)
Received: from gandalf.middle.earth.net (pool-173-48-133-32.bstnma.fios.verizon.net. [173.48.133.32])
        by smtp.gmail.com with ESMTPSA id n85-v6sm4104995qke.76.2018.10.05.09.45.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 09:45:22 -0700 (PDT)
From:   "George G. Davis" <ggdavisiv@gmail.com>
X-Google-Original-From: "George G. Davis" <george_davis@mentor.com>
Date:   Fri, 5 Oct 2018 12:45:20 -0400
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "George G. Davis" <george_davis@mentor.com>
Subject: Re: [PATCH] i2c: core: squelch error: uninitialized symbol 'ret'
Message-ID: <20181005164520.GA2617@gandalf.middle.earth.net>
References: <20181005161826.2455-1-george_davis@mentor.com>
 <20181005162841.wy4uyespwcvffkpc@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005162841.wy4uyespwcvffkpc@ninjato>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 06:28:41PM +0200, Wolfram Sang wrote:
> On Fri, Oct 05, 2018 at 12:18:25PM -0400, George G. Davis wrote:
> > The following smatch error was introduced by commit 7ca5f6be7900 ("i2c:
> > recovery: add get_bus_free callback"):
> > 
> > drivers/i2c/i2c-core-base.c:228 i2c_generic_scl_recovery() error: uninitialized symbol 'ret'.
> > 
> > Analysis of the code appears to show that the smatch error is a false
> > positive since 'ret' will in fact be initialized after exiting the
> > 'while()' loop.
> > 
> > Squelch the smatch error since it is a false positive.
> 
> What about fixing smatch?

That would perhaps be the better long term solution. Something tells me
that this topic comes up periodically. : ) For the record, I've
confirmed that this problem exists while using the latest version of
smatch [1] but I doubt my abilities to fix smatch. So I chose to squelch
it instead.

Feel free to ignore if this is a topic already discussed in other
threads. To be honest, I did not search the mailing list to determine if
this particular issue was already discussed.  


--
Regards,
George

[1] https://repo.or.cz/smatch.git/commit/79fe36620a7a3a45d1a51d62238da250fb8db920
> 
> > 
> > Fixes: 7ca5f6be7900 ("i2c: recovery: add get_bus_free callback")
> > Signed-off-by: George G. Davis <george_davis@mentor.com>
> > ---
> >  drivers/i2c/i2c-core-base.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> > index 9ee9a15e7134..7b25ecb6b616 100644
> > --- a/drivers/i2c/i2c-core-base.c
> > +++ b/drivers/i2c/i2c-core-base.c
> > @@ -185,7 +185,7 @@ static int i2c_generic_bus_free(struct i2c_adapter *adap)
> >  int i2c_generic_scl_recovery(struct i2c_adapter *adap)
> >  {
> >  	struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
> > -	int i = 0, scl = 1, ret;
> > +	int i = 0, scl = 1, uninitialized_var(ret);
> >  
> >  	if (bri->prepare_recovery)
> >  		bri->prepare_recovery(adap);
> > -- 
> > 2.14.4
> > 


