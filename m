Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3EFC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C8F2151B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBK6Gcgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C8F2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387646AbeHBQfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:35:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387503AbeHBQfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:35:32 -0400
Received: from mail-qt0-f179.google.com (mail-qt0-f179.google.com [209.85.216.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 004E32152B;
        Thu,  2 Aug 2018 14:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533221042;
        bh=AKIXEe8v96YmQP3Sla2ujSoUbM33kbFNeuZa8751Ze4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vBK6Gcgyl4RQMuQ2EnogXCucqbenhPiLYaMlmv8F5mWFeILvmvjxYT7GQv0XtJO1b
         tlCE7qxRIV9Vmq6Qm21sAUdtOjKymnYGHXB5uOqDkTESiOUMD9i3+OQeJ6tmX+9UqM
         13FiNaJ5QHKUsccIy6jAmaP4KgvdCBsxeZnklxh4=
Received: by mail-qt0-f179.google.com with SMTP id c15-v6so2593451qtp.0;
        Thu, 02 Aug 2018 07:44:01 -0700 (PDT)
X-Gm-Message-State: AOUpUlHiSY/8NTXrkwjQzbIxYv5dqyDOMavRLPBt3K9+Su7k3vrtby9d
        9p6IdMO047Rc4Q0J9H1eVNFKb8PZXgQQA0ocXg==
X-Google-Smtp-Source: AAOMgpdPmRGjwJqm7QyQph2R14SBS6J7+nHqeQ8nWD13xkdJjZ9vak1Qmm7Iig8/pkgVOefWB42/P2sGPrveoTTsxI0=
X-Received: by 2002:ac8:71c9:: with SMTP id i9-v6mr2880580qtp.22.1533221041131;
 Thu, 02 Aug 2018 07:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180725093649.32332-1-hch@lst.de> <20180725093649.32332-7-hch@lst.de>
 <20180731224630.GB12168@rob-hp-laptop> <20180801071635.GC20224@lst.de>
 <CAL_JsqJWOXX7-_sb4W63wPRqFjHuU-DM-LNYgczieWjAE5ABfQ@mail.gmail.com> <20180802095527.GD14203@lst.de>
In-Reply-To: <20180802095527.GD14203@lst.de>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 2 Aug 2018 08:43:49 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+auhyXMYfAp9B9TEkCs0Pw=oAAkXEY9KQYnw1rWUnLEA@mail.gmail.com>
Message-ID: <CAL_Jsq+auhyXMYfAp9B9TEkCs0Pw=oAAkXEY9KQYnw1rWUnLEA@mail.gmail.com>
Subject: Re: [PATCH 6/6] dt-bindings: interrupt-controller: RISC-V PLIC documentation
To:     Christoph Hellwig <hch@lst.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Stafford Horne <shorne@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 3:50 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Aug 01, 2018 at 12:26:31PM -0600, Rob Herring wrote:
> > Not really my problem that they didn't follow the process and upstream
> > their binding first. But this alone is just a string identifier, so I
> > don't really care that much. If things are really a mess, then the
> > next implementations will have to have better compatible strings. More
> > likely, I'll just see folks trying to add various properties to deal
> > with all the differences.
> >
> > You could always define a better compatible and leave 'riscv,plic0' as
> > a fallback to avoid breaking things.
>
> Is there any better way to define a compatible other than having
> duplicate IRQCHIP_DECLARE() statements?

No, but you only need the fallback if the compatible is
'"sifive,plic0", "riscv,plic0";'.

Rob
