Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE437ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 06:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CD12145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 06:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="aDfMl0DN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CD12145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeIXMgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 08:36:54 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44704 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeIXMgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 08:36:54 -0400
Received: by mail-lf1-f67.google.com with SMTP id g24-v6so15607779lfb.11
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 23:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=REPO90VD8avjIJyEr0W/D4HB1ESHClGfuUxtfVdF51Q=;
        b=aDfMl0DNPPAiwliUF+Eqd3FX4HOJ6Bx1V3SR9sFp7fbywWT+ya3SZDH/muvmvgQxiz
         I2RVXYrwACwMes3oPRw3ZUzSVX9o/fw4k8YOgmIzljXzRJ5n10JSFJNUPFnl6ivpLCCP
         73jiPixukVh5bDl1dCYUt1CXXAVtn2hhhr/10JuhDYlwHmmGU+kJChFeDuEsE/vciPYk
         1Fo2hOzPejyrzrQZbKbDu7jmFw5iWGaZ9x3MscDlFAVuAEmpw8/riBNnNOJGHrTah8ku
         9yvZ407yrdGdeW3lnkK4Mdm5h55Ao+sLuWehO+uAG8JhZldpWaXnMBMFQd1YrpMLEYOk
         c34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=REPO90VD8avjIJyEr0W/D4HB1ESHClGfuUxtfVdF51Q=;
        b=A7StP+n7PjZxyDDBMDvBLl8ObIyQPuWmAKz7EzLrDVLRFuosLG9QpJu3bKGXwiLbYi
         zkOvkP+ahnDe+rRUEalj23+P2z/qjHwNXDh9YmMVSd0OlGSARNwz65ngFjv57GAEu74V
         wGLI8bkQBWr0gNxFhh0YS5QljoL9YBsCQc7RrYGXwS7vFMzLErqH/dU1x9cnLlwYFpkI
         NWFwzhQfM6GCnKfQkyYhJCRiiYa99jNnapHnnL8omh3kJniFJdHh7pBmwzT3W34SMHlz
         lYL6WeoCbl46NW8NnViVA3hle5e3+ZMGwaZ05vq4NgkKx+ghJmuxgnMgxsvy2ZFpTQ4k
         ThbQ==
X-Gm-Message-State: APzg51BeDf0HqhrlgsbIPkDu6pExGDrpixbSe1rClc8eoEv534u8TeyV
        6HAdvF6pNCmFoTzgW7exmYBjHvl+20Hl01RYEGjUeQ==
X-Google-Smtp-Source: ANB0VdbUwWBwgJq9/TcOI2G8TxAGPFlr+SN+oYMxFA60IFAhBlr1hQ8ZLX4vkbBYlzBsESlPm1Xg/7HoGRHMBhAxwlI=
X-Received: by 2002:a19:9e85:: with SMTP id h127-v6mr4862957lfe.89.1537770979508;
 Sun, 23 Sep 2018 23:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <1537763755-28871-1-git-send-email-svellattu@mvista.com> <20180924051832.GB1974@kroah.com>
In-Reply-To: <20180924051832.GB1974@kroah.com>
From:   Silesh C V <svellattu@mvista.com>
Date:   Mon, 24 Sep 2018 12:06:13 +0530
Message-ID: <CALabi0Ho9w_6PcSe6D8PmGgLfw9sYWhBS-z=KebxCPqkaM8ibw@mail.gmail.com>
Subject: Re: [PATCH] Driver core: add bus_find_device_by_fwnode
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,
On Mon, Sep 24, 2018 at 10:48 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Sep 24, 2018 at 10:05:55AM +0530, Silesh C V wrote:
> > Some drivers need to find the device on a bus having a specific firmware
> > node. Currently, such drivers have their own implementations to do this.
> > Provide a helper similar to bus_find_device_by_name so that each driver
> > does not have to reinvent this.
>
> Is there a second patch that uses this function?  We don't add api calls
> that are not used.

OK. If I change, say, of_find_i2c_device_by_node,
of_find_i2c_adapter_by_node, of_phy_find_device and
of_find_spi_device_by_node to use this API, will that be good enough?
If that is OK, I will send this as a series in v2.
Thanks.

Regards,
Silesh
