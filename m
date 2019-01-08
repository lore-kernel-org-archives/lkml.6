Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9839AC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F23720850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546950388;
	bh=uHEENYzEzviA8Omqreumj7/6vckDegQyJbxnMcmMR+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OLcPMXefev11aGiG87AVDX80scwJ8M0GH48/Fr9ao5gSjauXBCLViDTw/t9hmtpQz
	 S4uaX+T6Sb6vmC2rcZuISnJUf+K5JV/VBWF6KIiE/f0Y/Vr2YC3zst/4Lhw1B2ZV9h
	 1D5FuYCHKVnoTdCHbBKi9qvBJ1QTdrdBUmV+nvNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbfAHM01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:26:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:37222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728782AbfAHM01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:26:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB9AC206BB;
        Tue,  8 Jan 2019 12:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546950386;
        bh=uHEENYzEzviA8Omqreumj7/6vckDegQyJbxnMcmMR+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X2MiREDhEPZ8ldT2i8TKc1J4HYj9i8a5hhU3lBgXxuiS0tWTHEifE70iINS8uF5RY
         sTXjNMNOBRHlKeUteyde/i80FTiCEVMmNn0G1wrsdVSA47ngkyghbJmiGn/MRBJn6u
         5+juW0D+DVf1JhpjiCsZBk3blQX9gtWxiEOrdywU=
Date:   Tue, 8 Jan 2019 13:26:23 +0100
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
Subject: Re: [PATCH 4.20 000/145] 4.20.1-stable review
Message-ID: <20190108122623.GB4801@kroah.com>
References: <20190107104437.308206189@linuxfoundation.org>
 <CA+G9fYsx=oUnq6V1JcQ4dvnPgLVwrBM_MjyXF7F1xV_CoGBOAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYsx=oUnq6V1JcQ4dvnPgLVwrBM_MjyXF7F1xV_CoGBOAQ@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 04:28:53PM +0530, Naresh Kamboju wrote:
> On Mon, 7 Jan 2019 at 18:04, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.20.1 release.
> > There are 145 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed Jan  9 10:43:39 UTC 2019.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.1-rc1.gz
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

Thanks for testing all of these and letting me know.

greg k-h
