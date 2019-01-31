Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77B4C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B0C218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FxJjiRbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbfAaKXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:23:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41342 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfAaKXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:23:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so2619488wrs.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 02:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/rgu2srdOTDY/TUDCyO8ND1f9F+MiGaxcyF4V+pRpU4=;
        b=FxJjiRbFLDYlXtva4zgglDY9v5Tvlmp7OC/zxDfs44JhqHXNLWmIH2b0t/1Y9f+IO+
         e0JtBcG/o83kL3//MZ9zniXJsyj4LEU+dpolOGdtZc1MvS6/m833b+MqM1lZQRta4V4z
         HEv5A3hVsVrPXhMixOnhqpVuhixPEp5pBttGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/rgu2srdOTDY/TUDCyO8ND1f9F+MiGaxcyF4V+pRpU4=;
        b=ayyItxLMTWpD1tZ4M8Ld5fWHEbxP0yMb9ihm+5gBSbEJuJTnV58W2kSZR/JG1Ywu8o
         /hTSJ15nq+eJv4IiWqZNDzx11KcwAvEhBJLKGUEgXZCEA95+D4FL1KLgYqiXR0qm/iuL
         oU+hYb9Ya9n5t+pGIcO/57sTHpQ/mQurPVYU1f2TKg4KSalDOlw/I/U6BVmQItyU1YyW
         VFQHpP4T7p708UkYtMX7Mir5Qm7KT9BbaSja5y28zOQJKPm8TCSnf6a6mX+E9bks2Wml
         mVEKZmYGvO/EsYX00uxVSrg4XRjm10NRr1FAQuZ4s98jXKFux7DUIaZk+xD+afiCDmjI
         BIzQ==
X-Gm-Message-State: AJcUuketfdgbg/wNhJWYPCRQbefhJ50BZ8d6uBrs05EBhneOykk08T1q
        QJXKLz5kJ4Nt5Jxypl8X5XdQ+w==
X-Google-Smtp-Source: ALg8bN5u+irPNW4CpnJzs7CtLLVoXOBUiHjP1lepgqXWYMjA+RIQf5rfkTiqSE1FbMxHPAGAwcbkqA==
X-Received: by 2002:adf:c5d3:: with SMTP id v19mr33628130wrg.30.1548930197285;
        Thu, 31 Jan 2019 02:23:17 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id 198sm8541714wmt.36.2019.01.31.02.23.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 02:23:16 -0800 (PST)
Date:   Thu, 31 Jan 2019 10:23:15 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-kernel@vger.kernel.org,
        Emeric Dupont <emeric.dupont@zii.aero>
Subject: Re: [PATCH v3] mfd: tqmx86: IO controller with i2c, wachdog and gpio
Message-ID: <20190131102315.GK4701@dell>
References: <1547250965-17668-1-git-send-email-andrew@lunn.ch>
 <20190129113532.GB24070@dell>
 <20190129205652.GF13334@lunn.ch>
 <20190130125007.GA4701@dell>
 <20190130155227.GC15050@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190130155227.GC15050@lunn.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019, Andrew Lunn wrote:

> > > Hi Lee
> > > 
> > > I posted a new version.
> > > 
> > > Your email indicates you are using Mutt:
> > > 
> > > >User-Agent: Mutt/1.9.4 (2018-02-28)
> > > 
> > > Which is also what i use. I've never had issues with signatures like
> > > this. I also cannot find any documentation as to how you configure
> > > mutt remove signatures. How are you doing it?
> > 
> > I think it's automatic.  I certainly didn't set that up.
> 
> Interesting. My mutt installation does not do this. I trim emails
> manually to be netiquette compliant.
> 
> > Try replying to your own mail.  I should automatically cut.
> 
> Replying to my patch works fine. It does not cut the patch.
> 
> This is a bug somewhere, since the marker i used is not a signature
> marker. It did not have the space on the end.

Yes, you're correct, it should be "-- \n".  Give me a sec ...

Ah, it's an Emacs Post-Mode thing:

 ;;; Revision 1.6.0 1999/03/04 18:04 Rob Reid
 ;;; Returned post-signature-pattern to using "--" instead of "-- "
 ;;; because some senders have broken MTAs (as Eric reminded me) and
 ;;; some users don't use procmail to compensate.  This time all of the
 ;;; functions dealing with signatures have been smartened up to avoid
 ;;; false matches.  Unfortunately that means they don't use
 ;;; post-signature-pattern in its raw form.

> Anyway, getting the patch reviewed is more important to me than
> tracing down the bug...

Agreed.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
