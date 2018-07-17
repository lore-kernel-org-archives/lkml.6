Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4E2ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00358205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjUJ6Y5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00358205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbeGQQuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:50:11 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34341 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbeGQQuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:50:11 -0400
Received: by mail-lf0-f53.google.com with SMTP id n96-v6so1275777lfi.1;
        Tue, 17 Jul 2018 09:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=NzmY+FSAYQHV2Q+eXmraonxlaPd+nmtD7Z+IKqxQaoA=;
        b=hjUJ6Y5E3gZG7Cw/nKRYyk8NIML9VVICnaJAUH+q9He+lQmUSET0H8mbYPdfGkTAHR
         V5l2bPIIn4n+WEjgjOfD2ZFralHQ/IIXAkfdZlIFtKdvQd1BdWqEDUXgv2HB5f+LM+bz
         5T6HyPyAsSWN2vAfRnG82jzSmZNjCnQpT8uTToOvIwWmWA+nwhFon4E+yw2rXpOziUk8
         dBJwxngDzmekBQhGt52dIbwPt2wUcByRC9upyejir/thmNl/4KuU/NW0nspZVmFsHS3l
         /AbcWeh8vpRQAcvbbzFSJJTYT5AMaLD0yY6+lhMEWDDOPeK0T8uNzbzBYbfr00RA7Q0v
         xwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=NzmY+FSAYQHV2Q+eXmraonxlaPd+nmtD7Z+IKqxQaoA=;
        b=f4HXcqoK3QXBPZffXLzZ3UbNXH7R3tJ8qDkHAA6u1Tt61nPur8IaTh4ULA8FGTd49q
         rnrxA50YW0kjjep13QNyMyjKnK+t4cOtlmpdy54Hq2Bs0c0RruvMojY9mi43YaZ0/QmP
         g/UDEdx8W2Wkb9iOqcrtWYw4O/58+dxTujZdhQd6JSNDoF2Cei1doECwzNqID2R1tQdB
         yjFSCf4ZzQCGZ6UcmpuEyRt2vogJDHOuJZ4t+dafEY4kza5ZWH7ylXNy5Nku+ZaP7lXp
         RkJ9mhypT9xuVVgRvZVoaqUfx3FLEvAsD0r9lByP7nH9ZRMsMfErff/kKUEmam7CchZW
         Bpkg==
X-Gm-Message-State: AOUpUlEDC7mpojj3LH476lCPwR7Nu7C/IIKmV0L9/XrVsUrt17M8LnfB
        92W2ISwYOK9R/GWp7yDTL+QjIrr+MADs4msG3ds=
X-Google-Smtp-Source: AAOMgpfxG8sctBl1s/EvUuB2Y4vLm7oNj/BEeLUedsIhh14glHPDQDrqK3uslS31DsR3Djs3kePYt7zRJBP38z0E1wM=
X-Received: by 2002:a19:a705:: with SMTP id q5-v6mr1786936lfe.148.1531844205533;
 Tue, 17 Jul 2018 09:16:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 09:16:44
 -0700 (PDT)
In-Reply-To: <20180717125855.GA3681@infradead.org>
References: <20180713133204.3123939-1-arnd@arndb.de> <CABeXuvphoYM+KOGPgtsuxzS1_XDSOO0Ta5hr3sA7gYtt-78wtQ@mail.gmail.com>
 <CAK8P3a2xu4KGVM1BvTjtXKHfXpBQ2PMynAPybW4cRt7FB8ktwg@mail.gmail.com> <20180717125855.GA3681@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 17 Jul 2018 18:16:44 +0200
X-Google-Sender-Auth: awGv455xJ6171C92J-42o8zoVbk
Message-ID: <CAK8P3a3suHZo25uNKnWRz3MLJOFTBRwixTfTW7fSxG2CNoU-NA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] y2038: globally rename compat_time to old_time32
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 2:58 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Jul 16, 2018 at 12:11:53PM +0200, Arnd Bergmann wrote:
>> I don't think it makes a big difference whether we change it now or later,
>> but if Christoph feels that it addresses his concern about the compat_
>> namespace being reused during the transition, doing it earlier would
>> enable us to finish the remaining syscalls.
>
> Yes, I've been looking at your new series and the reuse of compat_*
> is really confusing

Ok, let's do that then. Do you think it's sufficient to change it on top
of the existing patch series? While I can rebase everything on top of
the rename, the header file dependencies are a bit tricky and adding
a patch at the end would make it easier to ensure that I don't
introduce any bisection issues.

       Arnd
