Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7335C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EC520C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EC520C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbeJAWcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:32:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45748 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeJAWcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:32:35 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1g70WM-0007pI-QE
        for linux-kernel@vger.kernel.org; Mon, 01 Oct 2018 15:54:06 +0000
Received: by mail-wr1-f69.google.com with SMTP id y27-v6so5676184wrd.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 08:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ROZvVERiZ7Z79JYVklAClQd76wx8DBH5aV0YZlp+eIk=;
        b=NJBwRHSKceAKgW/85oFftSvs6PWOnKwpmL1WixH69DD3AXDUjCdOYHzeW9FTJ28bS+
         a+S2FldXLvKgvGsZvVQNC25UcPudphjwRvtgufx8RcPmiyvDiZNdocxsKSElwH6gXqZx
         G20QGFJk0yz5pucELfn6P1ZM+5dxvsSs0olQQLEbInxUMoJYa4wx7HS/IBuN2W62Dzgr
         5WrnuxK+smkk8gm62p8pxoMjKUhBOXHUqQ6gdGDGKZsNZUYVnHKbtjTDIzlN2qwivibl
         byk5/gFNYO4nV7d8BpeFQUWJlImg75QC9IuVp+3zNna82RMltuM5cEPGA7nXRBRxSp65
         C+BA==
X-Gm-Message-State: ABuFfoj21xGQYXN0aA+6i5NC4Tt6KGNFqqJna7lagIH/7g1M/PBmf1rN
        +hkOgS7HQj2laRxk4kpQ0nqAGr8SmH+WBjxz510KhvZcNnpPgRxAmFbn1FG2fNKMTdtetMSm1jL
        8QMujnXK5NwZEELZOH+gMN46QfhNGcca5am05ZLvYpyBdn/CGTAQ0JTXyfw==
X-Received: by 2002:a1c:ee9d:: with SMTP id j29-v6mr10011436wmi.52.1538409245718;
        Mon, 01 Oct 2018 08:54:05 -0700 (PDT)
X-Google-Smtp-Source: ACcGV61mkPiYzr+u1G91bZQmGm0YfPR5FgCZ/LlYWGnCNIK7eI+C6j2eDr3qPL7JTS4CgDIA40NBGCnx/QJ1uwtKYjo=
X-Received: by 2002:a1c:ee9d:: with SMTP id j29-v6mr10011418wmi.52.1538409245520;
 Mon, 01 Oct 2018 08:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <1517836201-19362-1-git-send-email-maurosr@linux.vnet.ibm.com>
 <a90ca2a5-5d64-bb3a-babc-dc654725a062@canonical.com> <a51e8b29-9aec-a5cf-8e33-46ae5eac1fd9@canonical.com>
 <CAK8P3a17Yb+DS8vPC3kgzL6j5SvhqOsJa3w=XOf_NDL7H40d_Q@mail.gmail.com>
In-Reply-To: <CAK8P3a17Yb+DS8vPC3kgzL6j5SvhqOsJa3w=XOf_NDL7H40d_Q@mail.gmail.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Mon, 1 Oct 2018 12:53:28 -0300
Message-ID: <CAHD1Q_zWdNsgTPuyUx_+dbtqMNRRVe-5pC19vTkpkdToxYoz4w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Change maintainer of genwqe
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Mauro S. M. Rodrigues" <maurosr@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        haver@linux.vnet.ibm.com, brking@linux.vnet.ibm.com,
        brking@linux.ibm.com, haver@linux.ibm.com, maurosr@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 12:50 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Hi Guilherme,
>
> I think what happened is that nobody felt responsible for picking
> it up. The patch was sent 'to: linux-kernel@vger.kernel.org'
> with a number of people in Cc but nobody listed as a recipient
> personally.
>
> I'd suggest that one of you sends it again 'To: gregkh@linuxfoundation.org'
> with the subject changed to 'char: genwqe: change maintainer', so
> that Greg can add it to his char-misc tree.
>
> Please also add
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
>       Arnd

Thanks a lot Arnd! I'll talk to Mauro in order we get this accepted following
your suggestion!

Cheers,


Guilherme
