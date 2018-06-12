Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 845F8C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F2E20660
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F2E20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754280AbeFLGbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 02:31:11 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:42388 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753943AbeFLGbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 02:31:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 02BB2D34;
        Tue, 12 Jun 2018 08:31:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sC42oj9jdOoG; Tue, 12 Jun 2018 08:31:07 +0200 (CEST)
Received: from var.youpi.perso.aquilenet.fr (static-176-158-111-12.ftth.abo.bbox.fr [176.158.111.12])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 4DE696E9;
        Tue, 12 Jun 2018 08:31:07 +0200 (CEST)
Received: from samy by var.youpi.perso.aquilenet.fr with local (Exim 4.91)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1fScpe-0004W5-0z; Tue, 12 Jun 2018 08:31:06 +0200
Date:   Tue, 12 Jun 2018 08:31:06 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Gregory Nowak <greg@gregn.net>
Cc:     "Speakup is a screen review system for Linux." 
        <speakup@linux-speakup.org>, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: speakup: refactor synths array to use a list
Message-ID: <20180612063105.7urgjfckrwjvqs6k@var.youpi.perso.aquilenet.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Gregory Nowak <greg@gregn.net>,
        "Speakup is a screen review system for Linux." <speakup@linux-speakup.org>,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20180604095212.GA18381@tanglefoot>
 <20180606132628.fxykchbznrwzgwqt@var.youpi.perso.aquilenet.fr>
 <20180611225703.csi47cdafhy6rxcf@var.youpi.perso.aquilenet.fr>
 <20180611235122.GA28343@gregn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611235122.GA28343@gregn.net>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Nowak, le lun. 11 juin 2018 16:51:22 -0700, a ecrit:
> On Tue, Jun 12, 2018 at 12:57:03AM +0200, Samuel Thibault wrote:
> > Anybody up for testing please?
> > 
> > If people want to see speakup get mainlined instead of staging, please
> > help.
> 
> If I understand right, this patch changes how synthesizers are loaded
> and unloaded through /sys/accessibility/speakup/synth, correct?

The load/unload is about the module itself, i.e. modprobe speakup_bns ;
modprobe speakup_soft, switch between them, then rmmod speakup_bns ;
speakup_soft or the converse (to exercise both orders).

Thanks!
Samuel
