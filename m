Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6589FC10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2C52070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550850019;
	bh=1r9gJG76S5Q7e+SHgat5I28AEvmbih0HiiYUbofRx+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JuUwXHclCDYCOdz/RtzRDzvFROUpHNZW+k0SZ5JbkFF/paoj9Ly/EBaRl0NDiEPYc
	 z7jWiTKQNj0hMJ3FKaqfxiispb3L/8lTIoJ8BKeVtccAfUbtuawXDdAgExQ3uhKog/
	 wSvlTX08xuRBTJ/XD9QrIwaMg9TMkPG3kJop7tHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfBVPkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:40:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfBVPkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:40:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CDD420700;
        Fri, 22 Feb 2019 15:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550850016;
        bh=1r9gJG76S5Q7e+SHgat5I28AEvmbih0HiiYUbofRx+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K2uuVlLWpeYClI/madryy3vgUff5Kt4pTsjg+JoTvGbBGL0hTsb41IJIu5H/9QEV0
         Tzrew65+CFlluGTIwqWGvEfFED0dRxK5oGUSLrL112+XmifCpQqt5QUXgHFdiLRoZe
         KRT2KpqqdGGV+fM0OXChSi/W8yJoamBC02/K3UBQ=
Date:   Fri, 22 Feb 2019 16:40:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.20 00/32] 4.20.12-stable review
Message-ID: <20190222154014.GA24571@kroah.com>
References: <20190221125250.855065214@linuxfoundation.org>
 <CA+G9fYtCDnfwNkqma0yhVOh+eOtasNZ2PQ=6cgdCi4dZF2ZyTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYtCDnfwNkqma0yhVOh+eOtasNZ2PQ=6cgdCi4dZF2ZyTw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 08:35:41PM +0530, Naresh Kamboju wrote:
> On Thu, 21 Feb 2019 at 20:12, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.20.12 release.
> > There are 32 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat Feb 23 12:52:26 UTC 2019.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.12-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Great, thanks for testing 5 of these and letting me know.

greg k-h
