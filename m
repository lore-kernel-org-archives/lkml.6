Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB13C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F4C218AE
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+BKawGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfAAVi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 16:38:26 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40436 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbfAAVi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 16:38:26 -0500
Received: by mail-oi1-f193.google.com with SMTP id t204so23862978oie.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 13:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TEYmtOePWdroJbHYdSyHUCAfEbb9jb+OBiq6SguEJjI=;
        b=j+BKawGFgYXM+K+4wKLv9V7nnU1yt69svNk6xCgd5PeTNh1xun5Ju5a7pNnjYQk8iK
         /VcSUzRU6g8tdSaSkHPi6n1d4MO8wSz3Wc41EHHHGUTeXiJa0q+bUlRGu633jiDu5c8A
         LeF8y7VT+Sxw4BBWtjco1WgaOUJeb5jo9uqaYO1/Ecl5C7JkBCvTG7iVU6yqHVLhFTQu
         mNYwKhA+E2MCzUW3EZolt2wB/E76Wh2nvGpac8Od/HoFmhV/pLfXxcAAAMywJ3jNyZfO
         HXmv+PJGuTYTl3GbDmfkRQQ0t3OqG3hy6K5GVQWJzrdIdKUxEqvpqZIhLrFEhW7ehuja
         JLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TEYmtOePWdroJbHYdSyHUCAfEbb9jb+OBiq6SguEJjI=;
        b=dpfz3ngv9JLs5L+COW3wOoMbHqCCSnhsfXmY9s4v8kZEEtnfufTAhtefVKC5l3lo1N
         6RQHDOotceNNHNhQROssvctlAtRc/5h4qEp5pEdsSzYhBFo9Q+ChHfak2OmgA3+xc5nD
         9NebevDn3/R6AA4FPERznmwgWvrr89xCPgG3lI2bLcpQWPs45/SIeZmOO+Y/eg26cOh6
         VePyKzbCj8RzSqAfV4Z5j4LrZXD+G0l2MPu3xiNxni5BcBVsHLbg6XNVYFoKqk+vD12b
         mqCEYTZ4jTKmcMrp6PCzMewyMrBeECWpojCLAELKBjBBsVzXX48KcyLrOOKQICcw/HWu
         UINQ==
X-Gm-Message-State: AA+aEWa5srQIBFwERW6Ux1UVDnJ35USaqBOpSU894azYwareiGS/YnX0
        mrYVEPpkjMomVGdcaxZMT605Yilo
X-Google-Smtp-Source: AFSGD/VB0Mfxx3KJw5QoC8FXQRW1YkaJQP64Jgt6ZtTFSFfX7RfZtF8WLdhkCgkaHXPJeFGkHxCEfQ==
X-Received: by 2002:aca:da84:: with SMTP id r126mr29291402oig.219.1546378705578;
        Tue, 01 Jan 2019 13:38:25 -0800 (PST)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id y2sm22491616oto.49.2019.01.01.13.38.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 13:38:25 -0800 (PST)
Subject: Re: [PATCH] Revert "staging:r8188eu: use lib80211 CCMP decrypt"
To:     Ivan Safonov <insafonov@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20181230183918.3888-1-straube.linux@gmail.com>
 <efbc3a4a-ce31-8785-73c0-3d89edc66977@lwfinger.net>
 <4dd17d38-8c4d-b5db-1091-edba0d95cadf@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <99d2e692-6a6b-b880-c8c2-99944f8a5f52@lwfinger.net>
Date:   Tue, 1 Jan 2019 15:38:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <4dd17d38-8c4d-b5db-1091-edba0d95cadf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/1/19 3:02 AM, Ivan Safonov wrote:
> I suggested a patch for loading modules from interruptible mode, but this patch 
> remained unclaimed ( 
> http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-August/124851.html 
> ).
> 
> For some reason I thought that this patch had been removed and did not track the 
> fate of this code ( 
> http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-August/124573.html 
> ).

That patch was quite extensive, but had only a minimal commit message. I'm 
surprised that it did not get a bad review, but I can see why it was ignored.

Where did you submit that patch? It certainly was never in my mailbox.

Larry
