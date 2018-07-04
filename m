Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1416C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91386240B8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jidanni.org header.i=@jidanni.org header.b="fd7yFcok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91386240B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jidanni.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753021AbeGDVWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:22:32 -0400
Received: from homie.mail.dreamhost.com ([208.97.132.208]:59878 "EHLO
        homiemail-a7.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752819AbeGDVWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:22:31 -0400
X-Greylist: delayed 132549 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Jul 2018 17:22:31 EDT
Received: from homiemail-a7.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a7.g.dreamhost.com (Postfix) with ESMTP id E194125C06D;
        Wed,  4 Jul 2018 14:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jidanni.org; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=jidanni.org; bh=sNxPQ2wd2jFAJAbOsJ7BmlgWyLw=; b=fd7yFcok4Q6Zb
        46bv02mtLfNAO1EkBM5ZbprP2cAarkljhNq0fU2fgOznlZTu/mjMxGenuW5FXRzp
        zi1ByLetfFT3cjT85mJDuGBHcpSJHcRh6XOimVCBmV1nUpb7kL256SnhJC4oE38K
        X/NDVxS8I/OwVQ/1WLprlw26tc06qs=
Received: from jidanni.org (27-52-34-48.adsl.fetnet.net [27.52.34.48])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jidanni@jidanni.org)
        by homiemail-a7.g.dreamhost.com (Postfix) with ESMTPSA id 6999425C06B;
        Wed,  4 Jul 2018 14:22:30 -0700 (PDT)
From:   =?utf-8?B?56mN5Li55bC8?= Dan Jacobson <jidanni@jidanni.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: recvmsg bug not clear
References: <87601whg6r.fsf@jidanni.org>
        <97b3d0e4-7920-4462-6bc6-8cca3e57c560@infradead.org>
Date:   Thu, 05 Jul 2018 05:22:28 +0800
Message-ID: <87a7r6d7cb.fsf@jidanni.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "RD" == Randy Dunlap <rdunlap@infradead.org> writes:
RD> That's a message from net/ipv4/tcp.c

OK, but there should be something telling the user one way or the other
that the following is an error / bug message from the Linux kernel, (and
thus not some random program that the user installed), from the
component net/ipv4/tcp.c, and represents some condition that was
unexpected and should be reported to ... or is the user's own fault ...
and if he wants to google about it he is best to use ...
