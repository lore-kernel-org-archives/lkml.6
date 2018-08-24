Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638C7C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D9021567
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D9021567
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=winterdrache.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeHXR7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 13:59:39 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:41113 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeHXR7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 13:59:39 -0400
Received: from ninja ([83.135.210.22]) by mrelayeu.kundenserver.de (mreue105
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0MeBmY-1gJ7EA3quM-00PwLo; Fri, 24
 Aug 2018 16:24:45 +0200
Date:   Fri, 24 Aug 2018 16:24:44 +0200
From:   "Matthias B." <matthias@winterdrache.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: How to report kernel panic in 4.4.x
Message-ID: <20180824162444.71390f71@ninja>
In-Reply-To: <20180824141120.GA31555@kroah.com>
References: <20180824142408.6340d052@ninja>
        <20180824125950.GA29673@kroah.com>
        <20180824160947.49387d7b@ninja>
        <20180824141120.GA31555@kroah.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:fSIJnpIWEwgeQOhsvZhy1uRykVXTyGJwgtZfj3nx8CBWKFcMhzl
 xStEEdYXqFEbMATMFzfP5V1WiUJTPh6jaCs/xucW2eUiQ+ORUwcR0XLD+Oj+P7JdDJQRzdN
 x7oFW0I1LT1XA0KozRbbYsgqiiAklUJeW71kavEOn95eLaU48deVW2ozZIT43XaGZNzzMNV
 LMWw2R5kTr6BYJD4uU9UQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MsbJWqtzJ88=:nIqD/Xzi0LkJpzA0uWtDLR
 wjYHjaKo9gmSsSX/lGPU55EJ0IjJc+vvirnPMnY/0eVQXgoRkGjLHNVLDIe66JUjExL/F4l7p
 UU1jcNPgByJ0ltuCAZWYOtf2IsGlS+FA+LbsSQqzvAWeKaVZ31LM9riz1YVNCLDkldrz2Lk3J
 IqgGFi9+84gYJRNszzOLfF7Wl6/C+lmYYJ/oYetMOrd7h6T+79i4BhClPSMV8rnB/CHGu8g25
 lijOcwIe5mVp3Q4xREjPh2QG78Vgnxkbm1uT2G3m2R/qSJP/Y6KSeAhShV0d9RhWcFYsXf4ML
 riLtUfIkWjRCgFaz1u5ZJ51KSWaMbXe5uAGC70bipoyDKUhiQHR/A+V/T11JUCtVB1Zj6R8LD
 GVNM8gPduSJfFYU2jlroZyaXS8GPQHEL1prsMMcFI8H3+/PjAhU+aS4Hf5tcnbOZ7gDQDxBEn
 IAcN0z2XxyMhy9rVnlKk53qgpIOWdVOckqNtQu5GodzpTM5S14hy7Vr8EsWfjBWSqH9nI/+ow
 moyqRu9ZvkxdrfHk6sCcgwzFdYx1YUE4QU3VB9N1MXXCQPvQaWZ3DxKwaq/eIFSo+2uQ0BUrv
 FHEhe+c3X3nlTB63fS8xB3Fkv6hyYHArKl1uP/8Ws25hggjqqY59oOn2dqhqRWc81BdiGWcmB
 RFwNJJpmpffogTTTto7HDpgv7DDr1poUk2ieqr0Qn9WOjQwO9/PpjhqX7WBnfB2afBymnybPh
 SxUHtad94wuroji1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 16:11:20 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> > [    0.595677] snd_hda_intel 0000:01:00.1: Too many HDMI devices
> > [    0.596251] snd_hda_intel 0000:01:00.1: Consider building the
> > kernel with CONFIG_SND_DYNAMIC_MINORS=y [    0.596839] snd_hda_intel
> >     0000:01:00.1: Too many HDMI devices [    0.597412] snd_hda_intel
> >     0000:01:00.1: Consider building the kernel with
> >     CONFIG_SND_DYNAMIC_MINORS=y [    0.612466] snd_hda_intel
> >     0000:01:00.1: control 3:0:0:ELD:0 is already present
> > [    0.613100] snd_hda_codec_hdmi: probe of hdaudioC0D0 failed with
> > error -16  
> 
> Have you tried enabling CONFIG_SND_DYNAMIC_MINORS like the kernel is
> asking you to here?  Does that help?

I've just tried and it doesn't help. Note that the above message is from
my working kernel and has a timestamp later than the panic, so if the
timing of the 152 kernel is somewhat similar to the 147, the panic
occurs before that snd_hda_intel code is even reached.

MSB

-- 
Bad comments reveal the bad programmer.

