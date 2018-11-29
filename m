Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A02C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C96720868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="o0E8M63S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bI51LxjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C96720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeK2TJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 14:09:05 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51095 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726651AbeK2TJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 14:09:05 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4E56121D8B;
        Thu, 29 Nov 2018 03:04:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 29 Nov 2018 03:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=waCbptYnG0xQOkAgw24NMTj+ozh
        gBzsCQJ2m9msFc6U=; b=o0E8M63SqyIUba3p3Aqhkr26htiSbFC1h8LNlKYlbXb
        dZVZNLs/TIJoiaSnQ7ILmO9Mzqw2Z+WtBCS2xMGE0NPRoegg5/klIzvsxeucZeXr
        62pK/mAFD3lzLeNWy2P70Z0wh5PX/tn9miWRrkMlGrOpIrgOugmVuMJ1jwSmBBAu
        Luv2H+eKoIL13BKrC1YhMrIVY4aZx2yLyvqBPU9398gS0Jj0/uMlo35Aj3b386hz
        DLrcaKqwe3So6Y9eWdmby8a7FLBe7wnKQksfdO00r9FZ0zxS8dYrsUeThaxCJnB/
        zspILOLgq2WN0Hws+nXpdEaVGSIpoVNCWwcYIa1Qqyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=waCbpt
        YnG0xQOkAgw24NMTj+ozhgBzsCQJ2m9msFc6U=; b=bI51LxjZytJkYJFZ4pf69O
        Bkaker2/VUjBz5C5vztDW9+7UPZH9jMX2bDSrx4P5AJ6xOytZjl+KK6LE+E0F8R6
        Uu4HHo/3CpF6r3OYujU7wMmIpvU9x7aXTMZuBHPKtJ8Tqp5huHm5AQNkQZfR++vU
        ewy1m6yv191Anm/795FbetyfMkLCpnCMa4zdA5gTku+2XAGzACZMhJLdq6Zzgq6y
        OrYEmt60AQZNTgginPLVD4B7BZY+mK0rbE5P6/nAnt8ygxsA45F8nkOcS2OkYs6C
        os6+OFE5ESdtY8VeXJCin92gezgrYBer2LxSfnZQ4cyQWEYaq3yzX2X1fjccasSA
        ==
X-ME-Sender: <xms:kJ3_W6JFeXHtB1Iuygn_LU13AoQG8dxOCXNqE4RKdGwIYV_fqBGEnA>
X-ME-Proxy: <xmx:kJ3_W6-niJ36XwtadZjB2ogsua7IeVO8w7ioUSCEGw1NpQ6Uj3sn0g>
    <xmx:kJ3_W3iv2JPrCOd3AE5yEp1gOP848pdW2lfgxZ3LqoAgK7kvbz3Uvg>
    <xmx:kJ3_W0MLMjya-6mmHOGykqfrzNM3dsMQfupckPV1FibJp-PtnVL0uA>
    <xmx:kJ3_Wwln0D9dm3foECyV3asrkPCKbYJJHJfmyltNUxqiaC25zxLnEg>
    <xmx:kJ3_WzWqcWjhph1f_DtYs_rd9NN6qcxzBcDmxA_tjTLXCkQXE_m8EA>
    <xmx:kp3_W7ZFpCtIacvMdJSG6tXftuoOtddpwNOM-YZh62rDvNNqLe36NA>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 44CA0E405B;
        Thu, 29 Nov 2018 03:04:32 -0500 (EST)
Date:   Thu, 29 Nov 2018 09:04:30 +0100
From:   Greg KH <greg@kroah.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [4.19-stable PATCH] dax: Avoid losing wakeup in
 dax_lock_mapping_entry
Message-ID: <20181129080430.GB13859@kroah.com>
References: <20181126142743.GA25618@bombadil.infradead.org>
 <154343119877.981933.9776503138356369421.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154343119877.981933.9776503138356369421.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 10:53:44AM -0800, Dan Williams wrote:
> From: Matthew Wilcox <willy@infradead.org>
> 
> commit 25bbe21bf427a81b8e3ccd480ea0e1d940256156 upstream.
> 
> After calling get_unlocked_entry(), you have to call
> put_unlocked_entry() to avoid subsequent waiters losing wakeups.
> 
> Fixes: c2a7d2a11552 ("filesystem-dax: Introduce dax_lock_mapping_entry()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Passes the nvdimm unit test suite which exercises the lock path.

Now applied, thanks.

greg k-h
