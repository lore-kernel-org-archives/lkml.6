Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D43FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6E4204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jj/HJ56Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6E4204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbeI1A6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:58:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40869 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeI1A6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:58:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id s5-v6so2507922pfj.7;
        Thu, 27 Sep 2018 11:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wx4n+pGnn4Z27VuDHAijr/2jdLp27dEjTrmAwqM/WRI=;
        b=Jj/HJ56ZB8avkSygxia05Hpk+JobOAl4f3IvxnRAXdEdPcjy92KjQlkOrDPbpkFSdh
         BBE8QzXlAC43dwZxAXcBCclSph0E+JUR3zpz5JKb4dOkuhp9W/W8vmOLzDn5381AorEC
         d4/69DlyDlEbmuLRal5shjutVlHBLBq/1l5oFVm2pGr+SkNdaEMg26WnaTksgr0Wh/m4
         JIIWg11vFwY1JRUa549y5EOK8tYmvGeA4Yf2zbdAhv1NBXCB7q5tLYKMqMr5Yj6VzhDN
         lalzUWF+aQiGpGJ+mbRllSlX3qyag7BElDz+hIdX2GuOsQMuxdSDR2QkBfRIqjw71/L0
         Ej5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wx4n+pGnn4Z27VuDHAijr/2jdLp27dEjTrmAwqM/WRI=;
        b=OKD0dZ6zvKL8Np2iXEAfkA8Zng+ks4biZS6ud+g3Tx5fJJmwBkc0ZqI9gV/H6l5UKU
         NCNL+DXphLN9Fax6jvBOvwiVw23cC95k9E2924jcNkbbXba+NQKU11/CEpSM7sDVab5w
         xjhNtTlrG1gpbyCmzLP5J14fCsuq6bpUWFA+I3h4gBPTLFadPUcmox4j6mjZL1tzKJmb
         xdvArbJ+QQ+mAQFK6XYKet6YoUL4pS3qtCKt7eQX3XqWUPQB5amijaNwYErYqCRAQSOh
         tIakHq14LkSSYpzPR8PgDfpriiyhaBa6M1RKcQxhOCuGHyxnKE9eWiE7uLuof/agGcch
         ffmw==
X-Gm-Message-State: ABuFfohm4VjvBBHRr+GWRCUC/5k/3mR4fOO7H4O/Qcq/mhFSJ0wYHoBe
        IxRrXUomkT6S9+ujxOBJCWLwy9SV
X-Google-Smtp-Source: ACcGV62hrVcB/QpiRxSpgZlyMWin4gj2FFWlrItZNEPy6NLv7ERsRNMAh1jAfIID5vSSjYszQzj3aw==
X-Received: by 2002:a62:1b45:: with SMTP id b66-v6mr8322260pfb.94.1538073558525;
        Thu, 27 Sep 2018 11:39:18 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id s85-v6sm5295923pfi.15.2018.09.27.11.39.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 11:39:17 -0700 (PDT)
Date:   Thu, 27 Sep 2018 11:39:13 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, corbet@lwn.net, afd@ti.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: ina3221: Add enable sysfs nodes
Message-ID: <20180927183912.GA15719@Asurada-Nvidia.nvidia.com>
References: <20180926064245.4091-1-nicoleotsuka@gmail.com>
 <20180926064245.4091-3-nicoleotsuka@gmail.com>
 <0cfe55e1-10d8-ac1f-8b6e-73777074a219@roeck-us.net>
 <20180926180243.GA6329@Asurada-Nvidia.nvidia.com>
 <20180926195817.GA19695@roeck-us.net>
 <20180926202519.GB10595@Asurada-Nvidia.nvidia.com>
 <20180926204455.GA17035@roeck-us.net>
 <20180926215504.GC10595@Asurada-Nvidia.nvidia.com>
 <20180927160509.GA18064@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927160509.GA18064@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guenter,

On Thu, Sep 27, 2018 at 09:05:09AM -0700, Guenter Roeck wrote:
> > > Point is that I don't _know_ how this is going to be used, so I'd
> > > rather keep it flexible.
> > 
> > Well, taking one step back, I am okay to follow your way if you
> > are really firm about it. Just please give me a more reply and
> > I will merge this change to that v5, dropping the is_visible().
> 
> Quite obviously we are not converging. Given that, I think it
> would be better to shelve the new attributes for now and to wait
> for an actual user who actually needs the new attributes.

I would rather remove the hiding code, if we have to sacrifice
one of them. We both agreed that in[123]_enable is more useful.
And actually we will still keep is_visible() for empty labels.
So even if one day we somehow feel safe to hide a disconnected
channel one day, it'd only need a couple of lines of changes.

I will squash this change into v6, and will send it after I fix
things that Rob pointed out at DT binding.

Thank you
Nicolin
