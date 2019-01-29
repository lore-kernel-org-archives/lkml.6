Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C784CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A882147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Szv/aWlQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfA2Xi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:38:27 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40679 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfA2Xi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:38:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so10112274plq.7;
        Tue, 29 Jan 2019 15:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+PKnZOF1yqFmuekM1RzTe7u5OOiAaunZnovVhZl+qbI=;
        b=Szv/aWlQJ10ULdZwETIrYZX4KT27S/jknazVwzeZ+u3KpJoj0exgxUgyx9r5/eyfws
         uSW/iimyZK4YYO6kPeZmYTBimX7lfba8c+3qRm53RhO6IYPqGUBNAqznNSEhx9ZJRNZF
         vyoPokHq+wvcV/NlmSfjeCgC7QwqXHsMzhNZxGvnjexxRdbzRTPlv54jOWZOIyoV6RlS
         HeVgu/2nOOuaOuCfWn8gWn3TAYSxCRE5IFTc3wKJbxtE0HuLj4VwE8aMbThlKsply3zy
         qmG+wcEhVSoTxOKC6It+A5mMbcVE68BXER4MHgGGj3GN7vDY/J/KWCuNm75PGgmacyO6
         TXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+PKnZOF1yqFmuekM1RzTe7u5OOiAaunZnovVhZl+qbI=;
        b=nfbmNcPV3HleOUksRd6ZKi2QDKCE/sqmpVV/ZwECb2LqhGQ7W/S9uC63WtpV6Mo4sU
         CKnOeN2D4Os2d17Jh5PzREGUNzaCnR+ecnCYkVkk2pS2nvb+5tIpswkoUEuyabK2MMMY
         K7ShrWsEMhoQNIQhV2IfeDcoCoRKAR9ngcrybwLJUF9/05o5YLxSgm7xw1zZGhlH53fB
         yPPrkbjDsxIF27hdwk4yUuxyHzrjMSYV8WyzmmRJa0gO3xIyzT5S5KWFdijJ1AEdabUH
         nwSk+aVKDfmUj01CixTAkwGFXv0jvWfCwqtC8+VJRddVGdcZv4Kmm3jqp851mq5Nmnki
         PoKQ==
X-Gm-Message-State: AJcUukdzkHwXx0O7cIdeSsIVQW86doE2iFqs9iwcbmrrVIMqx0NUYhyO
        tWD0w0YgjTL1b1OMYIfakeu77MF4
X-Google-Smtp-Source: ALg8bN6ABT00sEbE6Nmq7BO+lGJGOXpFcTUe/NyzMJ4t0yA/u0BC1C0pyZ1kBNZnQwS3Y3jS7RHHmw==
X-Received: by 2002:a17:902:32c3:: with SMTP id z61mr27961012plb.114.1548805106593;
        Tue, 29 Jan 2019 15:38:26 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h82sm75890725pfa.105.2019.01.29.15.38.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 15:38:25 -0800 (PST)
Date:   Tue, 29 Jan 2019 15:38:24 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jeremy Gebben <jgebben@sweptlaser.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] hwmon: (lm85) add LM96000 high freqency pwm support
Message-ID: <20190129233824.GA27719@roeck-us.net>
References: <20190129212920.27921-1-jgebben@sweptlaser.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129212920.27921-1-jgebben@sweptlaser.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 02:29:17PM -0700, Jeremy Gebben wrote:
> Hi,
> 
> This patch adds support for the PWM frequencies from 22.5 to 30 kHz
> available on the LM96000.
> 
> It looks like this chip has been supported for a long time, but wasn't
> mentioned in the docs (which I have updated).
> 
> Also, it has been using the generic 'lm85' prefix, which I have not
> changed to avoid breaking userspace or device tree files. AFAICT,
> lm85_detect() will only return 'lm85' for LM96000 chips, so it doesn't
> look like you can get a bare 'lm85' prefix with any other chips.
> 
> I stumbled on to a 10 year old thread discussing a patch which looks
> like an early attempt to add support for this chip, which may be of
> interest:
> https://lm-sensors.lm-sensors.narkive.com/1SIwaMDT/patch-hwmon-lm96000-support
> 
> Thanks for reviewing,
> 
Where are the actual patches ?

Guenter
