Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32833C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA41020870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20150623.gappssmtp.com header.i=@nexus-software-ie.20150623.gappssmtp.com header.b="dP21XG/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA41020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbeJKGVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:21:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40495 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKGVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:21:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id r1-v6so6458918edd.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 15:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sd1BO11W5IWgQwAqC4jEHQjThrog34nUXQ/TDSkmxZ8=;
        b=dP21XG/Of2wN0Zavj9iXNkvI6RR6Nljc/NiF0AHOB7gWweB7ELZkQV+A3rubSdIip0
         n7Eu+fFOSTC/fAnyNdCj1Y5La9LcJTl9SrlkmHqIkE3mEHIY6LQ2iNx+5/Te6ohgaP0y
         TnQVBS8BUBmWA7/DmHZQeZj9+Mg2wcVlt93K+XKd1Wf+p9noYdET8MIq1OTxsteaKtBv
         8pjv4n/zsST82pbMadrEZHZv4dKNVPX470oWeZgHXWslAaiOgKKvWQfHg9u9SXMvtRWj
         5Xoh0jjKPSnhsIuqyV/wcmGUV3WpOAP76aQqCBcLZLvODW7XfVbssTM+zL2mPm+J1xJV
         7Jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sd1BO11W5IWgQwAqC4jEHQjThrog34nUXQ/TDSkmxZ8=;
        b=m4BJWzOPatKeWn/SE+A5WBd/wLhFhNCfrohNwPDnEiPt7Cs1xWlnknDAjV39j/90bV
         oU+gM8h2J42dxz7a5lAkuM+/UdGIVqr7PGSwrZrBxLWUncK8BtwZ00bSEBv/UbHP7xHJ
         beOC5vEq8+Xwv9Vp5NmAz+A+y/hvdgM8DjrwOL1357H1h+zcQ0ZH0wsW8k/1UdDiOFtH
         s53Qx9nIu0izroicuL16meSWSRweiQRhERabq+8mK7sZfVoZuX09ePt1ArIA2z9lWKBD
         PfbKLmaQBR1HcQotgHzku0L2ib/0mJAR1h7biKiW7wJRoKEYTqr74au2NFZndGCh4FBX
         T0Nw==
X-Gm-Message-State: ABuFfogTyQi0m3H2z40sEoEEpe4mn4D8v1CT+wguiCdXpWxNVK9CxO7r
        G4LmcVV2ztcxtbcqS+8HpZtcNDve+Jo=
X-Google-Smtp-Source: ACcGV62dQyMQDLnnwEVl6b9UQXhhK7GhYzFRYKDSdcLh7Y+Y96yNaXROp6NKaNEfYk8eAZk4qR01mA==
X-Received: by 2002:a50:c25a:: with SMTP id t26-v6mr44668156edf.272.1539212234698;
        Wed, 10 Oct 2018 15:57:14 -0700 (PDT)
Received: from [192.168.192.38] ([80.111.179.123])
        by smtp.gmail.com with ESMTPSA id h17-v6sm4718275edh.77.2018.10.10.15.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 15:57:13 -0700 (PDT)
Subject: Re: [PATCH 1/3] staging: greybus: loopback.c: remove unused
 gb_loopback::lbid
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20181005142826.26108-1-linux@rasmusvillemoes.dk>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
Message-ID: <966e5d34-ca92-2b97-5850-f6c4855667b6@nexus-software.ie>
Date:   Wed, 10 Oct 2018 23:57:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181005142826.26108-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2018 15:28, Rasmus Villemoes wrote:
> Since lbid isn't mentioned anywhere else in greybus/, it's hard to
> figure out how it was meant to be used. It does seem like entirely
> dead (write-only) code.
> 

yep, dead code

Reviewed-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
