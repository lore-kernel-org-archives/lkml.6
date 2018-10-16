Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B29C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD1E2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l47tQaLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD1E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeJQEkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:40:41 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45644 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbeJQEkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 00:40:40 -0400
Received: by mail-lf1-f68.google.com with SMTP id v22-v6so6272142lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 13:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v36tdw5ECNgDycMRV3b45ysJ1bpPZcEEdyba3mPNyOE=;
        b=l47tQaLgv+oyWieiYBoZgP6oFNVpNQPQoevG1sUS2YuSbxgeAohURoh4lj3kTXUxxM
         duImo+LAZffzBv1/MYIVsTfpVSmJSf4ZY8zC1z13gvbcAVPI8RoSl5+rhV+28Mz1Ft6J
         CdJAcwOxGo0h2kCohKm1WY4egQUdp4MFpBd/msn36UgkOahklTaWOk4e1/Epa3TU7EQi
         zl0NuVMJ2fWypxWgtVpmGkcBzryOnRVft3aN/FclPL+mDnVeR70TddxgWI6cVIxI5oKr
         AIiNh9MmmoaCCxM7myfmCOs93GPidLqgW5urKvjFp2Dh0zHCZ0rKMKii9pKXa5wlxG8x
         +rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v36tdw5ECNgDycMRV3b45ysJ1bpPZcEEdyba3mPNyOE=;
        b=RkjbPsSKsJfWEv/jQbMJdRI0MnJ3GVBhHnmWJMm+LRoMvmB8r6gpu6e9qbvlIzAh7J
         7n8Fk70ujv0Xv8+5B69nBH9gNydvQJjWgItlkFVOrRB+qxmYjDAfN7V+FFplHgd4E7TX
         DdYMjaD6SNypiQsJ9nA5eJUs29wDg9CrFOMb7DcoA+h549qv8W2GGkWAQnuRJNmbZovI
         aS0D3xU+erGL5OEqAks+QHuvV0d2Kt6VCNhl6JT1uasMH/aozXIRiVLwCg2s/NqTvi7G
         AsVPNFWItKdavp/fTJ8mpVu0ZlkX8ztVmxctSH7VWX98G6snQtbAvlEjWYohns8m6mM3
         zhSg==
X-Gm-Message-State: ABuFfoil6R648ozEyF9bwN3QfaDAICNbspRVcCLPRV+ykeng++eL8XST
        Q1ImfP3n8NSpEAUP0EM7X/73KEN0rvgc+8eExQ/O8g==
X-Google-Smtp-Source: ACcGV62GcPcnkivA0kvRMS+v9Kgm69bl8Uk0JWTxR1rJNwfT1uG0LcQtgbVtccb2DrRjXlKrSnRXB666imiLz7sjHJs=
X-Received: by 2002:a19:5f57:: with SMTP id a23-v6mr8834749lfj.28.1539722908540;
 Tue, 16 Oct 2018 13:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181003171720.169953-1-rkir@google.com> <20181003171720.169953-6-rkir@google.com>
 <20181015183458.GA28454@kroah.com> <CAOGAQerzTxLEcFjqCqjGvFDaK79LWw7kuGqprw4mEj6gmcm6tA@mail.gmail.com>
 <20181015185611.GA5201@kroah.com> <CAOGAQerxP0hsVF2ArpXJ4HrPj=-XKfdqvAdUGoC4xo+sc4UYvw@mail.gmail.com>
 <20181016062721.GA882@kroah.com>
In-Reply-To: <20181016062721.GA882@kroah.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Tue, 16 Oct 2018 13:48:16 -0700
Message-ID: <CAOGAQepYWjm1TzLaRXnhFksDuQR-ukeChfHFRj1=uWyaUe-i+w@mail.gmail.com>
Subject: Re: [PATCH v3 06/15] platform: goldfish: pipe: Move memory allocation
 from probe to init
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I think we are getting our terms confused here.
>
> "init" usually means module_init(), is that what you are referring to
> here?

This is just a function that probe calls to, goldfish_pipe_device_v2_init.

https://android.googlesource.com/kernel/goldfish/+/android-goldfish-4.14-dev/drivers/platform/goldfish/goldfish_pipe_v2.c#1128

> Why would your probe function know, or care, about versions?

Different driver versions allocate different state.

> How is your probe function learning about the "version" to use here?

writel(PIPE_DRIVER_VERSION, base + PIPE_V2_REG_VERSION);
version = readl(base + PIPE_V2_REG_VERSION);

https://android.googlesource.com/kernel/goldfish/+/android-goldfish-4.14-dev/drivers/platform/goldfish/goldfish_pipe.c#106

> You have to clean up after your probe function failing before you return
> from it.

Are you saying that devm_kzalloc does not free memory if probe fails?
Is this useful?
I can free memory myself then.
