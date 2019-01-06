Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BC9C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5D721873
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="WxdBUMYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfAFI0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 03:26:16 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:31550 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfAFI0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 03:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1546763173;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=o4hqZQt0eUakSoo/AJwStiA6SrqHVjgeUpm9HGtdVcg=;
        b=WxdBUMYECBs6+zxumwy/7jTEMcLBkyO8Xf+RbN++fzM/W4abiQxDCCdWP9r0kl7IjL
        pPTpxzB8SDUhhl1rilj0z59bN3vl5aykueOIydAcEPTojObdiWswBBY8ktg1gxV666MR
        VpI3f2n3N8NLW62ze45TMiATes7z6t0qMQoEVg0Oz8PPQ3fA4BGCk/RK9gxyTaO8Tprj
        uTUQQfcJrK8/1kJMaXX9mw9fbxOz6WVh6UygLC7/K+f209DyTzRdDWk5lsBieqPPe6e0
        RykY//M9iNiWBynWgeJprNdW21MEyiJkMFPdMmnbGAYsecOAmWqom5pA9g70XD4EvQAD
        mFMw==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPbI/Scimcp"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 309bcfv068Pw7qR
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 6 Jan 2019 09:25:58 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Stephan Mueller <smueller@chronox.de>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, keyrings@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Date:   Sun, 06 Jan 2019 09:25:57 +0100
Message-ID: <7661280.VaQ99ZmoaG@tauon.chronox.de>
In-Reply-To: <4539995.kc8yiMsNgQ@tauon.chronox.de>
References: <20190103143227.9138-1-jlee@suse.com> <20190103143227.9138-2-jlee@suse.com> <4539995.kc8yiMsNgQ@tauon.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 6. Januar 2019, 09:01:27 CET schrieb Stephan Mueller:

Hi,

> > +	memcpy(skey.key, ukp->data, ukp->datalen);
> 
> Where would skey.key be destroyed again?

Now I see it - it is in patch 4. Please disregard my comment.

Ciao
Stephan


