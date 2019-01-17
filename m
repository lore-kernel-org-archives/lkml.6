Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002E4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C042C2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wvt/HX9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfAQAh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 19:37:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34665 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfAQAh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 19:37:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so3912067pfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 16:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xUtl+m3QUZbJVUiyQEgxPvOVYKv8vARyeE1EuZQE4z4=;
        b=Wvt/HX9itzrcGNgGVkzCyKVJD+q59Pziq/0c0LG5bjm9cBHO7CTWv0uH7rZr/g7SUm
         5aOa0RIuCt2XBMSzjqJ180LQRSYkq50oqoGlmRm3tTiLOSuBhsLq9jTghYDFBVERpDp7
         DchYZGICd/hJQsY14Ph5phK9Tv/mjG6v2V570=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xUtl+m3QUZbJVUiyQEgxPvOVYKv8vARyeE1EuZQE4z4=;
        b=S4rZUoDP3++CJrX6T6iKUS6voUUhHjUQbD7S+M5idiejOUL2zg8Pai7msnLsrfJZbh
         kRGFC5ffTXwwtIowShCGRUU6RoKDLn8AZjOiFQJq9fbXBSLisRwUNecu6wEYi8uPJsLo
         GQVR0P6MLNx4G/xOWVFpwlvc96X3HI39qzuRQoGRq6pZYu8jAdwHAhC8YRXdK0bvQJnE
         Kcp9HM91pXuUQJkMke97D0TXFzxonNhDO/dzNaFCw+IaWImHO/0hwoP5qBG7vX/F2LTd
         koPGDG76l/ZF23grttJ+/d6QRyHYIcMEXurkDlXf9jfURRQFyvpbX7T+SbRRpps2QwQ+
         /jvA==
X-Gm-Message-State: AJcUukdB5M3ekpJGMXiqQw2OJwATkn+fj4NF3LzHxNeKmf8kJBJeguNL
        8TfSnSl6Em6syDQEZnqbMZpDcg==
X-Google-Smtp-Source: ALg8bN4BntYcmVaC1ns2w1O/Gt2sD5Rw7henp2DnF2WvCVYKuPmWNGb80l4N8emdJnQw2mweN3OlqQ==
X-Received: by 2002:a62:5ec5:: with SMTP id s188mr12500688pfb.145.1547685446424;
        Wed, 16 Jan 2019 16:37:26 -0800 (PST)
Received: from dragon (61-216-91-114.HINET-IP.hinet.net. [61.216.91.114])
        by smtp.gmail.com with ESMTPSA id e131sm10067001pfg.75.2019.01.16.16.37.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 16:37:25 -0800 (PST)
Date:   Thu, 17 Jan 2019 08:36:58 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: linux-next: Fixes tag needs some work in the imx-mxs tree
Message-ID: <20190117003655.GA19069@dragon>
References: <20190117075459.50e6a22f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117075459.50e6a22f@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 07:54:59AM +1100, Stephen Rothwell wrote:
> Hi Shawn,
> 
> Commit
> 
>   fde7ed930ca2 ("arm64: dts: imx8qxp: Fix MU4_INT number")
> 
> has a malformed Fixes tag.
> 
> The SHA1 should be at least 12 digits long.

Fixed.  Thanks for spotting it, Stephen.

Shawn
