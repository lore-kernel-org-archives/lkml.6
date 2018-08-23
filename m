Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B7CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF04021568
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vi3KsMD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF04021568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeHWVj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 17:39:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37889 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeHWVj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 17:39:57 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so6717071wmi.3;
        Thu, 23 Aug 2018 11:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OFcUxlDpNdZFO3OSqQIlCjKidM2M3HO/0OZvcjNRLTg=;
        b=Vi3KsMD5Bxq1gnfQnXttGVejKfFoKiD//iP/BZDp8J+5clL0LXweooA9of0ezEeLwX
         +Qa+q+jKnpLQd36JQTuj8cn5DVVNzbIH07QQPZDcT0tZT51AfZvA6Xp4+MWrSBFyFgye
         C/KM111//8tMksnbRa200PNbgGclxVZDfPXg/9EzSlw/9A/aUsgrSW2EHkhz/IWvBlOe
         Wn3FQXG7v7NWmyeefswBeoft1HG9yGFvoR/7eInZYo54Bpz2sGUVlQLoeLXX4DAkHjMU
         VAZJsU6/TL3L3PgtYXHjMtgkhBJ2ChLV2N+5kT2QzjvgzmTiIS5VGTHfLPHUCxBHXt0E
         bw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OFcUxlDpNdZFO3OSqQIlCjKidM2M3HO/0OZvcjNRLTg=;
        b=d6yU3RLyAsi2wDFtXCK+Enrx2DYr3qek7h8miur4EQbhQMmWJcdFFRmHMvMo0AQ+lo
         PW4GTG/svlBq/u2KUfDWwnj9pGmt9pOfX6Wit7gVY82PYDFtbda5CL4mdNbnKxn8MPyy
         07XzivS/gbOsJ4mfCGq3UASxJUlA+/QTepM8Jdu/eZomZ/sCbr2bCQHavHZF21fWfcpj
         OI5ednodxcVNjceoWHDyQW/Yy3bcPlhkZGnNHhXG3E0eNXmuxhoN6mt/3+8Uusu43b02
         nRYvABOkAk5M5AYqXjgczxoIxatC6w5iUN3AtYaAickRKwzf9XI+/6IJnR1d0QgKNiOB
         VpSw==
X-Gm-Message-State: APzg51Aua2Ng+NXDYBCza/rSVH1NsMR+sb3rmHPACWJ0LHuS+F+//Wb2
        f5SO4u/Q+xKiOSXVd4v0jFk=
X-Google-Smtp-Source: ANB0VdbtaaiyHIvqwzszQWQebiFu4GcCxgKaUrDvB7AybDBKcaRQO/s+VGqZ0n4ps9h2dyRWLqyxNA==
X-Received: by 2002:a1c:f0a:: with SMTP id 10-v6mr350084wmp.58.1535047743592;
        Thu, 23 Aug 2018 11:09:03 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 34-v6sm6910901wra.20.2018.08.23.11.09.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 11:09:02 -0700 (PDT)
Date:   Thu, 23 Aug 2018 11:09:01 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/130] 4.9.124-stable review
Message-ID: <20180823180901.GA18262@flashbox>
References: <20180823074927.161454870@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 09:51:56AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.124 release.
> There are 130 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Aug 25 07:48:45 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.124-rc1.gz
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
