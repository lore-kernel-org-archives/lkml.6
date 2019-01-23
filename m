Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0034DC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE6620861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfAWLfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:35:37 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35658 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfAWLfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 06:35:37 -0500
Received: by mail-oi1-f195.google.com with SMTP id v6so1527054oif.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 03:35:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5bzRTu5XYAfH3x/FBA1RKU19K0iuBYFrF8WPayBPOIA=;
        b=ge+ofskGL3l1FxLuuiANMraBRPMv3ce/trQgMVEX7i4tAExl3yP//KFEJ5jW28ahnh
         eQ30sYJpgUpXm1JNpt/qJcnPcdCQYYnFoWfuFY516I8qXSp/82oFacQstuPNTHqJLMlK
         lnBr+R8WAaqIiRT/WHMDpQTh1fc8oS+unuI8WDi+i2f7SryIBhylqNq13w5HT7+PJAd2
         VnzCMRZhbliwDUdPo1Ht6bVpx9BrAHoP7245fcjZEJ3CJ7ldyKe2TaYgDw9yZfA1XjWQ
         ZzfzeGMFsXC0iNObUa2mfUnlIWp8cieeBhyCCexwcafN6Wjt7YLu3z1fLnkEkODqI9r4
         UNNg==
X-Gm-Message-State: AJcUukczPLL2NJEGAOYi3dFINv7hvBvWMAOC3unrh/4KM/xG/LewijH7
        W0begbj8/NsSBoRLmPkY9Nf1Yzns/53tFIOcUY51HQ==
X-Google-Smtp-Source: ALg8bN64TBVMGzIHknXAIfewJnhaJi2zOidX2o/xXjVdK0sI7LeWkhg4pOcKFNJBV/Eda5Q/1OANgpPSZ9a3dl8fAdc=
X-Received: by 2002:a05:6808:1c7:: with SMTP id x7mr1122383oic.264.1548243336123;
 Wed, 23 Jan 2019 03:35:36 -0800 (PST)
MIME-Version: 1.0
References: <20190122152151.16139-52-gregkh@linuxfoundation.org>
In-Reply-To: <20190122152151.16139-52-gregkh@linuxfoundation.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 23 Jan 2019 12:35:24 +0100
Message-ID: <CAHc6FU5V-XNt_PrzNbQMLsDkEbMNDQrW0VQzm+Xhy8dKwQEVFg@mail.gmail.com>
Subject: Re: [PATCH] gfs: no need to check return value of debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

On Tue, 22 Jan 2019 at 16:24, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>
> There is no need to save the dentries for the debugfs files, so drop
> those variables to save a bit of space and make the code simpler.

looking good, pushed to for-next.

Thanks,
Andreas
