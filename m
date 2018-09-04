Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB886C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 00:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7481E2077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 00:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t93zHHb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7481E2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbeIDFFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 01:05:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38873 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIDFFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 01:05:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id w11-v6so2120597wrc.5;
        Mon, 03 Sep 2018 17:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RGiS4Q5ONcvwkWRxAKJnH7weMuRkVmdOkupit9GuMNA=;
        b=t93zHHb79H/4Dqv9BRwLYO1ZBkhHDY9ipTi62Cqa6+6pm5a0g7r3LFHwwslOXPSVV3
         Hc+LtMvCzVQmWbmENadO+KoATNL1V37LvSgTqAodDWx+jxwvEEU7kHLqaH0Rzu2txocT
         3IYau2jJ4LN+tqQH9zOj/ww94JGYS5lM05+7+UuYKs7lKeB/cAvD9Sq1a2VqvVbDQaWs
         3CXxRPnSiQYEl/cJ1Xp+QISanRYohwKSdklxv941AB/Uk52b2rhsMZyRJmF6LBq+Kx2z
         ReZYFXJwOYxexqLwtN3146BETEiYoyqcAkns/bly4xf9SpbhEE7VuFEIqQ9MeRNGU3lY
         vwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RGiS4Q5ONcvwkWRxAKJnH7weMuRkVmdOkupit9GuMNA=;
        b=mhYJKqsCf77Rv8siM9vxbfF3J+qbTnDZICICMWkUigG7vWkViilvUd5Yf3dmEeRT/p
         jsqyCkk/3k+yrGoGU+XEZXn49RmjidWtoNIMndUx4BFqzYM5lbZp1+Dvi6E/IsOMm/B0
         cOW09alj28DouhKJFUQzESxePuRUmAd0whxXHlI8QfefeAnNrOmEwPzzAbUQ4Oc/4olC
         TA2YwV8kCh+fHC8yGvdrCaKq+m35fbqLYl1Yx+kByTDLNWl+WbUhqhiT4wd+yHy++vCs
         cLqw0usLtew/b/ekbIF/1zai7XQlAJCTDnaqK5D6NCVFxVLEeUa4XQsrenWdp65rAtIb
         DhWA==
X-Gm-Message-State: APzg51Az3rrp6pnK40fodVzaUs65EZ4FiCyQnu4pncW0bHo4o1rRxuDv
        Y6eQINJ69pB3qAXkKZxSXYc=
X-Google-Smtp-Source: ANB0VdbGXtcYTb8SJr+SPqeIweJJ07G1g1dhq+/bQ2stz/FOVPQONvyXmVxoQj7IAZ4NqmvfX/HeTw==
X-Received: by 2002:adf:f28c:: with SMTP id k12-v6mr2802304wro.263.1536021781319;
        Mon, 03 Sep 2018 17:43:01 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id l12-v6sm21588856wrv.29.2018.09.03.17.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 17:43:00 -0700 (PDT)
Date:   Mon, 3 Sep 2018 17:42:58 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/56] 3.18.121-stable review
Message-ID: <20180904004258.GB9187@flashbox>
References: <20180903164924.078355019@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 06:48:50PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.121 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Sep  5 16:49:09 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.121-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my Pixel XL.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
