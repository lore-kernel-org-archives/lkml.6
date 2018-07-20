Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F65BECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8A120652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8dXV0gO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8A120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388134AbeGTRw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:52:26 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43886 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388004AbeGTRw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:52:26 -0400
Received: by mail-lj1-f196.google.com with SMTP id r13-v6so11701969ljg.10;
        Fri, 20 Jul 2018 10:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xUAu5sIE/ZjJIVh1T+PTuFKDwyzOt3dYHd/EtyMYNY8=;
        b=H8dXV0gOwqdHpkENdgOqhmfuBWrnA/2g4mlRGY8w2btSmpx2gjpydELnx0QhRhMCtP
         9Yu1O8QeakurgSvBV8gxLXlMZdumaSVb4I9a8prDGqy0EpyThoVsseS1AbUAM36uuqB3
         Rs5cnCy3XrZEzF+2muPWyEVBmR4fRza8fOqI5VQYTbFJSmbgVJ5leIfAHqButsGiv1Nz
         J+PgverSEBrRCWfqe25xBqE51hr1qIPlGNUYqtvJOdMdQ1xtGN0n5soz39DvMRD2BdZl
         3Fcqn+i7H3dnffqBP2nYxhu6B2bxh89KL5XIgxjbw06Ph1FxFzERkNzZjeZFJlHa2KNY
         bV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xUAu5sIE/ZjJIVh1T+PTuFKDwyzOt3dYHd/EtyMYNY8=;
        b=Ptv+1zuxkyN9fPeM22WsitgAXzhg7JgEfrz5unyMUywzL98V2TSNUL+EpEmpIHC2xp
         K+tJiCO3sO29dUtLo0EXm1ACCfjqT/77lcsK2Ty28jFNCF5Je9OayMeWLRiE8mrNRf60
         3CaUYBbHajnS3Uy+Mqk2ykOw0SuNnSUUXJ7DQ8XaC2A90JfJ5Eay/DAmKtpz5VMl+oTb
         LMAa2BD13jay6t2Jp4Cdk+bjiG0Ev+58vINyujXNxf+q1zTwLtaT7xXq9QgP0YdDwhh3
         eeRPz3dcOSlR2FaxS8XJCgtuf7e8SUcRg6chPoB4+F+nkNZyNIjnIjS42CU2pwY9J7if
         IR+g==
X-Gm-Message-State: AOUpUlGXShzCz2WDmXj79E9eSVtruwgaVV9uuvik9/xiQfGjWhwF4RPR
        6YLyI6ImhBixERVt2L9Tat0=
X-Google-Smtp-Source: AAOMgpeQd6y9tUAwtXJdXrNqZ8QgDlME9Aa3JtGBsxCnGs+sM+jRypeHXgK4ihlOyHfaVj8LyNyJWA==
X-Received: by 2002:a2e:9105:: with SMTP id m5-v6mr2176137ljg.121.1532106195072;
        Fri, 20 Jul 2018 10:03:15 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id 97-v6sm368329lfw.13.2018.07.20.10.03.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 10:03:14 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fgYo0-0000ue-W6; Fri, 20 Jul 2018 19:03:01 +0200
Date:   Fri, 20 Jul 2018 19:03:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Martyn Welch <martyn.welch@collabora.co.uk>
Cc:     Karoly Pados <pados@pados.hu>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] USB: serial: cp210x: Implement GPIO support for
 CP2102N
Message-ID: <20180720170300.GH19245@localhost>
References: <20180720105240.24680-1-johan@kernel.org>
 <444431dd30f45f753644e2ea80dbe0c0@pados.hu>
 <1532100137.6926.10.camel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1532100137.6926.10.camel@collabora.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 04:22:17PM +0100, Martyn Welch wrote:
> On Fri, 2018-07-20 at 12:35 +0000, Karoly Pados wrote:
> > This patch adds GPIO support for CP2102N devices.
> > 
> > It introduces new generic code to support emulating separate
> > input and outputs directions even though these devices
> > only know output modes (open-drain and pushpull). Existing
> > GPIO support for CP2105 has been migrated over to the new
> > code structure.
> > 
> > Only limitation is that for the QFN28 variant, only 4 out of
> > 7 GPIOs are supported. This is because the config array
> > locations of the last 3 pins are not documented, and reverse
> > engineering revealed offsets that conflicted with other
> > documented functions. Hence we'll play it safe instead
> > until somebody clears this up further.
> > 
> > Signed-off-by: Karoly Pados <pados@pados.hu>

Thanks for the updated commit message, looks goods now.

> As Johan made some changes, I think his Signed-off-by should be here
> as is in v3.

Right. I actually just replaced the commit message in v3 which had a
note about what I had changed.

> Other than that:
> 
> Acked-by: Martyn Welch <martyn.welch@collabora.co.uk>

Thanks for the ack.

And again, thanks to both of you for getting this useful functionality
in place.

Johan
