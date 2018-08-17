Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB8AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1992B21788
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cVukcqe2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1992B21788
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbeHQX1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 19:27:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58166 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbeHQX1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 19:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tZflmqSleBMifuD5hhJ6UTgkAUx2yp2yuXTVZunNhpE=; b=cVukcqe2fVzLAaHc7pxw8i/BR
        2Z8kSUDKsxOwrwnAUXY4Rb9Vnahbe15Mm/eyrMrEVNJyKwAFScF0BtKC3ZSU8iorz5M3g8XatDK94
        +0/129wk6ST1Lg3Qm6xB5CzNaAAPWpFTuA9XLpfdOP0Iy/g2GAqFmYDp7pvEUABH0OOJC/B7xgBUB
        tHnKvTzriGRLOx0oyDrYEHqXe+6votDpBCG7RRuIlS5S4vO/SVvvnSUF3ElKysyywGzVV9MuBqr/Z
        44muKbtMne19cCxziOVrJnmY+8Rl1gC0ysKC/5XI9yb5QgI6xgpdWRtSyjFNPM31+rPe5fuapXHvS
        vKbZCvNAw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fqlG9-00083j-ET; Fri, 17 Aug 2018 20:22:13 +0000
Subject: Re: Say what the -[ cut here ]- lines are called
To:     Dan Jacobson <jidanni@jidanni.org>, linux-kernel@vger.kernel.org
References: <878t56rpc9.fsf@jidanni.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <47f50df3-1c46-cb84-50d7-99684d58772c@infradead.org>
Date:   Fri, 17 Aug 2018 13:22:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <878t56rpc9.fsf@jidanni.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16/2018 02:09 PM, Dan Jacobson wrote:
> The kernel should really say what the
> ------------[ cut here ]------------
> lines are called, else users will say things like:
> 
> "I discovered that the user needs to use xrandr in _two_ steps for
> certain resolutions, else he will trigger a
> kernel:  ------------[ cut here ]------------ line."
> 
> instead of
> "...will trigger a kernel problem."
> "...will trigger a kernel fault."
> "...will trigger a kernel oops."
> or whatever it is supposed to be called.
> 
> So say e.g.,
> ------------[ cut here ]------------
> Kernel fault:
> 
> etc. there in the syslog. Thanks.
> 

My google search fu shows me:

------------[ cut here ]------------
(immediately followed by:)
kernel BUG at ...
(or)
WARNING: at
...
and ending with:
---[ end trace c228cd85b8ef2f99 ]---


Or are requesting more descriptive words immediately before "cut here", e.g.,
----------[ begin kernel trace report c228cd85b8ef2f99: cut here ]----------

See, I would prefer to see the hex "oops ID" at the beginning as well as the
end of the trace report.


-- 
~Randy
