Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4D9C1B0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ACAA20871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACAA20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbeFTEUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:20:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:45197 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbeFTEUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:20:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 27531AF08;
        Wed, 20 Jun 2018 04:19:59 +0000 (UTC)
Date:   Wed, 20 Jun 2018 06:19:58 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Julian Sax <jsbc@gmx.de>, Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] HID fixes
In-Reply-To: <CA+55aFx1o8+ZTAqVQNH7Wq8tm90XYTUEx5By2wWo3KJDR3g2MQ@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1806200611290.6203@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1806191356280.6203@cbobk.fhfr.pm> <CA+55aFx1o8+ZTAqVQNH7Wq8tm90XYTUEx5By2wWo3KJDR3g2MQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018, Linus Torvalds wrote:

> What is that odd binary blob i2c_hid_desc_override, and where does the
> data come from? Not explained anywhere.

Fair enough; it's a pretty standard HID descriptor override, but you're 
right that we're usually replacing it in a bit more verbose way. Julian, 
could you please run that descriptor through something like HID descriptor 
tool, and send me a patch that reformats it? (for the way we usually do 
this, look for example in hid-sony.c).

I'll drop this commit and resend the pull request (as namely the steam fix 
really should go in).

The plan eventually is to offload all this crazy rdesc replacing to 
userspace, but that is still WIP.

Thanks,

-- 
Jiri Kosina
SUSE Labs

