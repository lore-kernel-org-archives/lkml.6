Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AE2C6778A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 02:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44FCD20858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 02:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoYzZpnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44FCD20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbeGWDzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 23:55:22 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:37379 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731059AbeGWDzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 23:55:22 -0400
Received: by mail-lf1-f45.google.com with SMTP id j8-v6so5317470lfb.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 19:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O3hTOBTxO2UJrLf7Z1CCjnPn/Ft65L+a28nUafauST8=;
        b=LoYzZpnwG0nmr8izPt/dHCCI13GVMSLkMNtfatHb1ugHMq0woxaSiQlkX8uKxWdSAB
         5+85hNZdiWd2sPQSC6OZf6rxKwChHxovRBaKFBuESZkO/z+YwPWEbgds9gLvfh7jRTxA
         ntWv9NEi2bVfxZKi77OfeaJ3dAHQB9IwYnBjpLh5gVKHTU9zVJdLWR9s8rRxoiZUBY+p
         qc5BW2btlD8KHLLhnzbq16fF7ox87J/m343EPVtDc6JE4Q0gDFL2XeepJrOEDlGCMzCE
         x543i+eY0D/gaHFXLh08ssqLKRiqePQ5b9MWtgyNBRKThTDRUpozDBm8CcTB6cT8FikG
         MVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O3hTOBTxO2UJrLf7Z1CCjnPn/Ft65L+a28nUafauST8=;
        b=h6JcIYBm3c+5xLqsG0uj4ByNsnJixRAlw3Pi5cAQWoqk+i+4htXvB36u/tscigVAjT
         T0Xxoj7Uab0AJej6OLReRK3dfNB14UOFX542oST/tsVuHkk58T7Nkg57El43GYKsrBMl
         ST/hmSoTSN8nJDIJu/u1WXfe5RpE0EFt5FFw1y1ZqahKX02zXF3wpdGbUTLUQ0xIbole
         VnJEBxK7ivoMnN4KoK50vX0WOOXJEegH0GjMarmXU35csC1axwueNZOhDQEFDZ8XZDQD
         3vsvPUF1JmrDF4buDjO2uEYU8TD9P48SDj6EM/7j7mpwSJE1YO6xDkt1JYiA1t2eMS5B
         Qwxg==
X-Gm-Message-State: AOUpUlGnTIO+k7uFAVWD1rNO7c1BbKHKrffqHPmIFqi0qjqrNyK1Lev3
        wTYIBuwnFIUQnu/BIzeBmJv0yVgMSNknKi9XCs0=
X-Google-Smtp-Source: AAOMgpfbnGOEuT4IKOabClO00ndJMyEEPsrZmZDIlNSBs06rLCU3Yq6eIymZTa+EfOblQk86BJnPyPOnvD8IEd4oCK8=
X-Received: by 2002:a19:9e8c:: with SMTP id h134-v6mr5929392lfe.63.1532314584516;
 Sun, 22 Jul 2018 19:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <1531825548-27761-1-git-send-email-ufo19890607@gmail.com> <20180717111608.GC7193@dhcp22.suse.cz>
In-Reply-To: <20180717111608.GC7193@dhcp22.suse.cz>
From:   =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date:   Mon, 23 Jul 2018 10:56:13 +0800
Message-ID: <CAHCio2j3atFwxHwm_zYGtXY4j1MJ8FNcthyXtLCBW19QJLdyuQ@mail.gmail.com>
Subject: Re: [PATCH v14 1/2] Reorganize the oom report in dump_header
To:     mhocko@kernel.org
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal
OK, thanks. Is there any problems for V14?

Thanks
