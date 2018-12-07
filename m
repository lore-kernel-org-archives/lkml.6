Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A388C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1FAD208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544165572;
	bh=pY8Wk73MLhYprXE6HRedJQZeFVOqYPBMipNLpniHsNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qKQZTxSlqbU05O74w2g1N5x/T0o2O/mbwagijJypYllzAqlVK8O78wzCjw+pbfoBD
	 OpiGt9it/w1jrZ/JJOhfHKk+XNy7U9KNAWiUwk1AHlqV17ZK3OtF72wd5IkJO0mgqj
	 IQLi8M66UVvse7nygFAHDpm7YR8UKk6u4QO4iLrM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FAD208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbeLGGwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:52:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:39772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeLGGwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:52:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04D1720892;
        Fri,  7 Dec 2018 06:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544165570;
        bh=pY8Wk73MLhYprXE6HRedJQZeFVOqYPBMipNLpniHsNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YUYdYQxtoPSxwVZsvvMCR0v3mblt0VvU6lEvexTHI4xqvbdrruOU2OgaJpYLFqPpG
         QDqzHyVlRRcDYHd70ceeyy7G/06sBlHRqCzfLpMI5pXs7aBxe0XNDrrwV6eGfo+NM9
         f1yuZ3Msc0XYYqMMYxIYjelTz4Nr42YE6RmlnqsI=
Date:   Fri, 7 Dec 2018 07:52:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/41] 4.19.8-stable review
Message-ID: <20181207065248.GB8158@kroah.com>
References: <20181206142949.757402551@linuxfoundation.org>
 <d6d42f05-629f-e41e-c50d-2e53316cd6bb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6d42f05-629f-e41e-c50d-2e53316cd6bb@kernel.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 03:10:03PM -0700, shuah wrote:
> On 12/6/18 7:38 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.8 release.
> > There are 41 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Dec  8 14:29:30 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.8-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Thanks for testing and letting me know.

greg k-h
