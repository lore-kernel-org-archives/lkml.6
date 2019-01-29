Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F552C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E98F20844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EZ4xAFQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbfA2Ic1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:32:27 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32875 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfA2Ic0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:32:26 -0500
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so16754440ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 00:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2AxdUIGC1kTdKpFS1Vqyter9qGjQHMLHKNI/Zd8VHNw=;
        b=EZ4xAFQHUfdh3NtWFqaaHj4EKiVEKs6t0FAo3ha3uWObPsCckbKnM4gvTH7vN8U08c
         OMR+VUoKETPt14nCyzcss+E4kDPE04mBk9tQDbYVEkCF2l8FoVoVqBAKmjjOjUPGCZgL
         CzMpRbn1oPERQH/38+BzlHbenVsI5aYEwpJjaSVAIRiIlRsqiCjVYqTNu8OomiphTkOB
         qyzDc2Ct2Ku81j6cpzXGNBFucTZOrvBfk1fVcC0OuYLr/70xVZJgHch718FsWsh1G3ZF
         nFkqczmN5eofidpdJmlTcQvyDW6tcZ+cRPGS1SuVGV/BJgcDwHun0H613uu/EVM+YkmZ
         CpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2AxdUIGC1kTdKpFS1Vqyter9qGjQHMLHKNI/Zd8VHNw=;
        b=CUGtuWsbhvACDDxaswQcimMihi+xOxd2jwWeuPoO8hn9oEJ9LcQ1CT3aBl8OxuLSXB
         VKk0z6EDX4zx6KHMo0i8ZbrvcmlRAHihsj39FESokGJtoZ839mBzu6vt3J6YnmWWYgNS
         4G8kVOXPLxLMUAQf1r/rzfp/QjgMbSARVUmLg9ARhDwgZBB/yzSTHfIf7eNrMncHuIZ5
         PmhDWS9FMr8xIju2mbDwMbOr2JGqaiKFhoShgOzCwodVxE4BZUt3Un9bAG7WOh4qNjuX
         1oP7mYHNsX13cU/C9bpZZ+setJo+9nHphnNwThfZODZcBQdmZ5VIRAcwsYpp4jB0FMX3
         5qPQ==
X-Gm-Message-State: AJcUukdUu6aJuFREJNkmYkwUERq1dPCIvtXm+EN1CRHmXjBiySWMGI86
        caU3Rwor2+RfYyq6zuWaEfKSU/vgeNS9iaDV0vB88g==
X-Google-Smtp-Source: AHgI3IabsiEWA43N+pfZuwc2pWmjT1YnlKHrx3N0ys6MM3VDE/q89YoLGxYGD6F3bgb0Z0hPS7tur3mKhfcemr/qkng=
X-Received: by 2002:a2e:744:: with SMTP id i4-v6mr13935535ljd.140.1548750744314;
 Tue, 29 Jan 2019 00:32:24 -0800 (PST)
MIME-Version: 1.0
References: <20190109021112.5836-1-rkir@google.com> <20190109021112.5836-2-rkir@google.com>
 <20190122110712.GA1004@kroah.com>
In-Reply-To: <20190122110712.GA1004@kroah.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Tue, 29 Jan 2019 00:32:12 -0800
Message-ID: <CAOGAQeo1Kv55EUn2sYPOt9EgBMfN=+o_A4KOPVgqbJHo+HN-Sw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drivers: platform: goldfish: goldfish_address_space:
 add a driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> How does QEMU do this today?  There isn't a virtio or some other virtual
> memory device that allows memory regions to be shared?  I can't believe
> that there isn't one yet.  If not, then this should be some kind of
> "generic" QEMU memory device, not a "goldfish" specific one, right?

I also thought this should not be something unique to us. So I asked
in our internal mailing list, I heard nothing back.

> Please work with the QEMU developers on this, I need their ack before I
> can take something like this.

This is a good point. I asked there (nothing since 1/24):

http://lists.nongnu.org/archive/html/qemu-discuss/2019-01/msg00055.html

When we were working on our device side, we had to change some QEMU
code and later noticed that HAXM also requires some fixes (we had
meetings with Intel). I suppose QEMU does not have this feature yet.

Could you please tell if we can proceed with upstreaming as is?

Regards,
Roman.
