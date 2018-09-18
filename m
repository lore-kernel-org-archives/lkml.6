Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE55C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7224D2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="q9Q8gfO+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L5lLjOcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7224D2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbeISDh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:37:29 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57801 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726821AbeISDh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:37:28 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B6F8C21F86;
        Tue, 18 Sep 2018 18:02:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 18 Sep 2018 18:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=OMQO+J2bROXWzNvkHWhu1FR/AAvJpPwwK/7jB5EK6NE=; b=q9Q8gfO+
        dAPytakF7I2hOvsWwB0iWYHYLNqTyXAWBiEV+Yd9IWnG1W88FC77ddJJFBR+yd9v
        jJBwVSUtE0FruXw3Gy8ftUB5LVZco3lTvxpcEqMJcMbyT5TIdEKcGU995GnvWq0X
        AGRd5bpH5RXN4Leqbc+LcAYxHBTea+gCP8NxL9ozLNPZcNy2Ys5GLlmc0ZcEyana
        pUtB2PScsFNtKj5fUjpkHCuVVjTl8WFSXaVfIEwkxbqJzFpBH4uLSyhYa3bL62sl
        W7ZjL8S5si/uP+oGWrUB/acwLMqoLZRBkatlLgqfdKAkQlkJNUItR+7h+NXPpHr2
        bFxbVnIoffnU9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=OMQO+J2bROXWzNvkHWhu1FR/AAvJp
        PwwK/7jB5EK6NE=; b=L5lLjOcXxglejUzjzscFmVjepW+b/oYICBuOAnZWHq0/L
        Dcs33TbuaUOWdvllFoTvYpssCl488hiKc5ZSvuAQNDfuXuVzvNhJJj+1Arr1Kk+v
        xf6E2zbtQajwkmfOboa3x8SSNo+iP5BbvHvOg1SqnGStYzfob1fHEQ6PLa9bzuNf
        lDOYyyBqbTlDhVapzHzzEG+kfUwyA6h10c6vp1vu2C6pEaqfotfwiAbOehWKUmke
        QoogrVMO727gQLB9A1aLgqk2/ZfmGfPDMDXIQGKovbGX6PhtG/NgiDkKGsvKv/pw
        bVIqIaKqwmchutBiWwtUCd/ofIRENt+jJSFxMmpqA==
X-ME-Proxy: <xmx:CnahW_ej6cE-Irp48YNqzPIsZWv3A4Z1daAXnwk1s6pKay1yAz5xow>
    <xmx:CnahW_OQqVAPYRvAy990Tx9466APxxxIrpKJpV_biPm9db3qgKqjVQ>
    <xmx:CnahWxoiYnEyx5Zps-b8IqpdA87YSdKzdQXsj0ZicyFzixr8I-mq2w>
    <xmx:CnahW4fNdmnrybLfEozPxsXD8KiMCkwLhe7mDEZ_vqz2CbqeFYB4Lw>
    <xmx:CnahWy7QO2ERGB7ZmESEtx_5YADCBLos-VAX5blMt_bEYzYUYMYixw>
    <xmx:CnahW13lUNYHxJt619BHM0QLR4uW3WiOg0Ze_zwoIdgawvLNimy7HA>
X-ME-Sender: <xms:CnahW3joYRuA98B1sjDTIXXsctE4xPYk5nWLDH-0g4Oec7_tkb-NQA>
Received: from localhost (ppp121-44-228-8.bras2.syd2.internode.on.net [121.44.228.8])
        by mail.messagingengine.com (Postfix) with ESMTPA id B3B08E405A;
        Tue, 18 Sep 2018 18:02:49 -0400 (EDT)
Date:   Wed, 19 Sep 2018 08:02:46 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/3] tty_port: Fix kernel-docs warnings
Message-ID: <20180918220246.GD22746@eros>
References: <20180912075044.8695-1-me@tobin.cc>
 <20180912075044.8695-4-me@tobin.cc>
 <20180918133849.GA25134@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918133849.GA25134@kroah.com>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 03:38:49PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 12, 2018 at 05:50:44PM +1000, Tobin C. Harding wrote:
> > Currently extracting the kernel-docs causes a six warnings of type
> > 
> >   warning: Function parameter or member 'foo' not described in 'bar'
> > 
> > Add function parameter descriptions to the function kernel-docs.
> > 
> > Signed-off-by: Tobin C. Harding <me@tobin.cc>
> > ---
> >  drivers/tty/tty_port.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> As I didn't take patch 2/3, this one doesn't apply :(

Oh I thought this whole set would have been ignored because of comments
on it.  I've been working on doing these changes for all of drivers/tty/

Thanks for reviewing and taking the first patch.  I'll be sure to
rebase.

thanks,
Tobin.
