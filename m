Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF0BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C8721855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X3inc+0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfBKVoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:44:08 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38262 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfBKVoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:44:07 -0500
Received: by mail-ed1-f67.google.com with SMTP id h58so383003edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 13:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jz7m1a+FGluQZXoGscSuIG8g4cW33nsSXIWoU/bTeSM=;
        b=X3inc+0g8d71KYB0klwWiT67APWByXJ6pi8dREpRgCV/SEteitRy5bClBU7beUcaVv
         PWDWV+Qg+2kdHSgLNnd7vSyy8XB4oysxfNpI/K4l37XyV9OpQ9wLbWiHBvd0uS2rqSSh
         dISz7M4vpxFYp9sscuLwucCfv6sHRKx+w/yISvpLt2HZfkyph5ODkk/tp1M9/1LwSHqR
         ebqkz+QbFa1NgKzJ3MJ4AvcnpVmy5vDMYRAOT54l9R8RXBfnMjsQ6BgV0LvwBmMapbHs
         ckUBzRxS3PtBbhLrtZ3Yfq575vcVFfGfBDJn3jifHqrBUVARpVpv11Hc92cK6Kz/qUac
         xAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jz7m1a+FGluQZXoGscSuIG8g4cW33nsSXIWoU/bTeSM=;
        b=o8HLuPpsNCFL/RZ3C2/F3q0sPKGcmkqBdp9bMrhlGkwe6Z5LwzbrcND0bHVqejQJVK
         BLBRpuzwnte6ighevJBT5BvgFDPAGSnJlT6otv313OyRWavSNKE1T7B83zNDRXXUc6r6
         yz1DBTmwOt0sXrYFYWA3oeRa18FyamPcPIeK2gTHvLG95dqb2omOV/C9ZS3ik+FueUfn
         ko3nKSYq5a8n0Txz3YcikWADtlZVYB3UPG6/07hiduPwfN4BCunKafe74cgshNv2K1qt
         I86wmZnYXyNwnmEjHgpuhRG4vzBNxhHRdhHZKwDEj6IveKDuyUPEgjUQljQ+zKQNaU0O
         PU4g==
X-Gm-Message-State: AHQUAuacqFV8gTtWRkrxRou3E4v0c34wwbjJEv6UstteovdIfSds3X8v
        B3NOtHuuqCI2p2BZZlURQ/OMzTvplu/EIC1lucdUOw==
X-Google-Smtp-Source: AHgI3IbziUUoG76CIg2kxrZq0Bgxy2x1YMuzrqPnTRbLTGSn1e3BSib8gxUndBS28MkXeVUPgl3pCZAcyribIcwga/g=
X-Received: by 2002:a17:906:f0d8:: with SMTP id dk24mr222755ejb.108.1549921445662;
 Mon, 11 Feb 2019 13:44:05 -0800 (PST)
MIME-Version: 1.0
References: <20190205190849.GA2686@kunai> <20190211034021.242932-1-jsperbeck@google.com>
 <20190211092417.7f211ee0@gandalf.local.home>
In-Reply-To: <20190211092417.7f211ee0@gandalf.local.home>
From:   John Sperbeck <jsperbeck@google.com>
Date:   Mon, 11 Feb 2019 13:43:54 -0800
Message-ID: <CAFNjLiVMOii_mzs4Px38GHxFq6WnrDNhQ9YHMb+4yGZZ6SFpkQ@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: core-smbus: don't trace smbus_reply data on errors
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 6:24 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sun, 10 Feb 2019 19:40:21 -0800
> John Sperbeck <jsperbeck@google.com> wrote:
>
> > If an smbus transfer fails, there's no guarantee that the output
> > buffer was written.  So, avoid trying to show the output buffer when
> > tracing after an error.  This was 'mostly harmless', but would trip
> > up kasan checking if left-over cruft in byte 0 is a large length,
> > causing us to read from unwritten memory.
>
> This looks fine to me, but I'm not sure how the i2c maintainers feel,
> but I always require that a new patch version starts a new thread, and
> not be part of a older thread release (causes these patches to be
> hidden from those that read patches in threading mode).

That sounds reasonable to me.  Unless I hear otherwise, I'll create a
v3 as a new thread.  Thanks.
