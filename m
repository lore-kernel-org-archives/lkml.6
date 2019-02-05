Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121AFC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E1C217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ewxtkuEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbfBEUOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:14:15 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:41297 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfBEUOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 15:14:14 -0500
Received: by mail-pf1-f173.google.com with SMTP id b7so1989043pfi.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 12:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=/6IWnNQoetMgHbg5Oy2HaxiOE3N1l1GqbhK5Zti3yI8=;
        b=ewxtkuEW1dRRm7al5eRUddT5tEp9DFSGkJCpxlZqeWmtZ/SkozTHMlUIOYCgqkbHUu
         pBLKYccJNyRcWv2nAqQVL6o5fV7pdf83JRQzyA080QZnj4AfQ1+lYi0IGcWKLJlnqOZF
         Xpp8SGE5eeeWT6tBM4vC29oIyreU0vTai8ODZOgX9obNJ6dp6rq0HqaC0GCeSPQMIfzh
         x5iBhNal/JeP0IPgsl9RmGQKKMv0VIfWAA7j7pKwFfZi8WKL0b3Csgf90BCZ50RyRk2I
         yBRvmuYxcMUuBGyOduyrU1q5BGWUsCfLNrOb8v0wax5RzyQAE6hjF8K1Biyxyf/Y0F2m
         W9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/6IWnNQoetMgHbg5Oy2HaxiOE3N1l1GqbhK5Zti3yI8=;
        b=OgAXHYgDKKIcyLsflaFZyJVOeyIhfgZfhMxYaTQNzRFWJ6EaLpBLyPt7rQLN1CkkTG
         MwmdouJLBpPxtCFoD/NKL3te6tunXiDDTO3q3ZysmAs1L0CCcr0IaMJktg3mtemgW1uB
         iZYFfg1jpNhAcMAWAt1719VUYWBTC7eq/BE10E4be8HH0xTgIeM8GD2UjX/EO3JZMiez
         Cfub5C1To8FDscaDyK1Xc2X+RPXMwIhxKSv9JTlnrZXF+e4osT4n71GLR7I8OVAj6OC6
         /ZErTMTvbCGKolq9phersosZTFQ/YHFlzfA0vwipemFMZr6kuhiyB+oSQlNqQ9cSCGJl
         Jkvw==
X-Gm-Message-State: AHQUAuanjuOq4v6S/p/FPwD49TaHRgY1VfMstjt2mnomT1WUc4mleAtt
        NtyiRdYUr+/l3II7l8iwWIxxRC7eEC8=
X-Google-Smtp-Source: AHgI3IZGQ0NxdDfuqUCGsKhbKzW/OnILHKm9jFkLHcWiE2NLV4YyTj+MaENkKqoNaa4ciUTdKLyGyg==
X-Received: by 2002:aa7:8608:: with SMTP id p8mr6857879pfn.125.1549397653787;
        Tue, 05 Feb 2019 12:14:13 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:d969:4d14:da79:2cab])
        by smtp.googlemail.com with ESMTPSA id j9sm4931946pfi.86.2019.02.05.12.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 12:14:13 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        "clabbe\@baylibre.com" <clabbe@baylibre.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexey.brodkin\@synopsys.com" <alexey.brodkin@synopsys.com>,
        "linux-snps-arc\@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: RE: [PATCH 2/2] arc: hsdk_defconfig: enable CONFIG_ARC_UBOOT_SUPPORT
In-Reply-To: <4881796E12491D4BB15146FE0209CE64681D4DC3@DE02WEMBXB.internal.synopsys.com>
References: <1549355535-22052-1-git-send-email-clabbe@baylibre.com> <1549355535-22052-3-git-send-email-clabbe@baylibre.com> <1549366931.27724.26.camel@synopsys.com> <C2D7FE5348E1B147BCA15975FBA23075014642EBE9@US01WEMBX2.internal.synopsys.com> <4881796E12491D4BB15146FE0209CE64681D4DC3@DE02WEMBXB.internal.synopsys.com>
Date:   Tue, 05 Feb 2019 12:14:12 -0800
Message-ID: <7h4l9ivvqj.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Brodkin <alexey.brodkin@synopsys.com> writes:

> Hi Vineet, Corentin,
>
>> -----Original Message-----
>> From: Vineet Gupta <vgupta@synopsys.com>
>> Sent: Tuesday, February 5, 2019 7:42 PM
>> To: Eugeniy Paltsev <paltsev@synopsys.com>; clabbe@baylibre.com
>> Cc: linux-kernel@vger.kernel.org; alexey.brodkin@synopsys.com; khilman@baylibre.com; linux-snps-
>> arc@lists.infradead.org
>> Subject: Re: [PATCH 2/2] arc: hsdk_defconfig: enable CONFIG_ARC_UBOOT_SUPPORT
>> 
>> On 2/5/19 3:42 AM, Eugeniy Paltsev wrote:
>> > Hi Corentin,
>> >
>> > In case of devboards (like HSDK) we really often disable bootloader and load
>> > Linux image in memory via JTAG. Enabling CONFIG_ARC_UBOOT_SUPPORT by
>> > default will break it as we will try to interpret some junk in a registers
>> > as a pointers to bootargs/etc which aren't set by anyone in case of JTAG using.
>> >
>> > So it isn't a good idea to have CONFIG_ARC_UBOOT_SUPPORT enabled by default.
>> 
>> Right.
>> 
>> It is difficult to accommodate everyone's needs (often conflicting) in a single
>> defconfig.
>> Can you folks create an out-of-tree defconfig or some such.
>
> I do think there's a proper solution which [hopefully] makes both parties happy.
> Eugeniy is about to send-out a patch which allows us to not care about
> garbage in R0/R2 when running after U-Boot.

OK, cool, that sounds like a good workaround for the JTAG use case.

Just curious: what is the more common case for end-users?  u-boot or
JTAG?

At least on every other arch/board we use in kernelCI, u-boot is the
*much* more common load path than JTAG.  IMO, I would suggest that in
the case of unresolvable conflicts like, u-boot should be the normal
path, and JTAG would be the special case.

Anyways, hopefully the patch from Eugeniy works and gets rid of the
conflict. 

Related: if you end up accepting this series, they'll also need to be
backported to stable branches if we want to support them in kernelCI.

Kevin
