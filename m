Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719E2C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2833A2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OzO6ZtbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2833A2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbeKBBgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:36:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34920 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbeKBBgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:36:01 -0400
Received: by mail-lf1-f65.google.com with SMTP id d7-v6so14641726lfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 09:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9SnBpkaM9lmAoGw/RdMGISXYHq/mOcdGifONxXvuXGk=;
        b=OzO6ZtbCSzUX+Vf5NMf3Oq0Dh31nNMKtpautMjpqX+zV7WiQGWOeriH56le2BUi2Ab
         PLF4rhmJaduKtxGhEvXEpNbWh4s7ZEFYvqSKWQ4zqZILllr9dB7WDLvmH5V4NSL9AcE4
         q+87kpHmzmJ50fJqncK5tCHuxuAL9x/gjTJQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9SnBpkaM9lmAoGw/RdMGISXYHq/mOcdGifONxXvuXGk=;
        b=aOo9qXMO1PKxAI+MRcZJPcK9T68Htlvb91fqtSaH5Zx8IRCGm+9WljtcpWfvIiBFTT
         wwOupUfNWNBujyZ7tSnsDuEoooNJ1zFWc3F9dMDYlmk9pZ4I8xv2zuMqG9rSj7C4qVdm
         /JK+TQa6kILFbRIIEpF4HJobKrJQ0rTLXPY0g/7wZf3dGBGacDHhCFIu88SOO48XC+6m
         0KObHqzLZFMwot5eYM9b50/9L+l3VZ5/7XC4pi64BmOcHcpchHCG6fzURWlRqcTHFsmK
         Qbca25bXzZCvrG5SwaTDicnHcSiC61E2C5uM8Yd6Ca4od8Iuw3E3uflnR0t8sIbuH3Dh
         peag==
X-Gm-Message-State: AGRZ1gLDsNRj7A9QFBROpNO81UvvvBCF8tx5yOrsrZJ48JzOEteJc+g0
        t4nrYjiW4uCYLEFfEDwDCnj+WKGWutNv4Q==
X-Google-Smtp-Source: AJdET5dv1mdXbvxgGbXYISyzLfm+hzt45jU6l8bhoKmtNss0bdn/RVAz8FgWS3AQuQFW6qnRpAaQPA==
X-Received: by 2002:a19:be16:: with SMTP id o22mr4775178lff.22.1541089938235;
        Thu, 01 Nov 2018 09:32:18 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id g14-v6sm4568378lja.96.2018.11.01.09.32.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 09:32:17 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id c16so14632890lfj.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 09:32:17 -0700 (PDT)
X-Received: by 2002:a19:4287:: with SMTP id p129mr5061563lfa.135.1541089936561;
 Thu, 01 Nov 2018 09:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20181101105031.GA2096@kunai>
In-Reply-To: <20181101105031.GA2096@kunai>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Nov 2018 09:32:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiEdxQB_10JfGiN0wAMXBuagqPqo=EyLsdEU2YZC8CG7Q@mail.gmail.com>
Message-ID: <CAHk-=wiEdxQB_10JfGiN0wAMXBuagqPqo=EyLsdEU2YZC8CG7Q@mail.gmail.com>
Subject: Re: [PULL REQUEST] i2c for 4.20
To:     wsa@the-dreams.de
Cc:     linux-i2c@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        peda@axentia.se, brgl@bgdev.pl
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 3:50 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> I2C has a core bugfix & cleanup as well as an ID addition and
> MAINTAINERS update for you.

Pulled,

                      Linus
