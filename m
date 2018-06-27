Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEF4C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A92223D35
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T41GM1lP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A92223D35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbeF0FNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 01:13:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751020AbeF0FNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 01:13:39 -0400
Received: from mail-wr0-f181.google.com (mail-wr0-f181.google.com [209.85.128.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E9632148E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 05:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530076419;
        bh=hQ+3FrOvWF7yZ0Oxl4SOOfgYRikVeceLBWvfAg5aqeE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T41GM1lP0FUDZVDpnBvZwpVc0IEUTa1/Ahuq5M+oT7RNOjaBicdM5acaZYMDwx+jG
         IPWz9w+jiz04du6f5ns5ooxZkLEvktAdpbUqz/Ar0/gnZylBQ35kUmd4bzWvF3b5CK
         vybKoKuyzV06uCdhTKHV7bLaNSaYJbghIXv7xrxA=
Received: by mail-wr0-f181.google.com with SMTP id b8-v6so583278wro.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 22:13:39 -0700 (PDT)
X-Gm-Message-State: APt69E2s9eapfHehg2kiJrDyCL9bWEruQnfXRC4+/w/FnJXcp9LfENfB
        2ueTMw6paA71NNvkQAYhA864WOHwHHW5TwTwxdsbnA==
X-Google-Smtp-Source: AAOMgpffGOPI922FnPmdeEEIdhuMOVvEwLqab0W4QqqcajORwsFzfAC34OlKJrUuNX4WqN9IREmIzpnqANDt+werSug=
X-Received: by 2002:adf:8062:: with SMTP id 89-v6mr3458001wrk.221.1530076417534;
 Tue, 26 Jun 2018 22:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <0d78b5b4-710e-1b41-46e1-74003ca1381e@intel.com>
 <CALCETrVLRmySnqpG+o-S9VGkx7uKFfLGeawyM7UDCRj_g7vs1g@mail.gmail.com> <45ea6606-e782-fd07-fffa-cc133b33f9f7@intel.com>
In-Reply-To: <45ea6606-e782-fd07-fffa-cc133b33f9f7@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 26 Jun 2018 22:13:26 -0700
X-Gmail-Original-Message-ID: <CALCETrVc5f9VMQtZ-_GeGzhmttXnFMjipK6ER59Q0LbY076N+w@mail.gmail.com>
Message-ID: <CALCETrVc5f9VMQtZ-_GeGzhmttXnFMjipK6ER59Q0LbY076N+w@mail.gmail.com>
Subject: Re: test_syscall_vdso_32 [FAIL]
To:     zhijianx.li@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>,
        kernel test robot <xiaolong.ye@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 6:23 PM Li Zhijian <zhijianx.li@intel.com> wrote:
>
> On 6/25/2018 11:40 PM, Andy Lutomirski wrote:
> > On Mon, Jun 25, 2018 at 1:41 AM Li Zhijian <zhijianx.li@intel.com> wrote:
> >> Hi
> >>
> >> Intel 0Day noticed that test_syscall_vdso_32 failed since 8bb2610bc4967f19672444a7b0407367f1540028(x86/entry/64/compat: Preserve r8-r11 in int $0x80)
> >>

[snipped]

Indeed.

Hi Thomas-

Something went wrong when you applied the patch mentioned above.  The
original patch is here:

https://lore.kernel.org/lkml/d4c4d9985fbe64f8c9e19291886453914b48caee.1523975710.git.luto@kernel.org/

but somehow it got applied with huge offset -- the same exact change
was made, but it was made to the entirely wrong function!  I'm a
little nervous about sending a fixup patch because there are three
copies of that code in the file, and I don't want to just move the
problem around.  What's the right thing to do here?

Clearly this needs to get fixed somehow, and the fix should go to -stable.

--Andy
