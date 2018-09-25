Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DB7C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E426520842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYT76LlB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E426520842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbeIYSPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:15:44 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:43776 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbeIYSPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:15:43 -0400
Received: by mail-lf1-f48.google.com with SMTP id x24-v6so19708628lfe.10;
        Tue, 25 Sep 2018 05:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qHmwP76R7myhqAdEdkmS3brN1G7dccRe2uvlgFsyW3E=;
        b=qYT76LlBZCcv1a4r88VF0s/avGS+1EI4jZrCDvsRVuqRn49j2Z2cXEUz2gP4xhr/XO
         wYdBrjc9SMFJPLM4yyYVlreYkl/L7Ik6dpflzUFR8W1639QhDRHMj+d26Ln7zXw/peJ/
         k5mRJqEtUHxR27DGvOwty+5LDazoF+nPNhB3+3Z/BGOx+76p30lCtmpnHQqNHDvRkBBM
         PKtxPIcW0BT0ZSBdcsAp3MVacbDcm1Pfvk/mu7+nMjxXxuNo3a0gGDW0fO7vOHaroxaT
         8oVmy46pmYp8FzhbE7kIMX62PLUgKVRgTFbVCkjG9/WCYu3nC3pmSmnHt/QIpD33IEID
         XAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qHmwP76R7myhqAdEdkmS3brN1G7dccRe2uvlgFsyW3E=;
        b=t4YJ9BGpAE9zR/zCwWDHzuW4zqEbGWqDEakXkRBWtDjzTOMUAWonCizTCPVuX5r9GW
         Exd3n7z1+V3YZu/fVFeUGHAiTlYs085lm/ZmSlk0r4WSQzEBp/+dTi/rgiGla9GQ6/ZP
         W0ifTouCmfDDX+/c7DNcbzjYFy7X+CTV7VAcZyp2lBHPzCjuWMLlum1KzUTFQQ+UNVJt
         phgBfNP2+2+bxHkgmNX+EOTuGbrFdl+m5YlRIsKkCtM83lAUEjQgQWwxZX6szeXmsbsu
         RA+oXnNNyGdmKllvKJdRnLxslT6IpJPq8APs7LqkTMeEPHMZGi5CcXATPK7O+/6/lO8/
         ig2g==
X-Gm-Message-State: ABuFfognlgfE25pGA63901ggcf5PeHEaDcAmt90GJ7g7/NXPfvB1DUUK
        88Dx0XF4umLTZIzpr+KCaCk=
X-Google-Smtp-Source: ACcGV62fHJpdYKHG9P3vSKQFWR6NKGYx7//u17Bot0cLd1nXPjlJu9GeLu3arwzdtaE6oETmU36Gxw==
X-Received: by 2002:a19:124b:: with SMTP id h72-v6mr597346lfi.72.1537877307408;
        Tue, 25 Sep 2018 05:08:27 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id h27-v6sm397097lfl.31.2018.09.25.05.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 05:08:26 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g4m8f-0005uJ-DF; Tue, 25 Sep 2018 14:08:26 +0200
Date:   Tue, 25 Sep 2018 14:08:25 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [PATCH v6] USB: serial: ftdi_sio: implement GPIO support for
 FT-X devices
Message-ID: <20180925120825.GF3332@localhost>
References: <20180925110021.GE3332@localhost>
 <20180925100635.GC3332@localhost>
 <20180924143151.2273-1-pados@pados.hu>
 <e4a12a0856d083eed0994ab888bc8869@pados.hu>
 <6fdea2db02ece8c7b51fb03a112fa4c0@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fdea2db02ece8c7b51fb03a112fa4c0@pados.hu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:11:03AM +0000, Karoly Pados wrote:
> >> + if (priv->gpio_output & BIT(gpio))
> >> + return 0;
> >> + else
> >> + return 1;
> >> 
> >> This could just simplified using negation (!), but perhaps this is
> >> easier to parse as it stands.
> >> 
> >> Sorry, it is not clear what your preferred action here is.
> >> So should I leave it as is then or not?
> > 
> > Just do
> > 
> > res = !(priv->gpio_output & BIT(gpio));
> > 
> 
> Locking here? priv->gpio_output is a u8, there is no way it can be partially
> written. Or am I missing something else?

No, you're right, no locking is needed.

Johan
