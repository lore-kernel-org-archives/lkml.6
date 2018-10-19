Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA10C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5178B2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djatbhV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5178B2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbeJSJpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 05:45:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39493 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSJpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 05:45:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id 61-v6so35666415wrb.6;
        Thu, 18 Oct 2018 18:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BC48C6gV9nzvP344DvXMLdDLIALbzuE9LJ40JM1nJPI=;
        b=djatbhV18sO5qQNTLyS3/emQ8SGuMggIczX1E2yq0u02Zlxmj0Y4unIQ7k6As/MAQe
         vX0qupXuXdB/b2DFdj4QgXKzlxQ84qqoUuGMouXhLjUyQpQG1inrP0HSbrc3/ii5JUCy
         1eVC4iGE380HKxXkQy6QRKLF7UKOTOC4V4tGoVbZkkdCabtbjTeSlXM38fbHn1YDQW+U
         y+6hnrN44XnphVVVrcUylg/DyogOHziY4O2L/LJIDMIH9VEcc5rg7xWgqrQSTOqyby/r
         nyLlumJujE76+D27EkFTl2jsp/+0LxQkFBR7nctu+yFZufzZQNZgs/DUrHnRcJRCpRFF
         EYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BC48C6gV9nzvP344DvXMLdDLIALbzuE9LJ40JM1nJPI=;
        b=iXyqk8ue3PGWnZ59VQ9p8fnnF0kUXxQQ62lde0230yFRVGwLtzzuJoT/aUVX+gxSou
         aWGP90PfKUzLK4KUe3CfMp+33w/9H3u0hTfes/Dgflk+x5toAES3xX74/11k7tgMXLhV
         CbNN+hfvJUiTJsCNogVQIGHa+fpIlLoM7NBYW0AdggF/AFg3i0sa6f1vgFA3mrZWbDkf
         NPdd3yh4IKvkDh7Ku9+f5ZA4eSWTZE/Mbe5AmCdWc50rYZrQHGFBThjx+RIzFNoFaerA
         6tDly+H6U0TiDnvsbT9tOxBb29T8BNWktAJzhni/Ice8ykAt2ksfv+RgOi0VIUS/SZ25
         tbhQ==
X-Gm-Message-State: ABuFfogYRCS+afV0bwUMHF0u9dg1NcTVgLtAR34OqmZEpyceNnFx7v2a
        N2aqs7kQKh+WM/z6qeMRkgA=
X-Google-Smtp-Source: ACcGV62doEeyNRtU93Ofq9ahyYitcYG2lDptr+yyGqFH/Ncp6kBfdxyAy8ZpdX8JHlfyckTm4HXIdw==
X-Received: by 2002:a5d:4488:: with SMTP id j8-v6mr32584010wrq.236.1539913274683;
        Thu, 18 Oct 2018 18:41:14 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id t13-v6sm12650208wrn.22.2018.10.18.18.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 18:41:14 -0700 (PDT)
Date:   Thu, 18 Oct 2018 18:41:12 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/35] 4.9.135-stable review
Message-ID: <20181019014112.GB19093@flashbox>
References: <20181018175422.506152522@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018175422.506152522@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 07:54:29PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.135 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Oct 20 17:54:00 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.135-rc1.gz
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
