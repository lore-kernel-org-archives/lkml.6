Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BB0C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE68208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE68208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756558AbeFOUxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 16:53:23 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:43742 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752884AbeFOUxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 16:53:21 -0400
Received: from mr4.cc.vt.edu (mr4.cc.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w5FKrKMn001345
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 16:53:20 -0400
Received: from mail-qk0-f198.google.com (mail-qk0-f198.google.com [209.85.220.198])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w5FKrFXA018242
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 16:53:20 -0400
Received: by mail-qk0-f198.google.com with SMTP id l29-v6so8923318qkh.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 13:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=b3G4TesSPjqw3xfqxuSHZk9//DhMwI81CN85vDIJEGs=;
        b=Pc5KTHcvL/TLlUFaYJYHFD/8DNmBE3a8G1ypZO2bxDy++MPfm/VUZE2S+jK2DOskEU
         WinJH9pvb41q0aCkVCbKSDKuziX5HGDOHGoERGUIiIdYFWWmvEMxMeEl74LlA4jf6Jn4
         WSgM5SZ6wqnQE2a8fGwsp+fsRSYfTg1ot5t/Ayo1xEW5tQ/E/I2ElkqKwltmlpvac3S2
         kQcJJ9MRxwj1D+XmWrTfjiCLtG7ESlRO3u0LUJ5//Ig9DaC355/PcD6fp4f0Wdq2SaGZ
         +yjlMOq07T3AzrcIYIYUH3YsgtpNQwOySk/daWiDZtbrIB4Ulmb4yd5mXrcLQqLhVgC8
         eE5A==
X-Gm-Message-State: APt69E2ksuKGg0dn/Ydde2uYW/SHiFbnQ7zkifI6EzshnspG6X0MVA9Q
        c+rFNdgJXVkzVH3cYCCV7zQJmxB9bZagZAo0bLNio5VwN37g8ztA6yVE6PvSBIMdGoo/qPD6FFA
        kvL9bKvysHWoWcPiKdNbuEbQLzrhC+Qb7ylw=
X-Received: by 2002:a37:318f:: with SMTP id x137-v6mr2730800qkx.324.1529095995298;
        Fri, 15 Jun 2018 13:53:15 -0700 (PDT)
X-Google-Smtp-Source: ADUXVKLMZLvLnpU7WndUufqvgNyCZQwrFk40p7xdTzwqDAQXaBMcdT8WdflaG66jqHcBJJkfiUeQ8Q==
X-Received: by 2002:a37:318f:: with SMTP id x137-v6mr2730785qkx.324.1529095995110;
        Fri, 15 Jun 2018 13:53:15 -0700 (PDT)
Received: from turing-police.cc.vt.edu ([2607:b400:24:0:c5a7:bb98:8d38:c9af])
        by smtp.gmail.com with ESMTPSA id m6-v6sm9633625qkm.12.2018.06.15.13.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 13:53:13 -0700 (PDT)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To:     Bart Van Assche <Bart.VanAssche@wdc.com>
Cc:     "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "sayalil@codeaurora.org" <sayalil@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "rnayak@codeaurora.org" <rnayak@codeaurora.org>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "malat@debian.org" <malat@debian.org>
Subject: Re: [PATCH V2 1/3] scsi: ufs: set the device reference clock setting
In-Reply-To: <347237a7f32b79aa516aa285700396052a69ccf8.camel@wdc.com>
References: <1528455990-24572-1-git-send-email-sayalil@codeaurora.org> <1528455990-24572-2-git-send-email-sayalil@codeaurora.org> <20180612192636.GA31725@rob-hp-laptop> <000101d403d3$87210d20$95632760$@codeaurora.org> <33eec86a35248e5b20f15bb568641b9affcc0a9b.camel@wdc.com> <95985.1529095054@turing-police.cc.vt.edu>
 <347237a7f32b79aa516aa285700396052a69ccf8.camel@wdc.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1529096002_2750P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Fri, 15 Jun 2018 16:53:22 -0400
Message-ID: <204056.1529096002@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1529096002_2750P
Content-Type: text/plain; charset=us-ascii

On Fri, 15 Jun 2018 20:42:41 -0000, Bart Van Assche said:

> In case I wasn't clear enough: I was referring to replying inline
> *without* quoting the original message. That makes a conversation
> *really* hard to follow.

So if there's no quoted message, what is the inline reply inlined into? :)

--==_Exmh_1529096002_2750P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWyQnQo0DS38y7CIcAQLUugf9HP7oqsNf4LxT+jwE1u8GwM4nUyCmM3zH
jBGKb3y5G26hTo0fQHaaZ9mfSI3vA08K+br5MB0npQkueETbS8qOAq+xwak+Hd97
owOSUyl11r+UcKfkA9n88nLQHI7UblXRjEGypi97gYy/XXZ41mprJUs8kR6ap/Tx
CzVwGVFr/N0NJTtZItT4LhlyOF5i1PO559rdYfLnoyeTbYrUqFn8Vti6z5DK6AoS
3M7iVa4whRW9qSHkQUJIUoy6nYJekrPWctyVs8a0edg5r6lavS1bUyYgViKRWeNl
xxrE1Ip3U1qr6PcMv6k1a/6LFt/JdZjxABsk32bbaqY6W7j2XifqrQ==
=vOHf
-----END PGP SIGNATURE-----

--==_Exmh_1529096002_2750P--
