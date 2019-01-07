Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4403AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1345A2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546875753;
	bh=xyHwYlMUxtAmZvLZ0B9xN892ULiaxtaQB1atI+4TECo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Tjn125n1A5sQ8TjyTYM1LateD284RjlT3Qk8ldjAsKrXkbqxFqZMf3ib9OWrzvgrQ
	 4pcOYh5cvdpXn1PToVBLuE4/2ZKz2NaKYn1vHItukc2z8J1/yPuarJV+FPUE6plQse
	 Ox8cZgufoegto2UUUb+lQSOiIc/ZFVKN3+1nBP1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbfAGPmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:42:31 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43269 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfAGPmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:42:31 -0500
Received: by mail-lf1-f65.google.com with SMTP id u18so586126lff.10;
        Mon, 07 Jan 2019 07:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n75hWKUAKINCjjwiXS3H+56nnwEW3ocILgEXSHrGOsQ=;
        b=sK2L1SHuZ/p45VDd7jRX1DgLcP2iqzrbqBn0D+/4AGa1i1RBG1DikbXsjwOafE3NTY
         CSPZR+ILWT57n3cvbZYZfiI8Vxmu2mbgKYOD4sQIIcgHXsZPhsbzUJB9kC72fZLJ2XD0
         YNp5XX/rcb+iu3c0l6JJ5Xd0+nPIR+JyRR8KNF8cfUaQkJBk6QoK4SrTnVGuZro9pGg0
         EN9lI4/LNGBMpYdosYI328QTYSVsiM1qtATufiuZwYuyoR2j3qh+nIaI85hs9EKPWnkh
         qZj392JUFeYDpZYtJeQvyWHwqN/IYiN9REHNrb8+5OgFtWTAfmOc8w+/M0r1gb/4XgQN
         a/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=n75hWKUAKINCjjwiXS3H+56nnwEW3ocILgEXSHrGOsQ=;
        b=NSNxT/x+nV13HjL8pgQ1eHz+omwmMHZxjpiY+oDVmwC6QW23zZNZhrrJ9HGd6XlNVG
         ScuUsnxYoKdQMUsJKy4kX4+EMmSR5KnG3XzMnR25qhKJWfUD6E1PTtTuEJENHgqJTMCm
         kpDa3QqbtMeqD0X2vMbqX8HhjPTXxrO2+njH6MBC5X5vqprs5Lv0HoJa/THEC+2vuJcL
         d7GQAv6y76pRd3UssAFiqJpHhfoBj+B3iKbTp+qWje109vOEK7muV0rbsFoknYHhXY0o
         uZzdqNQ+rHd5yI7jXfGmhmoWminrBKH95o5Ln32RWVPuVhZDVSw3P3xEWkywvai9mUZn
         kjVw==
X-Gm-Message-State: AJcUukczxKrkIdbRyPYxk04QkGSl5gwnGpldlcwIrY8Br5T8a5bCxrt2
        ev5SyGmYGVuvH0ZyoUXAQqeeiYLX
X-Google-Smtp-Source: ALg8bN4wNz28guO/Z7N7inuDlPbyghWrBgqoe92ZtfyO8Psnup2QvsWvTbfuNk1kWR9krwn+PBLlsA==
X-Received: by 2002:a19:ec16:: with SMTP id b22mr23110123lfa.65.1546875749008;
        Mon, 07 Jan 2019 07:42:29 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id c19sm12480524lfg.86.2019.01.07.07.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 07:42:28 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ggX2r-0006a1-OK; Mon, 07 Jan 2019 16:42:29 +0100
Date:   Mon, 7 Jan 2019 16:42:29 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Max Schulze <max.schulze@posteo.de>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: simple: add Motorola Tetra driver for
 TPG2200
Message-ID: <20190107154229.GE14782@localhost>
References: <20190107073149.8214-1-max.schulze@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107073149.8214-1-max.schulze@posteo.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 08:31:49AM +0100, Max Schulze wrote:
> Add new Motorola Tetra (simple) driver for Motorola Solutions TETRA PEI
> device

I rephrased the summary and comment above since you're adding a new
device id to an existing driver (rather than a new driver).

> T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  4 Spd=480 MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=0cad ProdID=9016 Rev=24.16
> S:  Manufacturer=Motorola Solutions, Inc.
> S:  Product=TETRA PEI interface
> C:  #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=500mA
> I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=usb_serial_simple
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=usb_serial_simple
> 
> Signed-off-by: Max Schulze <max.schulze@posteo.de>
> Tested-by: Max Schulze <max.schulze@posteo.de>

And no need to add Tested-by for your own patches; submissions are
always supposed to be tested.

Applied for -rc2.

Thanks,
Johan
