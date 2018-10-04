Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB45C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7E4206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="t+cKSbtx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y+RkACqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7E4206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbeJEBRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:17:03 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:48599 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727407AbeJEBRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:17:03 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 90614931;
        Thu,  4 Oct 2018 14:22:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 04 Oct 2018 14:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=oP4ji2rj35Wm8QntUqMSfQwAarn
        t/USROqUBrN8I0OQ=; b=t+cKSbtxMErniTzXxFtV0/21Ii0QezUWSTTTYuWJaHG
        Zo+ZrdvCu+RPBvJP4yteU8HFM1wGt4O/NTBvHpEqqLpFCm6WbVIZZTdx2DN9Bfm7
        F6q+k9ggsQaUE5y/tVb7EUIfSIqSki4+XlrA3gvwMhxBFw+flwf18ezuzWhqhGV2
        I9HliIdBrvprerL3cVVSH1z7S1LM/fastAPdJpdsXzaQeYREurap5J3zV4Ffpayz
        nlVkBWIy41UD2xCkJr99IVQQOFLdXvcZLYmUP1OobCjxMQvcls+64/oZ7e4vElQ2
        qLel4iqW2RbCRat+jJcj08qByqxpwmuUyI8Z9tGubhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=oP4ji2
        rj35Wm8QntUqMSfQwAarnt/USROqUBrN8I0OQ=; b=Y+RkACqUzm/Hxl22rr0Eoc
        Qm3yAEeToov4vCzc/djIoKXzBqJ0nbwZoQtr8nO8yFpzCwxyo0b4Oj3QFdfWVaFq
        P4apN+HC5zSch/ztMB+X3t1JigJli+V2wsPWdq8lGsstSKUTk+60MWNj5l5p5+z6
        3dgALE4e8lOf+kJJpPgFkkMP8nUlC09EOGHJo6//6XXVXaoF45L4adPaGT2TGiWC
        wwyalZZrd/WxZk4OdqAh2D3cBccFcJezUyVPHcQQhuLPI9ajX57QV9lbU5PLcokg
        kdj1hzuVVdoOIIr6W+iglhp9M8qP/VE7qvN1veQKFm6bXlrmo+sLuIzqzdumxwoA
        ==
X-ME-Sender: <xms:aVq2W6-qVBYzWAn2Lvqx1e4OOW7znsmO0oHXoto8K8M5VgKM3kZuzA>
X-ME-Proxy: <xmx:aVq2W0B_R_6XjomL21PCjWsBsNMKHvXZygg5rXAK8evmv3ULcS9VUg>
    <xmx:aVq2W1bVNFP8TZsRKHj_6H60cJtfgyjnpgiReZVyC589EckJXe93tw>
    <xmx:alq2W3-l6Amc8AS0TeSoB_RnrTwgIbmMt71FYlDGO1dSnss9sntR5A>
    <xmx:alq2W_yZFxuwkXRYy8YKL58BYIq2_sPPlG1xG9hzqdqatqDALk59Lg>
    <xmx:alq2W6-yU9C3ch3wSsQxah0rxcnqZgIhvhU-zxsx3zDlPhUTzeACCw>
    <xmx:a1q2Ww18Jmcpke5UqOHgFIjX1nOMeHGDGYQ64k1YLwGCjgHJWd7QaA>
Received: from localhost (unknown [104.132.1.111])
        by mail.messagingengine.com (Postfix) with ESMTPA id 373EF102E7;
        Thu,  4 Oct 2018 14:22:33 -0400 (EDT)
Date:   Thu, 4 Oct 2018 11:22:32 -0700
From:   Greg Kroah-Hartman <greg@kroah.com>
To:     Steve Sakoman <steve@sakoman.com>
Cc:     sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andreas Steinmetz <ast@domdv.de>,
        Eric C Gallimore <egallimore@ucsd.edu>
Subject: Re: linux-next: build failure after merge of the tty tree
Message-ID: <20181004182232.GB25473@kroah.com>
References: <20181004151501.280d8282@canb.auug.org.au>
 <CAOSpxdYzm6fTd88gP_OdrTuqbf-kJr3t+3ObPU9vMCHqYJSgHg@mail.gmail.com>
 <20181004170032.GA7344@kroah.com>
 <CAOSpxda1RjgBDN5mKwj8SQ5iVx-SYRMtD32-7_AO5kEwK0-acg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSpxda1RjgBDN5mKwj8SQ5iVx-SYRMtD32-7_AO5kEwK0-acg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Oct 04, 2018 at 08:13:39AM -1000, Steve Sakoman wrote:
> Hi Greg,
> 
> I sent the patch you requested to fix use of the "unused" struct
> member in samsung.c. If that looks OK to you I'll redo my
> "serial:serial_core: Allow use of CTS for PPS line discipline" patch.

I think it needs a bit of a rework, see my review comments on that
patch.

thanks,

greg k-h
