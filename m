Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02FAC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C75208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SdjDbNTD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LEvXmg3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C75208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeHXSFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:05:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49974 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHXSFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:05:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 311F46053B; Fri, 24 Aug 2018 14:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535121016;
        bh=RPu1z3Ex41prKE4O836SWVeYqvVh0HljERphfvvNZGQ=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=SdjDbNTD4PCz8Q24Jq8GgwLG+WB7D15mKy+TpArCGuLLfkyOTlgUGJ8TowQJEQ/K2
         v0NnUascYsnzgU79l170DoDUcvWssaJPN9mR8lbJR8DgF/3XfqGMTUWmZo9cQoLy/0
         U4BhAnAWknoyHK0OQ4AEJNaqQfbTvIiwKyGyJwLI=
Received: from WUFANW10 (c-71-205-14-210.hsd1.co.comcast.net [71.205.14.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wufan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C02D360251;
        Fri, 24 Aug 2018 14:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535121015;
        bh=RPu1z3Ex41prKE4O836SWVeYqvVh0HljERphfvvNZGQ=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=LEvXmg3oDLdjrhLMQ8u+tqk1vOQNkJrqpIQ2UPm5vyakMHWFtSqCOnST8n4TAaksR
         mqANaZ/ZnAd/hZ5hK5xrwXSOB4xqDQDeGOS/GVfC6PpRtK8R84Cu7h/GjRY2Mk/3jO
         EsHmBLrYSED7PUcoYHIDMRMifIDu8Yzy0JPSEymQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C02D360251
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wufan@codeaurora.org
From:   "wufan" <wufan@codeaurora.org>
To:     "'James Morse'" <james.morse@arm.com>,
        "'Tyler Baicar'" <baicar.tyler@gmail.com>
Cc:     "'Tyler Baicar'" <tbaicar@codeaurora.org>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        <harba@qti.qualcomm.com>, "'Borislav Petkov'" <bp@alien8.de>,
        <mchehab@kernel.org>,
        "'arm-mail-list'" <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
References: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org> <20180719140102.GB25185@nazgul.tnic> <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com> <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org> <b568fdcc-ca39-67ea-2799-8ed246c8ffb6@arm.com> <CABo9ajA7SPrVE-oiG=RicH+nL9_pp7fVATCdMugY5fuNAPzHaQ@mail.gmail.com> <68a800c7-446e-9b6b-1847-6e45a1d17262@arm.com>
In-Reply-To: <68a800c7-446e-9b6b-1847-6e45a1d17262@arm.com>
Subject: RE: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
Date:   Fri, 24 Aug 2018 08:30:13 -0600
Message-ID: <000b01d43bb6$f9419b20$ebc4d160$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQH/tyYeKuXYVNfD6ebQEYdjN2RjhwF4k3N9Ak2wROQCV0MBzQGuyO4eAk3P3l0Ccx7S46QTiz6Q
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,=20
=20
> Why get avoid the layer stuff? Isn't counting DIMM/memory-devices what
> EDAC_MC_LAYER_SLOT is for?

Borislav has explained it in his response. Here let me elaborate a =
little more. To use the layer information you need an accurate way to =
pinpoint each component in the layer and the parent components in the =
layers above. For example, to use EDAC_MC_LAYER_SLOT you also need =
information for the parent layer say EDAC_MC_LAYER_CHANNEL, or another =
layer on top say EDAC_MC_LAYER_BRANCH. There are no clear ways to get =
the information from SMBIOS table. In the case of "memory channel" we =
looked at type 37 which has the exact spelling but it was introduced to =
support RamBus and Synclink. Not sure we can readily use it for modern =
architecture concept of "channel/slot".=20

 I think it is good enough if we can pin each error to the corresponding =
DIMM. At the end of the day DIMMs are what customer can replace in the =
memory system and that's all that they care about. For the manufacturers =
of the board/chips they have the knowledge to map the specific DIMMs to =
the upper layer components, so they can easily collect error counter =
data for upper layers.=20

> CPER's "Memory Error Record 2" thinks that "NODE, CARD and MODULE
> should provide the information necessary to identify the failing FRU". =
As
> EDAC has three 'levels', these are what they should correspond to for =
ghes-
> edac.
>=20
> I assume NODE means rack/chassis in some distributed system. Lets =
ignore it
> as it doesn't seem to map to anything in the SMBIOS table.

How about type 4 "Processor Information"?

> 'Card' doesn't mean much to me, but it maps to SMBIOS:17 "Memory Array
> Structure", which the Memory Device structure also points to.
> Card then must mean "a collection of memory devices (DIMMs) that =
operate
> together to form an address space".
>=20
> This might be what I think of as a memory-controller, or it might be
> something more complicated. Regardless, the CPER records think its =
relevant.

Originally I thought "Card" were memory channel. But looking at the =
definition of "Card Handle" in CPER: "... this field contains the SMBIOS =
handle for the Type 16 Memory Array Structure that represents the memory =
card". So Card is memory controller or something similar to that. Right =
now ghes-edac assumes one mc. We probably need to map mc(s) to the type =
16 instances in SMBIOS table.=20

Thanks,
Fan
=20


