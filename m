Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-333886-1519829271-2-11078366455140523251
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519829270; b=cmVWEjkBVGM0uePKgu17mop+rpDAEMPDvzin0pcKUh+1B9X
    r5Urj9uXZx5Ww4MSzL6lLpR+jduyLwzPlV+iVVEr/JbLeawWuJT7lW1BcS3u7JJV
    fAIzZDXKnrfYIOCAyZLP2ipoi4ARsyhsEJqzZIP+UYMUGBdSd3t/K+DVK6aWVdXM
    g6RPPkrCLsuLCHdScbWhfkPN3cKrzWBJ5xg3VZRchlueo4ps9E75MIfbquX0sLIn
    n0fSyWS6KWkf7KIZpQtLt18RAiicfxfzsjamOaU86h4/EweczUX/VJIAaCRdIyMO
    sQw6JRaGqpkF24hg7t2a/bAcqZ+b0fO3oCEihcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519829270; bh=gyFNCuXONipMnFcU9lhW59Cshz
    OTiplpguMxZSU+BLM=; b=uarzbN9U4/RduH/+fz2cwKVyIJPlnsXC8POtcKirk8
    kizuD+r16LR32KgXQcInokeWRxjieMnucUHGBiK3TrqpGuIYNgFj9WbBY/5N68DE
    85u9AuJu8vkcz65nyhF3pkUc6dzk7x8BiBMGUq+t22+cydkp2kdtN6X6q4r1ZfMD
    Yyu43dFqIl+LF0HioRkkSy2tYAcfM/RDmkSJpdvvTijBwI8Jdg6KMTfS8kUZimGQ
    cIIaoewR2tx1JC+IrOZH3GoZrfC5/cTXs3VrLxOeE737cBdJYff3fu6JUG8xbphJ
    2SovyMIin0CoV+ZJazhOOq8RROTgb4WabLqCJ/XH5qyg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=BbFFlaRD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=BbFFlaRD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752722AbeB1Orf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 09:47:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38332 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752700AbeB1Ord (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 28 Feb 2018 09:47:33 -0500
Date: Wed, 28 Feb 2018 06:47:29 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: gregkh@linuxfoundation.org, oneukum@suse.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v4] usb: core: Add "quirks" parameter for usbcore
Message-ID: <20180228144729.GE20414@bombadil.infradead.org>
References: <20180226150457.22299-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226150457.22299-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 11:04:57PM +0800, Kai-Heng Feng wrote:
> +static char quirks_param[128];
> +module_param_string(quirks, quirks_param, sizeof(quirks_param), 0644);
> +MODULE_PARM_DESC(quirks, "Add/modify USB quirks by specifying quirks=vendorID:productID:quirks");
> +
> +static char quirks_param_orig[128];

> +static u32 usb_detect_dynamic_quirks(struct usb_device *udev)
> +{
> +	u16 vid = le16_to_cpu(udev->descriptor.idVendor);
> +	u16 pid = le16_to_cpu(udev->descriptor.idProduct);
> +	struct quirk_entry *quirk;
> +
> +	mutex_lock(&quirk_mutex);
> +	if (strcmp(quirks_param, quirks_param_orig) != 0) {
> +		strcpy(quirks_param_orig, quirks_param);

What happens if the user is writing to quirks_param at the same time
that you memcpy it?

I think you're going about this wrong by trying to use the
module_param_string machinery.  You should be using module_param_cb()
to build the quirks list when the user writes it (and then translate
back into a string when the user wants to read from it.
Also, you won't need to use a linked list for this; you can just allocate
an array of quirks.

