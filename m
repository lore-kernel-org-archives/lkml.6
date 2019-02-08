Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB77C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 06:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9891421919
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 06:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549608367;
	bh=wMjvqSOW7aywA9g5ghjvIzUYjsbOdXhnVzMlmxJVfBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QSMYwFO+iv5nNjs3zSiZlHtCkpEnQBOXAcyMMGymuScLIcIBJbC8xSRlV9TOKZUDR
	 4JLII2kKg3tvD70AIOpUJVZi6bxbgimE0Z9nHW/t4T6PSnSb4T5uViS/pKNRr2asp0
	 Akd4D2HGz3j4SsNri6LKxA+dP1bWWzrKNsQjwlPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfBHGqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 01:46:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfBHGqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 01:46:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6181A21916;
        Fri,  8 Feb 2019 06:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549608364;
        bh=wMjvqSOW7aywA9g5ghjvIzUYjsbOdXhnVzMlmxJVfBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EfEhodv0p8rG3M8zQNfoioRLA7lJRHZdmWaDdu/lfu9jgrw9Y5LRU+Iv9cwpz1Vfq
         UPfuk+3XF+j6V7bkRSHrS1mHRJULnTWEgvgaJugMei9TflKNhd9gNmj/a6Eoy9ToL5
         CRkWZPAlB8swq5GPScFwyKrS7aPviI1csOOuxk6M=
Date:   Fri, 8 Feb 2019 07:46:02 +0100
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
Subject: Re: [PATCH 4.4 00/34] 4.4.174-stable review
Message-ID: <20190208064602.GA18164@kroah.com>
References: <20190207113025.552605181@linuxfoundation.org>
 <CA+G9fYuO-xX94KZG165-9_9QEZ7_VypxckHgPmX6dTTsHrAzxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYuO-xX94KZG165-9_9QEZ7_VypxckHgPmX6dTTsHrAzxg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 11:43:55AM +0530, Naresh Kamboju wrote:
> On Thu, 7 Feb 2019 at 17:12, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.4.174 release.
> > There are 34 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat Feb  9 11:30:10 UTC 2019.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.174-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Great, thanks for testing and letting me know.

greg k-h
