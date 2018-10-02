Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645ECC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC4A20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="w7dennKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC4A20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeJBQrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:47:03 -0400
Received: from mail-it1-f178.google.com ([209.85.166.178]:50243 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbeJBQrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:47:03 -0400
Received: by mail-it1-f178.google.com with SMTP id j81-v6so2664356ite.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 03:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ovYa1liYOCn+nwbc4Bo8DuZUzoYH3qff/WIfFOCEDOw=;
        b=w7dennKUaQEBMEef0zSWUnaopal7Adk6RrBUwq80QvA7d4UBJlh24MIZ/iK0E3lN6m
         W3nU7AMIGpSfUOEud18cnj2ZBbx3ZA1LIIosYAWzw2LW2GPAIPqbEwig22bTpvCVoY3X
         Bgnpdh49LAub+PPPhRMEjNXvXHO9OrJPc6zrnBO4WojPQf/5m6WwCF3xnWz2FlcD13XN
         E3Tj4pw4YzIRElzCXc6xyVtHxI0CBeIdB6Zzt9n/HxfhgXSCX0LoBOQqmeL0jokcyUe3
         oebmZRbnEZ4wJM6BCl1BBkghyUgMSUfOMz+tscjaeSCnMadK6E4xsso8lFwqcXTu/zef
         m7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ovYa1liYOCn+nwbc4Bo8DuZUzoYH3qff/WIfFOCEDOw=;
        b=sTp5QeMSYMipm6r+yyGJGY+CTm29Qs0dz3YN/mvE7shSb/V5VNTqC58xY1t9zz6GzE
         DOXms7wFqjxiw1iTjv/gxg0otCryNqCYAs0Bks72zwXSog5CizN1aYlRsP+KX3j43qSj
         lei7DdX5AVUs9r+U1b/FYIiXUy57wobJ0OkldYo4kI6kkIJ4KY4YPDrIsAl2ql2inQFC
         tQlxnV6fZ1gG3TKjWOTVFsdQ54GTgoKglVb/a5cGPEjRX5ejVKIGduZyDaYOdV9fzzSz
         ndErqowY1me9Q5vcbJCbilPxCtAJAbGXSVPV29KMFQYq1ndhqsK682a+xWWzbKatygDn
         3KVQ==
X-Gm-Message-State: ABuFfogg/QL41BlNNVelC4p965hYp2QGUqWadNprjuOEf8UKtRwZ0cey
        7thCo4KvYp238lJGL0DVko466g72dkBZ+YMUU9ZEfw==
X-Google-Smtp-Source: ACcGV601BoDbxcQ9y4zM7I/6KDGZhqjkWAN+2qmKD8dUNoIrgkG/TIOkqOOIWbneijDlbND8BuPzXu7D/pAY3JGugPE=
X-Received: by 2002:a02:1e94:: with SMTP id 20-v6mr11610070jat.34.1538474674373;
 Tue, 02 Oct 2018 03:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181002191236.0aa50539@canb.auug.org.au> <CAMRc=Mf64AMBiMwBTCYeG18txVqbdvkQA35ZyZuRtwOCe70RpA@mail.gmail.com>
 <dabf8577-418c-65bf-03b5-89f0236bc53e@linaro.org>
In-Reply-To: <dabf8577-418c-65bf-03b5-89f0236bc53e@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 2 Oct 2018 12:04:23 +0200
Message-ID: <CAMRc=MdvRoKSFcYLednczDdZgCNr-nU634PgoZE2UdLXepUV6A@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the char-misc tree
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-next@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 2 pa=C5=BA 2018 o 11:56 Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> napisa=C5=82(a):
>
>
>
> On 02/10/18 10:49, Bartosz Golaszewski wrote:
> > this looks like a false positive - this routine is used in
> > ./drivers/nvmem/core.c at line 943 in this revision.
> >
> Note that the caller is under
>   #if IS_ENABLED(CONFIG_OF)
> so this warning!
>
>
> --srini
>
> > Best regards,

Right. Let me fix that then.

Thanks!
Bartosz
