Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867F3ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4044220693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Z7ziaxwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4044220693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731618AbeGSJcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:32:07 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34540 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbeGSJcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:32:07 -0400
Received: by mail-oi0-f68.google.com with SMTP id 13-v6so14146840ois.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 01:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nfU7/8mZ+eGxqb06bFfTcDPB3lCODjSFRa2YZiCP82I=;
        b=Z7ziaxwOg5emIKpTT3ykZ4tjs5N9fyA7LGGx1RKm9PZ+gQcEDZoHS8UGpwwhenFFMs
         tThBrERhFWgjWQemZB0XyUVQ0e/4kJIOuUXg+jjBkd9BLGPPbYqmUoYIrjO/3tEjZFvS
         wFiMdKZq0OEAauxKfblxf0MjPiLNokY35YSI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nfU7/8mZ+eGxqb06bFfTcDPB3lCODjSFRa2YZiCP82I=;
        b=kypUpApsYeg0fDeVHZtCbojxV0NXVzpl+VjEslbYG2MFUn31qjs6eEA2REbUQraK9v
         30iZODnQauAlRkrwgRwyukEJd9gKCfdh35FL67CgZHxo0F2B7S/Ja8chTqFkEdBIU5vD
         ilnnisUw3ETE5oArGyBbk+LhEUMjTvCT0wqyqdEZ31lnkMFa4KIYZUbftcoX2G3qKzst
         cG64QOipJPOrEDcO9geZmIMbdeOebXkEJQItfzpYYtHzz3CSVZbMZpr49KO1taG6+iE6
         BQ29oalyTwMU4A4wpIw6a3CpDwddPsdYP6rtEKgZ6ZTs/Sz3zBa2vyMS8hYjslEOTxsI
         uNKg==
X-Gm-Message-State: AOUpUlEwxYY3mEOhWGsEhh7AxM08Y3IzFydb72oTDpakDOt/2rPuptB0
        kUpDTvAwDYgNxdDNhp8cUATFiPypSDx21sm7/XOxRw==
X-Google-Smtp-Source: AAOMgpe3O1nC+sW44tiv4wYfEn2SUpuzGzottoFwFlvwWOVzcBxV/SCTHpkay8ifAvPNVjxWKQWd0+mCU5nSdamI73U=
X-Received: by 2002:aca:ce0f:: with SMTP id e15-v6mr10465992oig.13.1531990200360;
 Thu, 19 Jul 2018 01:50:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:113c:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 01:49:59
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <18289.1531987758@warthog.procyon.org.uk>
References: <20180718154637.31878-1-mszeredi@redhat.com> <18289.1531987758@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 19 Jul 2018 10:49:59 +0200
Message-ID: <CAJfpegvJOXo-e5swL5iNgiyGOQHT3viz86+NMAe1zvOC0Qwaig@mail.gmail.com>
Subject: Re: [PATCH] vfs: make open_with_fake_path() not contribute to nr_files
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 10:09 AM, David Howells <dhowells@redhat.com> wrote:
> Miklos Szeredi <mszeredi@redhat.com> wrote:
>
>> Stacking file operations in overlay will store an extra open file for each
>> overlay file opened.
>>
>> The overhead is just that of "struct file" which is about 256bytes, because
>> overlay already pins an extra dentry and inode when the file is open, which
>> add up to a much larger overhead.
>>
>> For fear of breaking working setups, don't start accounting the extra file.
>
> Sounds useful for cachefiles too, though Christoph Hellwig objected strongly
> last time I tried this, so you might want to check with him directly.

What the cachefiles use case would be?

Overlayfs wants the "shadow" file open only as long as the real file
is open.  Is the cachefiles case the same?

For overlays the real cost of pinned memory by open files  is already
sunk in the layered dentry references.  Which means overlayfs is
already pinning substantially more memory for an open file than other
fs (by about a factor of 2-3, due to pinned lower and/or upper
dentries and inodes).   If this was a problem in real life, then we'd
be already be in trouble.  The stacked open file patch only adds the
overhead of the actual struct file, which is small compared to the
multiple pinned dentry and inode structs.

Christoph already commented on a previous version of the patch and I
pointed out the above.

Thanks,
Miklos
