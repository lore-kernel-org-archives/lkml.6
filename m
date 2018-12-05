Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B023C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BC3208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544034280;
	bh=8Qdh0YqyMgY0V8drfpxyJKb9FlyiwJMUfTBDCCXJTT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wb7pI0i032Ca6b4GkZJMf77Zo0yJ9rU/lJOwTT7SMzR9oAOX72jOWlg38XVq7bCsY
	 576eFF04jhOuymbHoss/YzysYzMvMiQLBzKatWg8qBmX304KECEupSPuH7CvxpISF+
	 1057IMCtKyer/i2kZSQh8K6+rHfhlFj3fCH7ks1s=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BC3208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbeLESYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:24:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:50280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbeLESYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:24:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4BA020645;
        Wed,  5 Dec 2018 18:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544034277;
        bh=8Qdh0YqyMgY0V8drfpxyJKb9FlyiwJMUfTBDCCXJTT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yjbjbYRP+Sl7DrOdHARtJoHrD9v8VG2Q9B3IwUHADiGKB1dhaaHU4DXtTkc2mRlFQ
         CAkFnN4lAU2yqWhXjp1OI/084X29fDVR64CaStcy/A+nnv7rj5AhvASAQ6dR0hg5c/
         Y+eDph0UjahSrOUlYnbfQ2oRu51DVdfNxxwuBdiA=
Date:   Wed, 5 Dec 2018 19:24:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Harsh Shandilya <harsh@prjkt.io>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/139] 4.19.7-stable review
Message-ID: <20181205182434.GA26842@kroah.com>
References: <20181204103649.950154335@linuxfoundation.org>
 <4D8074B2-9CDA-45B3-B0AD-9887C962617A@prjkt.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D8074B2-9CDA-45B3-B0AD-9887C962617A@prjkt.io>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 07:51:28PM +0530, Harsh Shandilya wrote:
> On 4 December 2018 4:18:01 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >This is the start of the stable review cycle for the 4.19.7 release.
> >There are 139 patches in this series, all will be posted as a response
> >to this one.  If anyone has any issues with these being applied, please
> >let me know.
> >
> >Responses should be made by Thu Dec  6 10:36:22 UTC 2018.
> >Anything received after that time might be too late.
> >
> >The whole patch series can be found in one patch at:
> >	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.7-rc1.gz
> >or in the git tree and branch at:
> >	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >linux-4.19.y
> >and the diffstat can be found below.
> >
> >thanks,
> >
> >greg k-h
> Peachy as usual on the Lenovo IdeaPad 330-15ARR, no dmesg regressions.

Great, thanks for testing and letting me know.

greg k-h
