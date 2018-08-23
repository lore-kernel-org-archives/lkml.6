Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203E6C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25B52147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="tdnSqTWe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OGyHlwNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25B52147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbeHWVaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 17:30:46 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46257 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726547AbeHWVaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 17:30:46 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id F0EFA21C2E;
        Thu, 23 Aug 2018 13:59:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 23 Aug 2018 13:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=3PTGEVf5PAEE7mxqNGSLwmQ3pyoYqx1dEeHni+a+F4Y=; b=tdnSqTWe
        Fei7wsu9wUcSOp5uLuCZfVCJP5L6xFxRyVidvkx5ZfN1SaYmfWtjd0dgmk4kS8M0
        aW3rktagT9XtJvKVCPbKn6A5GbVp9DfofY4nN8uoK9yJvuC4cYaBN6pqbYB7ZOlg
        V6N/G4fzvzkNaK/h6j0A9YVv8oJeJkf40v+38uWuMDzFBxmpuFVJCeX7AMJ9+j/4
        bO5y07QkQB7PFqvmqU3nP9B+7m82dVmv9R+6PVX3kLewjSjo0PzJQ0El9+/gyq7t
        OmJDl4A4ETIoQbW1hMkb9DoolLzuCzUCbcNUMnhXCvv48e7zGx87ojuPdlOf0Ry7
        Z7EoYlxfsDdZpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=3PTGEVf5PAEE7mxqNGSLwmQ3pyoYq
        x1dEeHni+a+F4Y=; b=OGyHlwNvpFXTfi4TUD77oIiiWUjAWhDcTpshHtZEjhxxb
        EYd44cynOHqFma3PysGZ4j5nlbL7QRsnpi3lti/cItBhM4+gldpSPzKJUOIqqDDE
        RL3WpYm23tU4XyOthRORdCHPvOdAaoHW8oVuV9WHh0s3GUR3/YXQ/oqlEOXY4Y9H
        UA3uqpvA1it3j0HZpdPXsqUahk5iC7R+Q2xV6auKCM1OiO29wLy9Hi3rVlUghA2/
        0yP3xheJ3b5KiBVy6cuaZ7A3Lck4+zSvhGARrQsock62LDj0XoG+VN+CWruOcxL+
        PKhj3mxVlFlm4BUa7iMEU8vy8AiUvubEyUJnK81SA==
X-ME-Proxy: <xmx:GPZ-W0aQeWSFLLt0x6o1XZAvYDtzfgntSOyrKn6VFbfIsAoEQQe0jA>
    <xmx:GPZ-W4aHXqVIAI-cwf_1-L7yiVYt_AwnCj5XZlrzQ9vnlkgH5E6aIw>
    <xmx:GPZ-W7vOTDph43PMX0Kr0qo0WiXE6TnpOv5YFaZ1kD_FxlsSFWTlgA>
    <xmx:GPZ-W8-OOhbnfn0D0HzFv2umun2MOd8JVTvqYMCvFLMPUXHj8hgKCg>
    <xmx:GPZ-WweyeFXxCPXol3LAWuMbiI25Z3Zl9tPMKlZiSnQKiviYwGOoFg>
    <xmx:GvZ-WyMzpPV3UCFSIEpW2LtTZcyjowzK_g4_aVYXkDTVIV_np4SBFQ>
X-ME-Sender: <xms:GPZ-W426vY-C-ipxkNBBWHKlWjsPFOdjWCQBmRdb5cfJoCWpdWh5sw>
Received: from localhost (5355525a.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.messagingengine.com (Postfix) with ESMTPA id B661A10291;
        Thu, 23 Aug 2018 13:59:51 -0400 (EDT)
Date:   Thu, 23 Aug 2018 19:59:49 +0200
From:   Greg KH <greg@kroah.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jessica Yu <jeyu@kernel.org>,
        Chih-Wei Huang <cwhuang@linux.org.tw>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH v2] modules_install: make missing $DEPMOD a warning
 instead of error
Message-ID: <20180823175949.GB14106@kroah.com>
References: <490A46D5-834E-46A9-9106-A31F94344F99@goldelico.com>
 <d5093e14-c826-9183-cd94-ecb99a799fc8@infradead.org>
 <CAK7LNAQDRj7aKMNqkTL3XxbsFHUuYwOaPn8buh=b9O9+CaKjig@mail.gmail.com>
 <61369202-8425-4cb7-aa9d-b83f15c528e0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61369202-8425-4cb7-aa9d-b83f15c528e0@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 10:52:39AM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> When $DEPMOD is not found, only print a warning instead of exiting
> with an error message and error status.
> 
> Warning: 'make modules_install' requires /sbin/depmod. Please install it.
> This is probably in the kmod package.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v2: add missing "exit 0" and update the commit message (no Error).

You need a cc: stable in here too :(
