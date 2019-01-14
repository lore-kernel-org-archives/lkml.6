Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F91EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259BD20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547467228;
	bh=ifsWtsRN/z0SJK5nLzQLBAogAQZVptSI9jgc9t6V9xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d4p9pTK8KRmkbO4HRZoY7Nvn+tkF1uOCs53uxLu4upDji7SdKqmeWoLD+X7RfiQ8B
	 w1M9bUm313cqhjrvohu1+UPCPmyHSznfyA073BXYmCoPAXK5yzxnQ6YLWg1e59EDF4
	 3wlpTOz7aoKC1S1+VCWn2GhOfu4m0qqs31AW0EDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfANMAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:00:25 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39718 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfANMAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:00:25 -0500
Received: by mail-lf1-f65.google.com with SMTP id n18so15387514lfh.6;
        Mon, 14 Jan 2019 04:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sfv8Q3I1SxDUQ6ujz8gZ0BIXmW+cbBhcVJvldERsiI0=;
        b=XbM+7zxE1Zu7zrzacMXEsVxUYeqWKkQJeR334UcLSk2Giab8/Jb6uAcieBSI+YOW35
         1CqrDRbpoBWUlRfi1bym3OzUvxHtfGs+YPMvk2s2E4QTPYPLEEOVzVA4nC3Dd2vx9EHj
         tLy7VI6SwpbBOifbD4QJxQ/7ggyeHcwTXcud/G8uND7AmbC/Wj4PVP7VlNsNTZrBC/61
         J+RzsxTx+t7oioajgqdmP2ciT+vTkGHlKjI7wy4PU2q984HlfzmI2DTlyhKOt2/JtQ0O
         e2/MHCj3u59YCKmb0UeGfxoAqhJ8mBMo4+4mXE9CP7mvNVcss+NeiOVv0QzF0QVKH/xD
         PYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sfv8Q3I1SxDUQ6ujz8gZ0BIXmW+cbBhcVJvldERsiI0=;
        b=pj9PqdfN7I/ST/a72GRI9W1lHGMDmk+T4CBfJ/RrUsRV0/UIJvKL0DaPZgH7C8DxQf
         HffefGD4rhpH3/4p4HWLCESnacyktWi078QO01qSk2UshrIEJn2SpD/+03D6BzMa0R6w
         I2mTMRkhj/wfcIAzo53quuAD4TpFu3aUVOKPAt9ltsSRZfY9YByCnOWUNwDjZ4AojtBb
         bGzePTh1bFOKfF/HmDAVVHYSm2ag9JUFPArmRXShBaaKoOjVMqtXZmNcJQUMtPOCwdpK
         zbVRlPDXPIXBWtr+PvxUOzPGNI1xCwI1QxLtecJWf8KTbkWh0U1ZnMJ391HKEz1YgQuD
         lteA==
X-Gm-Message-State: AJcUukcQixC58qsSmeGuIoZ4PeRgV7xgCaCoe2zbfMMUlEkSfmzmpUYD
        HGY6Blnq3l8p3mGXnzotKdQ=
X-Google-Smtp-Source: ALg8bN4nl1NXeV7RONQ16wuxxqfWJ/fWhWNTMaz4Hxnhj6kgNTi7ompuRh/jOtL5sSD61tkCnUTSNQ==
X-Received: by 2002:a19:518d:: with SMTP id g13mr12753879lfl.143.1547467223186;
        Mon, 14 Jan 2019 04:00:23 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id b69sm49283lfl.28.2019.01.14.04.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 04:00:22 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gj0uj-00012s-Lp; Mon, 14 Jan 2019 13:00:21 +0100
Date:   Mon, 14 Jan 2019 13:00:21 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Johan Hovold <johan@kernel.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v2 1/5] gnss: sirf: write data to gnss only when the gnss
 device is open
Message-ID: <20190114120021.GF3691@localhost>
References: <20181209195150.5192-1-andreas@kemnade.info>
 <20181209195150.5192-2-andreas@kemnade.info>
 <20190110120228.GB3430@localhost>
 <20190113215036.11c543db@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190113215036.11c543db@aktux>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2019 at 09:50:36PM +0100, Andreas Kemnade wrote:
> On Thu, 10 Jan 2019 13:02:28 +0100
> Johan Hovold <johan@kernel.org> wrote:
> 
> > On Sun, Dec 09, 2018 at 08:51:46PM +0100, Andreas Kemnade wrote:
> > > The api forbids writing data there otherwise. Prepare for the
> > > serdev_open()/close() being a part of runtime pm.
> > > 
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > > Changes in v2:
> > >  add locking
> > > 
> > >  drivers/gnss/sirf.c | 28 +++++++++++++++++++++++++++-
> > >  1 file changed, 27 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
> > > index 2c22836d3ffd..ba663de1db49 100644
> > > --- a/drivers/gnss/sirf.c
> > > +++ b/drivers/gnss/sirf.c
> > > @@ -35,6 +35,12 @@ struct sirf_data {
> > >  	struct gpio_desc *wakeup;
> > >  	int irq;
> > >  	bool active;
> > > +	/*
> > > +	 * There might be races between returning data and closing the gnss
> > > +	 * device.
> > > +	 */  
> > 
> > Please drop this comment, which is too verbose. The mutex protects the
> > opened flag, and that could be indicated using a new line above the
> > mutex and below the flag, or using a short comment before the mutex.
> > 
> > > +	struct mutex gdev_mutex;  
> > 
> > Please rename "mutex". We should be able to reuse this for the serdev
> > open count as well, right?
> 
> No. we cannot. The problem here is that we would take the same mutex
> in a serdev callback and around a serdev call. Then we have things like
> that:
> 
> [   36.700408] ======================================================
> [   36.706970] WARNING: possible circular locking dependency detected

Right, we need to be able to flush as part of close. Thanks for
investigating, though.

Johan
