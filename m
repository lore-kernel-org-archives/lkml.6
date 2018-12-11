Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500D3C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1322920989
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20150623.gappssmtp.com header.i=@mojatatu-com.20150623.gappssmtp.com header.b="UxvUYo/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1322920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeLKPXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:23:55 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:34569 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeLKPXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:23:53 -0500
Received: by mail-it1-f195.google.com with SMTP id x124so11105938itd.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 07:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yoaN8Y+Eu1T7LptkPRHLCJC61d2gygAwEAcsSxhpB68=;
        b=UxvUYo/1vxrt2tHkpQXCRI313zVmwCycaYHNmRQLb33etQ5jy86KoxvwXiF8Y4sP1V
         pdmKPNvo/SM1Yb26n+uceBYgOTRyQG4gZ6A1jbcpk7/JWoQ1CY0m0St0shUXUdbvmqRl
         qsgp7BErDQ4l01Bcl7ExkoFg+dE0uVcw+GxYlXlIA0KeSpnbjmlLqT5PyDHko87TbK15
         +x6sxYEh2LvpI+w2MuymA5xRsfm3TQDzmHlyyX4TBFRGsvN7Bu6SggR9PtEW/arYBDXg
         30IGW2bVDvHQLM97Aw04d+eYkQdC83qZ6zeAKl28sdP+nW8khc1v2NWDY5/etr3IxhvS
         4V8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yoaN8Y+Eu1T7LptkPRHLCJC61d2gygAwEAcsSxhpB68=;
        b=o5zpzFlgd4X9AoNHR807MLQTXVBeFr51iiIsZQfwTB3rGGd6ZUT0GshhU8JtlrubJ+
         OtwJiglLDFsezkEHYYJ0EeSyX8QN6/83BPtGDMuMNlk1+OKLe83F9OMaRA7NZlxTKEkf
         VPn+ECtVUAsE5UX2nafZ1JMWaAvWm4R/U+aR1XfZmtHGUxaE4OIZZ2Y1uvtPJE5wwgVP
         86CR85S2vFdqg2Tevy9pkO685SfCMM8P85ffcUsBTZRzxMN0H+HXfwCpvmHQzzHXgw2M
         r9kbgtVuNt4Y3fUqVGiMBAoZfs66HJJmzHl8IXhAmtLIoTaQsuW/5AFXMqJ8Td32vLlp
         C04A==
X-Gm-Message-State: AA+aEWZs2A9Bbq1rLVlDgA14IPUOKwjQ4HM4+I7iY13vfStEnYTygl2e
        Wa6Aeumnd/vCboDDj0rmgaSVPg==
X-Google-Smtp-Source: AFSGD/VFh/2/6jyrNuwQNbL7SwuNv+WE7NroNOfb6i/nFJB8TJ2vP/w8VF5peNgg2IFJj84cv1DedA==
X-Received: by 2002:a24:128a:: with SMTP id 132mr2516456itp.80.1544541831805;
        Tue, 11 Dec 2018 07:23:51 -0800 (PST)
Received: from x220t ([64.26.149.125])
        by smtp.gmail.com with ESMTPSA id m81sm1349534itb.43.2018.12.11.07.23.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 07:23:50 -0800 (PST)
Date:   Tue, 11 Dec 2018 10:23:45 -0500
From:   Alexander Aring <aring@mojatatu.com>
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     David Miller <davem@davemloft.net>, yuehaibing@huawei.com,
        h.morris@cascoda.com, alex.aring@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wpan@vger.kernel.org
Subject: Re: [PATCH net-next] ieee802154: ca8210: fix possible u8 overflow in
 ca8210_rx_done
Message-ID: <20181211152345.gdlu6rnzng3kddgo@x220t>
References: <20181211031339.21048-1-yuehaibing@huawei.com>
 <20181210.220107.751606140724107779.davem@davemloft.net>
 <87dbac94-8b2e-8cef-5166-8c130529ceb9@datenfreihafen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87dbac94-8b2e-8cef-5166-8c130529ceb9@datenfreihafen.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Tue, Dec 11, 2018 at 09:26:37AM +0100, Stefan Schmidt wrote:
> Hello Dave.
> 
> On 11.12.18 07:01, David Miller wrote:
> > From: YueHaibing <yuehaibing@huawei.com>
> > Date: Tue, 11 Dec 2018 11:13:39 +0800
> > 
> >> gcc warning this:
> >>
> >> drivers/net/ieee802154/ca8210.c:730:10: warning:
> >>  comparison is always false due to limited range of data type [-Wtype-limits]
> >>
> >> 'len' is u8 type, we get it from buf[1] adding 2, which can overflow.
> >> This patch change the type of 'len' to unsigned int to avoid this,also fix
> >> the gcc warning.
> >>
> >> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
> >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > 
> > WPAN maintainers, I am assuming that as maintainers you will be
> > picking this up and sending it to me.
> 
> That's correct. On driver patches I always wait 2 days or so to give the
> driver maintainer a chance to reply before I go ahead and apply it.
> 
> I will take this one directly now and do some smoke testing. It will
> come together with another fix as pull request to you.
>

If this "len" is related to the frame (error message says packet) length when
"rx_done()" what the function name tells me, I think what the drivers
is looking for is:

ieee802154_is_valid_psdu_len() plus maybe before calculation of the length
depends what else the transceiver put as payload.

side note:

All drivers need to check if the length is valid as this is transmitted
in the PHY header and even not portected by CRC which is only for the
MAC payload. I had some ugly bufferoverflows expierence with some
at86rf2xx while my microwave was on.

- Alex
