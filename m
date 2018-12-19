Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0ADC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0493218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545232472;
	bh=SIilwSaOyYDUHP8bb0/SSm0oRFT8nn281s5Ub4xugmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HRpga15ttuv0g5YZle3KnrQytxWSKzas+z2vLSiF1ylJKxNb98AMXG3wVVBSiO7+Y
	 DxvFeduMPkM+uMXtnhszPxrTTHU1mNytIdo8Mu/ZP4yT2h0TUfOhMATYCS0QzP4Mid
	 E/GTjlirPpyPhCv1EYLqWzzqA5DezMggvpn8Hy/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbeLSPOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:14:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:43262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729951AbeLSPOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:14:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 550E821841;
        Wed, 19 Dec 2018 15:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545232469;
        bh=SIilwSaOyYDUHP8bb0/SSm0oRFT8nn281s5Ub4xugmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gmQpeihR6zFaMPNTCoPQZf0wCBo6tfO2+Yxg56+gM+hiu7Mccz08MgtejFWVyq6eT
         TdvyKQLtBHM27iKI+xYDmFfud5BRTeRF4HdTe+oOWAiIAtIeTMP09nlKJBiC13j7/U
         KSdPTYwkK2t+LKp1rEkbC6HLfB31LDwQccYvCPV8=
Date:   Wed, 19 Dec 2018 16:14:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Harsh Shandilya <harsh@prjkt.io>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/44] 4.19.11-stable review
Message-ID: <20181219151427.GA396@kroah.com>
References: <20181218163927.119623235@linuxfoundation.org>
 <D3BC02ED-AFA9-4390-83A7-148406821637@prjkt.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D3BC02ED-AFA9-4390-83A7-148406821637@prjkt.io>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 08:31:25PM +0530, Harsh Shandilya wrote:
> On 18 December 2018 10:09:12 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >This is the start of the stable review cycle for the 4.19.11 release.
> >There are 44 patches in this series, all will be posted as a response
> >to this one.  If anyone has any issues with these being applied, please
> >let me know.
> >
> >Responses should be made by Thu Dec 20 16:39:02 UTC 2018.
> >Anything received after that time might be too late.
> >
> >The whole patch series can be found in one patch at:
> >	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.11-rc1.gz
> >or in the git tree and branch at:
> >	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >linux-4.19.y
> >and the diffstat can be found below.
> >
> >thanks,
> >
> >greg k-h
> Built and booted on the Lenovo IdeaPad 330-15ARR, no dmesg regressions.

Great, thanks for testing and letting me know.

greg k-h
