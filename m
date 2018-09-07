Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68345C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2095020844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdZwt++z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2095020844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeIHDWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 23:22:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39636 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeIHDWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 23:22:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id s14-v6so7375355wrw.6;
        Fri, 07 Sep 2018 15:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZIdzc5cWSusj/mkcjlSTQ0l6orh19Sn6jxdo2I3Iv70=;
        b=BdZwt++zJu5fyhmwNMHy4Pb5M16sj1/2maojNoo0hwyJQLjTNL0RZNPjceJn3rtTLx
         JVz1oCjdZdQXm5JFLh/LrXGAAGpwtuu7+UMtcCxjEmPxW6Kx6osjl27CxMdzK1jYm/+w
         Do0m4FYo/2RvgsX5ddshCUphkHhxAjUpEg4FPnPN3VmLYIuMFNDBlGSZnqE+Itpk6QBI
         FRM/c1w3nfBOdiDGL5k/FrhPrjl0IRVkSLhv2FZcCL/9sVErcfysjX4CgrZgsMr7kfEe
         38E5NlG0tdF+dDSlC3LE5RIP06jM0aaoGpezaP9rMPoIBE3WoTNlWaQhzZVLj+1uhOWb
         GoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZIdzc5cWSusj/mkcjlSTQ0l6orh19Sn6jxdo2I3Iv70=;
        b=ci1/ALaqTBlWABftTkIVLhIarZ2YQtLTAoICi1WvLDCUDPkvYQ4DykrnTr8n9UBdPu
         f3n/1aZ2krKQh+bvWHGEgkE9RQNHm/TkHxReq3GuIME2Ui8yMPOyY4BUJvgdCtZT4eSy
         JepgxPSa3WAwgtHkAREBXICrmQfB9W8vraT6Oxq/J9mV3Ispg6GqL9A9efSW2wQNBZZ/
         KcCjN5obv8pzdjQCPCtV4ebDdCJzar/VNUQPNFY+VWaNo9a02HxPHhObcMljv92YEw/x
         XtAwHTHHFrbCco2XoHxTXF59MzByg4hkCxszsuBGIvqVdRl0ZU310j7lZnfm/0PJSxfC
         hNTg==
X-Gm-Message-State: APzg51DgcaAtQCEeRo4YzJ+s1YNqGj2nkd6oAjHbDsSoIpbmSOo4kMiK
        IrtdWx+a9D0pVjjH7a4+oEw=
X-Google-Smtp-Source: ANB0VdakIo6kMDnFq90PVW3jlGVeAoSRZyfMLTc/qMlUmbys3C1BuFjIdauoPdw319yYGhvyiYCNLQ==
X-Received: by 2002:adf:9244:: with SMTP id 62-v6mr7129030wrj.62.1536359950783;
        Fri, 07 Sep 2018 15:39:10 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id k63-v6sm10936789wmd.46.2018.09.07.15.39.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 15:39:09 -0700 (PDT)
Date:   Fri, 7 Sep 2018 15:39:08 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/47] 4.4.155-stable review
Message-ID: <20180907223908.GB2171@flashbox>
References: <20180907210904.607934824@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907210904.607934824@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 11:09:56PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.155 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Sep  9 21:08:44 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.155-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my Pixel 2 XL.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
