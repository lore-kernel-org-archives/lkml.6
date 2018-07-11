Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF11CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892D02077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzYz0wep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892D02077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388769AbeGKOoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:44:16 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46755 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388402AbeGKOoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:44:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id r17-v6so19384635edo.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 07:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h8Ii2QooUTst5rtH71TiNDLI6A2Mup1FelGS/tnivUk=;
        b=RzYz0wepWHV9ex61IndXrFkBsekkic6PrqicCwxvlfWRTviJML7cTGnFpUvGgdD3NO
         Yg3xQtVlaOj5eaGPuE49QWR5tOM6EyijfcTyQmn4XvEkoc+rXQgQm8WN6ORvGSe8ZKcX
         WtmMkaWpDQ+ZMMuSePKfKu2ZB/33germUzx/++fwBylqKmo2vuTiPkrmLiAlBKC9XYSf
         KsH4BQNz3/4cRuR6Lry9nXHmfhYUNkrU8bFP9ILue5muHKIYG1wF/6/80DiArTb7UWOg
         q+5d9eYGS5oHnqP2Gq+/otbnlIzqC0g1411mGTl39mmOle0RCDd+KB2KvMcIRHsDBCgJ
         KoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h8Ii2QooUTst5rtH71TiNDLI6A2Mup1FelGS/tnivUk=;
        b=ZtXZFPM9PwLe9Dhjhmg97PZrLQz5adi3Ck997URvVAZGZ56QHmPQT/2fPwxs0ePCFq
         OtpNPyoIltu4UhATzGA+f2VvBLxl9IdtsLqOtH+GupOo5YR6wG3klSvzNkNQ2tna1LRg
         fDth1CnoR2FkinPivrp6Xfz7iSy4LUeu4L45gPrB2iyXch8qc/RKSFq/IYwQOCd2fT+N
         j1Ifp/vRWqd6QzQQrSQuDMBf6+W1nAFGert28lAcHOne1+gGcA6+zrqQEdurAgLzG/x5
         0Ilpy6NoC6YXXjKzMO6OlrhCBscKk9XJorbzLyCEiCw5UpuUFusGBdjsS2SGwtL6tM4D
         /3ew==
X-Gm-Message-State: APt69E07E1YHc66VPP++ukk0UMUXKdJG+emAv+RpjDlIE36V4hTfaqGW
        +awgsKLAh9NUXscKoKiCexw=
X-Google-Smtp-Source: AAOMgpfggrx+AovFF7cCBld/U6e8OvUMEFvXPgHwEINryg/Iz6weEMWvjgQ1Jfki5O/0bG3VKxOjkA==
X-Received: by 2002:a50:b134:: with SMTP id k49-v6mr25640270edd.55.1531319974444;
        Wed, 11 Jul 2018 07:39:34 -0700 (PDT)
Received: from xux707-tw ([109.77.228.66])
        by smtp.gmail.com with ESMTPSA id e25-v6sm9164403edq.65.2018.07.11.07.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 07:39:33 -0700 (PDT)
Date:   Wed, 11 Jul 2018 15:39:29 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        kstewart@linuxfoundation.org, keescook@chromium.org,
        aastha.gupta4104@gmail.com, linux-kernel@vger.kernel.org,
        John Whitmore <johnfwhitmore@gmail.com>, pombredanne@nexb.com,
        tglx@linutronix.de
Subject: Re: [PATCH v2 3/8] staging:rtl8192u: Correct spacing before and
 after parenthesis - Style
Message-ID: <20180711143927.GB12935@xux707-tw>
References: <20180710150523.17384-1-johnfwhitmore@gmail.com>
 <20180710150523.17384-4-johnfwhitmore@gmail.com>
 <20180711111349.GA28836@kroah.com>
 <20180711140935.GC26416@xux707-tw>
 <20180711142250.GA3907@kroah.com>
 <20180711142710.GA12935@xux707-tw>
 <20180711142943.chjedee3m7v6yogh@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711142943.chjedee3m7v6yogh@mwanda>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 05:29:43PM +0300, Dan Carpenter wrote:
> On Wed, Jul 11, 2018 at 03:27:11PM +0100, John Whitmore wrote:
> > On Wed, Jul 11, 2018 at 04:22:50PM +0200, Greg KH wrote:
> > > On Wed, Jul 11, 2018 at 03:09:37PM +0100, John Whitmore wrote:
> > > > On Wed, Jul 11, 2018 at 01:13:49PM +0200, Greg KH wrote:
> > > > > On Tue, Jul 10, 2018 at 04:05:18PM +0100, John Whitmore wrote:
> > > > > > Corrected coding style issues aroung opening and closed parenthesis. Spaces, or blank line, removed from after '(' or before ')'
> > > > > 
> > > > > Wrap your changelog text at 72 columns like your editor asked you to :(
> > > > > 
> > > > > I'll fix it up this time...
> > > > 
> > > > Oops sorry and thanks. I thought the magic number was 75 which I got from:
> > > > 
> > > > https://www.kernel.org/doc/html/v4.16/process/submitting-patches.html
> > > 
> > > 75 works as well :)
> > > 
> > 
> > Well if I went over 75, which I knew about I'm very sorry I messed up. I'll
> > keep an eye out in future. Might be using the wrong editor but let's not go
> > there.
> 
> Here is the line:
> 
> Corrected coding style issues aroung opening and closed parenthesis. Spaces, or blank line, removed from after '(' or before ')'
> 
> It's 128 characters.
> 
> regards,
> dan carpenter
> 

Scissors I really messed that up. Sorry again, editor must have dropped out of
auto-fill-mode for some reason. :(
