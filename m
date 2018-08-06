Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E96C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3E821A5E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1ORIjge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3E821A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732787AbeHFVia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:38:30 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35461 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731454AbeHFVia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:38:30 -0400
Received: by mail-io0-f196.google.com with SMTP id w11-v6so12008490iob.2;
        Mon, 06 Aug 2018 12:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ChJUtLcgVl2ea+PYpvAYEDaniTyXdkr9NSQ3gHEosCU=;
        b=e1ORIjgeeMRmIjqOpfDUnSQ0cyvhdcTTgiojxrfQzdTnyBbGfcq34Gw+JZXwhF3pWV
         zRyipfbuCSpcagGlv0JKydXoq5Q9ZsR6U73eCA6KU9SGdw6qOmNmoCh7tabSfH1OeGbi
         5CL45evi5TVebwDIMgeLHo6GPKozCYr5DPb3Hnf2D9EBUXGj4mBrHMHWEn23+UYW65Xn
         5QBKsHdSN9VWnI2hyvtMPdecYEjx015C1PNCcXP4SYC3hqjfoDlmkasjdVKE7w7xvlnY
         cmlOa1I3TyrPwfKmEydTGdBDg6a9KMSOINJDJl0bIxaAlN/ivmyNBjJMDYuyMeOGtS2F
         wkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ChJUtLcgVl2ea+PYpvAYEDaniTyXdkr9NSQ3gHEosCU=;
        b=Xj+Mhqs3679JE7G4kJvXWhmfNeZmqgTKehxFf4coXyqc+/zKp1YOaSEFvmAul4Y/TL
         r6d3QPOzbMUwvhSLjIC77dBtgmI8e/3GI2SAz3x2FQ5KfgVszPrV0FVgYcDCm9ee5tSW
         akCyIx2Gbu9dJvNcl+WtU5hmwkpDXbFKZWHhqYKj58Q2Fbn2+OaERACEUJPvexBBo+xC
         ZO5FtfitkZPsIhn7AKSProyY3xs0xhUJrgK57kPbZGT4Z2O1+MvkRuiVNFe52OWqhG1P
         7KvhZGAvIu/YVTRlVXzPiYimczGAwukeRf4q1aLgkLAbFttxkrol6UP3VepIWCP7+s+e
         NSAw==
X-Gm-Message-State: AOUpUlEPq/9NrwmAsNI5Td9nO2urK22ReFv3KlDuZ2W4bkJBsmVZB7bu
        47+21UlY8AaK1AQ3jBBnyOsLjcgSfjER4YdgW1baZOBkZao=
X-Google-Smtp-Source: AAOMgpf+qJLqAx2NkOcj1Wj+cyPP7I0cJvNyMEv9KgdKb3nHKx3RjOBQhE9ZwFsyInDIw4TnPwCj8LyvG3X68d6iLmk=
X-Received: by 2002:a6b:254e:: with SMTP id l75-v6mr15503965iol.47.1533583677843;
 Mon, 06 Aug 2018 12:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180806185158.2382-1-zertsekel@gmail.com> <20180806190912.GJ9372@lunn.ch>
In-Reply-To: <20180806190912.GJ9372@lunn.ch>
From:   Kosta Zertsekel <zertsekel@gmail.com>
Date:   Mon, 6 Aug 2018 22:27:46 +0300
Message-ID: <CADxo8W+5rvp-cFzqiSJ7RGC13N42v45N0pJ+m+2qO8DQ5AWS7Q@mail.gmail.com>
Subject: Re: [PATCH] spi: orion: cosmetics - alias long direct_access variables
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat@cesnet.cz>,
        Stefan Roese <sr@denx.de>, Ken Wilson <ken.wilson@opengear.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 10:09 PM Andrew Lunn <andrew@lunn.ch> wrote:
>> @@ -683,6 +683,7 @@ static int orion_spi_probe(struct platform_device *pdev)
>>
>>       /* Scan all SPI devices of this controller for direct mapped devices */
>>       for_each_available_child_of_node(pdev->dev.of_node, np) {
>> +             struct orion_direct_acc *dacc;
>
> I would prefer direct_access, but it looks like this is too long to
> put the devm_ioremap on one line. But it should be enough to fix the
> odd indentation of r->start and PAGE_SIZE.

Actually, the longest possible name to put devm_ioremap on one line is
`dir_acc`.
I think `dir_acc` is readable enough to ring the `direct_access` in
the mind of a reader.
