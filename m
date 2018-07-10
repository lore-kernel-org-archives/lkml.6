Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7C2C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E545220A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cUZUUY5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E545220A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732402AbeGJX5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 19:57:19 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34608 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732376AbeGJX5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 19:57:18 -0400
Received: by mail-io0-f193.google.com with SMTP id l7-v6so22032463ioj.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 16:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eA++RSwaWsjKqHuV04jgKeSrdxFbxsHUBVq6lEAJ+bo=;
        b=cUZUUY5KQkkFUHNm1R0KGk1LxT8pMRNa0KLGufWnruQBKrE+2frE9i1yL9wKMHJonI
         mpx8orOorPPm0oMgeU1ZH6xIpM28YZiP5393boAltqGegj7lDnomiiilMWpQcmO7H5jF
         PKp0EFJwNkpQxHv3FRhTfUNu1EqORMnSssRFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eA++RSwaWsjKqHuV04jgKeSrdxFbxsHUBVq6lEAJ+bo=;
        b=HUASj0Vp9OBNjWwzYe/YhCEA6i6q/361VfFEWZpkc2Gh19bhf27xoM6K4RHhtxsyAm
         tpVS+vPCTNf/bhraRie3UvkHEPZ9ZdSD9AD0s13QjSisR5lP7ntvHcmwSwOuTVI6du5Z
         AyYwMMC00qt+ZV++CAigzvtEzfaJnvPeVxVdQhaBES2qy5A9bS+z1EPScOvLudIZ0WAc
         1orcah2bvWajsoS8Ufyad5Nurz95oWUG84iM8Qh3/EQzGPeuRAYUXNpBiumcCIRNJVLf
         vn7CS3DQTH7cWK5+1tOs6e0VGF5U8vjEQQJU57+L6c1JHbSdMRwkiSTiJvQCRLalC/Cs
         kHXQ==
X-Gm-Message-State: APt69E1+tPRhr3ygnk96OEwQPhXrYy+c8jkpwY+m2uQjp5nTe/XvF+2L
        Aqq9JOOKtw9pG8vJV9pETuS3f/MUtuRuQBjY6n8=
X-Google-Smtp-Source: AAOMgpcO26fa3IKIMHtFghj8CF25zUhxGcJMNIlIW5hmvJw0WPzJC5A5UxabkJvd076y2NCazAjysB5WdcCzOnEifMc=
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr7506535iom.238.1531266948818;
 Tue, 10 Jul 2018 16:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
 <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
 <828fb935c0cd04e74a09b8ed2b78aca405d7c5b2.camel@kernel.crashing.org>
 <CA+55aFwg+j60ZFi7t7kVXbobCT4XHoiZP_w6+Cbm+AeU1ytfNQ@mail.gmail.com>
 <20180707164838.GC16279@kroah.com> <c105fb1ff12533b4980098ecd411089e0630b6bf.camel@kernel.crashing.org>
 <20180710145549.GB11703@kroah.com> <c9e513337a1792af7e86b0646b218a1f0a3c379f.camel@kernel.crashing.org>
In-Reply-To: <c9e513337a1792af7e86b0646b218a1f0a3c379f.camel@kernel.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Jul 2018 16:55:37 -0700
Message-ID: <CA+55aFwWq1pMzKbkgTN9f9srSHubq+tKKPHwZazqt8ODD3btNQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers: core: Don't try to use a dead glue_dir
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 4:32 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> > I like that fix, which should make this patch obsolete, right?
>
> Yes, for that specific issue, but Linus seemed to think patch 1 was the
> "right thing to do" regardless...

I would definitely prefer either a kobject_get_unless_zero() or a
warning if it is ever zero.

The fact that right now it silently can do known bad things, and then
causes odd corruption _later_, is not good.

            Linus
