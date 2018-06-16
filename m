Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F608C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 14:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46C3208D7
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 14:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hmh.eng.br header.i=@hmh.eng.br header.b="k6kaq8eC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pK0tjVUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46C3208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hmh.eng.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754189AbeFPOMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 10:12:40 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:48119 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754105AbeFPOMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 10:12:37 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 281DB21193;
        Sat, 16 Jun 2018 10:12:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 16 Jun 2018 10:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmh.eng.br; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=hSmTsCOqURpovvI6PSOMBqVrA+VKgbbw2tEnGQYOJck=; b=k6kaq8eC
        crf0YQUrSM8CUyU+DruAk5LDySzXyOYZ6WpmeKSIdmzbOweKxaI4WunJUGaTamNL
        Xx5/s5xOav3dvmrdnR+i6I1GoYqzgsA38tv3eYNURgj1EowYKnai7NvfGOo43OwS
        InFaHtaqGbN9HlQvDv2KGsWpsopDgnZLfX4Iksj2Gd51XD48X1J2RPza0zFo//et
        I1mzcnuLOAjvD8YnFJOP1c++BIhUbZy2t9Bamd7D3nC2XL78TbK5sG3RyQ27Kke5
        T3mUHgVxL1dOOuXatk5uGIzeeodM2MmGUKh5fejPNiAfFrt7kSI9nWPypzt1fMSz
        Wf/HWENi4Oi9Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=hSmTsCOqURpovvI6PSOMBqVrA+VKg
        bbw2tEnGQYOJck=; b=pK0tjVUa4gB4LL2WdEt9+Dq4NQNvqaASpXRYtlxk76RJa
        3Kir/na3XUAmTlOJ7so6lyIFr7HqmkdKl/M9YPbGDUNObgY4qzIX7bcRvOhXuQWE
        CXtFyFcqPsMAKUxlkyfOaIv2ZNZCn1bOoLkbeouAsqofWT01GM9Pz7K/rtGsc9I8
        Y/msqrpHnnhrSZH6iyna862M6lKtap/LdFLQjtNJZ6uYuDePtGlwYTlO1gPjgvK1
        OLfz8zaFM/+Qsi+8dI6Aqz5HwVxBEG/hetwdKVJXsnmeZV/6bka1k11bcFeBOOvH
        s9R9HilMM/Hk3xR2uv8xSNCn/IMp6tDTbE9bzEYjw==
X-ME-Proxy: <xmx:0holW2K9g-i92DitVTEEjBHjOHa3Y83v-LXgApjgl7gIGuuBubqfOw>
    <xmx:0holW8H3bxZHvOwFkDpaE3tAoKmlWw6Cw4o0pBKf8cUpL9tCa89o7g>
    <xmx:0holW-Rg9tNUWf9CH-XBEsCWwFaYCd6WBJiun19Xnqo3BLHwzkmcvA>
    <xmx:0holW4EEvEL38PVWgqmG_vyNWvx44dyaIeSQ5BC24Y7YI0BqObKsfw>
    <xmx:0holW6-DmjbIc7NuhlwPQ8yONM9cnflhnSy1bCZDeGYFecLZ3zIM7Q>
    <xmx:0xolW9YpFpQs6Hrehy9B316F1589rls8kD3sqN_ltRjJIHnetGb0Ig>
X-ME-Sender: <xms:0holW8IsGkLzKTQfaogrP4MYwaBIMQkEss5Qm7dZY1QDgLwGeRjdEg>
Received: from khazad-dum.debian.net (unknown [201.53.245.99])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9A448E425A;
        Sat, 16 Jun 2018 10:12:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by localhost.khazad-dum.debian.net (Postfix) with ESMTP id F07523400436;
        Sat, 16 Jun 2018 11:12:32 -0300 (-03)
X-Virus-Scanned: Debian amavisd-new at khazad-dum.debian.net
Received: from khazad-dum.debian.net ([127.0.0.1])
        by localhost (khazad-dum2.khazad-dum.debian.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Wl9SwYhXvq2M; Sat, 16 Jun 2018 11:12:32 -0300 (-03)
Received: by khazad-dum.debian.net (Postfix, from userid 1000)
        id 1234F3400435; Sat, 16 Jun 2018 11:12:31 -0300 (-03)
Date:   Sat, 16 Jun 2018 11:12:31 -0300
From:   Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ThinkPad T480s & LED_MUTE, LED_MICMUTE
Message-ID: <20180616141231.dy4mvirgeax2tviq@khazad-dum.debian.net>
References: <20180608111057.4wxpg7m7nm7suf6n@pali>
 <20180615112606.GA3986@amd>
 <20180615113728.h7snxhe2juaqvjyx@pali>
 <20180615123007.nxsymdvr3nj3it5i@khazad-dum.debian.net>
 <20180615190915.cdntdeesc52ei35u@pali>
 <20180615233628.gy2ffgupctheyqof@khazad-dum.debian.net>
 <20180616073334.GA13880@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180616073334.GA13880@amd>
X-GPG-Fingerprint1: 4096R/0x0BD9E81139CB4807: C467 A717 507B BAFE D3C1  6092
 0BD9 E811 39CB 4807
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jun 2018, Pavel Machek wrote:
> Question is if we want flexibility or security.

For thinkpad-acpi, it is security by default.  Flexibility is allowed as
*compile*-time (Kconfig) option, and only as long as it defaults to
secure *and* the help text is very explicit at instructing distros to
NOT enable this option.

That said, if mic-mute is under HDA mixer control, it will only be
"secure" if ALSA is also blocking userspace access to the relevant bits,
and if that is not possible to do properly, might as well go for
flexibility.  But only in that case.

That would be why I use phisical shutters on embedded webcams unless the
hardware actually airgaps them from the USB bus when the privacy switch
is active.

-- 
  Henrique Holschuh
