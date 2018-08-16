Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209D3C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1B6205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jidanni.org header.i=@jidanni.org header.b="R+kqwC4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1B6205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jidanni.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbeHQM0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:26:47 -0400
Received: from pdx1-sub0-mail-fallback-a1.dreamhost.com ([64.90.62.138]:45390
        "EHLO pdx1-sub0-mail-fallback-a1.g.dreamhost.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbeHQM0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:26:47 -0400
X-Greylist: delayed 43361 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Aug 2018 08:26:47 EDT
Received: from homiemail-a38.g.dreamhost.com (mail0898.sd.dreamhost.com [10.50.0.187])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pdx1-sub0-mail-fallback-a1.g.dreamhost.com (Postfix) with ESMTPS id EAD26287C49
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 14:23:22 -0700 (PDT)
Received: from homiemail-a38.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a38.g.dreamhost.com (Postfix) with ESMTP id CAD5A10AFBD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 14:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jidanni.org; h=from:to
        :subject:date:message-id:mime-version:content-type; s=
        jidanni.org; bh=4La7RXlUv8dszE3LGLLFbZKN+zA=; b=R+kqwC4+DVvZoMSL
        oEb81FfknSOJhnLbXhq4c87WJhsa8HB79WgqUnZeFH/sHxEbIZZ5lbBuSO14Ljmy
        S72z7h+MpTV2pHveMj70K+WTRV47jnrTJ6wgLNJvnpK9EDmmrOnZU6IcF3bgDhGG
        v3+fyeRBuCz5+wZhYF1pBldThHI=
Received: from jidanni.org (114-41-8-34.dynamic-ip.hinet.net [114.41.8.34])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jidanni@jidanni.org)
        by homiemail-a38.g.dreamhost.com (Postfix) with ESMTPSA id 870AF10AFB5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 14:22:51 -0700 (PDT)
From:   Dan Jacobson <jidanni@jidanni.org>
To:     linux-kernel@vger.kernel.org
Subject: Say what the -[ cut here ]- lines are called
Date:   Fri, 17 Aug 2018 05:09:10 +0800
Message-ID: <878t56rpc9.fsf@jidanni.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel should really say what the
------------[ cut here ]------------
lines are called, else users will say things like:

"I discovered that the user needs to use xrandr in _two_ steps for
certain resolutions, else he will trigger a
kernel:  ------------[ cut here ]------------ line."

instead of
"...will trigger a kernel problem."
"...will trigger a kernel fault."
"...will trigger a kernel oops."
or whatever it is supposed to be called.

So say e.g.,
------------[ cut here ]------------
Kernel fault:

etc. there in the syslog. Thanks.
