Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7267C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA1F21906
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iPe0VI1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbfAZQTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 11:19:00 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:40043 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfAZQTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 11:19:00 -0500
Received: by mail-pl1-f171.google.com with SMTP id u18so5883458plq.7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 08:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3R4YX3J/6AYXxf9yM+ApOPk33kHcY4V56br2LqL9bO8=;
        b=iPe0VI1HhJCrIUGa7u/duF/XqK3MTVyMJk0ZW1DcGzK/X+S8oC6a64gOvXpSfSE6pw
         DSfmQ7VP3IfGRYsJyi7LP7Z2XHAOK/2qEenahfTwcIgYD6Bulrwyl3ciSniuoZn03zXN
         nHTrUU0PQtGZcHZcfpVMqjpL2nf0/rLE096BW05mwdc3WF+4cH3LPldZX5T9DloIt5cY
         cppErZGf5VfXiNtX6cX0pxpHef3SxOiAmWz2b4iY9ybVo1viQOInyGc2KJDElkHKTEwC
         /5J5AwfPIrMV2FEcyk6eyGRnWgCtt1RuUP9tbljKHM0GhFO7fD8YRy+6jlsofqQrHOez
         ztkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3R4YX3J/6AYXxf9yM+ApOPk33kHcY4V56br2LqL9bO8=;
        b=MzUcbcPcj1HviWKCQ/EfQ+lR9vZJ/TWiFMc8JA46rf/zXF0ROd7JPYY/ZacoelX1ti
         pY6U+lYMB6NezOvbrqENmpMfjZblmqgd8cenUVw+5bwefnHZ1Yb3vsIda3KUSssD5toX
         MDrm4YrQ6YwPmCb62JjHJCpA6cyTD2UzsH9dLt9+zOFyJ8QAQM+QkGSKnkm0Te7Sdolj
         zfj0riufigFHv3trR+sxrs8i61C0/tiETpfvIcTaDzxd3q71VgfUBIkl2zHrZ+abdSQw
         MKA2dk4Hyps5tK9QYo0ncVgLqOXQuNrjVjag7gWZ8pGTsLN46/npdRBDruJEloqJHXFk
         pj2w==
X-Gm-Message-State: AJcUukelWd4JBkZOFiSnvj1q752pCxo9NzRq9Refd/QsXDtSM/T2IQVz
        GTPgJDZb1BaXcwLbQTPUlJYUBAr0Ny4eLMtrLkTMs3pPcJ4fWA==
X-Google-Smtp-Source: ALg8bN6f7H7Ts0Z4Tl42JMgJCzaG6xYZdhHf0CStuv0kvuzTGBCaUP5lzi1LndNajYdYlG5nWpJbj7Ij8TK+GT30jmY=
X-Received: by 2002:a17:902:4124:: with SMTP id e33mr15478862pld.236.1548519538862;
 Sat, 26 Jan 2019 08:18:58 -0800 (PST)
MIME-Version: 1.0
References: <20190124185852.19423-1-Florian.LaRoche@googlemail.com>
In-Reply-To: <20190124185852.19423-1-Florian.LaRoche@googlemail.com>
From:   Florian La Roche <florian.laroche@googlemail.com>
Date:   Sat, 26 Jan 2019 17:18:22 +0100
Message-ID: <CANZrA2YcgKq3N5LM6__djG1it3D1ATjHeaTMtoeZD3KLhHVZMg@mail.gmail.com>
Subject: Re: int_sqrt() adjustments
To:     linux-kernel@vger.kernel.org
Cc:     Crt Mori <cmo@melexis.com>, Joe Perches <joe@perches.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

The first part of this patch is wrong: it changes from an unsigned long
param to __fls() to an unsigned int param in fls(). One option would be
to add another implementation of flsl() or given the minimalistic usage
of int_sqrt() in the kernel to keep the current code with __fls() and only
change masking the lowest bit.

The only other nitpick I have come up with: Adding __attribute_const__
could be possible.

best regards,

Florian La Roche
