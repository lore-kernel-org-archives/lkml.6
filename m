Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC3CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D7620862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Oa5qtFps";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gzisDOU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D7620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388204AbeHAVhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:37:50 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:41513 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732116AbeHAVhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:37:50 -0400
Received: by mail-yw0-f196.google.com with SMTP id q129-v6so7668139ywg.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 12:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=R85Z+jG+ojkH4awTRqpD3S/9cdVx17Q+eg9JGbcfAl0=;
        b=Oa5qtFpsK4WR5ETyJISS1VAT0/dHrqCkgyvjiLg+ZWmAAqg6rkkD1TM5PYT+air4n1
         2eTK2cmBxmy9AsJ1VK1j9io7ri/EV5N7RBGH2Gs46VGzBAiI7qHw5bMYXPdKnZGPE3Wj
         c1f1UZhDQ0zqHWRcWxecCbMsCT61CpJg4R/8/xDqkblELL0FnM8BlGZn/sbQpr9abQhJ
         L2wgTweuoBdxNthxUoW5lkwU5D+wJkorwYhHyn/ygFLZmxY9bZFx0DPf1NOGCiHMBaa9
         VpX8ezbqF60SHzx1/Om1XvrQ9aI5xvh4NY1ibvDmbNdGakAzUKlOnEtI7oXmzAY/0aKk
         3kzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=R85Z+jG+ojkH4awTRqpD3S/9cdVx17Q+eg9JGbcfAl0=;
        b=gzisDOU+WLvMjGSAkxcKz3A8I4HpkVeVlz6HYTzhp8ufGK7IQ/Vq3eFR4Hq/TN+vZA
         2jZXSo2xbV0nYVmmStUdtrPKMnwoQeQ1H0KUoOSUcE3TaNG3KjteGa7UE3LK1Z8MYuNS
         bj2niMv5zayzwiikkpus3QyUPZRpNGcTuhTFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=R85Z+jG+ojkH4awTRqpD3S/9cdVx17Q+eg9JGbcfAl0=;
        b=iAiYWmnNDPKIhIouEa2OXK4/9ptLd2mMWnBHSou1cidV5/s+qkyG0iOLzl6QotdHH2
         zI6JtA8IqJtQGyAa1Iw9oQ9HHHPkC1HdAemoGiYdjCkQYHPfT74ZI/1n46pY2+f3OpTL
         SevlaU3MG9ViHcdGkTf1+Sc0UIPxkdrXl/S2gmT3zoCanMjOjWQVcurqYv2eYZGIbjuj
         owBlT0X+LJJv9vj6mdGgYlBd7nS+uyYKdwIetHTNZgcCm4M0TYCXPnO/UQNtEuR6kV+J
         BgCmJ2kzMXlJn+DtNkZpSbQ4qYzfcuDGrOHSOMf684zgxemESl9J4BVmUidjYVINI7AS
         GPtA==
X-Gm-Message-State: AOUpUlHYWJYcQGDpai23PtNdzVAPyBit2UeWyNgLgG75cWqKyXwt3uZt
        OBtjpE8Mz1aRQtJLjlnAc1JJtZfnjGvtLYPlaa/Pjg==
X-Google-Smtp-Source: AAOMgpfVjLr/Ibpt3pWNQGq33pA4VB8Jg8zSvgjxmcnZy1QBs2T36pbpEkLsga457WCYqoq3plN9Pqw9wR3zJ+D7Ko0=
X-Received: by 2002:a0d:f002:: with SMTP id z2-v6mr14688776ywe.116.1533153026933;
 Wed, 01 Aug 2018 12:50:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 12:50:26 -0700 (PDT)
In-Reply-To: <6c04fc087bae896bf00b94184def3d7697a22d6c.camel@wdc.com>
References: <20180731195155.46664-1-keescook@chromium.org> <20180731195155.46664-4-keescook@chromium.org>
 <a5b545eade66f95c9a9ecf37676306a8d395187c.camel@wdc.com> <20180731201225.GA1989@infradead.org>
 <6c04fc087bae896bf00b94184def3d7697a22d6c.camel@wdc.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 1 Aug 2018 12:50:26 -0700
X-Google-Sender-Auth: 9PG58nQpZwWUmdJ_HS33lkZUJHk
Message-ID: <CAGXu5jK2kLiOGTbq2TCBp97c2KZsZKPDNLSWDWY4r+RQpAP4fQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] scsi: build scsi_common.o for all scsi passthrough
 request users
To:     Bart Van Assche <Bart.VanAssche@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "david.kershner@unisys.com" <david.kershner@unisys.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "nab@linux-iscsi.org" <nab@linux-iscsi.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "manoj@linux.vnet.ibm.com" <manoj@linux.vnet.ibm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "jgross@suse.com" <jgross@suse.com>,
        "cyrille.pitchen@free-electrons.com" 
        <cyrille.pitchen@free-electrons.com>,
        "sdharia@codeaurora.org" <sdharia@codeaurora.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mrochs@linux.vnet.ibm.com" <mrochs@linux.vnet.ibm.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "ukrishn@linux.vnet.ibm.com" <ukrishn@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 1:18 PM, Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
> On Tue, 2018-07-31 at 13:12 -0700, hch@infradead.org wrote:
>> It shouldn't.  All these are built into scsi_mod.o, which is only built
>> when CONFIG_SCSI is set.  Under what circumstances do you see them built?
>
> Although I think you are right, I still prefer that the scsi_common.c file
> would be moved to a new directory. That will prevent confusion later on for
> people who want to add additional code. This patch makes it nontrivial to
> figure out which code is built when SCSI target functionality is enabled but
> SCSI initiator functionality is not selected. I think moving scsi_common.c
> into a new directory would make it much easier to figure out which code is
> built depending on the kernel configuration.

While I don't disagree with you, this series is the result of several
back-and-forth discussions where that option was seemingly rejected.
Christoph's approach seemed to satisfy Jens. If you can convince them,
sure! I'll do whatever the consensus is. :)

-Kees

-- 
Kees Cook
Pixel Security
