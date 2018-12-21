Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C76C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20ABB21909
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545386419;
	bh=hENGQRcjLT0VxodouxKXjzeSrD648XvUB7kfyjFZ9Ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ciAkJBaNbAPGNsrDYZsw+0iG4iAXR8YR8cOPUjLGbLpwiG8vitdZxiRJu2+HSXoaC
	 t08SYqQ4DN8AlVAOv2p0hZAmZPJo1jB+DoaaWZ4cO2W90VztPTXdJkE2CJWxe9C1GX
	 d+wFAVuUxt8yUIsgNHLbr/SPB6RufQcOpS/GTvCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389240AbeLUKAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:00:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:45808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389173AbeLUKAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:00:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 518C621906;
        Fri, 21 Dec 2018 10:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545386407;
        bh=hENGQRcjLT0VxodouxKXjzeSrD648XvUB7kfyjFZ9Ug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PmCw4w9wK5oYzzxifJc1rt7J6wGcjqghuyAZ5ovzUhdAL2plUASQ9/3fQ9Tkhzdsg
         YJv38LYCX2h4NEp5Xzr1e2g/qc3ujfnDwv4jsY5BdRQ8mWGUBBOMgHu68nVd3DSt9I
         7kK/ammiXvSdE+updGsAIlGKNNUinOkY4mRYnzus=
Date:   Fri, 21 Dec 2018 11:00:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jinpu Wang <jinpu.wang@profitbricks.com>,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
        patches@kernelci.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        shuah@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org
Subject: Re: [PATCH 4.14 00/72] 4.14.90-stable review
Message-ID: <20181221100005.GA24805@kroah.com>
References: <20181220085922.332225035@linuxfoundation.org>
 <CA+res+QQt7GEL0td1FraSJNnR2yOcDgXGahW+YyiuMSeWTshfw@mail.gmail.com>
 <CAMGffEn_TMi_17YBbg2KYk=_QArEJkdPdfV52wSqM+8QMhWyNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMGffEn_TMi_17YBbg2KYk=_QArEJkdPdfV52wSqM+8QMhWyNg@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 08:54:35AM +0100, Jinpu Wang wrote:
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Date: 2018年12月20日周四 上午10:39
> > Subject: [PATCH 4.14 00/72] 4.14.90-stable review
> > To: <linux-kernel@vger.kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
> > <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
> > <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
> > <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
> > <stable@vger.kernel.org>
> >
> >
> > This is the start of the stable review cycle for the 4.14.90 release.
> > There are 72 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat Dec 22 08:59:06 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.90-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > linux-4.14.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Merged, basic functional tests, no regression found.

Great, thanks for testing and letting me know.

greg k-h
