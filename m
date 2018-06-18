Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB68EC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7832B208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7832B208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=juzza.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967896AbeFRIzr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:55:47 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:41389 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966112AbeFRIzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:55:44 -0400
Received: from null ([172.19.249.30]) by mrelayeu.kundenserver.de (mreue105
 [212.227.15.179]) with ESMTPSA (Nemesis) id 0MJD1W-1fWUdo2zbm-002oXm; Mon, 18
 Jun 2018 10:55:34 +0200
Date:   Mon, 18 Jun 2018 09:55:32 +0100 (BST)
From:   Justin Skists <justin.skists@juzza.co.uk>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        "Speakup is a screen review system for Linux." 
        <speakup@linux-speakup.org>, Gregory Nowak <greg@gregn.net>,
        linux-kernel@vger.kernel.org
Message-ID: <2123576446.627448.1529312132509@email.1and1.co.uk>
In-Reply-To: <20180618084634.j3jugh3gqnl2bz7o@var.youpi.perso.aquilenet.fr>
References: <20180604095212.GA18381@tanglefoot>
 <20180606132628.fxykchbznrwzgwqt@var.youpi.perso.aquilenet.fr>
 <20180611225703.csi47cdafhy6rxcf@var.youpi.perso.aquilenet.fr>
 <20180611235122.GA28343@gregn.net>
 <20180612063105.7urgjfckrwjvqs6k@var.youpi.perso.aquilenet.fr>
 <20180618053444.GA1614@gregn.net>
 <1117674358.626563.1529311304239@email.1and1.co.uk>
 <20180618084634.j3jugh3gqnl2bz7o@var.youpi.perso.aquilenet.fr>
Subject: Re: [PATCH] staging: speakup: refactor synths array to use a list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev28
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:isj3U2jLYwRdqMef1AjaU+xjbjZZIhLQKO1+T16+QJfQPXC5WC5
 0NqHlsjSkPd35VJV0BsB6ZnVc+ow9YQ1fijGrTiZPqkuxjc55YdYwj1W8Dy6cTVADbFs00M
 z1g+cgODiHIC5r2ZsAPz8Dp1ABlXOLQW+I/wA4mrMlxQT/ktVxBvNPRCtzXy8Oue6a5xQZE
 vkQsJcwWCVU7EJvRkJWiw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dcE6Cz5hMHw=:WVSuGWgHLLl0gDFZEOEBLV
 igqsxwL10HsRNXOaK7ZooPmjel9Yg6T64WO6HZBeyN131Dlm7r+yW7LCSOGASyjSce77ODq/J
 O9DfSLWkY2NJng7Q+/tZhJFdo2S/3/PTEIr11cuhO7SUD9pGml7HyswPGilCaqRt7aaaPjRp3
 Sr55nn5wr+UZvwqNvg8qaVx7lYeMYhqsc113IU0EWlAq4CrMnqXmBbyjptN7tGDG8juQo+jxw
 X3amzulLsxc5/0rH/tsjCCGVggfpLb4bj96kDwYpjmUQWnJsLGbGBanlgzpWqnZ2eKJBP81fB
 EZ5LIeoKwgyYR3YfI8uLXXz5nyTN469ZfhgDhVSLrZbneG3F4WEkLKlHGAkGX8AmVX22L+2dE
 Iv5e+iYjQswzvdBqYV6Ty1v2CA3Y8S0WNtH1Hy0mh1Hh0sjQtnvsn/d8btfQ0QArKmIl5QpPM
 rx6flyszyViZsdGx71sWKeC/sVIJQk3TSBTZ6dZNsjlcHnmFqGw6VC8V4PMwyz0qDMjvvCR8G
 hxKkgTRpH+880AAvnaX0fVPbEIDYu4BAdZpqeCzlSa9s/TyDPaniJCqXvqwSzWPGt/nwQz94g
 q77ii29NTUkRimHHe66O9qWNlr9RXuUh4NhGY/erMV86y25MODXEBwNUAQp55rwGDYXMCWqHD
 f7ZQQVVkL0T23ECo1HPclAFN/1R2BgCoTAo5oBJTR564bFvEX5RDjiax0swOL48O39MTNxyXJ
 2NWS4+gxNet4V3Yh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 18 June 2018 at 09:46 Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:
> 
> 
> Justin Skists, le lun. 18 juin 2018 09:41:44 +0100, a ecrit:
> > > On 18 June 2018 at 06:34 Gregory Nowak <greg@gregn.net> wrote:
> > > With /sys/accessibility/speakup/synth set to bns, I am getting output
> > > alternately from the bns and from soft. It's as if speakup can't make
> > > up its mind which synthesizer is being used. When I echo soft
> > > >/sys/accessibility/speakup/synth, I get no speech at all from either
> > > synthesizer.
> > 
> > Is this a known issue, or a regression due to the patch?
> 
> I don't think it was a known issue, but I don't think it can be a
> regression due to the patch, since none of that is handled by the
> array/list at stake.

OK, thanks. That's what I thought, too.

When I was going through the driver code, to become familiar with it, there
were a few places that I thought needed a closer look. But I need to finish
setting up a regression testing system before I do.

Justin.
