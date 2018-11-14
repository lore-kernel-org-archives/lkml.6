Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7001CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39497214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQK4IpJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39497214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733293AbeKOBwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:52:34 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43460 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732950AbeKOBwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:52:34 -0500
Received: by mail-lf1-f65.google.com with SMTP id u18so11839998lff.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 07:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ro/Rd6yPPfAZwGse5lXKiW1Hf7gyNQmNxqp7zyIaN2o=;
        b=PQK4IpJP/P91irKCZtgB3jFp1c5TunayrJeFheCjqESoWxxn9xQMUdbQScAv55Yxxk
         nwhvgXx/OzGIicSipd3fT6zsAMLNMYWyI85e94/SCvoebC0VBXa/6INdamrtSMIiILmt
         TOqzfE9Y8lYSkO6lZ/pv9jwCUzgpX7DUtF4kh+sIAUHDfOl2nZ3YPRvjeAGs8cH3Uffo
         fOcWDHnPikdtwMtkUETXZAJsNQHFah3oLdhNauBA0a+OGvi8jvGdI4+XSrZ+ZM7v/Gz0
         mQOjl5bUdkZU7zSXcV//9DA5u9EKqt1roNDB1HupuREoboVzR0MSH236YfNfUYKvL9Rs
         2JOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ro/Rd6yPPfAZwGse5lXKiW1Hf7gyNQmNxqp7zyIaN2o=;
        b=G637VHTTbi/Kg71zGEnhh50UYOG5FSIUiFeSa75WEud+Tl8YXo6mtqbLmQreqdR5FN
         uL3zdHvdnxg5KenV07nbjV9juCqi1El10MM975TQqwivwNKrqGQvebNW+I1IWQF/aHhi
         huYkiMeGx0mJFWwbD/UxOgDinUX6HUksLEF0oMn+f1AsAmwxh94SkG01ysCqeF16CzwG
         piZqONdeW8ZLmOgckjrHfhnA5kcZx4u87c+HiTi2K2PP1ZsFzVQ7AYcdwBy+7tLYqLVS
         M3Le2DNAxqidxf8NnZs4ksdUcPbl21fwh/Qm+e2KyavQUkvbT406bS/pHJVoRDTnjqlk
         sE3g==
X-Gm-Message-State: AGRZ1gIPL7xS1ozqBnqDLvOfRWUsJtwCJ9J2WWaWRPJEkndrR4KVf0In
        j6aFhluqR/UcEK1MxBsufIw=
X-Google-Smtp-Source: AJdET5fRh0sWUU3w/UOsSzBFrR8tdsKpDih8IxFKZA8uN0/wLpyE0FPFW37pilymmPKdJiB43FdrlQ==
X-Received: by 2002:a19:d912:: with SMTP id q18mr1161739lfg.24.1542210526063;
        Wed, 14 Nov 2018 07:48:46 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id n3sm3723976lfl.44.2018.11.14.07.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 07:48:45 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gMxPG-0005Q0-Nt; Wed, 14 Nov 2018 16:48:42 +0100
Date:   Wed, 14 Nov 2018 16:48:42 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] greybus: gpio: switch GPIO portions to use
 GPIOLIB_IRQCHIP
Message-ID: <20181114154842.GD19900@localhost>
References: <20181109074735.GA5998@nishad>
 <20181112151509.GH13311@localhost>
 <20181113181805.GA32516@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113181805.GA32516@nishad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 11:48:09PM +0530, Nishad Kamdar wrote:
> On Mon, Nov 12, 2018 at 04:15:09PM +0100, Johan Hovold wrote:
> > On Fri, Nov 09, 2018 at 01:17:41PM +0530, Nishad Kamdar wrote:
> > > @@ -40,8 +38,6 @@ struct gb_gpio_controller {

> > >  	struct gpio_chip	chip;
> > >  	struct irq_chip		irqc;
> > >  	struct irq_chip		*irqchip;
> > 
> > This should not be needed any more either.
> 
> Just to confirm, by thism you mean only 
> struct irq_chip	*irqchip; right?

Right.

Johan
