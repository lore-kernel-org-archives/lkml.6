Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9EFC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437BF20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="knyEbu00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437BF20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbeKUDLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:11:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:36136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbeKUDLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:11:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A7F5206BA;
        Tue, 20 Nov 2018 16:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542732062;
        bh=MTMe9oQMPtuONqgY7Y5ecZcNcIYPXiQvCczkhlI6kiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=knyEbu00/AFySfT2RVQSFxSTjzD37iE8Udu++aUhghHcQHosIW9aQ5rxUtZ91RZOQ
         W3o8ThHStbvy9VW7vjfXR0/qWFK3hp5HRfxyIRZsUmTQ5eFR0miXDCJFghmbKOQE35
         Bxi6pxEoxATKFFZ/YUhymirEHDSa2BdZlWyX9xeU=
Date:   Tue, 20 Nov 2018 17:40:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Harsh Shandilya <harsh@prjkt.io>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/90] 3.18.126-stable review
Message-ID: <20181120164059.GA27257@kroah.com>
References: <20181119162620.585061184@linuxfoundation.org>
 <0DFBC924-F22E-4DA6-A755-BD5FD14CDD4D@prjkt.io>
 <20181120111613.GC11550@kroah.com>
 <D161C16F-60D6-4C60-B065-C780BD3DCF55@prjkt.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D161C16F-60D6-4C60-B065-C780BD3DCF55@prjkt.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 08:18:57PM +0530, Harsh Shandilya wrote:
> On 20 November 2018 4:46:13 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >On Tue, Nov 20, 2018 at 04:09:05PM +0530, Harsh Shandilya wrote:
> >> On 19 November 2018 9:58:42 PM IST, Greg Kroah-Hartman
> ><gregkh@linuxfoundation.org> wrote:
> >> >This is the start of the stable review cycle for the 3.18.126
> >release.
> >> >There are 90 patches in this series, all will be posted as a
> >response
> >> >to this one.  If anyone has any issues with these being applied,
> >please
> >> >let me know.
> >> >
> >> >Responses should be made by Wed Nov 21 16:25:28 UTC 2018.
> >> >Anything received after that time might be too late.
> >> >
> >> >The whole patch series can be found in one patch at:
> >>
> >>	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.126-rc1.gz
> >> >or in the git tree and branch at:
> >>
> >>	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >> >linux-3.18.y
> >> >and the diffstat can be found below.
> >> >
> >> >thanks,
> >> >
> >> >greg k-h
> >> Peachy as always on the OnePlus 3(T).
> >> 
> >> P.S. Not tired of this old-ass tree yet? :P
> >
> >I am very tired of it, but it turns out lots of people still depend on
> >it, so I'll keep it around for a while longer :(
> >
> >thanks for testing,
> >
> >greg k-h
> 
> That's just sad. Anybody using this outside Android?

Not that I know of.  And really, they better not be, as it is NOT a
kernel one should use anywhere else at this point in time...

thanks,

greg k-h
