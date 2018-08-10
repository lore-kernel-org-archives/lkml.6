Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA7CC46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F496223B7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="VPZ56/qq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OGKyjJNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F496223B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeHJEOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 00:14:17 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55827 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725198AbeHJEOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 00:14:17 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 135E421D23;
        Thu,  9 Aug 2018 21:46:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 09 Aug 2018 21:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=cL+WQ92uM6WkajZ8nC95EVWt/OP9dM/mErMbMwTqynU=; b=VPZ56/qq
        TAjfqmZvAlt6lm+50u6t2f03DrZZVfH3y0mfmc7qoUHWgSEGqnpS6aYBr8cknnfl
        JJVWO2H5y3X7RhY9psqU+DtHrA6e/GaWYwWytjRs+r6yZHZLd1IrqwHDrbGejbFI
        SuOAXz6RbmwawdiAmk1iiATraSd7VS3H+7FoQ412CwouRII0c0kXv+4CnnhxZyO2
        +arwIzf9zz7+t9T5iwlYqsgR58qO11sGo/ioa6WudOfPW57Aze/qmWZSxB8VssFL
        Mfp3VC+KymV3js/n4Z1jeNpgqxKIM6dF3iM1xHRnBG88VS0yrMUY/VOTwtfZ4zti
        HuvaG+5d82400A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=cL+WQ92uM6WkajZ8nC95EVWt/OP9d
        M/mErMbMwTqynU=; b=OGKyjJNxKI5e2FJhHg6lIGk3LXfpctdTUxthQU0D26RMV
        jPVtsmQNlTmkFeAlPAey/hdX59p4rE1dkeEMliguuCeiSDbnrXyDyaHGVaUvCAii
        vtdIlTJxJ49WlZhOhRNutDqujP8tNCl4CO5W5s7S3T6HhhM2hUx24xbLNLmjG5qi
        TB4EQK7QJQbQSjJSt39l11vrQCNwFBBbD2UZfN1u4ixKhUtrDEGB/fIyGExrsEkE
        VnhoCpYpcOnkMJ8eEFtjGIQWFNgUMqP4xBkZNx+xr59Erm1J6XNNvkbNrzNOAJtY
        fXh4Z6NPxlPLaKLGmL6GeGpra2ZOn1hRc1wcmiuiQ==
X-ME-Proxy: <xmx:gO5sW6lbJfgMU0yShDjOxTWFoDWyNCVouTpQ4L9WMwpCzzXN26jN1w>
    <xmx:gO5sW9aGRVRhcBE5zCtUYrT5z8iaoWTJh_kFOQr2VOJLONyWjTEMfQ>
    <xmx:gO5sW_721W6-JdlZ7BHUK5-CyJFogbh1_epUBqPGeS0CObEF6dya-Q>
    <xmx:gO5sW2-h_rLiorXbA9-yxr_IUxPN7oHaf9oo1rtq5L48_EFO5zL3WA>
    <xmx:gO5sW0l8nYiKGAcc-UKXDpWTOOrf8BQk0Y22xtUoJeTMJBbhKAP2Xw>
    <xmx:gO5sWw5bxUR7sur7quICTWcWyztCqrR2e_LvXHRlig6Xox4jUjs9HA>
X-ME-Sender: <xms:gO5sW91ntSEst4kB57fJvFFSgaspDuDs3ZIQYffg4Q3Ys8rCvfwcgg>
Received: from localhost (ppp121-44-213-17.bras1.syd2.internode.on.net [121.44.213.17])
        by mail.messagingengine.com (Postfix) with ESMTPA id 846971025C;
        Thu,  9 Aug 2018 21:46:39 -0400 (EDT)
Date:   Fri, 10 Aug 2018 11:46:36 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/4] Convert filter.txt to RST
Message-ID: <20180810014636.GJ32374@eros>
References: <20180809052328.27942-1-me@tobin.cc>
 <20180809060734.rtqqu4sexbwzuqmm@ast-mbp>
 <20180809072753.GF32374@eros>
 <80bdc251-9f57-602f-6536-b34651684bb7@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80bdc251-9f57-602f-6536-b34651684bb7@iogearbox.net>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 10:24:54AM +0200, Daniel Borkmann wrote:
> On 08/09/2018 09:27 AM, Tobin C. Harding wrote:
> > On Wed, Aug 08, 2018 at 11:07:35PM -0700, Alexei Starovoitov wrote:
> >> On Thu, Aug 09, 2018 at 03:23:24PM +1000, Tobin C. Harding wrote:
> >>>
> >>> Daniel and Alexei, can I please have permission to add GPLv2+ to the BPF
> >>> docs?
> >>
> >> kernel licensing is GPLv2 without +
> > 
> > According to process/license-rules.rst
> > 
> > 	    GPL-2.0+  :  GNU General Public License v2.0 or later
> 
> Not really, please see the first three paragraphs of process/license-rules.rst.
> The COPYING file of the kernel says that it's 'v2' and not 'v2 or later',
> unless otherwise _explicitly_ noted. Given that and given there is no other
> specific note in filter.txt, it would mean it's v2-only due to that rule.

Thanks for clarifying.  My understanding is now; this is a case where
checkpatch is too verbose and we do not actually need to add a specific
license identifier to the documentation files (new or otherwise).  They
get an implicit GPLv2.

I'll remove the licences identifiers and re-spin.

thanks,
Tobin.
