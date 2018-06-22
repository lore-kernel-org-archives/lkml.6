Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE4CC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E7124072
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E7124072
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754385AbeFVKlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:41:23 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:20992 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753275AbeFVKlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:41:22 -0400
Received: from belgarion ([90.55.203.186])
        by mwinf5d64 with ME
        id 1mhF1y00V41oiFu03mhFT1; Fri, 22 Jun 2018 12:41:19 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Fri, 22 Jun 2018 12:41:19 +0200
X-ME-IP: 90.55.203.186
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Takashi Iwai <tiwai@suse.de>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>
Cc:     "Liam Girdwood" <lgirdwood@gmail.com>,
        "Mark Brown" <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ALSA: ac97: add codecs devicetree binding
References: <20180621154356.5438-1-robert.jarzmik@free.fr>
        <20180621154356.5438-2-robert.jarzmik@free.fr>
        <s5ha7rnditx.wl-tiwai@suse.de>
X-URL:  http://belgarath.falguerolles.org/
Date:   Fri, 22 Jun 2018 12:41:14 +0200
In-Reply-To: <s5ha7rnditx.wl-tiwai@suse.de> (Takashi Iwai's message of "Thu,
        21 Jun 2018 21:45:46 +0200")
Message-ID: <874lhvnlx1.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai@suse.de> writes:

>> Special review query: review the "return of_node_get(node)", which
>> assumes that upon device removal, of_put_node(dev.of_node) will be
>> called...
>
> Is it really done automagically?  I couldn't spot it.
Neither could I ...

I based this on device_set_of_node_from_dev(), and the it "seemed" logical to me
that a device probed from devicetree would take a refcnt on the devicetree node.

As the "logical" conflicted with my search for the automagical of_node_get(), I
need the special review query.

Cheers.

-- 
Robert
