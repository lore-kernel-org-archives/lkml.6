Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63382C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AFE2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25AFE2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966530AbeFSPPJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:15:09 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:46936 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966451AbeFSPPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:15:05 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1fVILT-0000LN-Lo; Tue, 19 Jun 2018 17:14:59 +0200
Date:   Tue, 19 Jun 2018 17:14:59 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Dave Mielke <Dave@mielke.cc>
Cc:     Nicolas Pitre <nicolas.pitre@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] have the vt console preserve unicode characters
Message-ID: <20180619151459.3il7hfdqyucit57o@angband.pl>
References: <20180617190706.14614-1-nicolas.pitre@linaro.org>
 <20180619130953.bxil552igfkckjmr@angband.pl>
 <20180619135213.GB2563@beta.private.mielke.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180619135213.GB2563@beta.private.mielke.cc>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 09:52:13AM -0400, Dave Mielke wrote:
> [quoted lines by Adam Borowski on 2018/06/19 at 15:09 +0200]
> 
> >You're thinking small.  That 256 possible values for Braille are easily
> >encodable within the 512-glyph space (256 char + stolen fg brightness bit,
> >another CGA peculiarity).  
> 
> Not at all. We braille users, especially when working with languages other than
> English, need more than 256 non-braille characters. Even for those who can live
> with just 256 non-braille characters, it's still a major pain having to come up
> with a usable braille-capable font for every needed 256 non-braille characters
> set. I can assure you, as an actual braille user, that the limitation has been
> a very long-standing problem and it's a great relief that it's finally been
> resolved.

Ok, I thought Braille is limited to 2x3 dots, recently extended to 2x4;
thanks for the explanation!

But those of us who are sighted, are greatly annoyed by characters that are
usually taken for granted being randomly missing.  For example, no console
font+mapping shipped with Debian supports ░▒▓▄▀ (despite them being a
commonly used part of the BIOS charset), so unless you go out of your way to
beat them back they'll be corrupted (usually into ♦).  Then Perl6 wants ｢｣⚛,
and so on.  All these problems would instantly disappear the moment console
sheds the limit of 256/512 glyphs.

So I'm pretty happy seeing this patch set.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ There's an easy way to tell toy operating systems from real ones.
⣾⠁⢰⠒⠀⣿⡁ Just look at how their shipped fonts display U+1F52B, this makes
⢿⡄⠘⠷⠚⠋⠀ the intended audience obvious.  It's also interesting to see OSes
⠈⠳⣄⠀⠀⠀⠀ go back and forth wrt their intended target.
