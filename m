Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05121C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45A820862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EizfVLI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45A820862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbeKFANZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:13:25 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42816 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbeKFANZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:13:25 -0500
Received: by mail-qk1-f196.google.com with SMTP id u68so15052509qkg.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 06:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=yfo1+UsnEF5hy4ZmoOvDeWugDXvGpcNA/YXatLFEP/k=;
        b=EizfVLI2xPw2/ENVKGANr4KS/SgdlxLcZ1cbm0W9OJskulz9tVBQU/R4nj3dkZoPNI
         sKoy1W+RFkRyNnnXcvib5wdz22wKbHHVFl9bReUO2+ibl9uNU1oXxX0DLauCOMuaqtti
         L/t28Bz2IRquG9v/C19zvZLwYFRp3co6Gh+4hwoSR39eha+QHwN6lumd+ybW3a8hjlXF
         GyeaxM2RFqK4rPcS6GgWCWtKGjk7nDG5MnbYbNhIwh+VPhopw7VhYwIopkIjMl6kRDta
         3/0vQx/dylfWbW6glUdxY7x2mBLPNyGzCsIwxQCiRtU8Vg5Hr+wURIvOXDejMDwV1WSi
         fCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=yfo1+UsnEF5hy4ZmoOvDeWugDXvGpcNA/YXatLFEP/k=;
        b=rLRK0SQUXjE/L6bouvt9hrxZHiktH21Q4CrjDC57Anjmp9b9AOQKB8lKNqBjBk698/
         rlG0i9NNUPaN74Gcz0IrrhfxkO8ff5bwM73b/aTXhbijPJN0qH1n48ld3js+0EIOAP6O
         bn9k+5ljkIKn9oWb8dmXIvIQz5vpxSiVuYO2iE+pEDieXGqwo0hOFtnZRWX905rLeMZJ
         goQwvCjCsY2aUWhRUJZ8CERr7SB1A7aWMoNdwmzG5HyD5RnAdqGfT2MATTA2WvhEHlrl
         vqHy3aV0zk8NsXtsBh1e8Z6+xFWgOhfIz/6xeuOyTmJYT4QPrwc8ygk2RVrsxotrST0b
         04xg==
X-Gm-Message-State: AGRZ1gLHD509r97aC7dqeNVytky47NMAYjXIivLtj0B5t5GM7jCE1esr
        9v4XY5FQ+URUdGOkn6MTsgfzfxjgrS+ycLDffXA=
X-Google-Smtp-Source: AJdET5d36+zY4IXu5VDkCNjmZRReS/sGCC5OGvbgcMrmKltZsw08mt7XvbzkwayX/qNByJej2imZjigH/cTqMbOqom0=
X-Received: by 2002:a0c:d992:: with SMTP id y18mr22334591qvj.161.1541429599925;
 Mon, 05 Nov 2018 06:53:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:9881:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 06:53:19 -0800 (PST)
In-Reply-To: <alpine.DEB.2.21.1811051225430.1566@nanos.tec.linutronix.de>
References: <20181102154935.2073592-1-arnd@arndb.de> <alpine.DEB.2.21.1811051225430.1566@nanos.tec.linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 5 Nov 2018 15:53:19 +0100
X-Google-Sender-Auth: N1WVP3pJxzHIwdDlhqXLTjp1W8g
Message-ID: <CAK8P3a1D8p=WXb83bCTQ38VuKymAGQTYMoNx_Whg_yLJ3nyY2g@mail.gmail.com>
Subject: Re: [PATCH] x86: vsmp: avoid link error with gcc -Og
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/18, Thomas Gleixner <tglx@linutronix.de> wrote:
> Arnd,
>
> On Fri, 2 Nov 2018, Arnd Bergmann wrote:
>
>> When the compiler skips optimizations for ease of debugging,
>> teh vsmp_cap_cpus() function is not eliminated from the build
>> with CONFIG_PCI=n:
>
> thanks for that, but the code has other issues, which are addressed with
> this:
>
>
> https://lkml.kernel.org/r/1541404864-31603-1-git-send-email-eial@scalemp.com
>
> That should also solve the problem you've observed.

Ok, I've dropped my patch from my test tree, will let you know if
I see any other issues with the new patch applied.

      Arnd
