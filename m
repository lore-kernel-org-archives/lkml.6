Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2510764-1520530761-2-5345298854524910416
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520530760; b=sS6xibpqwvPBExRbrP0YIS+nfyeCmvb2iIRBiSjitF+gI4d
    j3urAdZ6pYm1QNuj6kBc4NaEgCdEBf0zVtvW+ADDRRhD4DK8MpvULUflUA9i8lmY
    0H5+fJ68fPZer5vetkEnovnSjTGmIg1Ai26HAJovbP/D81VMHVdvrQcKJLsqQEXH
    iZCb8G2+hF1GI18aG7aeIukquqMaXLS/W+pg2fBp9L++/zJYyHFzMvpHIhnS9y7H
    ZYJskktxvKXwVWeOuV9du/5GIZnr+IaThfqgQz2wKloV/GEYuJc1pFLiABjy6pxN
    5CnX9YtvtVR48ybBNmp5zzl43IOIoHIO3iKYVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520530760; bh=iJPJgBaqsymSsVltkE3Bxhms/t
    lN2rB5q9PGswNjTYs=; b=vI5YU3tKz16udOT5xppKx73fxasycxvw0LVqZpxf0I
    rRvA7FW3WLfjEG6oF6YN2WHqGD2kjsk4OUUKLgdzohJi6KszqWl6lhU4l5ZtNhgS
    cxbX9dQPYsDz4SjVon1EUDslcXPkR/2U2hBUGDj7Fw49Yd22Nrc/OADC/4naX3tz
    rsZTQsiJblpn/S9lyxF1MO8MBaXZc9ZP0S9bcPr8SA4NNS1NpcADfS7o2S1R+0dx
    6rkAXL8dj0sRkc5FrrZ5pfLVTgFG2sd4oIZ7bMz8SBEzaTJ24IKQVfRiPmOyHceD
    UdQXgrjsewmTwSD1rP4t04wVYROr6l6Rll+NvOpMs/NA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=R15WqooH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=R15WqooH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935995AbeCHRjR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 12:39:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37388 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932137AbeCHRjQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 12:39:16 -0500
Date: Thu, 8 Mar 2018 09:39:14 -0800
From: Darren Hart <dvhart@infradead.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Santeri Toivonen <santeri.toivonen@vatsul.com>
Subject: Re: [PATCH AUTOSEL for 4.9 025/190] platform/x86: asus-nb-wmi: Add
 wapf4 quirk for the X302UA
Message-ID: <20180308173914.GC11045@localhost.localdomain>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
 <20180308045810.8041-25-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308045810.8041-25-alexander.levin@microsoft.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 04:59:01AM +0000, Sasha Levin wrote:
> From: Santeri Toivonen <santeri.toivonen@vatsul.com>
> 
> [ Upstream commit f35823619db8bbaa2afea8705f239c3cecb9d22f ]
> 
> Asus laptop X302UA starts up with Wi-Fi disabled,
> without a way to enable it. Set wapf=4 to fix the problem.
> 
> Signed-off-by: Santeri Toivonen <santeri.toivonen@vatsul.com>
> Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>

Hi Sasha,

I'm curious about this AUTOSEL tag, and what about this patch triggered
its selection?

Pulling changes like this can be risky if they aren't done sequentially,
resulting in the stable driver having a spotty patching. I don't
necessarily object to *this* patch, but in general, I want to understand
what triggers the selection of patches that maintainers have not tagged
with stable and which do not contain fixes tags.

-- 
Darren Hart
VMware Open Source Technology Center
