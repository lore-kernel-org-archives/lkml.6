Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F35AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCD120870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sfconservancy.org header.i=@sfconservancy.org header.b="GrwOsiMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCD120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sfconservancy.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbeJ3Hjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 03:39:37 -0400
Received: from pine.sfconservancy.org ([162.242.171.33]:45796 "EHLO
        pine.sfconservancy.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730604AbeJ3Hjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 03:39:37 -0400
X-Greylist: delayed 598 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Oct 2018 03:39:36 EDT
Received: from localhost (a79-168-5-133.cpe.netcabo.pt [79.168.5.133])
        (Authenticated sender: bkuhn)
        by pine.sfconservancy.org (Postfix) with ESMTPSA id 5A00EE477;
        Mon, 29 Oct 2018 22:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sfconservancy.org;
        s=pine; t=1540852734;
        bh=J2j4IcRAYAWx87Sf5KYAlA4mDpXi9ouQCudY3s8XhAM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GrwOsiMcIKJOM10amNjyMF0A526IOqxcqqdoVDu3ive1tSdOHCuU5mrccJ3LvCXyU
         eKPVQLUR+5iomNbTOmLrh0sxkRioM1jW4xK+gbZTs6qMsQrWnz7f4rYT8WiNOz9kQ/
         JGBk7mKuHZuYDIdY5l38ufCQzPXWBaCmXUR/3ZhhGKkkslmYnh+swK4JoQBdPNpUBE
         CU8soFXIK7JDhCYavMQzkiGG0VurwpiqtTaoH9Pobwcsw6rKdpX55Cd/NkSeBXveiq
         jxUXpFo7SSWHB8yb9YgxWRDgKJnC7tI1Ao+5CPEILJ6iNjnUV4SGnZ2zCuZCSEs9uf
         ZDxFdoM69lPuw==
From:   "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
To:     ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Laura Abbott <labbott@redhat.com>, editor@lwn.net,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Chris Mason <clm@fb.com>,
        bruce@perens.com
Subject: Re: The linux devs can rescind their license grant.
In-Reply-To: <20181025081911.GB11343@kroah.com>
Organization: Software Freedom Conservancy
References: <185b786a2bd6e8d527dca161dc42e4f1@redchan.it> <20181025081911.GB11343@kroah.com>
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEVAKiCGSDptUUeJe3eu
 eGm7dGzcopjFce4jAAACdklEQVQ4y2WUwZKbMAyGjZPesWt6xg7dcxbonmNW+Fx2MPdujN//EfrL
 2XabVElmGEufflkSEQ4mu5Eo5GIvgQSfCdf3bUcpf1q6yL7v2StGCuHv+ZZ7yYdwyjsg56u4Ee3x
 X4BVWlmIlijdIywiuKZAYfsX6Qtxlo9AfhdMtBJ3uBPJg5A34hG5tg6EOI7hgaBCtO4/jXQjJD0S
 fJEbcQ/kKy4iTuLYIZ4/n8RZngT3Nj8aE6iKMA1Y2LYtkDEdhZ6Jc0feWqX8inJ8rdwr0TuIAzS0
 1LpSTcikdUc0vkyHojFZN71O1m45lZxpOn/vhWxBONONWpuxB9yZMDkF4uJo8q4dntsxX/zkiPL1
 6t+Eq4V4MsY9Kf0lT2PpQqL5VTzXlvCEfk0dNG5NSPubsMqEpzBD0zc5Unjhm6cfIBQK5Kjdx7yv
 /JBymifRKXPbwlXNuDrNcd5yCKhq6SjSvu/LuhYwsgahuyAQFePczLyGG/ZlCwbEs6Y173lfGhAg
 i8o0iJM7dDMHNo1B8hiZoK+DGHpFEWH7EhdKc/6F2m5EX5kmbtvcKFE1zUYoLpIuhPdxT2v8WVfe
 r+my7msqjkqpZo7Ga6UqqZQ+og2HQliH/NZbZWtr8VuTZ2KQRhtSlVEcruoKnSjE0FrfLXWtFL5q
 ER6NXhw7RGWYEBWL+QYTmT3fYzhbQpT3yifuVEqJ/GtJhfTfAs1NhGGzQuj0qRC1BYEZ5L1MD7Qd
 2IFNUcYEInQLk0FNRn84lMX+IrNVxAT5U3HgjcMC4j/EYPwgxr4+3BytsHYCkooUyHb445AaIjnM
 WN9sRi0/HGcBhFX4XUx+atnxG85wHO8ZbYsqAAAAAElFTkSuQmCC
Date:   Mon, 29 Oct 2018 22:31:46 +0000
Message-ID: <87a7mwz8od.fsf@ebb.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 07:56:26AM +0000, visionsofalice@redchan.it wrote:
> The linux devs can rescind their license grant.
Greg KH responded on Thu, 25 Oct 2018 09:19:11 +0100:
>> No they can not, please do not keep spreading false information.

I was explicitly cc'ed on this thread by visionsofalice.  I've read the
whole thread, and the only useful thing I can contribute here is to agree
with Greg and additionally provide some backup research on the point:
https://sfconservancy.org/news/2018/sep/26/GPLv2-irrevocability/

Software Freedom Conservancy engaged our legal counsel to write a new
section for the Copyleft Guide that further explains the irrevocability of
GPLv2.  We published this when others raised these specious claims back in
September.  Direct link to new section:
https://copyleft.org/guide/comprehensive-gpl-guidech8.html#x11-540007.4


HTH,
-- 
Bradley M. Kuhn
Distinguished Technologist of Software Freedom Conservancy
========================================================================
Become a Conservancy Supporter today: https://sfconservancy.org/supporter
