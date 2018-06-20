Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7517C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D70E2083D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ICQdrqaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D70E2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753931AbeFTBv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 21:51:29 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:55493 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbeFTBv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 21:51:28 -0400
Received: by mail-it0-f53.google.com with SMTP id 16-v6so3227722itl.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 18:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WTLF0aT7/IWplx5BqF6gevYnDEeOfLZQUDiwirYrIaA=;
        b=ICQdrqaMyoTj8nYLWRjA9pbmZPgacMtiXSS9a8sYd57SCE9zFtTFn2IsE42jYEDTRC
         wdPtgBCSlwSn1Nh4npjuvoTx/mM0GWqLNh3AwVCGC7eF5U0xlBYDt+V8fTFRJQvWd85P
         gv3UcS/6ry79KlfooHamCtNMoo/Eoa64rDBCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WTLF0aT7/IWplx5BqF6gevYnDEeOfLZQUDiwirYrIaA=;
        b=KRRopmZx5DdNmncGfJdBVmRNi3WL8vllP9I5mwLvjAFzsadyaWRjU19Oro1HJo2Yh3
         5zWPhVrAhICSKjdTfwxgWXyIeFUdl7VxROz5b/LzPJYhvuJz/CkEtHbEZUfA5+3wIgEp
         VzfJqyCzjzyADI1Ij+xwGS2lfL/TeIt9YiW0xjKxz4O7up6AedG/7Ftm348m2mdHE+Id
         ixS03ZUZHIHhyu2Ery0H6653qVIVIDoHz6KvgMqv2KdTHM/o9n1omePr1Ed63DF5FJRW
         XICy0J4eoGapdNv+P1niuDUcT0/icSmQ5aHPIx4Kns0/pvxZpX3rkVPxa76hVPQsr6xK
         0BKg==
X-Gm-Message-State: APt69E0P2qxI4d5E9YexZ3KOGHKifgcZm/sJEFJDEbEN0ou3Olmjvn6u
        yz2LGMmmrmhaOpVsslnDesD+0VUr69T/I3rnLcj2cOLs
X-Google-Smtp-Source: ADUXVKKLEAB0eWqe2TILupY25Vb7CipTWoUR5HMV3sEUx1ql3H4OQPuWexuD02q2ygYtJm98wWDGf/i8pS3RtfD5O+o=
X-Received: by 2002:a02:666a:: with SMTP id l42-v6mr16068294jaf.70.1529459487141;
 Tue, 19 Jun 2018 18:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1806191356280.6203@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1806191356280.6203@cbobk.fhfr.pm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Jun 2018 10:51:16 +0900
Message-ID: <CA+55aFx1o8+ZTAqVQNH7Wq8tm90XYTUEx5By2wWo3KJDR3g2MQ@mail.gmail.com>
Subject: Re: [GIT PULL] HID fixes
To:     Jiri Kosina <jikos@kernel.org>, Julian Sax <jsbc@gmx.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 9:00 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> - i2c-hid fix for devices (such as SIPODEV SP1064) that fail to provide
>   their report descriptor, from Julian Sax

I'm not taking this crazy stuff after the merge window.

Even *during* the merge window this would probably have made me go
"WTF? Eww!" if I  had noticed.

What is that odd binary blob i2c_hid_desc_override, and where does the
data come from? Not explained anywhere.

We don't just add random binary data without explaining it.

                      Linus
