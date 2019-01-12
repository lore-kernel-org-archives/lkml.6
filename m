Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EA4C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE33A20872
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547308008;
	bh=jobNzcFchHjxnReG+QNfjcxjcl/KNVK4dni7c4DDefs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l7qAhO0MHsN8ykSLlhgZzNQGu9QaTyMjMBF75BJ4C5j41O3RMzIwpUpOl0CciY1B7
	 4mDxLUZLO+AI6/Sybba+ROk1mM+lvevdBzQYJFmp06zbkksek+uorZoxA5LyseBSWj
	 Aw1S4BW1MVuGeRSZL/i+AbPfhLaXiRBn+T2lGNIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfALPqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 10:46:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:55452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfALPqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 10:46:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 229382084E;
        Sat, 12 Jan 2019 15:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547308006;
        bh=jobNzcFchHjxnReG+QNfjcxjcl/KNVK4dni7c4DDefs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HDIOVbBxXovP57m181gzguDB6nCldTJou3SUZa31fXUqoEsFkOcOoKhDEvHTQKAas
         Ui+bmcLdiqoh2Avmaihl1aHtYhpr7RZw+tRdZsIbB+w2CYyU4SiY7RjxVLLQ+K85f/
         F1trINqic0IxeETqPb6di8axQOoJbtEdFdgMkIAw=
Date:   Sat, 12 Jan 2019 16:46:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Harsh Shandilya <harsh@prjkt.io>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/88] 4.4.170-stable review
Message-ID: <20190112154644.GA16249@kroah.com>
References: <20190111131045.137499039@linuxfoundation.org>
 <D6A3D633-A92E-4124-BC4D-58EF011B81DD@prjkt.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D6A3D633-A92E-4124-BC4D-58EF011B81DD@prjkt.io>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 08:27:35PM +0530, Harsh Shandilya wrote:
> On 11 January 2019 7:37:29 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >This is the start of the stable review cycle for the 4.4.170 release.
> >There are 88 patches in this series, all will be posted as a response
> >to this one.  If anyone has any issues with these being applied, please
> >let me know.
> >
> >Responses should be made by Sun Jan 13 13:09:58 UTC 2019.
> >Anything received after that time might be too late.
> >
> >The whole patch series can be found in one patch at:
> >	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.170-rc1.gz
> >or in the git tree and branch at:
> >	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >linux-4.4.y
> >and the diffstat can be found below.
> >
> >thanks,
> >
> >greg k-h
> Built and booted on the Pixel 2, no userspace or dmesg regressions.

Great, thanks for testing 2 of these and letting me know.

greg k-h
