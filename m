Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33964C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C604E20823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nx1OX4/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C604E20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeJaDdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:33:54 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43965 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbeJaDdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:33:54 -0400
Received: by mail-qt1-f194.google.com with SMTP id q41-v6so14705120qtq.10;
        Tue, 30 Oct 2018 11:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mD9MNXdI/4NjoJAnUKMHjVYl/7kc/0kRBTRVncU5bc0=;
        b=nx1OX4/uncD731SQJTGjtZw3mGfXapV5A9iaDH8tAL7t42jRVR3hMoEBhb2FaKRWNv
         Mb0QNDehYuRoGuCK+5ylJbH8sbGTrIzXYb3H2pNfFl9h4mquPqs5qQY0HjPDFyJjMbzy
         3XxcGEbWbMvk0FVexeKFG6AgrShaXoCDXVuDDS7lyqGft39fp8bKc5PqwmjmC7dcx4F1
         umMf6g66HRxqSA/Lh/D5TpW2EW8YrvUpgfd+oGNtx/qjulwo34kuLDYqMN8fHiSU8wJa
         Fy9Of/utsrdrQTp2OO3I2NZdaP+mdaK2m+H2/zFI5ZnRB7zVVFLtyRkxIQhDBiG63LhY
         YqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mD9MNXdI/4NjoJAnUKMHjVYl/7kc/0kRBTRVncU5bc0=;
        b=RAo5opr4gmnEPX/V0KUsJENnRK2xQlaZD4aa64AeF7XHiny//l2/rQfu5iXNw5D/QA
         cWtAyGmX4+uB6pwQi9Jp0J1y+zV+0xR55BpkKVkNyk9azobQamITvO1Jjm67FOzVaT16
         tMuHjUNjz5zbLxoHwR+/W9BeLOeTZ8JO2leUgW+C/21MnTZ4PRELU2RC88H6+pNEAsu3
         DOK+jQe4JvWQFl17O8JNMO8hdYMzb6JDEihDK+2kWcJuvc5quHXoc1wMX4HMmphN6WPG
         ikeuc0AN7YB1dUFr5ZZWGqpyqk0YbkLjt61xPDljLBUbQjJx27jhTpjtlSaG/AV5N4oM
         eDIA==
X-Gm-Message-State: AGRZ1gLp5/f0KUT0EtG07b3DeGvA8tTWDXeJHWAu0L71AJBJ5Rk7OChK
        RieHpj+Qa64Fnq8Zi0FiRNXp0GI2/DAp8tZhfRnMnw58
X-Google-Smtp-Source: AJdET5eKfvEbKJ8tFvul3anRAoxIAWaGq14J/d9uS2nGYTjfsRu2CWh5YpY90/+t4FyTNRsnH2m2zgIpi2tor3X5vYE=
X-Received: by 2002:aed:3b4b:: with SMTP id q11-v6mr3325117qte.229.1540924756447;
 Tue, 30 Oct 2018 11:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20181029200311.16947-1-semen.protsenko@linaro.org>
 <CAKaJLVvpNZW2a+3xc7PE0+iU1nm39A7PEjCu8F9ijrT+wEXOag@mail.gmail.com>
 <20181030063408.GA26627@kroah.com> <CAKaJLVtT+pFzOBjybAXmOC0mJyN=BHavsfAYEzgSWn-i7UYEjA@mail.gmail.com>
 <20181030130401.3ab5gl4fsvpa2fes@cs.cmu.edu> <CAKaJLVvXUTB5hyoRPZpfnzFKiLrCfLmras_37B5JxSYs4438Tg@mail.gmail.com>
In-Reply-To: <CAKaJLVvXUTB5hyoRPZpfnzFKiLrCfLmras_37B5JxSYs4438Tg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Oct 2018 20:39:05 +0200
Message-ID: <CAHp75VcofObTqAK_wwAcz006OYeoS2XZdiafswt6QrwG6JoFCQ@mail.gmail.com>
Subject: Re: [PATCH v2] codafs: Fix build using bare-metal toolchain
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     jaharkes@cs.cmu.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        codalist@coda.cs.cmu.edu, coda@cs.cmu.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 8:33 PM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
> On Tue, Oct 30, 2018 at 3:04 PM, Jan Harkes <jaharkes@cs.cmu.edu> wrote:

> > I thought I had responded

I don't see your response either previously or now (currently only via
Sam's reply), perhaps you have an issue with mail delivery?

-- 
With Best Regards,
Andy Shevchenko
