Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F60ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 08:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745772084A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 08:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCaQqW3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745772084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeGUJS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 05:18:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41846 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbeGUJS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 05:18:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id j5-v6so13216316wrr.8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 01:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p/9uF5QRqbdy/VXNy1wCqXc9JfpyW/6C4oWKpe02dz4=;
        b=HCaQqW3kdbBR+wWpBcvS8IZ4MAsqmqNEXsogVv6hrs//T349ftmjgipbZ7c3ad7/qh
         kEqtF/W0RlW4duHpm6U3Ve5wGoQagKACiwIba/neGws5XdRfvWS4ZYFCdu0rct1wNtO1
         Kx5VFAKU2W/YeIO+PQPTh1btFeouthqsHEwVCJxa3QXa/+Xf5ppQ1grIcIdJIw1rHOjz
         5FxJOnyU0aHKxZGM3/mIRMmUi5U+M6mpYtQaf54aWqweqbxjg/5mOx+tpVsWSgWFKK3+
         QOyFcH0LE+dIrF6jQXLWueHO2m4FdCMAze60Wkl8fmWzvmC9kpDqINj9J4MuGKj+nOfk
         ersw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p/9uF5QRqbdy/VXNy1wCqXc9JfpyW/6C4oWKpe02dz4=;
        b=QKqMnLlgeE4BO6UZG9AtTISQ9vohhhw+apsqWa74/1brEXp5Kg2sZUFoXclTl9BcDu
         7XDAkR02yIfRNODI0DCm4rInZB7ghHQx5f8m1sWA13IcKXwuc+RVZYEb+WVyTSL1UM8J
         GWxEJWFbdVn2K2mLvVL1kKHsu2WDlKswjN+KdZcd4jpKWpHFJpukxuyHkHZtaxfsC1tk
         msoVVC7SHfPuFoZdxmiAwK1GcwLgesLPDC0ls3boqDdLnIV/BJViaVyRTTdDgsaaCVeQ
         CahYn+IR1dnc/r1mup1kMHBvD74LheGh9/TivZng2MgVwxbrZGaUJtVdElJegjtA5jUn
         9lGw==
X-Gm-Message-State: AOUpUlFJ05HsdS3kcEH/x/HwLqr9e+uUYhJrWKsFLljgjxbkL4AD0310
        oEyyAGGYEcGhm9skv+9N/OM=
X-Google-Smtp-Source: AAOMgpcDwAjTJAbf3XQUv0+9u+Quf2HJa9AJYdWBfk+wCwbAKSazYTb03KC0G0rCDdtLCbIh3+ZyBQ==
X-Received: by 2002:adf:e190:: with SMTP id k16-v6mr3469781wri.36.1532161592881;
        Sat, 21 Jul 2018 01:26:32 -0700 (PDT)
Received: from xux707-tw (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id w9-v6sm889814wmw.23.2018.07.21.01.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Jul 2018 01:26:31 -0700 (PDT)
Date:   Sat, 21 Jul 2018 09:26:31 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        tglx@linutronix.de
Subject: Re: [PATCH v2 09/10] staging:trl8192u: Rename TClasProc >
 t_clas_proc - Style
Message-ID: <20180721082629.GA28035@xux707-tw>
References: <20180716190454.31489-1-johnfwhitmore@gmail.com>
 <20180716190454.31489-10-johnfwhitmore@gmail.com>
 <20180721070215.GA20326@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721070215.GA20326@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 09:02:15AM +0200, Greg KH wrote:
> On Mon, Jul 16, 2018 at 08:04:53PM +0100, John Whitmore wrote:
> > Rename the struct TS_COMMON_INFO member variable TClasProc to
> > t_clas_proc. This change clears the checkpatch issue with CamelCase variable
> > names. There should be no impact on runtime execution.
> > 
> > Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> > ---
> >  drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h     | 2 +-
> >  drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> Ah, I think the problem with the rejections was that I didn't pick up
> this patch, because you mispelled the driver name :)
> 
> I filter for drivers to apply everything for that one at the same time
> to make things easier on myself.  And this got dropped.  Please fix the
> subject up and add it to your series and resend, that should hopefully
> fix the problems.
> 

Oops! (I'm sure this list probably rejects naughty potty mouth language, Oops
will have to do)

Sorry careless on my part, I'll go through these patches later today and
reissue a series. Thank you for applying and sorry I messed up.
