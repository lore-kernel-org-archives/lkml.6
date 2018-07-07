Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AB8C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E7421A0E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E7421A0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753687AbeGGIcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 04:32:25 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:56252 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752809AbeGGIcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 04:32:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id A085FC14;
        Sat,  7 Jul 2018 10:32:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4UBKo4cM8-s8; Sat,  7 Jul 2018 10:32:21 +0200 (CEST)
Received: from var.youpi.perso.aquilenet.fr (dhcp-64-205.ens-lyon.fr [140.77.64.205])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id D9D1473E;
        Sat,  7 Jul 2018 10:32:20 +0200 (CEST)
Received: from samy by var.youpi.perso.aquilenet.fr with local (Exim 4.91)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1fbidf-0001bS-Vc; Sat, 07 Jul 2018 10:32:19 +0200
Date:   Sat, 7 Jul 2018 10:32:19 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Jann Horn <jannh@google.com>
Cc:     w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: speakup: fix wraparound in uaccess length check
Message-ID: <20180707083219.pbxqsfe4duxueepv@var.youpi.perso.aquilenet.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Jann Horn <jannh@google.com>, w.d.hubbs@gmail.com,
        chris@the-brannons.com, kirk@reisers.ca,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org
References: <20180707015344.146672-1-jannh@google.com>
 <20180707081347.czde44j6rjepjpkf@var.youpi.perso.aquilenet.fr>
 <CAG48ez3pPcrA8B9bLwuht1Az8EXbDZa1fGmx73esvZBpmwifpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3pPcrA8B9bLwuht1Az8EXbDZa1fGmx73esvZBpmwifpg@mail.gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn, le sam. 07 juil. 2018 10:22:52 +0200, a ecrit:
> Or should I rewrite the
> patch to be simple and just bail out on `count < 3`?

Our mails have crossed :)

I believe what I sent is correct: for softsynth it does not make sense
to have room for less than 1 (non-unicode) or 3 (unicode) bytes.

Samuel
