Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0865FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85FC217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545125111;
	bh=UGeGQ8hh7ybUAaX8yZl6E4rwNBpJdlXH3HvRxu4MWOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tABF/iygtdEQYK54uyWMXN42UNLCzLNhqhF16lxuIHOoDxbDNsf2xSb/da/bcUGIF
	 1Bt9RoQ3gYmzISRViHCE8wpvoyWQ2Sr4C2GibGw6V2BxweE4Ll9e4SUAkKLIquEdzC
	 Y6DQDoQKOQAfhBMOtXZxDx8ulooQR1OORN5EZ63Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeLRJZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:25:10 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37169 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbeLRJZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:25:10 -0500
Received: by mail-lf1-f66.google.com with SMTP id y11so11713686lfj.4;
        Tue, 18 Dec 2018 01:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BAmw6cl4MWNkxWmSE/QIGA+ZSriS0cgXyfMJq307+44=;
        b=DqN2p/WsYyUoCK6rX89bS668s+2JpaDjXWxIc4CALpRHLgmbAVkYnB2LKtZQgbyY53
         GcpdEfPIGnPljJiBchkXI8cYv1CkVBxPV9ilGafbSEO6lBuQjwjWpJaPfFbrkueUtBnq
         /5iuJzV8B3UMX/kBPph76bMODwdcS7EyT6xJ0yVLmPE4vE6/fBw+zNKFPZoOUB6iuRhN
         ioTiD57s4kD8QkyA0wPNzqOKqi4kQfqwgTR1RhOhQhcl7ZdIxTs3dBRleWI6tKIvWbD1
         VfsMl383Liwi7JwMjegfAz9FcZw/HSFcOvlqy5XFeNjRH3uTGFdEtAABtQwHIg6pBAd3
         F4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BAmw6cl4MWNkxWmSE/QIGA+ZSriS0cgXyfMJq307+44=;
        b=H8uZc0gPDqakAvc7PIzCHD3HTJkwh5JRFRnP7Mpb5h7DRmXCR93xERJnTBSZm5IPsR
         MALi23vGTeA8cjqhxSny0FdFm8l0o6LjY6jzTzbTgm9+F/LhKyuceGXbf75BtPpxDCs6
         5uvuM9igsP7JnZqWYppHVgaUiBIy9fYxkMewHutEl6umuwVwcNleTv52G0EK6YKrwzP1
         cBVNCeu6Q0g3MZrVdLaIb1/qt4s71fcp2Ha9+7UHytFuG15H9XKlLK+OVnUrxBpgINpL
         zsS2KJh5Qu82lQVwNT36Ko1X3tDHOG4NM2eWoN5Kp7NawEDs8JiWezSz/gzetPrbxA4i
         bGsQ==
X-Gm-Message-State: AA+aEWbN+AM7vz2aRpJufhz7FusC+jAToFjCKg02ROucIlQ3lsmHbYWM
        CHu4B+Nk3F5s3ehayb28Le0=
X-Google-Smtp-Source: AFSGD/W0PfKt2uQIcXk8KF0y6dL1OdRDKA2QqMKceRN0OTLF+jhf3GeP/22XOprt54JBLteDxdJ7DA==
X-Received: by 2002:a19:7dc2:: with SMTP id y185mr9021782lfc.27.1545125107979;
        Tue, 18 Dec 2018 01:25:07 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id u11sm3143054lfb.85.2018.12.18.01.25.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 01:25:07 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gZBck-00031W-Ca; Tue, 18 Dec 2018 10:25:10 +0100
Date:   Tue, 18 Dec 2018 10:25:10 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Scott Chen <scott@labau.com.tw>
Cc:     young@labau.com.tw, jocelyn@labau.com.tw,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: pl2303: add ids for Hewlett-Packard HP POS pole
 displays
Message-ID: <20181218092510.GJ20658@localhost>
References: <1544698908-32589-1-git-send-email-scott@labau.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544698908-32589-1-git-send-email-scott@labau.com.tw>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 06:01:47AM -0500, Scott Chen wrote:
> Add device ids to pl2303 for the HP POS pole displays:
> LM920:   03f0:026b
> TD620:   03f0:0956
> LD960TA: 03f0:4439
> LD220TA: 03f0:4349
> LM940:   03f0:5039
> 
> Signed-off-by: Scott Chen <scott@labau.com.tw>

Applied for -next, thanks.

Johan
