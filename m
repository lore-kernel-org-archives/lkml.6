Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D92C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6289208E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6289208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030423AbeFRIqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:46:39 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:57096 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968114AbeFRIqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:46:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 06A0FFA5;
        Mon, 18 Jun 2018 10:46:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OwpJrxWeN5e4; Mon, 18 Jun 2018 10:46:34 +0200 (CEST)
Received: from var.youpi.perso.aquilenet.fr (dhcp-13-150.lip.ens-lyon.fr [140.77.13.150])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 93CA06AC;
        Mon, 18 Jun 2018 10:46:34 +0200 (CEST)
Received: from samy by var.youpi.perso.aquilenet.fr with local (Exim 4.91)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1fUpo2-0004Pl-5Q; Mon, 18 Jun 2018 10:46:34 +0200
Date:   Mon, 18 Jun 2018 10:46:34 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Justin Skists <justin.skists@juzza.co.uk>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        "Speakup is a screen review system for Linux." 
        <speakup@linux-speakup.org>, Gregory Nowak <greg@gregn.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: speakup: refactor synths array to use a list
Message-ID: <20180618084634.j3jugh3gqnl2bz7o@var.youpi.perso.aquilenet.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Justin Skists <justin.skists@juzza.co.uk>,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        "Speakup is a screen review system for Linux." <speakup@linux-speakup.org>,
        Gregory Nowak <greg@gregn.net>, linux-kernel@vger.kernel.org
References: <20180604095212.GA18381@tanglefoot>
 <20180606132628.fxykchbznrwzgwqt@var.youpi.perso.aquilenet.fr>
 <20180611225703.csi47cdafhy6rxcf@var.youpi.perso.aquilenet.fr>
 <20180611235122.GA28343@gregn.net>
 <20180612063105.7urgjfckrwjvqs6k@var.youpi.perso.aquilenet.fr>
 <20180618053444.GA1614@gregn.net>
 <1117674358.626563.1529311304239@email.1and1.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117674358.626563.1529311304239@email.1and1.co.uk>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Skists, le lun. 18 juin 2018 09:41:44 +0100, a ecrit:
> > On 18 June 2018 at 06:34 Gregory Nowak <greg@gregn.net> wrote:
> > With /sys/accessibility/speakup/synth set to bns, I am getting output
> > alternately from the bns and from soft. It's as if speakup can't make
> > up its mind which synthesizer is being used. When I echo soft
> > >/sys/accessibility/speakup/synth, I get no speech at all from either
> > synthesizer.
> 
> Is this a known issue, or a regression due to the patch?

I don't think it was a known issue, but I don't think it can be a
regression due to the patch, since none of that is handled by the
array/list at stake.

Samuel
