Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016C7C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 00:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816402077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 00:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSFaOieW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816402077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbeIDFFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 01:05:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37314 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbeIDFFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 01:05:01 -0400
Received: by mail-wm0-f66.google.com with SMTP id n11-v6so2505656wmc.2;
        Mon, 03 Sep 2018 17:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9NjVWGbndTtl5WqGmQNDWit2+ieFnQFA/JvdZSYuU6A=;
        b=NSFaOieW5MnH6XKyrcD767l6iF1amPc5xjcA7uT8IHf/q01gmJ9Fnj+2+HLcLvUbUu
         YJNs1/J55x3kqsdg02/qds8/uqaaMZr+kmgKuX8Lwhr5xtKmI6eYsR1kKAVzb2XYj6p1
         FndkCd8h46ipmcJhn/qM09vGXrHgMeZehQeNCPuyzyfQI8DMeUSn0h9DwkWMHecfS2Z/
         /N3ZVojh6e5zrltPDmSNikvlwsWe5IQ+YWaseFtJih3VpsyzrrD1Tc87iIjtf6g6u7Ge
         EKdUVkrNNA5L2icoFjj8V1lvhcn5btUxsHeVF4KcBCdkiVqY1FAAK4fVVAau/9TMI6Q6
         DekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9NjVWGbndTtl5WqGmQNDWit2+ieFnQFA/JvdZSYuU6A=;
        b=de2k23jMgHlaF3b3ZnxFxmCRDBijuPx7Ws2Tz7MoPQp7a09uHxH+VGXEfysZKe1NIU
         tCPUqma2u2LriXWp8M0o4ncuP1/3mSDSwmrHRBffT6wL6apySuWmZ4MLwZZhM6rSEf3u
         PGfApRqxec5b8DfDfZGc7L5NPjxuNQnV9c2mBhlxhDgBADXJGx8/+soq377WRg55DAh8
         uj2PTiqGNiC06HrTftlAS/ticadEhNli4fF8Vr/FEeY/IVIMbJgTMixJVY/cl0X6vk9t
         TnKWke7Sj/m6ZGEMy/uDOJ/rsGHpautgpSmB/am8HRgXdnEEWobEBaCHBETcpLWuOyIG
         9nqg==
X-Gm-Message-State: APzg51AzpRsb1EPdctSOUrmBvWb3kmiuqUiwi1WuuyIEYuGXtVtzyxIm
        UMc92+7iSKjDBDQ2X1PKQMw=
X-Google-Smtp-Source: ANB0VdbA047e14Wyd81sFTpHtire0R7J4/nWBjSglnqb6DhSKlxHoIvFy+/omnFrpIn90Mi+VtbnNg==
X-Received: by 2002:a1c:8153:: with SMTP id c80-v6mr995540wmd.123.1536021744573;
        Mon, 03 Sep 2018 17:42:24 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id a37-v6sm44568865wrc.21.2018.09.03.17.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 17:42:23 -0700 (PDT)
Date:   Mon, 3 Sep 2018 17:42:21 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/80] 4.4.154-stable review
Message-ID: <20180904004221.GA9187@flashbox>
References: <20180903164934.171677301@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903164934.171677301@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 06:48:38PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.154 release.
> There are 80 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Sep  5 16:49:18 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.154-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

I get to trade 4.9 for 4.4 temporarily as my Pixel 2 XL back from
RMA and I lent my OnePlus 6 to a friend :P

Merged, compiled with -Werror, and installed onto said Pixel 2 XL.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
