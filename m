Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE5FECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 19:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7787C20871
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 19:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7787C20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbeGNT7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 15:59:38 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:57335 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbeGNT7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 15:59:38 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1feQOB-0003Th-V2; Sat, 14 Jul 2018 13:39:31 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1feQOB-0005fB-DE; Sat, 14 Jul 2018 13:39:31 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Linux Containers <containers@lists.linux-foundation.org>
References: <20180712130733.11510-1-adrian@lisas.de>
        <87sh4o5s82.fsf@xmission.com>
        <20180713135541.7ada72437862c32f4563a9a8@linux-foundation.org>
        <CAGXu5jJMBDd3-Yab78aYwQ1N6VG7=BjARoTF1pDygPhaWA9VNQ@mail.gmail.com>
        <87pnzpvdtd.fsf@xmission.com> <20180714191030.GA17877@localhost>
Date:   Sat, 14 Jul 2018 14:39:24 -0500
In-Reply-To: <20180714191030.GA17877@localhost> (Josh Triplett's message of
        "Sat, 14 Jul 2018 12:10:31 -0700")
Message-ID: <871sc5vc7n.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1feQOB-0005fB-DE;;;mid=<871sc5vc7n.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18gvSUzTuWmj5DpSJ0Z13IyU7LTt639n6I=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] kconfig: remove EXPERT from CHECKPOINT_RESTORE
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> writes:

> On Sat, Jul 14, 2018 at 02:04:46PM -0500, Eric W. Biederman wrote:
>> For a config option that no one has come forward with an actual real
>> world use case for disabling, that cost seems much too high.
>
> The real-world use case is precisely as stated: code size, both storage
> and RAM.

That is theoretical.  Which platform will break or feel distressed if we
make it unconditional.  That is real world.

> I regularly encounter systems I'd *like* to put Linux in that have
> around 1MB of storage and 1MB of RAM, or even less.

Yes.  There is so little code behind CONFIG_CHECKPOINT_RESTART that it
won't help with that.

But if minification is the actual requirement for disabling
CONFIG_CHECKPOINT_RESTART than CONFIG_CHECKPIONT_RESTART is properly
behind expert and it needs to be default y instead of default n.

Eric
