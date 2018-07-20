Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90904ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FD420862
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpsC26Yu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FD420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbeGTOXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:23:06 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54565 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730996AbeGTOXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:23:06 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so9546370wmb.4;
        Fri, 20 Jul 2018 06:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xqJtFtuDXk0zJY31+6P6z5fcOy/QETR8kWD1bijjHZg=;
        b=qpsC26YuTtSfgl+4RW1cgULnDUrBifBPEgTnh93D6edBeldQLiW+KVKXN8KBN3CCEg
         UKdmOC7iBLoqjrxz6HcKmbyrpAq3ucyLFyBYk5swe+Im3bPXvc1mAVdJxh/UYzuCZtWi
         PpctQUGyWGmulk/grpp/PB8czETmcBt1mV2emUX+R6as8YW4FDI2HuA9O7g5AgvrcczN
         fEfP9QDiX8ZvqmSPAVFUE3Ljizjkng+Sr9q1KW9mBaQuOow/7NqVuupmJxewxUaV03dr
         d4hZwGLNDsGdZjohQPO8/DF+SedutHCOkA1mOsLFQ5pNwS10S+LRtGTTMeqnci0px+g4
         A8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xqJtFtuDXk0zJY31+6P6z5fcOy/QETR8kWD1bijjHZg=;
        b=T/1ObOQfJk2mztbhiIkDecIQdZb7MFoY9SCfujF5yKqcUWVUiri/L57gE+R0fmx9P3
         leEAwQJKeQIh1Iy11whh95DvYqYCzW/BznY/R3HtDqxMphG4E3fhPQAp10imcbEUw1Gm
         nom973nGJyT1LvYgFHTULkDys3R3M6Ic3aoV6tyFDn64s9B5WPrzptzcLlld96U8bjp9
         36kK+Zr48uBnFo/xYS0oSLsdW0LodVlqe9qH1ZSAAya6nBwBopxp54hp4OU2HNS9deXw
         Iup2Rh577P0ha1kLn4WNFl6BHtw3EGc/pI+OZLMvF4IsDpstbLgQx2QxWzs+xqoJl8az
         C6WA==
X-Gm-Message-State: AOUpUlHh8gexY5fwP50C/sMBU1pxpEz8Ay7V0WyVxnGJ2y/+bWwHooft
        mtzN5YAnkVKqw3HuTl4u3/w=
X-Google-Smtp-Source: AAOMgpetZF6BjbPp743BgIU0WVO8uH/HTQI9pg51dyVyt2CGLArhIJaMaVoiAPJ5IsjCZT04IqL47A==
X-Received: by 2002:a1c:3a8f:: with SMTP id h137-v6mr1664207wma.41.1532093685132;
        Fri, 20 Jul 2018 06:34:45 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id g10-v6sm2215942wru.43.2018.07.20.06.34.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 06:34:44 -0700 (PDT)
Date:   Fri, 20 Jul 2018 06:34:42 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/66] 4.9.114-stable review
Message-ID: <20180720133442.GC31668@flashbox>
References: <20180720121407.228772286@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720121407.228772286@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 02:13:17PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.114 release.
> There are 66 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jul 22 12:13:47 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.114-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my OnePlus 6.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
