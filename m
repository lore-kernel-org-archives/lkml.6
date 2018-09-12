Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DA4C4167B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A570920882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="JlqOurGE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jkYgncg+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A570920882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeILXqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:46:51 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47621 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727809AbeILXqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:46:51 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 05A0021ECD;
        Wed, 12 Sep 2018 14:41:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 12 Sep 2018 14:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=rWieNYIbNtIzH9LhfJLaGIVejfYtMlwqedJ1Kp1BlD0=; b=JlqOurGE
        gGaHqzT/QBHM6Qd6yXYdXqNLFjhTnwG79K0am0J0BUFMPoYrUFK3oNim+oyJqpn7
        5N7voDIGSbQoMQMubDnayAvAt3Xi3yUWn4D1QMssQSjVCCaWFI9qbs1PuljGVvy+
        HV8zSzZySlTndcJD8gaM86ttnV/5x/dkTNH68bmu5KfybNEMB91TnhClhMkBgWzU
        R6HN+zXGHUSffh0gxSuJd4YauQJb3SfI2tWcyBIrEt1iEMGGY79CSiiIIFJuH6hN
        P7wEZ9XzdeSXRQjNa3XtltByusK+shYJwQc3YTGWhnzFRMszKgYQ2O46mbSlcg+m
        ilWMNc0ha6tOvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=rWieNYIbNtIzH9LhfJLaGIVejfYtM
        lwqedJ1Kp1BlD0=; b=jkYgncg+1SmDxbEdl+uvHImX+LjO8p7VyR+EJSRjFbGbj
        WZ9Uxi7O77jTw4vynfaTC/pKcCNfL25ZNP9PfhJlesIfhPUnAXmG5/ZzQT0XX+6I
        fV6OpKSLmBtqWEwrvocDuL0SnxuOmtSGERpJWvk+kUEFIpBgnh7EcCW0+ersJUmh
        YZeoqYNruMXWGJiBecTv44925ILLgt1vbr6K1mitrB+Xmrfq0dBr1YWvmrRq8v4H
        3k5e2UQDitqoVkvt8lHVbwHOETIW6gyqQ/wERYGhCk+9wmUzio9hF7++SKpHZA3c
        WJlpbQNfC6Q5JlVzp5GMOO6PEIoh5cQ4G4hdD3d5w==
X-ME-Proxy: <xmx:vl2ZW1wLF36Yl2ci5wnspXIdA68rg6W_5Vx4A7E8vOz9HxzIxjkbYw>
    <xmx:vl2ZW_XdIfcHjD3x62nGYgek-_HmJw-LvI9WOHSiU66tWTFjs63gFg>
    <xmx:vl2ZW_P6iy5DLTrH3-jp_wgsl8koyPNOzxtC2vM2OMoYsxlnjsxE4w>
    <xmx:vl2ZW5AmfTXz1f0mShs7s8S2GnyNBNYsfyQQsjZpdWzHI48pZfrWaQ>
    <xmx:vl2ZW0eJOzdCabCmCuGoYnKQtH47wfKlvBDHCmfsjqMDFWgVG3LwMw>
    <xmx:vl2ZWxEigUzJ8xFNzzQvN0UFC2oiuEFDPM_Ep0F-BIzqTInQjMGC2A>
X-ME-Sender: <xms:vl2ZW2ttLOl1SC6x3W76yC-qzfUzq-fbVpjcL_zfIDm6W5KeYzcFKw>
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.messagingengine.com (Postfix) with ESMTPA id C09E2102D7;
        Wed, 12 Sep 2018 14:41:01 -0400 (EDT)
Date:   Wed, 12 Sep 2018 20:41:00 +0200
From:   Greg KH <greg@kroah.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH stable] x86/tsc: Prevent result truncation on 32 bit
Message-ID: <20180912184100.GC10317@kroah.com>
References: <alpine.DEB.2.21.1809121439390.9957@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809121439390.9957@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 02:42:08PM +0200, Thomas Gleixner wrote:
> Subject: x86/tsc: Prevent result truncation on 32 bit
> From: Chuanhua Lei <chuanhua.lei@linux.intel.com>
> Date: Thu Sep 6 18:03:23 2018 +0800
> 
> From: Chuanhua Lei <chuanhua.lei@linux.intel.com>
> 
> Commit 17f6bac2249356c795339e03a0742cd79be3cab8 upstream.
> 
> Loops per jiffy is calculated by multiplying tsc_khz with 1e3 and then
> dividing it by HZ.
>     
> Both tsc_khz and the temporary variable holding the multiplication result
> are of type unsigned long, so on 32bit the result is truncated to the lower
> 32bit.
>     
> Use u64 as type for the temporary variable and cast tsc_khz to it before
> multiplying.
>     
> [ tglx: Backport to stable. Due to massive code changes is the upstream
>   	commit not applicable anymore. The issue has gone unnoticed in
>   	kernels pre 4.19 because the bogus LPJ value gets fixed up in a
>   	later stage of early boot, but it still might cause subtle and hard
>   	to debug issues between these two points. ]

Thanks for the backport, now queued up.

greg k-h
