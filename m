Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830A7C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4828020821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544433847;
	bh=P5I0hTduhb0vb5knaclSUXemxourT3r+QA9ZXGZ3Hkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mk6c1RYFmrrhW1Ue17XPLkjKvJAo4J7A6m4VJgAWT7zKSfCo2m+24sIrkacgYsH1e
	 AgkgWvbWGR03krOalK2fhPVPnKdvbI+dhx/9SzfGMMBIU2zJX6BklSoP7d+EjKd6AX
	 sIsc7rmKp2SEZx7Twndk3HWlwlKgLdI6VXWhEEMc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4828020821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbeLJJYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:24:06 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:43929 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeLJJYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:24:05 -0500
Received: by mail-lj1-f170.google.com with SMTP id 83-v6so8917380ljf.10;
        Mon, 10 Dec 2018 01:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8YQGxQ9ossh/4T5JTTSJ44lxsBKwSNtnNfN8U+GbEso=;
        b=j6hQhC2lk6fYi3YKgO0W7BxRnQVwuQJFBZ3bQTe7nQjaV4/1dIXgSpdavIXzJ8p2uI
         Ewf4WKxpWs0RLo3jwIDeW/DMehOqEqcrFe4Bh1yIoh3wBtsOCem8Dr8PHavMAOUeSS/M
         NtWIRNVKgsN3Fb96H+tHXV7z03XurHuN/dSjYZH0/wCX8fbcycZnp4Cj2Vep3+KO3yS7
         kCBEUxQuWP8y4s6k68T6KPQdvd3D7zeX9xwYGBnkv3cdoLDAu9t+kLiFo9CHtUZkNXzO
         ECDY/o9ub/xVIT9gpikJEuXLOIwlQflmHoCkqKjg15FLI7/75k0bHIervnIyBeioL0fE
         OOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8YQGxQ9ossh/4T5JTTSJ44lxsBKwSNtnNfN8U+GbEso=;
        b=GoWVC1ZpN9hIeJAX8Al2mFqaXICNjht9synrCUDhu0ERuG4zBFfXIyWT640LQJorlx
         xj6HAbd91j/4w5d32oY+MfE2iddyt4yKR9rrGKfGHHEAN6a4IBIYqshby836lJkX0P95
         RSI2AVnUDQufoZ25d6k00Y/7S+8ftbYxK2Mv+00DdsPTnJrincAaN/DduufiVfueOZZV
         ZGW/JAv8yPRQ0JPmJTC8VnMHwOFLpRnq3H7eY1QpzTA3PzL/iXzacUaNkGn+6SAoYLd4
         BwjGfAEoKjIZVRz2nMHET9m89gGUO/2YXYRTe6ErZ81m5GLxptcCf5rYbv+pGQvY7osN
         9Kyw==
X-Gm-Message-State: AA+aEWazHcEgg1ov5/2cKWmGI2Lg2N+sxu8ttr8G4K8Cpsik6tzL0eIz
        MnKEa2SeN8VjBqGEj0ttcD0=
X-Google-Smtp-Source: AFSGD/X1DwZE3uZLPKLoBon2ljZwnfyjfDysig7Mb4XcrdXFNEQZln2RPspqC17otIQLJpYDHdnxbw==
X-Received: by 2002:a2e:458b:: with SMTP id s133-v6mr6412385lja.170.1544433842152;
        Mon, 10 Dec 2018 01:24:02 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id u15-v6sm2236082lja.63.2018.12.10.01.24.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 01:24:01 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gWHnV-0006ab-Cb; Mon, 10 Dec 2018 10:24:17 +0100
Date:   Mon, 10 Dec 2018 10:24:17 +0100
From:   Johan Hovold <johan@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] USB: serial: mos7840: remove set but not used
 variables 'number, serial'
Message-ID: <20181210092417.GD31358@localhost>
References: <1544151042-120303-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544151042-120303-1-git-send-email-yuehaibing@huawei.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 02:50:42AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/usb/serial/mos7840.c: In function 'mos7840_send_cmd_write_baud_rate':
> drivers/usb/serial/mos7840.c:1584:16: warning:
>  variable 'number' set but not used [-Wunused-but-set-variable]
> 
> drivers/usb/serial/mos7840.c: In function 'mos7840_change_port_settings':
> drivers/usb/serial/mos7840.c:1695:21: warning:
>  variable 'serial' set but not used [-Wunused-but-set-variable]
> 
> 'number' never used since introduction in commit 3f5429746d91 ("USB: Moschip
> 7840 USB-Serial Driver")
> 
> 'serial' not used since commit 5833041f1b13 ("USB: serial: remove unnecessary
> reinitialisations of urb->dev")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied for -next, thanks.

Johan
