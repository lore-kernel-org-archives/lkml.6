Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01105ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 22:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F132087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 22:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="ppEzPMT/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n2CATKyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F132087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbeIQDmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 23:42:54 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57019 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728169AbeIQDmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 23:42:54 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A2D2C22158;
        Sun, 16 Sep 2018 18:18:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 16 Sep 2018 18:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=kWgdmMZ5Lp6bGRs3o5NLuNYCnJi600szaF2YGpx0US4=; b=ppEzPMT/
        pkpD1x23q0BgPENlcf7rlFOMQnfYZLUIZHeQMOj6YkDGnUZGVNio0/uDNCW8OEC+
        vOPXG6xCIG6DhPPnT+Gik4ZE0lrg/vjY4ox3JVX7l85OigIJ5/2ZEh1egRBi519K
        S4mu/gN7COoxSG9hja10u0kW2hSrWMdnSJ8sTyuSoPW9cXZnj6sBOKIFB8ba3cqH
        Xy12QYxmvwKev84uREOgL8s4uNvq9U0t9UWIWBqIVxj7REJFxAeTLUBOLWAjcYZE
        DSaALQwDFCPhtIGHRTtk/WMz3I9Fs3CAOz5eIkwWeb0vj2cwbQeBHOx4jRHljEfZ
        AFZ6dD5RPjqjjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=kWgdmMZ5Lp6bGRs3o5NLuNYCnJi60
        0szaF2YGpx0US4=; b=n2CATKyv1xMQMNVddDFUJfQaSc7mj3HsozZP9wV/3dltK
        saM9xOTbLVdiDXHfk3vWqoYyIkMDdDbv97zqHgQnAe0NOQAnfH4Q6fISP/wTXO8A
        S/cNzGdP1c494BzKV4KdOXfW+IA8oaQHrZOFGyPn47gxtSOW3op/Vhov4ao/2w4C
        y/SafwNDNm/D6REVhKMmEofYwC+CC5E0XpJX/+aX6KALqIiqrgTVedZc6TTvxyfA
        S1V891+yjNlyWF2go0j7Uk7Ykx4YgdrX8bzqR3G66xUolixKdBjQM93etOpEgCIZ
        G9kgqwTt6teCga+J4P/OwdiZKnuQkeL+cfqC2X/bA==
X-ME-Proxy: <xmx:staeWyEu7XMw-zNELHw6BgNv6JSk3jF55fmh892E8XFcL1NTyQM8zA>
    <xmx:staeWyZFQyZWeG3gR7O68ELMR_79Y2uZEKGf7iVJYooAo54qnQf8gw>
    <xmx:staeWyVTWQHIEN6dnJHfekYzBp9XAPgfAQgqwDj60RfnEQiZEATuiw>
    <xmx:staeW4nCwATtqyNN7-iDVWWiTRn7mt5Sz9c2AAeZt0UKIHFNMBdraw>
    <xmx:staeW9B4ZIFiNzYSyHrsRlnPhvmkH4RSntZ0gPLjepH_a4hZ-n8Q6Q>
    <xmx:s9aeW7i0jbJAr3cdPJAfJaEZSO_yCF9fBhDGgrfZqG33D3eEJqAyJQ>
X-ME-Sender: <xms:staeW46DV51tKoN4ACXZYIZCE1swBAQrtJdxu-C0rjh0xjUFawhaBg>
Received: from localhost (ppp121-44-228-8.bras2.syd2.internode.on.net [121.44.228.8])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6F57C102D6;
        Sun, 16 Sep 2018 18:18:25 -0400 (EDT)
Date:   Mon, 17 Sep 2018 08:18:22 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Jason Wessel <jason.wessel@windriver.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kgdb-bugreport@lists.sourceforge.net, stable@vger.kernel.org
Subject: Re: [PATCH] kdb: use correct pointer when 'btc' calls 'btt'
Message-ID: <20180916221822.GO11198@eros>
References: <ff05bd36b338f4f914780176e9eba8138e1b254b.1536927765.git.christophe.leroy@c-s.fr>
 <20180916190610.vzqxwps7zqy2zc6o@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180916190610.vzqxwps7zqy2zc6o@holly.lan>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2018 at 12:06:10PM -0700, Daniel Thompson wrote:
> On Fri, Sep 14, 2018 at 12:35:44PM +0000, Christophe Leroy wrote:
> > On a powerpc 8xx, 'btc' fails as follows:
> > 
> > Entering kdb (current=0x(ptrval), pid 282) due to Keyboard Entry
> > kdb> btc
> > btc: cpu status: Currently on cpu 0
> > Available cpus: 0
> > kdb_getarea: Bad address 0x0
> > 
> > when booting the kernel with 'debug_boot_weak_hash', it fails as well
> > 
> > Entering kdb (current=0xba99ad80, pid 284) due to Keyboard Entry
> > kdb> btc
> > btc: cpu status: Currently on cpu 0
> > Available cpus: 0
> > kdb_getarea: Bad address 0xba99ad80
> > 
> > On other platforms, Oopses have been observed too, see
> > https://github.com/linuxppc/linux/issues/139
> > 
> > This is due to btc calling 'btt' with %p pointer as an argument.
> > 
> > This patch replaces %p by %px to get the real pointer value as
> > expected by 'btt'
> > 
> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > Cc: <stable@vger.kernel.org> # 4.15+
> 
> Would a Fixes: be better here?
> Fixes: ad67b74d2469d9b82 ("printk: hash addresses printed with %p")
> 
> No blame attached to Tobin, but the fixes makes it super clear what

:)

> changed and why this breaks kdb (which was not explicitly called out
> the patch description).
> 
> 
> Daniel.
