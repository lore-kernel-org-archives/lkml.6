Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E413BC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A723620850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A723620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967677AbeFRI6i (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:58:38 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:57174 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966711AbeFRI6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:58:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 2874CFA5;
        Mon, 18 Jun 2018 10:58:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8ThKQAQvqf6N; Mon, 18 Jun 2018 10:58:34 +0200 (CEST)
Received: from var.youpi.perso.aquilenet.fr (dhcp-13-150.lip.ens-lyon.fr [140.77.13.150])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 8A1DA6AC;
        Mon, 18 Jun 2018 10:58:34 +0200 (CEST)
Received: from samy by var.youpi.perso.aquilenet.fr with local (Exim 4.91)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1fUpze-0007G5-79; Mon, 18 Jun 2018 10:58:34 +0200
Date:   Mon, 18 Jun 2018 10:58:34 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Justin Skists <justin.skists@juzza.co.uk>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        "Speakup is a screen review system for Linux." 
        <speakup@linux-speakup.org>, Gregory Nowak <greg@gregn.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: speakup: refactor synths array to use a list
Message-ID: <20180618085834.an3h4ykz4t3j3epl@var.youpi.perso.aquilenet.fr>
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
 <20180618084634.j3jugh3gqnl2bz7o@var.youpi.perso.aquilenet.fr>
 <2123576446.627448.1529312132509@email.1and1.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2123576446.627448.1529312132509@email.1and1.co.uk>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Skists, le lun. 18 juin 2018 09:55:32 +0100, a ecrit:
> When I was going through the driver code, to become familiar with it, there
> were a few places that I thought needed a closer look.

Yes, cleanup work is probably needed in various places.

Samuel
