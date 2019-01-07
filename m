Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC45CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E462089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546879035;
	bh=eFH32WHuTRScNT48M45NKiN73l7OjLAk13GN31Q0uC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0NHCAuISuYU57IaPY4X2YqLRNJF0QtaXVq18BqmYFwjYywaZ2DrOhpMe9KlBdEIoZ
	 5eo0mRTU0aQks5cakfzjLQwlCXPnhimYlniC8hS8Bf04Dt5yT/PcoUv7qSHeSSWZ1v
	 QE4scjcNY6e3ieUvey8ECbrQsiT8XOUqgFy9Q77k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfAGQhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:37:15 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40323 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfAGQhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:37:14 -0500
Received: by mail-lf1-f68.google.com with SMTP id v5so744570lfe.7;
        Mon, 07 Jan 2019 08:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OesGRHeQjjHAr6dEOjmw/xnpBLcPVIoRKc0KepIuIcg=;
        b=vfSxrm01TiLpz+25jc1xsFh+l3fIwsTVw3eaXW9OP43XueFKXZyMo1W9bSqZsU+Nrd
         7g9zPmOM6/epQswUYSA4ubR2/AQ5iGRZBwc1WyPZzZ5qgTfVqq4l7PR6OWmksPab4VPu
         hKCYWavQkZXzKiWe5ypE5glvB5tIwHq1QzhcouSlv+ZyXpprcIFCvNAnSpyLjoOwU5Lf
         qg9+m4IQwUyErC+7c86WsWXQDS2QaVJUKMLG9wzr2d+MQunEA/exuPmDts/pJPtWI/Vy
         ImHkoqH3HieIg1opsEXBUMNam65iIue156xRQY7oK9BETtxhD0EglN7oA+VlaMFTipF0
         d2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OesGRHeQjjHAr6dEOjmw/xnpBLcPVIoRKc0KepIuIcg=;
        b=PdO1w7wD/sMQcPspo4b3LEbT4WhHEeWJW4vjBhfsnhZLK/xWDhFgiMLP1IeOwpIUzL
         8jwIHOtwS68Kfvc8NdHrJ+rBx9bwnPkO+Ho0aABiowNfHQI3jpwGaBElR2HTKBj1tVEl
         9rKxIdiWywCa3TJmIT6bVkwTjDRDKIH8NFkgQ5qayH1yxhKJYm8ccLYAKdqP+PY/hviB
         umO7KYH+NcxhK/XPu3ysk+tr4+H8fJo5VNUjGPyo1BD2K4NtXzLyHMax6Y/c757m7u26
         fsaJL8W+3/6+cDbhVVjzI/3HTm1C0Yj32tEeDvs2qvOwrL6RV5j679iXSfn8mmGpH+3L
         IAww==
X-Gm-Message-State: AA+aEWY12g9MJ9f1LdZkEBbiOa14251yXxVEF0x3tcPFATtJNJal62I4
        fPmvhwRYPbIF/b1viwonDIU=
X-Google-Smtp-Source: AFSGD/Wc41qVUsikF+w2mR+rLI84dYpHLAXCVLjg9yKdoHcu8U2krxcDLEUq6yCsJ5qsvbipoWqWMA==
X-Received: by 2002:a19:3809:: with SMTP id f9mr29820492lfa.148.1546879032364;
        Mon, 07 Jan 2019 08:37:12 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id v17-v6sm13755008ljg.32.2019.01.07.08.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 08:37:11 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ggXto-0006lY-SB; Mon, 07 Jan 2019 17:37:12 +0100
Date:   Mon, 7 Jan 2019 17:37:12 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Loys Ollivier <lollivier@baylibre.com>
Cc:     Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/4] Add driver for globaltop GNSS receivers
Message-ID: <20190107163712.GF14782@localhost>
References: <1545994235-8309-1-git-send-email-lollivier@baylibre.com>
 <86bm4x6830.fsf@baylibre.com>
 <20190104091937.GA4737@localhost>
 <86ftu41lqx.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ftu41lqx.fsf@baylibre.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 05:21:58PM +0100, Loys Ollivier wrote:
> 
> On Fri 04 Jan 2019 at 09:19, Johan Hovold wrote:
> 
> > On Thu, Jan 03, 2019 at 05:04:35PM +0100, Loys Ollivier wrote:
> >> 
> >> As suggested by Neil Armstrong - this GNSS device seems to behave like
> >> most generic GNSS receivers.
> >> I'll send a v2 with a generic driver that works for both GlobalTop and
> >> u-blox.
> >
> > That doesn't sound right to me. Judging from a quick look, this device
> > appears to be based on a mediatek chipset, so I suggest reworking
> > (renaming) this as a Mediatek driver (gnss type would be MTK, reflecting
> > the vendor protocol) even if it happens to look a lot like the current
> > u-blox driver.
> >
> OK, agreed - will rename the driver as Mediatek.
> Would you recommend keeping any reference to Globaltop ? Such as in the
> devicetree gnss bindings.
> Or only keep "mediatek,mt3339" for any solution based on that chipset.

Yes, I suggest keeping the globaltop compatible (cf. the sirf driver for
devices based on sirf chipsets).

Thanks,
Johan
