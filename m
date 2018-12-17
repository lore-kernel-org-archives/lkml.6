Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F715C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2662133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545055954;
	bh=/ADW8IU70BZPKEfEOh08c1nFRaGC984Nl+ThnRw3hvc=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=WZWfwkrLs7HnllMZcjWtrjOxR5K0vDIsMbHAbCHWr+28qPjbHqv/lWaUjOKfMnOOq
	 fKRVBshfXiNidW/DYu8SllBkSpKsYJqOE7A07tXLWNkSAPrb5pnzEEjiUun8q8QILd
	 YiikAcOyvaXbpohtlHqxxRGbTIvL/tZv5auIMs/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733238AbeLQOMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:12:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726965AbeLQOMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:12:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C71920874;
        Mon, 17 Dec 2018 14:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545055952;
        bh=/ADW8IU70BZPKEfEOh08c1nFRaGC984Nl+ThnRw3hvc=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=y0s687N2VMEA6o3vJz5ICI/Mi5atN5Zb5VsMKK83oRqGMzSKy3cLi50NUjbRzwV4Q
         K6OM07MtDEa6sSZgHiP7+0bGU22bq8+08WGw5oseeatVbSS6BsTX6m8AQi1jmsrXTx
         SSGg0NdnGddcn8sg3tuooUbrkWqQysHJ4jGNf1J8=
Date:   Mon, 17 Dec 2018 15:12:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.19 000/142] 4.19.10-stable review
Message-ID: <20181217141230.GA26946@kroah.com>
References: <20181214115747.053633987@linuxfoundation.org>
 <20181215170102.es7drxdtiz7gzaib@xps.therub.org>
 <20181215171145.GA2086@kroah.com>
 <20181217135632.fisfyfkt4473q7ze@xps.therub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181217135632.fisfyfkt4473q7ze@xps.therub.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 07:56:32AM -0600, Dan Rue wrote:
> On Sat, Dec 15, 2018 at 06:11:45PM +0100, Greg Kroah-Hartman wrote:
> > On Sat, Dec 15, 2018 at 11:01:02AM -0600, Dan Rue wrote:
> > > On Fri, Dec 14, 2018 at 12:58:05PM +0100, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 4.19.10 release.
> > > > There are 142 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Sun Dec 16 11:57:12 UTC 2018.
> > > > Anything received after that time might be too late.
> > > 
> > > Results from Linaro’s test farm.
> > > Regressions detected.
> > 
> > They were?
> 
> My mistake. There were some false regressions that showed up and I was a
> bit distracted when sending the reports and missed that.
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Ok, good, thanks for confirming, I was confused :)

greg k-h
