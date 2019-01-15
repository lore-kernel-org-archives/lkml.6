Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914CCC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB1D204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RqwQu9pS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbfAOP0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:26:48 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9310 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfAOP0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:26:47 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3dfb990002>; Tue, 15 Jan 2019 07:26:18 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 15 Jan 2019 07:26:47 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 15 Jan 2019 07:26:47 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 15 Jan
 2019 15:26:44 +0000
Subject: Re: [alsa-devel] [PATCH v1 3/3] ASoC: soc-core: fix platform name vs.
 of_node assignement
To:     Mark Brown <broonie@kernel.org>
CC:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-tegra@vger.kernel.org>, Matthias Reichl <hias@horus.com>,
        <alsa-devel@alsa-project.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Takashi Iwai <tiwai@suse.com>, <linux-kernel@vger.kernel.org>,
        Marcel Ziswiler <marcel@ziswiler.com>
References: <0660a471-3698-2059-4494-ad146518a4ed@nvidia.com>
 <20190109125340.GD10405@sirena.org.uk>
 <52f5f2cf-9260-f9c5-f73d-3c3d5debc86b@nvidia.com>
 <20190109141439.GE10405@sirena.org.uk>
 <875zuxb9uy.wl-kuninori.morimoto.gx@renesas.com>
 <a2068291-e554-cc4f-9af9-0022f3c4de34@nvidia.com>
 <871s5kqb43.wl-kuninori.morimoto.gx@renesas.com>
 <dfdc497f-9e52-99d7-208c-d8eef31fe61d@nvidia.com>
 <87h8efpoxh.wl-kuninori.morimoto.gx@renesas.com>
 <ea6b6a3a-b4eb-1d29-51fd-330b2b170005@nvidia.com>
 <20190114230255.GK11073@sirena.org.uk>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <312f8e32-36ed-cadb-77cb-54267680fefb@nvidia.com>
Date:   Tue, 15 Jan 2019 15:26:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114230255.GK11073@sirena.org.uk>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547565978; bh=7jya5haRRX9+yIOQO6s+SqZP9w+QmFokNgyExMys3OU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=RqwQu9pSHjuwBE+3vp8W54edhS9wOp0F6JpTUKsIo8t49pVZddllQ2eEAQTAT5/aa
         Bsx7wG96bJcrikvhAT61gS6pVtUb8Iln0q6g87b/MFkUUOPyI69U50qXCFoHNQ9eJV
         nYz+udOioErqJb0b8qcniotPIqXufoZvWkIp8NAnK4Q3c/V5sDUuf/qBBj8ChCl4a2
         wADSz+qCEUzUfZUoEtktLSfFKxt+Gj73sNrsF5yu451eg7fCc3b4IOX0fppnPyOvZP
         6j5l129uTTTyQHixdvvH91XKZ5M1WMm/ZsuEknr6wTOSYGIvIqD7Jbqob6t0AyZ6zF
         BwqYSgIqA1lPg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/01/2019 23:02, Mark Brown wrote:
> On Fri, Jan 11, 2019 at 09:15:42AM +0000, Jon Hunter wrote:
>> On 11/01/2019 08:51, Kuninori Morimoto wrote:
> 
>>> So, can you agree about these ?
>>> 1) Add enough information/documentation about legacy/modern style and its plan.
>>> 2) Add dirty pointer fixup patch as workaround
>>> 3) switch to modern style as much as possible
> 
>> I think that Mark needs to decided on whether use your 'dirty pointer'
>> fix or not.
> 
> I've gone ahead with Curtis' version of Morimoto-san's patch just now -
> hopefully that's fine for v5.0.  Like we've been saying neither approach
> is ideal, thanks Jon and Morimoto-san for your efforts analyzing this
> and your proposals.

Thanks! Works for me.

Jon

-- 
nvpublic
