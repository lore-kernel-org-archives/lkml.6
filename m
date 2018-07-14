Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61128ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 19:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EF020890
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 19:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EF020890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbeGNTY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 15:24:57 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:54948 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbeGNTY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 15:24:57 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fePqg-0000fp-Lw; Sat, 14 Jul 2018 13:04:54 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fePqf-0000Ye-Pz; Sat, 14 Jul 2018 13:04:54 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>
References: <20180712130733.11510-1-adrian@lisas.de>
        <87sh4o5s82.fsf@xmission.com>
        <20180713135541.7ada72437862c32f4563a9a8@linux-foundation.org>
        <CAGXu5jJMBDd3-Yab78aYwQ1N6VG7=BjARoTF1pDygPhaWA9VNQ@mail.gmail.com>
Date:   Sat, 14 Jul 2018 14:04:46 -0500
In-Reply-To: <CAGXu5jJMBDd3-Yab78aYwQ1N6VG7=BjARoTF1pDygPhaWA9VNQ@mail.gmail.com>
        (Kees Cook's message of "Fri, 13 Jul 2018 21:44:15 -0700")
Message-ID: <87pnzpvdtd.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fePqf-0000Ye-Pz;;;mid=<87pnzpvdtd.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/igUpu2rF7wxN/VXxbqIt8IHPQr6SyJqI=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] kconfig: remove EXPERT from CHECKPOINT_RESTORE
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Fri, Jul 13, 2018 at 1:55 PM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
>> On Thu, 12 Jul 2018 11:33:33 -0500 ebiederm@xmission.com (Eric W. Biederman) wrote:
>>> What is the value of disabling this functionality ever?
>>>
>>> Is there any reason why we don't just delete CONFIG_CHECKPOINT_RESTORE
>>> entirely?
>>
>> For the vast number of Linux machines which aren't servers?  Check out
>> some defconfigs - only one of arm's 119 defconfigs selects it.
>
> Right, and I would bet the minification folks would like to keep it
> out of their builds too. I think we should keep the config.

I take it then you are volunteering to test with and without the config
option?

Even if the config option is kept I intend to rip it out every time I
wind up touching code with it in.  Config options have a real cost in
testing and development.

For a config option that no one has come forward with an actual real
world use case for disabling, that cost seems much too high.

Eric

