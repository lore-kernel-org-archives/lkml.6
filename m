Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF28C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7EB21470
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="v5XYFqqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7EB21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbeJBFTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 01:19:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45728 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbeJBFTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 01:19:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id a23-v6so10270823pfi.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 15:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D5F4ud7WwLrz4o/DYl5aN/SBeLUGNS/qsxpjBmfl5D4=;
        b=v5XYFqqnOHaUtcwk3bColCCNgKZB8poWJNKP5PIy7VlyTDhzzS+RuxqxizyQ07DWue
         4m9lMvBVQEjQAGtr7MNpnsiT+rdQ6Sz6TT3BWdldkWcXASzWXL0Y9b6qgoQj/s2BJ5PG
         jqnBDeRRcesb3e5clsrdD4qS+w1oY+X2XpjXrXwyqDGYzawGtKbRVa8mWN0+IqYKllrV
         3vTABjH3Q2nN3qLCh28Y+aOy1FvcgqC6eM1OC4p9vleee8qFoiSS2kX3/GTXzXcPiBDh
         HF2mA1NzqPtPzUDLJDG4HsQI3DhL2bxaD93qoZMcvPjYJKvRzq3SNUEfyH+3cEUmKmUH
         7+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D5F4ud7WwLrz4o/DYl5aN/SBeLUGNS/qsxpjBmfl5D4=;
        b=IenUiOKePZiYDyBqAoDi3bPFYj8dt/c9UDkY8kIpE9uy5ByHDgAo2lRNNLRLW87IjL
         X/gCz3/x7GlnmWDHgXzWmmNdVmLYEd+UPfJzr7z5acvmqFYFA8hudRvOxEZ/DsS5KJb3
         jHcDioPihH5PvJejeQrCAwxnjEcbNadCoZ4xKzofc2wTLrAWm5d+5+K7Ju1X9BemSFNN
         qs6Bjo+E3/HZ0oFSxcwjGNXl62ZqoqhrVN7hSjmn5YLu/AkD6nXI7mQnKZaQTnIszD0P
         a2gikDKDwpCrz8hXDRxfFMcD23n5DI4Z2/Atw/yZXHkrxW6w5vS2IlXdZsNqhRg9vKkl
         P5hQ==
X-Gm-Message-State: ABuFfogVMA8jjnLBosdtaJKyVbv02GXfjTJBrVXND9RM70RX5Z2mg2mN
        m9GaVNpPOPU37pAmb/UETZjaQX00/ZI=
X-Google-Smtp-Source: ACcGV63BZmajDQQPao93K8aTNGiT75ZyXDr8saMHbgSmBT27+YuupxM/78ialVuMidXbjIv9pNU3Bw==
X-Received: by 2002:a17:902:286a:: with SMTP id e97-v6mr13921369plb.340.1538433590024;
        Mon, 01 Oct 2018 15:39:50 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.22.static.utbb.net. [107.191.0.22])
        by smtp.gmail.com with ESMTPSA id l16-v6sm9934644pfb.75.2018.10.01.15.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 15:39:48 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] AHCI support for BCM63138
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20181001173302.25398-1-f.fainelli@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1f741f17-0374-f519-504b-adee93340d68@kernel.dk>
Date:   Mon, 1 Oct 2018 16:39:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181001173302.25398-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/18 11:32 AM, Florian Fainelli wrote:
> Hi Jens,
> 
> This is a resend of the previous series posted here:
> 
> https://lkml.org/lkml/2018/9/20/1060
> 
> With a few minor changes:
> 
> - rebased against your for-4.20/libata branch
> - added Rob's Reviewed-by to patch
> - fixed the use of the reset controller API

Thanks, applied for 4.20.

-- 
Jens Axboe

