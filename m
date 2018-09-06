Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ED6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779A62075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="Nzcagtcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779A62075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbeIGAUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 20:20:33 -0400
Received: from imap.thunk.org ([74.207.234.97]:60032 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbeIGAUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 20:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=TK7yvDaceeZh7xw3kn0N6a7yTc2jrvVGJ4hUC0xXAVU=; b=Nzcagtcj+FSOaXFx4ZSlRMaMoA
        wJmC7PZi6f2SBY/pbON3c5gwcathsPPvuwjXwY+hjibPPnyPbgFQK6gSQRrnigLQBhXnq6NdlDh4Z
        JZ2L0QyDkci04xv+zKH8WDr/hhGFRUl4cGwgKHt8E49zyO5OzmdHbbW73iPx9kbkHLlE=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fy0Bg-0006UJ-0S; Thu, 06 Sep 2018 19:43:32 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8D40A7A5675; Thu,  6 Sep 2018 15:43:30 -0400 (EDT)
Date:   Thu, 6 Sep 2018 15:43:30 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Matt Hart <matthew.hart@linaro.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        David Howells <dhowells@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Widespread crashes in next-20180906
Message-ID: <20180906194330.GH5098@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matt Hart <matthew.hart@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        David Howells <dhowells@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <2e8e31f5-4db5-4907-2d09-f6444bc78ede@roeck-us.net>
 <20180906140413.GA5098@thunk.org>
 <CAH+k93Fgk2yZ3OzBOL2uxSVuOqEJB5wS1Zfny8bDkbuQ3sM6Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH+k93Fgk2yZ3OzBOL2uxSVuOqEJB5wS1Zfny8bDkbuQ3sM6Jw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 03:13:23PM +0100, Matt Hart wrote:
> On 6 September 2018 at 15:04, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> > On Thu, Sep 06, 2018 at 06:45:15AM -0700, Guenter Roeck wrote:
> >> Build results:
> >>       total: 134 pass: 133 fail: 1
> 
> Do you build arm64? Because KernelCI is seeing build failures in arm64
> defconfig for next-20180906
> Clearly it's a module build problem for sunxi but I'm not sure who to
> CC about this.
> 
> https://kernelci.org/build/next/branch/master/kernel/next-20180906/
> https://storage.kernelci.org/next/master/next-20180906/arm64/defconfig/build.log

At a guess, from the MAINTAINERS file

ARM/Allwinner sunXi SoC support
M:	Maxime Ripard <maxime.ripard@bootlin.com>
M:	Chen-Yu Tsai <wens@csie.org>

						- Ted
