Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id FC3RK9mHGVsASwAAmS7hNA
	; Thu, 07 Jun 2018 19:40:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7F3326074D; Thu,  7 Jun 2018 19:40:47 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G+FjiZiy"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E6FBE601C3;
	Thu,  7 Jun 2018 19:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6FBE601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932323AbeFGTko (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:40:44 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:37639 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932207AbeFGTkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:40:42 -0400
Received: by mail-it0-f45.google.com with SMTP id l6-v6so14149018iti.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 12:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iN8Ra/UQhr5BhzOKOieDs0dWhNyc34SSVCZqu6Sx8tg=;
        b=G+FjiZiyfhjMj+DgO6epU+0QQMFK3TmAlKvqYfyxNNo+OkldepU8WZ8bb2E8H10AFz
         UMicYANzrOI2rseOwFmeEUo8fUAGHRXB4dsthPW78Yvdkp2gMUE165ukCRolGIq75oMC
         z56xHfjWY7CSwCy2SLNLww8MLKe7uMF5cZJ6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iN8Ra/UQhr5BhzOKOieDs0dWhNyc34SSVCZqu6Sx8tg=;
        b=oHdm9xhyVQswGzLBoLHTpe3J5x4OOG0FbqhZY8a5v6FIqS5HsT/hRTn14JPTmjbYQs
         uzxfKchyoslaWp0WmqbXCHzZmAKYA8A0tEiI3NvI7kCnvJyRnrRM2Rzg7+IB39dzyCE1
         AkaXZ1L5lSAhwLM9F/r2MvDV5jde71Wgt/SF4h4R1qM3p0rFcvKa6guRgu2sVnMkYacI
         EBjYBhscRuZ4R9xKAqrdhrHTFdgHfE6MxyHqW3ajUNcMpWqYGFegaJl3wd6IKBth38WZ
         +MSUM0nb4QiUxDX2Djg0Rz5BpO+qGizIr91N2yOAxFPpsnqom9vypiYpxt5pxsLRGRpf
         mlqw==
X-Gm-Message-State: APt69E26mwJfPdsWEzbyxdZN3q3+9CSIKZMU2xM0hnTltCzicYO8aJMu
        Vn+0A91BhorPe5XoO98GNev+j3LMo4ByJfXS98I=
X-Google-Smtp-Source: ADUXVKIplyx+Rk9LItUwr5VGiYBpZ3QjwUVmSAshgSX7JhPz7IxzYDJ4qT/n8LnTI4oIkALucB41YTFHp/ioLD+WMRQ=
X-Received: by 2002:a24:8046:: with SMTP id g67-v6mr3101819itd.16.1528400441951;
 Thu, 07 Jun 2018 12:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFxhx_tKGm02UySguvbyfB_7oTF31QfgOHCK0YkBvmfV0g@mail.gmail.com>
 <8f46ed9a-85c0-8df4-2d1e-d268cbc9d0e9@mageia.org> <CA+55aFwJAbr8_Xs0ZX9K2iAr8bf=ZgNnKTLopQe6jPCgEBemrA@mail.gmail.com>
 <7a5458da-4222-7480-00ed-a51bed2c1e39@mageia.org> <CA+55aFyD0OMV1eoc9wh_hLcnRhHq2FwJf4EZcORmHPNxTRSX9Q@mail.gmail.com>
 <daf0fbba-6357-1748-d583-bcb5edf067ec@mageia.org> <CA+55aFwiyuA4fKztofM-fdDSc+ZH9aAR1xksL8ZWRDE-pdXruw@mail.gmail.com>
 <CAK7LNAS=PvYVrLczeJT0utq3UHNL5YtSE_w=RjJYJ3SD9ALrYA@mail.gmail.com>
 <CA+55aFzNCQZHEz9P2a4ZSyWB0RxZcTkh5TVfwTmup-Y-6b8qjw@mail.gmail.com>
 <CA+55aFwAwoDdZRP6n9xXDPkeCUm35mmGH3fXv=r1HOZq1bpiGw@mail.gmail.com>
 <CAK7LNAS4Xb_CQ31t_cqt3q0zRFZ-O2n3+qkxXfxZB_jmqvFmWQ@mail.gmail.com> <f1f35cdf-bd03-54bb-7196-c13131f7d0fc@mageia.org>
In-Reply-To: <f1f35cdf-bd03-54bb-7196-c13131f7d0fc@mageia.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 7 Jun 2018 12:40:30 -0700
Message-ID: <CA+55aFxe+LooLzpvBLwW9Ehwomp45zdJ3a-P71ipHJzdMmtDkQ@mail.gmail.com>
Subject: Re: building in 32bit chroot on x86_64 host broken
To: tmb@mageia.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 12:35 PM Thomas Backlund <tmb@mageia.org> wrote:
>
> I can work around it for now (or keep the revert in our kernel builds
> for now) until it gets properly fixed...

So rather than doing the revert, it's probably better if  your
workaround just does

   make ARCH=i386 oldconfig

(or maybe even just a "export ARCH=i386" in the environment)

That should get you to continue to otherwise do the same thing.

And if it turns out that your flow is the *only* one affected by this,
and nobody else complains, maybe we can just say "yeah, slight change
in build rules, easy to work around" and leave it at that.

                Linus
