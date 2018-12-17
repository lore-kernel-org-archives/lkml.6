Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76E5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0A2214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="RuE8Du49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387753AbeLQUff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:35:35 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34786 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbeLQUfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:35:34 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so6949485pfg.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 12:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6AgDmzoxlwfYO3E3FfNbM/qMUiM2v65TmXBk7SuPY7I=;
        b=RuE8Du49uLfmRj0sjDzWf6vAd3GD+ThkejmeSWVi0ycwQWwvpYXVCyzQZT4U3M5Wts
         KBeMSqXKroR3bN5Y7g9TVHxugvW3/5eFN2YGkTijUBLYv1XwIyNLGVfKr39jOqXFbx81
         2Jmsa0F0aL6hBscT3o/9NWcQoFaN1yZIwtNmfZFD6/waDkRtFzVgsNnX6rKdxTXam1Tn
         QcnxeqnXTP6DIvy4XZo2KnNQAXoW/6I+Oeg41Wn05FZwg4a+z5sJ6dRnMpvxR8uuyHFc
         1Qb1Iu43OdKxGT4Oh6fGCW2uCsCshwEVc8CGbekMxnHTBK4mrGEIGF09DyMRl8KFtZM0
         lHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6AgDmzoxlwfYO3E3FfNbM/qMUiM2v65TmXBk7SuPY7I=;
        b=n6lgxyZMuPg/bJavVOQrN8cDAG3ttXkza/5WqKTP8J226IXDBEE86P5K+8dluvg3Ob
         lsRQCNerzu7Ii/BMVUSbimaVvZ0VHwsDBAZIHdsf3yG4+3MSEcnl7k8JlhRmRifjseTZ
         lNW+zS/baebInTGXfJqecZ3NETtu58/02pFAy+lY5l8sz4HKVtJ93wd43R4DADYxO2vJ
         cXVc1NbLk3rvzwa78z+0Jbqk6Uq4945yN2JGojXg21qcD/ODeP4dEhXHuZAn0Ylw0zCp
         CvcVT+FRdKLbacWItzJTx0Hk/Z0jdXJ/lhRrRvIO3YkE3Lu4bZP2nLr2RGK25h6O1459
         J1Ig==
X-Gm-Message-State: AA+aEWYvTyHLoQkf2GPsPqI1MRwnsC2ao/JXI3t1oivA1GWFJtKfQfcO
        BcB2qX6bIUCVq8ijMYoIF4EshA==
X-Google-Smtp-Source: AFSGD/VYczsxtVzc1IHnhRUqVEs6Wb+LJ/euAxF0Zptj+Yg7SljAPl66mFkseAi3YdavqRtN1ZXhAQ==
X-Received: by 2002:a63:cf48:: with SMTP id b8mr13541348pgj.17.1545078933761;
        Mon, 17 Dec 2018 12:35:33 -0800 (PST)
Received: from xeon-e3 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id j21sm18531113pfn.175.2018.12.17.12.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 12:35:33 -0800 (PST)
Date:   Mon, 17 Dec 2018 12:35:31 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'devel@linuxdriverproject.org'" <devel@linuxdriverproject.org>,
        vkuznets <vkuznets@redhat.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Return -EINVAL for the sys files
 for unopened channels
Message-ID: <20181217123531.71a4f3d4@xeon-e3>
In-Reply-To: <PU1P153MB0169F16082CBD9FD9F0457B1BFBC0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB0169DDAA2CBC2901505AE692BFA00@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
        <20181217091518.5004d4c7@xeon-e3>
        <PU1P153MB0169725E468897F135F2155BBFBC0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
        <20181217101703.78e8bb3f@xeon-e3>
        <PU1P153MB016981FD2D1CF90635DCE562BFBC0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
        <PU1P153MB0169F16082CBD9FD9F0457B1BFBC0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 18:44:12 +0000
Dexuan Cui <decui@microsoft.com> wrote:

> > From: devel <driverdev-devel-bounces@linuxdriverproject.org> On Behalf Of
> > Dexuan Cui
> > Sent: Monday, December 17, 2018 10:31 AM  
> > > From: Stephen Hemminger <stephen@networkplumber.org>
> > >
> > > The old code was risky because it would silently return stack garbage.
> > > Having an error check in get_debuginfo would eliminate that.  
> > 
> > OK, then let me make another patch based on the latest char-misc-linus.
> > 
> > -- Dexuan  
> 
> Hi Stephen, your patch can apply cleanly. Let me rebase your patch to
> char-misc-linus, do a test, and then post it with your Signed-off-by and mine: 
> I assume you're Ok with this. Please let me know in case it's not. :-)
> 
> Thanks,
> -- Dexuan

Sure.
