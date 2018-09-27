Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3C2C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D202172A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbcDjK6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D202172A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbeI1Ffr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:35:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36052 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbeI1Ffr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:35:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id d1-v6so3017882pgo.3;
        Thu, 27 Sep 2018 16:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R3JUVI4VF6/KFF2AMLchyR/zYUB4Yah6d+9TpVBnI3Q=;
        b=sbcDjK6l6ganMDhmL3vER6vLIqkRXtKA8WoH+2HVWcmN3VGBrZj7ifmf1ITFRRbzYo
         cPpiFlzyYiexYqabBpfLSMN9zvS+Tduv5MmlBQC/3mtH1RdMPLAp+ErpDU/o3EApM9OK
         apXyaTUDpk2aHZmFo+cuKJIGom8/igkHiTf3YKUlXeDh5tDnde64iV7E1c7hDRt72woe
         lKmzTIriYYiGW5ghmZn4otZ/p8e9BUePRW+/HfXZC2XbILquBILZ9nujOpQgwY6GLBMT
         VD4fRazbd/ciGjp7T4pZ75NnGI80g9DGXoWPzti3JCd8B7irku/c35PBXFXf8TRJdaLQ
         AcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R3JUVI4VF6/KFF2AMLchyR/zYUB4Yah6d+9TpVBnI3Q=;
        b=I6WaeqtNj7HhBiHWEgpBo+fYChRGF+AFhasOLDMCPW1NX/Yp0kaPyQGt/2BesSDZgE
         1S/vOpC2Fo5nsk7ZQ/8tv8jegtsUUtxbwJCGNI9CgxLfZKAAJfc4g2gBthfilHzJcy2N
         zMKl8WBIRmoV+YYYkPgbb7+HC3CGsCxSvtwXdQoo4jbuut11sbnLv3EGaiSbzoOMmN93
         aANF6TnrkkSPfmdt2CLqLeojIBuqaOddcEZR5N/mSh9oC226nC3Ck4D70fuqcc6C6BT0
         yxzGm34M45OCfpjgyDQpYSzWw3mtJKy2kO4rJEUkGuZogs9HJHfn69f0FGBVdVtqsTuV
         jgOg==
X-Gm-Message-State: ABuFfoh1hF/gUMAWH5ric0RLoDUAnyL0CIjsg2DrpAxHF+dNWUsdGGt/
        9c0d4xfzXGO4quPIVZjlCac=
X-Google-Smtp-Source: ACcGV62wvwmyhoOzn6WPmkOYxs4nuIotrNhfu2U8cb/Ti3f2ATXepRtNBqTnKv8jXbapMyLCoCtb8A==
X-Received: by 2002:a63:27c1:: with SMTP id n184-v6mr12407268pgn.278.1538090103580;
        Thu, 27 Sep 2018 16:15:03 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id w81-v6sm6724984pfk.92.2018.09.27.16.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 16:15:03 -0700 (PDT)
Date:   Thu, 27 Sep 2018 16:14:59 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, corbet@lwn.net, afd@ti.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: ina3221: Add enable sysfs nodes
Message-ID: <20180927231458.GA31793@Asurada-Nvidia.nvidia.com>
References: <20180926064245.4091-1-nicoleotsuka@gmail.com>
 <20180926064245.4091-3-nicoleotsuka@gmail.com>
 <0cfe55e1-10d8-ac1f-8b6e-73777074a219@roeck-us.net>
 <20180927222614.GA8430@Asurada-Nvidia.nvidia.com>
 <20180927225200.GE9198@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927225200.GE9198@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 03:52:00PM -0700, Guenter Roeck wrote:

> The proper fix for this problem would be to add support for suspend /
> resume to the driver. At resume time, all channels will have been
> re-enabled if the chip was powered off, even if they were explicitly
> disabled by devicetree (or via explicit configuration). This means
> the driver just behaves badly across suspend/resume, period.
> Displaying a raw value instead of a cached one doesn't solve that
> problem. By using a cached value, at least the user would not notice
> that the chip no longer does what it is supposed to be doing.
>
> I guess we just have different priorities. If I think suspend/resume
> is a problem for my use case, I would just go ahead and fix it.
> I would not try to write code that doesn't fix the problem causing it,
> much less argue for it.

I agree.

> Having said that, I didn't mention that part in my other reply,
> meaning I'll accept the code as is.

Thanks for the generosity. But, since Rob hasn't acked yet, let
me write the patch for suspend and resume first, which shouldn't
take long.

Thanks
Nicolin
