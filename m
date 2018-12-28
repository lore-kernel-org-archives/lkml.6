Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0726EC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 20:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB42E217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 20:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LlGraahw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbeL1Ux3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 15:53:29 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37351 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbeL1Ux2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 15:53:28 -0500
Received: by mail-lj1-f196.google.com with SMTP id t18-v6so19580522ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 12:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dPFdHWOi4rLzsD1EuCJln2SieOfQRPHTHr7un7+D4TE=;
        b=LlGraahwBAl/1oNrZPDFziUMHCBJFcT7v1JrCrJcJjQSfmE1U8M2J4j5ud3QjVBFW6
         8y3JH6iQTU7TlHXlMjjU7WIY/RduhoLToCCNcNjU/PjROft0dQ1rtpANzXzeyeb7CZrP
         0BWk4ISw+cUx7+tdvZY1k0nqUWTpFUL3oCAS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dPFdHWOi4rLzsD1EuCJln2SieOfQRPHTHr7un7+D4TE=;
        b=BU/AAodvJqB6URTyhPSCjCfHMI+wj2cYCh44CxfgXp21sNpCd9NxgfDrsdMSHRbEUn
         j6Dcbzefp826F9Y0tGsoCodhtmtGSYlQoJwpm8GsNAbjvy+BUuZTILRpYOj3UWyPX9sf
         gmtdQDNA/T87pqLjisV62DLtiRSL/3sh82FxG5fm1/j2hD0wAGb/y81covyBp+hZSCal
         YnrSwvTim9doQOrlH0mXK22AUaCOJrhQx6VyJQCWfsc4qUsAj6xb+MLpjSax87pKSJ7H
         bJ9O92Ho8d5LzXhaiB/UZBg/fuvcj+9gMwVE56WHiHutPkrNc9gE4NCe1wScQO4bj1R9
         fHOg==
X-Gm-Message-State: AA+aEWbUYgRa2L2ayCPgjQtST4lyM2CESyNA/eyLIgrnNMkVUxizVent
        Lb6InsXorkk/rH0MJ3l8/G6NO6bg590=
X-Google-Smtp-Source: ALg8bN6gTmFIbzzc7x2Wl01ozYgBI6S4T1utT6ctkqjlIMr7A28EBRojwIb+wb1aqw1hU2I4ftIEug==
X-Received: by 2002:a2e:551:: with SMTP id 78-v6mr15958374ljf.82.1546030406004;
        Fri, 28 Dec 2018 12:53:26 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id r26-v6sm8849164lji.25.2018.12.28.12.53.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 12:53:25 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id l10so15225492lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 12:53:25 -0800 (PST)
X-Received: by 2002:a19:cbcc:: with SMTP id b195mr15425293lfg.117.1546030404611;
 Fri, 28 Dec 2018 12:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20181228152226.9897-1-willy@infradead.org>
In-Reply-To: <20181228152226.9897-1-willy@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Dec 2018 12:53:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=whoWr9v5N9DQEd4ec=9y541MJmMFh6yVb3vTEQTw5Nc+g@mail.gmail.com>
Message-ID: <CAHk-=whoWr9v5N9DQEd4ec=9y541MJmMFh6yVb3vTEQTw5Nc+g@mail.gmail.com>
Subject: Re: [PATCH] Fix failure path in alloc_pid()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 7:22 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> The failure path removes the allocated PIDs from the wrong namespace.
> This could lead to us inadvertently reusing PIDs in the leaf namespace
> and leaking PIDs in parent namespaces.

Applied,

             Linus
