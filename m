Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7FCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 04:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D1821780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 04:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FmZ50JXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D1821780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbeKNO7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 09:59:00 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35764 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbeKNO67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 09:58:59 -0500
Received: by mail-it1-f193.google.com with SMTP id v11so22074807itj.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 20:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FwP+c6xqOm6lbLDSw5tMvXvATT9ZgezutSIzK6JP0/Q=;
        b=FmZ50JXOOSDt7+0NSljM1fcNt+qQ8ICf2AiEoiAXrdDwDw8bnOHVEsxNXyjvLAfrpZ
         RFuGi4chxj7KZc3jVEo4VnmXQJY6bleJQZcrxxeWTEHrsHUA+du/GP4m/cao5+bSapVu
         ZLaUeCJkii4REPDNW3h2UZnDqm+NjmNBFf5QY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FwP+c6xqOm6lbLDSw5tMvXvATT9ZgezutSIzK6JP0/Q=;
        b=nhgxrKgDULDixICL/63VOAknxdS3EoijUQKijmVTsXkW1kdHtNCUgYMs/hUy5029Q5
         xVhbxzA7Shh0pB9aQb6qqIzGwwczP1TW1LN1KxvbPmQ0pYSZgj/CnbePOUEBq5UG1ai+
         she4PRvy+mqlEHsTx0nt67isuy5w0xCRA87ecr9UzsUzWWVuyXXHoqZ6RDUG/3acliA6
         LKQQS5EIvODHRmwA1FUWsuWMyW5YsdIQvKzudxGBwZm6E3XzA4Kve4Z06aD3tBut+v42
         KtZoNQ8S+gKjb8TuJRXeM761wwtvQ/z+pWRZhXAbmR2cQtGLgC2GI5KXCuDN+B7oMexF
         irfw==
X-Gm-Message-State: AA+aEWb3vswrIvJDDrRRIVm/JauTz2DSSzf40I4Hs9gwPBEmMRGYVA9Q
        UqwHVTyXErxCYybU7ixfcPFzPzwA5Mw9F0paZTmX2w==
X-Google-Smtp-Source: AJdET5dbb4/u28ZKk9uxAN3ak6g8KEudwhP4kxb74RH1REvSeSPtBuTPKkRxX0AlarCDMlz1UHthKAWlcXTP0FGi20M=
X-Received: by 2002:a24:b009:: with SMTP id d9-v6mr679932itf.166.1542171444362;
 Tue, 13 Nov 2018 20:57:24 -0800 (PST)
MIME-Version: 1.0
References: <1542092265-20956-1-git-send-email-firoz.khan@linaro.org> <3908561D78D1C84285E8C5FCA982C28F7D4560BE@ORSMSX110.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7D4560BE@ORSMSX110.amr.corp.intel.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Wed, 14 Nov 2018 10:27:13 +0530
Message-ID: <CALxhOngSrDmg12W9zMEgNWakKUK_W9wOv0d2MQ0pmixOs-Ns1w@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] ia64: system call table generation support
To:     Tony Luck <tony.luck@intel.com>
Cc:     linux-ia64@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Tue, 13 Nov 2018 at 22:39, Luck, Tony <tony.luck@intel.com> wrote:
>
> > The purpose of this patch series is, we can easily
> > add/modify/delete system call table support by cha-
> > nging entry in syscall.tbl file instead of manually
> > changing many files. The other goal is to unify the
> > system call table generation support implementation
> > across all the architectures.
>
> Replaced v4 with this new version in my "next" branch.

Ok. Thanks!

Firoz

>
> Thanks
>
> -Tony
