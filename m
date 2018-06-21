Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8FFC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DD3208B6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwXA6Veo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DD3208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932993AbeFULYM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:24:12 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45724 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbeFULYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:24:10 -0400
Received: by mail-wr0-f196.google.com with SMTP id o12-v6so2768648wrm.12;
        Thu, 21 Jun 2018 04:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6irLPcupmnrNHh6QSRO6iuHlUofdgzKL57NiYrFkMxM=;
        b=pwXA6Veot9lY7W4/yJ2DgZP3E/gxdornXz7UTRnlGIJQcjkddpWlMc2nDVNMj5z1R+
         JfEYpztZSjPkNis2HxGzwsp3z3rV05ylZL+B4ndoh5Iptm5XIyl1KiWgVEdn+6+csA3I
         qGReHk/0D9r4nOb7L5t5uzRkuP7q3rtbPQi7IGoq15qtWkOyyUFYrBNWjEaIXXn0eIIh
         GbY1NXNFxbG4jxGbmFYX9dx68A+ve+Mwba4EAXlCF3TBTDZwx76dDzbAxNgTmOE/8WoJ
         ElGOsHCZXkb7VPz6zUt6Nc4RsfIY534EmJooM6Vjo4gPvI/UgYZMiB32wCOgHnMPQyo/
         mtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6irLPcupmnrNHh6QSRO6iuHlUofdgzKL57NiYrFkMxM=;
        b=PubV63y+g9PrAL+etiLSWQAhMZmquHzvInMOS52su6zsiim/F0D+I4bWXZjSaH5CGc
         EB41UTu7Cc0GWT7+Q51OqFrgkHrI5QSJ8upyNPIVZaFMeDC2MRt61VygxlZIu8LDIuIO
         uu2frmcFa85jwVK9BQyW/j4dQ1jkS7iLoYxnObJUVQY9hvmMtUr8rUZzm4Z4qg/KL0Wv
         H2MhSUaBcZwxVOn4Gm6l0YrHGoGBbEYP1+T7M4+WjWYPVe/W05Ju40xnQ2yncLftpVjG
         7LuxxJ96XAbuB3B/OxFEkH3XCt0YWWfQVNii/4IkMxAo/2tbqX34NT1e3EMUX26JJLOm
         0k5w==
X-Gm-Message-State: APt69E1Ak7RIEgKBg7iZFavrMJwqdw35SwSYjIDO5+dmgXpjgmjKKqNl
        JXroAbMeEMS6dYPzVGB5xHg=
X-Google-Smtp-Source: ADUXVKKVMbtTorMUZ5MV+orcP1isyrMYqun3bEESzkHGeEJaLp+4zxE+tWu2VCSh6x2/irM8ZgPdxA==
X-Received: by 2002:adf:e881:: with SMTP id d1-v6mr22136306wrm.43.1529580249547;
        Thu, 21 Jun 2018 04:24:09 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id y8-v6sm6533907wrs.0.2018.06.21.04.24.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 04:24:08 -0700 (PDT)
Date:   Thu, 21 Jun 2018 13:24:07 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ThinkPad T480s & LED_MUTE, LED_MICMUTE
Message-ID: <20180621112407.fxwnkdvgtxwifryd@pali>
References: <s5hk1r01acc.wl-tiwai@suse.de>
 <20180615190959.pqipwnm6a3tf3lxc@pali>
 <s5hmuvvtdmi.wl-tiwai@suse.de>
 <20180616154309.ualrx2py6ndr5xgz@pali>
 <s5hh8m2u3cp.wl-tiwai@suse.de>
 <20180618102806.vwm4rhvxhn6hi43z@pali>
 <s5ha7rsz8i8.wl-tiwai@suse.de>
 <20180618112121.cl76a3oozsbbbqnb@pali>
 <20180619083712.dwb4d357sfxcgrre@pali>
 <s5ho9g7dv6j.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <s5ho9g7dv6j.wl-tiwai@suse.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 June 2018 10:42:12 Takashi Iwai wrote:
> On Tue, 19 Jun 2018 10:37:12 +0200,
> Pali Rohár wrote:
> > Interesting is this part:
> > 
> > $ head /proc/asound/card0/codec#0
> > Codec: Realtek ALC257
> > Address: 0
> > AFG Function Id: 0x1 (unsol 1)
> > Vendor Id: 0x10ec0257
> > Subsystem Id: 0x17aa2258
> > Revision Id: 0x100001
> > No Modem Function Group found
> > Default PCM:
> >     rates [0x560]: 44100 48000 96000 192000
> >         bits [0xe]: 16 20 24
> > 
> > It uses vendor id 0x10ec0257 and support for it was added into
> > snd-hda-codec-realtek in commit f429e7e494 which was introduced in
> > version v4.15.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f429e7e494afaded76e62c6f98211a635aa03098
> > 
> > I applied this patch to Debian's 4.9 kernel and mute & mic mute leds
> > started working. This one patch was enough.
> > 
> > Takashi, it is possible to backport this patch into -stable trees?
> 
> It has already a Cc-to-stable, so it should have been backported.
> Maybe it wasn't applicable at that time due to lack of other dependent
> patches...
> 
> In anyway, feel free to ping Greg for including it to 4.9.x if it
> works for you now.

I sent email to Greg, but it was eaten by "email-bot of Greg
Kroah-Hartman's inbox". So I sent another patch email to stable ML.

-- 
Pali Rohár
pali.rohar@gmail.com
