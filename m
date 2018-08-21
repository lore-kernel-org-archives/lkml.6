Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA01EC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A49B217C5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCM18hl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A49B217C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeHUSTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:19:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41526 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeHUSTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:19:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id s15-v6so5814313pgv.8;
        Tue, 21 Aug 2018 07:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IsN4pVHDw51wPObBTSg3ACt8TiJaE7cEqTYAxvGR1Kg=;
        b=WCM18hl7nOretdx49fma77Xb1qBC5ghhCag3EBs2xL2R1jfDV0h92KCB1qf5s26r1X
         otyYaK5uvv9fknDfxqLUDWg268RbLjfU2BiXTVqp76zlb7ztkPAnQu5ZHHLUuDTWssPL
         gLAJSNBFHdJ/TGV/0edHzUOlRh/ODszE2nXK8VaaYS+cp0LxvViftryIx1gkXW+Bzqqy
         i0Lt7X1wzefVz/rSNGrtIfTksHAIrZy4B7nyvYrMhUim7pd1YXSRwNtmzTr95mS2DbYh
         nHZ9fYfC+stSiDLgdIEnYXdBmUieW4psxw3ODC4ov+lgs38U1znVPqo/6Q8t+Bz8pcWY
         ss8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IsN4pVHDw51wPObBTSg3ACt8TiJaE7cEqTYAxvGR1Kg=;
        b=AG7kjkRX5tQV9S6iDL9YqkQAzLrdmXdqq7ZsVpGgQcXt1DIbxpinuiUyS6buYqIssP
         EYEkfF7Atsg1PKPHZS+SC3cBndZcLf8TQwVh8GP5nUYbDTwC60k/wXAlVJcKEiOoryNx
         Rruy1eLmNwdHUijfwsjNMdqk8R5SjX7y6pmvufSkMlNDspE5czKPlhw0IpMT+fuSsKCD
         tc9B6OXyhT76xgpIUCKGu9VteIVX6aLKWXcYkgfi4ZOv0QsKRpw480VHpgURhUn5a/4v
         m1KbYyIBvMZ0g+Pu0eDjFkWvECxbigKxc25QKe1Go/SvwufTdEKVZcGL5ScqIFssG55Y
         eUbw==
X-Gm-Message-State: AOUpUlGyLtNxgZeSE9lhD2mtUil3g6r2cO7+U0BsU6xE/8tz4sqNAJaV
        +0zevjwn6E7WD63ZDWF87JQ=
X-Google-Smtp-Source: AA+uWPw6W86lzzUA+lDyhXktCEhwUmIlsEGdWmUZavh+tFwK0tdBFB1mZf0cNRpBkJBa/yjVgAM8rg==
X-Received: by 2002:a62:a05:: with SMTP id s5-v6mr53468018pfi.147.1534863558482;
        Tue, 21 Aug 2018 07:59:18 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h18-v6sm34232995pfa.173.2018.08.21.07.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 07:59:17 -0700 (PDT)
Date:   Tue, 21 Aug 2018 07:59:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.18 00/35] 4.18.4-stable review
Message-ID: <20180821145917.GE13639@roeck-us.net>
References: <20180821055019.954904905@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821055019.954904905@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 08:20:26AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.18.4 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Aug 23 05:50:07 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 134 pass: 134 fail: 0
Qemu test results:
	total: 302 pass: 302 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
