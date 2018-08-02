Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50281C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0183E2150E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvqPWRBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0183E2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbeHBQIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:08:15 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33619 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732283AbeHBQIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:08:15 -0400
Received: by mail-io0-f193.google.com with SMTP id z20-v6so2003913iol.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IdF7jUEexRC4GbnJH7EPr1jr8K9tF5uKiVoaWGfOuMI=;
        b=TvqPWRBBwZq+asp0Lf0wUBIErRz8bj3xUgb6E8/hMUZNqbx2WEtH5WoRPIURc1MSAK
         McNywcshro03blTyWFGKqInFZX+IJcp2l4VKYBzkQrt2ay0kX9i4UA4uxDHNBjhYkSO3
         vFnj2e1LD2M6yPEhz3ghOrRvjc7dfSMNnBmwCJUZOEWYn7nsDs4sJX55EPHqhSt+3aBX
         s7h+3PBNIItSdV37QKI9QDU0U0IVSer5ibQZzAtqowTuIPHixtbaSWEP1Ja1ELDZ1DMO
         Ll4ImBh77A9FIidNgHnbOuDfbLf0ehxZlgbdjBPMGRRf8UZeNSouEV8vxIMhbTxFUw7i
         Phow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IdF7jUEexRC4GbnJH7EPr1jr8K9tF5uKiVoaWGfOuMI=;
        b=Gd7T/Kxfn3jwr2mswxVY0ORHD7plTvG59mqNikhWITM5rqMZo79dkyeaVcxrVpAQxH
         4UWh+QGnxqD5ZnrrC/tlL85uISSfk9LgkT/zRXn/QTduEEhHVT9FMEKQb5/VFC05cuxY
         i4bYdw8MnontQy2mR1j/isad1stm2g97buC+FQHHFa+RVQK6qq/ZyCPo62HGZWSNmHMd
         LV7nWdnpfKIW9mX17e+SIN9IBSf4yiG06LacEJwJ6ywoAeH+UaZLY5Pitb07UZ/0aahz
         lYuXyUL2oE5u3lN2Kd5WvuXa7fmd3w81Q+OJANk0z4zbOtCNIzkTXrkI9voTPQVoB3eB
         TNEg==
X-Gm-Message-State: AOUpUlGiK9vKvi0sAK7OdU9/s8Ykv5Cam+QLYQwpjyMHMFe6j2OaO8p5
        fXU5nRCdOWPJRIZ//RkFEmVsLhWquoM=
X-Google-Smtp-Source: AAOMgpeLwTUWeGaVesbXIu+j2d95AI2ZWblwBqI3iW+z06pG3fY68VwNFiUBya2g7Lm+xU31XiCqxg==
X-Received: by 2002:a6b:f40b:: with SMTP id i11-v6mr2400679iog.162.1533219410727;
        Thu, 02 Aug 2018 07:16:50 -0700 (PDT)
Received: from [100.71.5.67] ([184.151.246.124])
        by smtp.gmail.com with ESMTPSA id m1-v6sm528929iok.81.2018.08.02.07.16.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 07:16:49 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [RESEND PATCH 6/6] arm64: enable RapidIO menu in Kconfig
From:   Alex Bounine <alex.bou9@gmail.com>
X-Mailer: iPad Mail (15G77)
In-Reply-To: <20180802140033.GH38497@guest228.east.isi.edu>
Date:   Thu, 2 Aug 2018 10:16:48 -0400
Cc:     Christoph Hellwig <hch@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jwalters@isi.edu, Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Message-Id: <D6EE6CE1-FB11-41EB-B787-A093D26CE3E3@gmail.com>
References: <20180731142954.30345-1-acolin@isi.edu> <20180731142954.30345-7-acolin@isi.edu> <20180801095404.GA17585@infradead.org> <fad8661c-cd8c-3a9c-ca03-5d2f63893a24@gmail.com> <CAMuHMdVDra1MKcuuD0SqEYXSggr0iVFcbcjL33z7JuiE1_y8yw@mail.gmail.com> <20180802134544.GG38497@guest228.east.isi.edu> <20180802135421.GA13512@infradead.org> <20180802140033.GH38497@guest228.east.isi.edu>
To:     Alexei Colin <acolin@isi.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will experiment with this idea.
Please keep me in CC as well.

Sent from my iPad

> On Aug 2, 2018, at 10:00 AM, Alexei Colin <acolin@isi.edu> wrote:
> 
>> On Thu, Aug 02, 2018 at 06:54:21AM -0700, Christoph Hellwig wrote:
>>> On Thu, Aug 02, 2018 at 09:45:44AM -0400, Alexei Colin wrote:
>>> If I move RapidIO option to drivers/Kconfig, then it won't appear under
>>> the Bus Options/System Support menu, along with other choices for the
>>> system bus (PCI, PCMCIA, ISA, TC, ...).
>> 
>> It's not like anyone cares.  And FYI, moving all those to
>> drivers/Kconfig is osmething I will submit for the next merge window.
> 
> Ok, I would appreciate a CC on that patch. After it lands, if
> there is time, I'll resubmit a rebased version of this patch.
