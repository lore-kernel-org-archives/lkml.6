Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AA0C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D922080F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfBKWio convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:38:44 -0500
Received: from linux-libre.fsfla.org ([209.51.188.54]:39424 "EHLO
        linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbfBKWio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:38:44 -0500
Received: from free.home (home.lxoliva.fsfla.org [172.31.160.164])
        by linux-libre.fsfla.org (8.15.2/8.15.2/Debian-3) with ESMTP id x1BMcJ34003936;
        Mon, 11 Feb 2019 22:38:20 GMT
Received: from livre (livre.home [172.31.160.2])
        by free.home (8.15.2/8.15.2) with ESMTP id x1BMc0bI178809;
        Mon, 11 Feb 2019 20:38:00 -0200
From:   Alexandre Oliva <lxoliva@fsfla.org>
To:     Tom Li <tomli@tomli.me>
Cc:     James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] On the Current Troubles of Mainlining Loongson Platform Drivers
Organization: Free thinker, not speaking for FSF Latin America
References: <20190208083038.GA1433@localhost.localdomain>
        <orbm3i5xrn.fsf@lxoliva.fsfla.org>
        <20190211125506.GA21280@localhost.localdomain>
Date:   Mon, 11 Feb 2019 20:38:00 -0200
In-Reply-To: <20190211125506.GA21280@localhost.localdomain> (Tom Li's message
        of "Mon, 11 Feb 2019 20:55:09 +0800")
Message-ID: <orimxq3q9j.fsf@lxoliva.fsfla.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.84
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 11, 2019, Tom Li <tomli@tomli.me> wrote:

> What is the current link to your repository? 

git://dev.lemote.com/linux-loongson-community.git

I use a different git URL to push stuff, so I wouldn't have noticed if
the above was gone, but I've just tried to git clone form the above and
it seems to remain functional.

> We've just identified and confirmed the source of the shutdown problem a
> few days ago on this mailing list. It's related to a PREEMPT race condition
> in the cpufreq framework that triggers a timing-dependent, probabilistic
> lockup in the i8259 PIC driver. And it was first noticed by Ville Syrjälä
> on a x86 system, my debugging rediscovered his findings.

Oooh, thanks for the links.

>> and, more recently, a very slow system overall, that's been present since
>> 4.20.

> The mainline framebuffer driver doesn't have any hardware drawing, printing
> even a single line on the console is required a full screen redraw via memory-

That doesn't seem to explain even a quiet boot up taking several times
longer than 4.19, and package installation over an ethernet connection
(thus not using the console) also taking several times longer.

-- 
Alexandre Oliva, freedom fighter   https://FSFLA.org/blogs/lxo
Be the change, be Free!         FSF Latin America board member
GNU Toolchain Engineer                Free Software Evangelist
Hay que enGNUrecerse, pero sin perder la terGNUra jamás-GNUChe
