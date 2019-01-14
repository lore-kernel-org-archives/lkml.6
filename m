Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03206C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C416120660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Nu1Ma85D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfANJPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:15:13 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42358 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbfANJPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:15:12 -0500
Received: from zn.tnic (p200300EC2BC4CA00116FEC2D9C4463FB.dip0.t-ipconnect.de [IPv6:2003:ec:2bc4:ca00:116f:ec2d:9c44:63fb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6D3EE1EC058B;
        Mon, 14 Jan 2019 10:15:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547457311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4Cyw5tVjqr6oJq6X5bdMCiAtpamEVubIioeHcGN2Fcg=;
        b=Nu1Ma85DzE/D4XYru3fDyGynddKRL+tyVikMssiBryDIGAuVLAbWueRSN5OKqhhe2X70zG
        HkQYEwzNTQpSZ3rzZW+6+to/mXjQ9377FPVvYk8U3BMdXJ5jGpBhFOY3OUCTystuYJGQhN
        CI2lasGYUFpkUodj89Q9iXyoCnwLxdI=
Date:   Mon, 14 Jan 2019 10:15:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        k-hagio@ab.jp.nec.com, anderson@redhat.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
Message-ID: <20190114091509.GC2773@zn.tnic>
References: <20190110121944.6050-1-lijiang@redhat.com>
 <20190110121944.6050-2-lijiang@redhat.com>
 <20190111145650.GG4729@zn.tnic>
 <be8fbb64-7748-c7da-55f7-99fe69796a94@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be8fbb64-7748-c7da-55f7-99fe69796a94@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 01:30:30PM +0800, lijiang wrote:
> I noticed that the checkpatch was coded in Perl. But i am not familiar with
> the Perl program language, that would be beyond my ability to do this, i have
> to learn the Perl program language step by step. :-)

You could give it a try - it is not hard :-)

And there's no hurry for this, take your time.

> Do you mean this one 'KERNEL_IMAGE_SIZE'?

I mean, all those which are unused. Optimally, you should look at the
tools and see whether they're using those exports and if not, remove
them. But no hurry here too, take your time.

My final goal is to have this up-to-date documentation of what is
exported and what is used by user tools so that people can look at it
first before carelessly exporting yet another thing.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
