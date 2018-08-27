Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEC7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFF4208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FrXhjfSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFF4208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeH0Srt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:47:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37364 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbeH0Srs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:47:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id h69-v6so7869278pfd.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 08:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bS9Ab55QBCK2cV6W2FrkQTCpTZ/2mvU0fk+qxlAjq2E=;
        b=FrXhjfSDEWxZRpWZ8tb2yclvhTqzL68MGlCZ4mndS+LIlurZnBItP/aarhcbZxSfr4
         /MVzwN8xYTxh5FfFqzUGuqOjLgR4QgsaLR3CHiMyQhfa3deWhipo9vm4/HDL1lcDW3Ln
         rUwun5RxZGv8tDcv0zT8BG9EXezywcz5PSJls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bS9Ab55QBCK2cV6W2FrkQTCpTZ/2mvU0fk+qxlAjq2E=;
        b=DBGKDcA90ZDSS9tDJpYAadBXnKT8PYqsi/4rER0rPwpQC2GxGiGo7DWtW1zqAjsRcs
         rpXLGdJLbLSFhxyzvZf03LKhgLQ7t3rY+LODS94j7q5eoZjr7/aste1o4tSy+wA6T/rL
         tc2MmA5Wa3wY9+NEfj6NMwbcK0k+LckV+b9vTAvPNu3X/9Z5b1uqV53OsbMYF6krXiKM
         cqTyuMk/x031Gkzc8RpdjH/1P07NWVdDJPKrnA6XwQeKraJUia5pLTLIugOVJjPLL7J3
         EZgZ4F/4f2eIH/U5icKr64zlj/pna3ie+2V7LDVWv9zErRLkbW+fla0+Pg0aEGlXfQx4
         f8Vg==
X-Gm-Message-State: APzg51Ch0b8lPLykS5novfHmAI7prhdZlBkZd8gfh8QYeGuNQg+C1F17
        dr2B1dUloDC5TAVSn+49mTYPdQ==
X-Google-Smtp-Source: ANB0VdYynB087yAGjhacJ8cZ79HeQGVh1jwjnxikz/l2O/pSksRiUTq2v72qCicya/n+3uGrPkHK0w==
X-Received: by 2002:a63:6949:: with SMTP id e70-v6mr12617665pgc.119.1535382049447;
        Mon, 27 Aug 2018 08:00:49 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p19-v6sm19230759pgk.28.2018.08.27.08.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 08:00:48 -0700 (PDT)
Date:   Mon, 27 Aug 2018 08:04:29 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Kiran Gunda <kgunda@codeaurora.org>, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org,
        jacek.anaszewski@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V5 4/8] backlight: qcom-wled: Rename PM8941* to WLED3
Message-ID: <20180827150429.GM3048@tuxbook-pro>
References: <1535106467-17843-1-git-send-email-kgunda@codeaurora.org>
 <1535106467-17843-5-git-send-email-kgunda@codeaurora.org>
 <20180827100448.GF31905@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827100448.GF31905@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27 Aug 03:04 PDT 2018, Pavel Machek wrote:

> On Fri 2018-08-24 15:57:43, Kiran Gunda wrote:
> > Rename the PM8941* references as WLED3 to make the driver
> > generic and have WLED support for other PMICs. Also rename
> > "i_boost_limit" and "i_limit" variables to "boost_i_limit"
> > and "string_i_limit" respectively to resemble the corresponding
> > register names.
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> > -MODULE_DESCRIPTION("pm8941 wled driver");
> > +MODULE_DESCRIPTION("Qualcomm WLED driver");
> 
> "... supporting pm8941, xxx devices" ?
> 

I would suggest not doing this. There's quite a long list of different
PMICs containing some version of this hardware block.

Regards,
Bjorn
