Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC2AC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B8E217BF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZna9+jK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B8E217BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeHUSRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:17:21 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45233 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeHUSRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:17:21 -0400
Received: by mail-pl0-f66.google.com with SMTP id j8-v6so8910729pll.12;
        Tue, 21 Aug 2018 07:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/AxvICr2cK0nwkVFIwTpvj9uP8SVKc39p2cWKhNqWL8=;
        b=iZna9+jKPur3kFroWthUDMLlmMLrAo4x9yMsgHlfApGuObPLG3PTt2H0rz6bdKA9Dz
         b6DXwVphh3JZiD0Sy4Xqp5nOrzafPlrXTXPbbvSFtMlNvocRvHO7CAy4dFVYQB/7gKe3
         zYrZPUj+XH8STu/aCCecgzeDKMMls/i3726UF2Y7jVNuqGGi6bP4EZXW0VGQy9DDEIU4
         2rjppiYyo61Hw8YOAABNCf2YuqKFqCRmunBKbpBoYWNNk6fH+uChsWuvwCc9nCzoKfNO
         qEOG/YnMUE3e4bmuLGZ8H6SUtDi3qaucyoWcK1eutUMjFjyQNtEl/J6ECI4dC8v0q/EB
         DUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/AxvICr2cK0nwkVFIwTpvj9uP8SVKc39p2cWKhNqWL8=;
        b=Np5gytcelCo/MCqAwFHYoL71v9p7+z4yq3zu/r1tFfzXZmlKjB8ql9hX4pa7OmQ5bH
         I1KEg1Cwzo1Ml1pKhHOTzZQ0jvnahoiYwwClzSRiSxqDotdcjq4TtQQ5TaggNgiNWZjx
         NyHnMhzcTvCofjXElBYddKetVScKZ9IpLY5VPHN1ELSe7LpHkEieIMVRyPfqhJscFCgy
         uvnQDzb94Rme/E0AXQo0I9zo0+VzvOERqRhqOrmuwXJmtLO9ioQxpNX6IiQDQKFValTN
         cwtMETFbMt5isa4rtvEO/ADUMATIZlQCQfLFfKNR02+Y2z3JkENGpY/9HCBO7wTYdhLX
         UdyQ==
X-Gm-Message-State: AOUpUlGhsN37AZ6P10REGlVRdBrxwhT8z3sGHMel0Y6imR4yuS0sE2KE
        v/GVJxCJ8xzdeYuWirEXrk0=
X-Google-Smtp-Source: AA+uWPzsRVp6goBWXQXMECGKzzD5Om3QBTKJpCJoavziuIDitgUxreEk3uYPsx01rJYWFuftL/ClEw==
X-Received: by 2002:a17:902:2904:: with SMTP id g4-v6mr4659932plb.70.1534863411621;
        Tue, 21 Aug 2018 07:56:51 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id e7-v6sm17794866pgc.55.2018.08.21.07.56.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 07:56:51 -0700 (PDT)
Date:   Tue, 21 Aug 2018 07:56:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/25] 4.9.123-stable review
Message-ID: <20180821145650.GB13639@roeck-us.net>
References: <20180821055124.909865464@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821055124.909865464@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 08:21:14AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.123 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Aug 23 05:51:15 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 289 pass: 289 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
