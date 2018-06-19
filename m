Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E863C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE81C2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fXKA3Wn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE81C2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967172AbeFSRQV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:16:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41142 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966646AbeFSRQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eEOKeI7SGBf8f/8ulA3k7DcqqoJZ9rL5/5Ug6Q4jvkQ=; b=fXKA3Wn50oABGlqEu2TtdUI8v
        M37+25WAPDLRRZI7kIv1++HoiSNF2IOAU/w5WfdN1n1wcWHWiQgEIu19njftqbybYGrEfnSZfYNhq
        rgcUNGTzVh66HBaM8AT5BP2/5f//dSFZvtILs9X7RDFFSHDK/4+00aPjL5UczL8xifba52Yujmz2z
        /GnOEJ3v02j/+en9Qiwa3vPna37mUyvNAu5Tzv+xt9dbW9DhHfZ8ip5V+UWvggy93nsvMF4RHRFwR
        f8pOsVfqSocGnd2fs/CL2HONmotOdPGAGhhM058wykQ/3ZDQQK+OYvbZQrHEPzumTJ1LwshaDgmdJ
        GrZdPiSSA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVKEq-0004do-Of; Tue, 19 Jun 2018 17:16:16 +0000
Subject: Re: [RFC v7 1/1] mconf: global i-search in menu prompts
To:     Dirk Gouders <dirk@gouders.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20180617121534.4809-1-dirk@gouders.net>
 <20180617121534.4809-2-dirk@gouders.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6e23227d-f3ed-2197-7458-b060b8c90b64@infradead.org>
Date:   Tue, 19 Jun 2018 10:16:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180617121534.4809-2-dirk@gouders.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dirk,

On 06/17/2018 05:15 AM, Dirk Gouders wrote:
> 
> At any time, at most one i-search is active and the navigation path to
> the current menu is displayed in the subtitle, the second line in the
> menu window.

Nice.

And the highlight of the current menu item is also nice when TAB is used to
switch to the buttons.  As well as toggling the help text based on context.


> Navigation example:
> 
> To navigate to options concerning NFS file systems, simply type 'n',
> 'f' and 's'.
> 
> Hint: use the 'z' key with focus on buttons to search for invisible
>       prompts.

I think what this says is that the 'z' key is a toggle for the display of
some (invisible) prompts.  Is that correct?



I reliably (consistently) get a segfault.  I have hit it several times.
Here is one way to get it:

$ make menuconfig
and then enter:
/debug\



thanks,
-- 
~Randy
