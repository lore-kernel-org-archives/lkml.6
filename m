Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7F5C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AABD20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="NcVFLpRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfANLmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:42:54 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38504 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfANLmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:42:54 -0500
Received: by mail-qk1-f196.google.com with SMTP id a1so10308921qkc.5;
        Mon, 14 Jan 2019 03:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V6RyqVqTsW2wUgM3iE9ftzfC21Ku2y0YEvbTox3U+yE=;
        b=NcVFLpRoaYQKc3MQzL2CIelNqTvVThhEzNZFvCMyWt9l9FM5HOBLbaaQjFbEC1TRJd
         8AutPqz1bstM57ORbIUbHBXbQyhAJWM+hSvQySTcb+X7amfpPQHVWeY/mtw0aOGULPma
         WeEM/9nG8Yy0CojM1W6rgunmZ9MHltNNJuxrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V6RyqVqTsW2wUgM3iE9ftzfC21Ku2y0YEvbTox3U+yE=;
        b=ExWEzoZ2YRTFbTuDBag0LDKs1M/M5fu+Vu2i3ItSz3+PaDgmjq4oyGhAnBDZgSUBQr
         WA3AM7JMmA6biOtH9rz5/CB8MNTqqLw8ILcy7L5aZPgt/uQYcxOy+Vg12FZhcOdxemI4
         BDuyx4ZsqwTMewZmXIuJiGFIWxOOmQHve17wcXNbISpMeL5jpZb81YVw3YmTAQjjsDyy
         xkmqxk8NxoUSyLXMC9BVudDLuaridRlaBHcKdX2hYL8xyr+xTovoUFSqpv1Vt92tC97d
         4KZhoyfxRjwZ2UgkGjOmYHiCzBV49CaApeaOUzedcqm0ttGBRodMTm+XiKSxhAJvGQhY
         rjKA==
X-Gm-Message-State: AJcUukfYEWYlfMDz4Mgnq1KnYtWYo0r6eZoMaOLrKo/AkthLtVM9Xyix
        FP3BzSKOaHY/WRkyKPyws8wasuNEzRVBskDRSKA=
X-Google-Smtp-Source: ALg8bN61vPHmDFt59oJjGsnPDUxQeZ2HKmFZE65UF4JoH+tbdX0SI+dTbl5ZWCRcHq0Ks6nBhOM6b8Y0/3Lb5SXVTLA=
X-Received: by 2002:a37:781:: with SMTP id 123mr22049227qkh.231.1547466172551;
 Mon, 14 Jan 2019 03:42:52 -0800 (PST)
MIME-Version: 1.0
References: <20190107214136.5256-1-jae.hyun.yoo@linux.intel.com> <20190107214136.5256-9-jae.hyun.yoo@linux.intel.com>
In-Reply-To: <20190107214136.5256-9-jae.hyun.yoo@linux.intel.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 14 Jan 2019 22:12:41 +1030
Message-ID: <CACPK8Xet1HUbC4MN-XO31oZj56+af1Lpc_mtee-COSYizedWTg@mail.gmail.com>
Subject: Re: [PATCH v10 08/12] mfd: intel-peci-client: Add PECI client driver
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Wu Hao <hao.wu@intel.com>,
        Tomohiro Kusumi <kusumi.tomohiro@gmail.com>,
        "Bryant G . Ly" <bryantly@linux.vnet.ibm.com>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Vinod Koul <vkoul@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        David Kershner <david.kershner@unisys.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Johan Hovold <johan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-hwmon@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        James Feist <james.feist@linux.intel.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019 at 08:11, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>
> This commit adds PECI client driver.

It looks like it's a PECI driver for the three CPU families, and it
implements cpu and dimm temp, with sideband functions deferred to the
future. If you add that information with a few more words it would
make for a nicer commit message.

> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>
