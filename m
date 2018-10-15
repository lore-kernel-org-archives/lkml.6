Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DB5C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE49208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lu6e7zET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE49208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbeJPEKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:10:37 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35583 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeJPEKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:10:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id r191-v6so15111864lff.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 13:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=38XTM2fqny8gr74IcrCnJ94WC0bj4ugKL4AP/ZIIzMc=;
        b=Lu6e7zETKWUVoMD/TfiaLzhLNP5uiCyd2+XjxL+doDdVrX1n2U/MJpXNpLmF+HiPxi
         TY3q3NwzLsEn1PuH+pbe5fubiNcyTEDgwoOZi/w34Wt+qHkSOUDVUqbOxrUZy34b3Vl8
         ZB7tCEIqk2IAPKx0EYNzZGPQzasOL2nZpxnUZnoGlQjgAVvgg3+bIbiMzDwF6sBQ97yW
         sG4o3KE2FZzWdSZPK8MO04YHohevdZnuljckLx98LtCINR8iyQRvfCh/Z2+9W+Ti+gPn
         bpfDTVz/IiANLEbOTuhE9fwmlim5GXVINA1HCYn2IAbkbvn+f93wFF5dEYf+f39dLxyM
         TkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=38XTM2fqny8gr74IcrCnJ94WC0bj4ugKL4AP/ZIIzMc=;
        b=PZwZqthrJG97JCwaGq1riYl1RR9AH8U7lcXUBliItNWeJtX6HVf5951FfoFwoyybc+
         Yw+KA8Oi8yT5BS/zk9SaPJmYp3K3iDrQdKhEB6XgBSyT2gA2UidmG6E+ERCtzQxmQBju
         cMUulqDzUUM+CSHyvkDmnMW0N57q4AAbyU7Mxo0DL+55JJxLPc6VLNaN3KqHnkZA1hwa
         /UNlDsb0VYxog9iZZYO4AvCOBS7MVD3Q6mrqW0L24vW1ETQGig4s3h1v+dLB15prDbd/
         hSkSFahzdl7ziyJxtGjplXy2366jemQSAH2Bhc88e0PI1hAOz1EApfKwDYJ/Rd/iJW1G
         8lBw==
X-Gm-Message-State: ABuFfoixW7QFYDJ6OwixUjFssX5f1ZYJ8WcKmliGvqz2D1sSDtuAndES
        v8G67NpIJUDfipYor8NyrsQqwAnz0i7HYsToep+PBA==
X-Google-Smtp-Source: ACcGV61MAnEFIdSrMlCf5hjNMg2+qfTaOU3t+cxqy10t9Rt3E3qF/1MRF27eSRsANodhdYsrPDhC2qPfsrcd79gi2XI=
X-Received: by 2002:a19:c189:: with SMTP id r131-v6mr10076311lff.59.1539635027475;
 Mon, 15 Oct 2018 13:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181003171720.169953-1-rkir@google.com> <20181003171720.169953-9-rkir@google.com>
 <20181015183807.GA6905@kroah.com> <CAOGAQeo31ggKCHsJw3D297J6Ya1kq8MptTaDR7q6H7-q99sdGw@mail.gmail.com>
 <20181015190134.GA6700@kroah.com>
In-Reply-To: <20181015190134.GA6700@kroah.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Mon, 15 Oct 2018 13:23:35 -0700
Message-ID: <CAOGAQepAqCorTosBwqJq-Kez=MUThv35JM=S8jfZEkkk1Xr9jw@mail.gmail.com>
Subject: Re: [PATCH v3 09/15] platform: goldfish: pipe: Move goldfish_pipe to goldfish_pipe_v2
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I want our "v2" driver to be in a "v2" file and our "v1" driver in a
> > "v1" file. I think this is reasonable.
>
> The in kernel driver is the "v1" one.

I believe v2 (on our end) was upstream as goldfish_pipe.c instead of
goldfish_pipe_v2.c.

>  Why do you need a totally new driver file at all anyway?

I don't want to mix v1 and v2.

> And again, can you GUARANTEE that userspace will not break if you rename
> the kernel module?

Yes, it works:
https://android.googlesource.com/kernel/goldfish/+/android-goldfish-4.14-dev/drivers/platform/goldfish/

I don't see how userspace could be affected, unless we refer to
__FILE__ inside the driver for some important things. I believe we
don't.
