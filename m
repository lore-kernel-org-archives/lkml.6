Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2989908-1520941032-2-10815388702898941487
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
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520941032; b=nD/mrnoaQhm5mFYKDv5qrIpKgvKjyibwvrCJfXz4pNdHTY5
    PGNKUtiByZfHUI8Yhg4zOHvT7Z+PWAczIORP0Bnr7FkstYcxycTQZRAgkDTr4Fur
    E0yEN0up20xF6wkt8rGF6nxJzBabBLFVwch1FcUu1vqnt5XpjCkReFe6uIHqTWrk
    OLLlTAG0SBt4Y3fF9O6QYV9ltDEwq0HB5Q0OZqaRg6ULqsZA0j9Ce5ZqaNqIKuG1
    bXE9VbM1dJICwgyNspouR0Qs618IosrRdon5esZ3zWD3/mNLYpShHNMJejt6VFk0
    SeBERWhYMyjKtlmdFhoP+J+9EgCpzG5mgUgIhtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520941032; bh=YpcHBAU29484lEbki+R0lPFPy2
    t5iDcWR8S15mSl9o4=; b=mZGpZ1bwLHKKngGA3vKs2zQ4IcgbkOdvESpRyliYEL
    knX7P7soe6Zub5w+GpsSb5kOWthsohMUZ9/zgdJDoBA6MBc2W9k4mRRVwbeRN48y
    7lnffJ1Qv9cTIWQlaeYOy3VK7cZUn2jyDJ2TNOUjzdKHBGzdx88d3fZlbi2PsrBP
    HjB0EOL396GrQdlBBaamHnfd9HxGxP00jWiwjfAFqit7+a8+lXMcRyXxwqx6nPj8
    ph1w6ijh2tCElGr3aAwblbY4e2Ku5hlkg0RiWJwzWI2pxJoEJ6CECQwBxPvBvDZx
    Vt7+Dgwb7OcEvithg1jAq1oZz8IgtUEAtLGbx4E4/krQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Wwux305i x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Wwux305i x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933019AbeCMLg6 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 07:36:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932708AbeCMLg4 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 13 Mar 2018 07:36:56 -0400
Date: Tue, 13 Mar 2018 04:36:54 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: gregkh@linuxfoundation.org, fengguang.wu@intel.com,
        oneukum@suse.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] usb: core: Add "quirks" parameter for usbcore
Message-ID: <20180313113654.GA3304@bombadil.infradead.org>
References: <20180313072619.29717-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313072619.29717-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 03:26:19PM +0800, Kai-Heng Feng wrote:
> +	usbcore.quirks=
> +			[USB] A list of quirks entries to supplement or
> +			override the built-in usb core quirk list.  List
> +			entries are separated by commas.  Each entry has
> +			the form VID:PID:Flags where VID and PID are Vendor
> +			and Product ID values (4-digit hex numbers) and
> +			Flags is a set of characters, each corresponding
> +			to a common usb core quirk flag as follows:

This doesn't really tell me that the specified quirks will be XORed with
the built-in quirks.  Maybe something like ...

			[USB] A list of quirk entries to augment the
			built-in usb core quirk list.  List entries are
			separated by commas.  Each entry has the form
			VendorID:ProductID:Flags.  The IDs are 4-digit hex
			numbers and Flags is a set of letters.  Each letter
			will change the built-in quirk; setting it if it is
			clear and clearing it if it is set.  The letters
			have the following meanings:

> +		/* Each entry consists of VID:PID:flags */
> +		field = strsep(&p, ":");
> +		if (!field)
> +			break;
> +
> +		if (kstrtou16(field, 16, &vid))
> +			break;
> +
> +		field = strsep(&p, ":");
> +		if (!field)
> +			break;
> +
> +		if (kstrtou16(field, 16, &pid))
> +			break;

Is there a reason to not use sscanf here like hid-quirks.c does? 

