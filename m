Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D26ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECCF214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLErFfep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BECCF214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbeIRQw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 12:52:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43510 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeIRQw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 12:52:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id k5-v6so1647649wre.10;
        Tue, 18 Sep 2018 04:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AQrOqxQvM5yGOOn5QfGr56eA41+z/v8xVEiqYTx1xlk=;
        b=bLErFfepoQjuDn1mjPuIB+gOdto4bslvTSvHQyG0HFTue/XvZCnphoK3BCwWXkVt9J
         k5NlwcsKsWEBzv92JkolFq8BYi8gNms/wtM2Jj8pyHJFR37sL3/mJ5IZI6A9Q0Ag+efk
         KneyZcwIdzLuhEniF2UbDfIGpr4XSRQ+7ELylZ/ojszonqGg2MzYWTrX9VKKWn2iaEh8
         xSwgPfDBq8GaNbuUfITJh9mvGsTHhdMlBO2dvuxz8CjX5fhnfSfmh4AdtOu8N/bvU9VG
         yXM9vvGGSjEJsLImx1+qVKPqtkP6ITQboQnaagPlJ3XfILxAaVz7zYtGf8q73EQLRQiy
         ewvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AQrOqxQvM5yGOOn5QfGr56eA41+z/v8xVEiqYTx1xlk=;
        b=aVdfI7Nk3iWC8GG3PR7WXENqlga3D7WIjYfw3G3ygtwqv0gCMW+MHkCkErApihdvCJ
         TBHqqfv+P4qCBiLMUu+2r4FcNzsA4Rd3LKa9fTTvPACWSwLvLF628AAn8stcqP83R1cM
         RdxKoeO3Es0KBBlCNZMmCuzDm4qvM6W9Ea28M7sPRlT7rsX3ha/dUO1kAxJYQs+nXD2q
         EwYRYgdONdYNli496aPNyx1Vz5X1+WZbUTd08mvrDJNT0GWLLIHMiC9OF7FsrRHMlhWd
         65umMa1rAIwiSEMBI/gGgi421DeZkDHJykeM41veVj9kLcBHIehj1fW9AzsOi9hcPQwZ
         nqvw==
X-Gm-Message-State: APzg51DVmestf33V772tPQaVoTNVe+7oWn0RUNqZ9h2JWNOoD1On1d8D
        vJFT+u/y1tflx+nuY7l0nWY=
X-Google-Smtp-Source: ANB0VdaGkUtajoK6xP4B9IJyzZKywwEE3DZr1XiAeuaj0LlVZcvW/oM+vN7egeU73/anOuEuEd0dbA==
X-Received: by 2002:adf:9ab7:: with SMTP id a52-v6mr22676080wrc.75.1537269616697;
        Tue, 18 Sep 2018 04:20:16 -0700 (PDT)
Received: from pi ([185.208.64.4])
        by smtp.gmail.com with ESMTPSA id k13-v6sm15765037wrq.7.2018.09.18.04.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 04:20:15 -0700 (PDT)
X-Google-Original-Sender: <johan@kernel.org>
Received: from johan by pi with local (Exim 4.90_1)
        (envelope-from <johan@pi>)
        id 1g2E2C-00078x-8k; Tue, 18 Sep 2018 13:19:12 +0200
Date:   Tue, 18 Sep 2018 13:19:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [PATCH v4] USB: serial: ftdi_sio: implement GPIO support for
 FT-X devices
Message-ID: <20180918111912.GE3943@localhost>
References: <20180918094515.GD3943@localhost>
 <20180918091634.GC3943@localhost>
 <20180916175847.3288-1-pados@pados.hu>
 <ef753ab98cf19ce4482e76864d406c1e@pados.hu>
 <6e1a6550cbf886cb7dcfea641244bdcf@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e1a6550cbf886cb7dcfea641244bdcf@pados.hu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 10:27:58AM +0000, Karoly Pados wrote:

> >> Does that mean something can call into our module while this method is running?
> >> If not, I'm clueless about the possible race here.
> > 
> > Correct, you can get gpio callbacks until the gpio chip has been
> > deregistered (anything coming in after that would be a gpiolib bug).
> 
> I'm just puzzled by the fact that this can still happen even while the port 
> removal code is running. It also makes me ask the question what else here can
> run in parallel. Don't we need mutexes here-and-there in the ftx gpio functions too
> in this case? Or does gpiolib make sure to serialize multiple pin and direction
> setting calls?

Good point. The old sysfs interface would keep things serialised, but
the new chardev-based one does not (nor does the in-kernel interface).

So yeah, we need to add a mutex protecting the gpio state (i.e.
direction and value).

Thanks,
Johan
