Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E614C43444
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC6021871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ph/7c4l2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfAECsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 21:48:31 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:32837 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfAECsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 21:48:30 -0500
Received: by mail-pg1-f174.google.com with SMTP id z11so18247763pgu.0;
        Fri, 04 Jan 2019 18:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6wQfkN/TIt9PCEKz1YXzxME2KYLAjV/XhP7L6NOpM/w=;
        b=Ph/7c4l2//miF05k6MKNRx4Cw+n9yxK9+KKzCpgmBHiJWiQc/oeIxG9DVvELThWqc+
         vVjq8jLu9z/Bmd4smgYPLt9FYBNI6TUU/0qWp80T1uD/YK3xPpB2r0hjis/VKvbNyqj/
         8Am6MJSCPMaq/8tfoLnLrvw+9GYRiS9FNleivfXFdkn3bm7dEJOnX0we+9DlHX5C/lIz
         d1hHsoMAnBNFrh2adNK/v4KMh7Gio2wcJToImr0WWM2uQmNTgiRF6mv/xXg6G/xJXtLe
         tkZqctgkQ4iXF0KV1KysUhnkuhv5LbIw04zPQCAc+C3ceYsF0SQI7acpytNwqgKGBsw+
         6bYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6wQfkN/TIt9PCEKz1YXzxME2KYLAjV/XhP7L6NOpM/w=;
        b=AvqoXgOOm2D8qK5K/hIzbrrbMhPudqhPLaUCqsYmBkgl0sAO4+r+sWUCQnxGfGRKK7
         m2BdK2zmvt6MTb9Dyhb6NEHRxOfpau3S7qjztUvMmJ9WAmsnyr4JmXDuLyq9mXMYyT0P
         SnXQT3OdJl39palAuFy8I0BB8AIIryzuFexwsvxWGA5xZvx+PFUEaamyQ2EHZdSdSzSH
         9OJgrRsdvDwWiKIxXUdQ2jbk3aaNEAmplVecWdMV93z2nwMmOHUBx2ZqNlpeWJz3BD+W
         55Cy2VuNSXSDyW4GjdXTQ+PgHz1jsmZr70ttpHYDFlqm8mSHMfWpxP5YRgx6CiJVu4Vl
         dCaA==
X-Gm-Message-State: AA+aEWbzyw92LhsqZyP1P9wE1o7rij4HvOFHx/RRnu/kUtGo8eOIhBwr
        MPH0eeVJ7J/Yk7Lm8kZj1E7bJZ/n
X-Google-Smtp-Source: AFSGD/Vwrvpwqf5fuq3zU9AJl43cslGMrwSts9SboO6dmyEsjE12t03PXAju8tCml5mTzKflwDmClA==
X-Received: by 2002:a62:e0d8:: with SMTP id d85mr53817376pfm.214.1546656509024;
        Fri, 04 Jan 2019 18:48:29 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id k38sm118521205pgb.33.2019.01.04.18.48.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 18:48:28 -0800 (PST)
Date:   Fri, 4 Jan 2019 18:48:24 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (ina3221) Implement ti,single-shot DT property
Message-ID: <20190105024823.GA20936@Asurada-Nvidia.nvidia.com>
References: <20190105004904.17947-1-nicoleotsuka@gmail.com>
 <20190105004904.17947-3-nicoleotsuka@gmail.com>
 <c5d8771d-3274-6982-2f9f-903fd5310488@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5d8771d-3274-6982-2f9f-903fd5310488@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 06:37:55PM -0800, Guenter Roeck wrote:
> > +enum ina3221_modes {
> > +	INA3221_MODE_SINGLE_SHOT,
> > +	INA3221_MODE_CONTINUOUS,
> > +	INA3221_NUM_MODES,
> 
> Is NUM_MODES used anywhere ? Please drop unless there is a reason to keep it.

Will clean it up in v2.

Thanks
Nicolin
