Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B045C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42302081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3e4H6un"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfBHSqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:46:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56148 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfBHSq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:46:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id r17so4768525wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 10:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tkvry6DhbzfjyBca+lSPtgCkSaDPcnAkTuoWxDH6XYw=;
        b=Z3e4H6unAQw+B3d197hzsZRn7vAaX+FZUvva8drgLh/YZBVcIC6wF1cNu53U1HlZP1
         a6Re7OXV7gjgdk/rAHRSSPLEILXPbBFCHJKEo+gHnO3MJsnOQNQEqQxEesk98d4+5Cxg
         VdgU5ivzrh8YU3IOXPUd2vOlrXyY/vY1bg9JxzX1RqHQA005Xq86IcuxJe3CVvlMs21w
         qqQEcijTld6BLFKxWonX0sk3tYks1XoS+xteV93GnUvOYTzEPb50SUdA5CP+b8CRgWT9
         B6/b9rgus6iyvRAmS2hwMrDyGscXj4kMd9uRnC0kLApt7TT+74BWhjjGsXBIJ7Gw+9qj
         Mamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tkvry6DhbzfjyBca+lSPtgCkSaDPcnAkTuoWxDH6XYw=;
        b=kc4BeERGNnzSUUCLzYbzW2Xad35fdB8DQ0p/HrRdTEuq+UbZzdNz8HmRtuKEoNedh+
         p0sc2ujurtUXZpU/JkfCManqf7q0+Hx0z9+FV6h+gWU2U+oisRWCE3YkXHgCo2W4hNhS
         3NxR3c1fDk4s6mmYechyMc1Wm0J3thS5vTMw/Tc+ud7z/cIZmXG38fYOiacO2hV2NtsI
         Ohm9SG9Feoef77bvH1JGqGkZlWgDdvHXsFZRYolyWX8da1yrhu1AGEoqPdyRTltCHXVe
         Zqsp9w2LCD8+zZmcbUTKrzrywzzUZwFDkDsVplpjrfCF6EvRG361uxQYZzduiCRoeyRx
         t8Dw==
X-Gm-Message-State: AHQUAubbII9VN/9B6Qd3gzpyx/ACK64f8f63GdZVPaUxFhB5KG8ChXid
        AoVtQKp+TvDCBaBFrs0bBxk=
X-Google-Smtp-Source: AHgI3IZ/Ilbjoy05oU4ZhxiEw/59BpCgKWq4fL32woPQ8K8TJUIhEj6rfdeYNqEF9iKvx2sF93oDJQ==
X-Received: by 2002:a7b:cd14:: with SMTP id f20mr11846055wmj.93.1549651587886;
        Fri, 08 Feb 2019 10:46:27 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id y12sm3002105wmi.7.2019.02.08.10.46.26
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 10:46:27 -0800 (PST)
Subject: Re: [EXT] Re: [PATCH v2] mtd: spi-nor: Fix wrong abbreviation HWCPAS
To:     "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "richard@nod.at" <richard@nod.at>
References: <BYAPR08MB4533C8EA6B775C7514FA7F82DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
 <298d18cf-094b-d5d0-45d1-39c7b75ba309@microchip.com>
 <BYAPR08MB45335415CC3690816C1FD603DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
 <a83a9655-0ce7-da15-ec17-80ef88764e21@microchip.com>
 <BYAPR08MB4533DB0A7F4E30543750C83FDB690@BYAPR08MB4533.namprd08.prod.outlook.com>
 <20190208184718.3c488d0d@kernel.org>
 <BYAPR08MB453327FB53F7DFE50C55C1B4DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <7278fa87-bfe4-3d95-9a9a-5ef4c0277d78@gmail.com>
Date:   Fri, 8 Feb 2019 19:46:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR08MB453327FB53F7DFE50C55C1B4DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/19 7:43 PM, Bean Huo (beanhuo) wrote:
> Hi,Boris 
> I sent three times, seems last time is successful. would you check that is correct?
> 
> git send-email 0001-mtd-spi-nor-Fix-wrong-abbreviation-HWCPAS.patch
> 0001-mtd-spi-nor-Fix-wrong-abbreviation-HWCPAS.patch

git send-email --annotate --to=... --cc=... --cc=... 000*patch

This will likely make your life easier, rather than having to paste
various email addresses to git send-email queries.

[...]

-- 
Best regards,
Marek Vasut
