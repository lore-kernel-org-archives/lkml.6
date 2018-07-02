Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974FCC6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314AB25482
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JXIRr64n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314AB25482
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbeGBAAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 20:00:18 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34916 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752613AbeGBAAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 20:00:15 -0400
Received: by mail-io0-f193.google.com with SMTP id q4-v6so13207453iob.2;
        Sun, 01 Jul 2018 17:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pKPFQBrhR9awbupdHfyoG3OxvswdTJEqQqrfVXuR+Rs=;
        b=JXIRr64nATnNSR5k5Cz65TwvxZKFYBA74cS0fRKgLK30mxeK8aOAYSA3x9H5vmCYsR
         /pFyjx023pyryz7X/TLdjfDLv0LVGrdBArGIYHEjcL32O+0X+NiMHzYFovo8rqhCS4oW
         2TFlCICdvt/czFMXK1CSqGRvCR90da3wfgIYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pKPFQBrhR9awbupdHfyoG3OxvswdTJEqQqrfVXuR+Rs=;
        b=dVgLMuWZsb8DetGR50Slndqy3K+/PsppVcgorIUSMqERrQK4G4Z72webpxfnkxYBsA
         N6FwRYJUx6SSxfa2TuzsFVz1KWI1St0/ssqTNr+FM4LCuBPBAjwahHQ7LsAYf6wzSPNP
         eoXPWfp5C0Dw+2K0kjfXzOquxG2tTu1B2eA5FNRj/T53/uJXgGQMBJ+FphkHMB1ldKqQ
         ubMnrdrIzVI19cziqy1/RgiBJ2QpJ2oeWtyOxBPBAcw5eNTpHqPuXBeVexRhhfj3tQ3N
         938NVBzXeZbljNiuF4zUKAsWRuIpMcMrLaTJbUd7iA8LKPF345ByomciWg3ZTSHQj3lX
         ALww==
X-Gm-Message-State: APt69E1CeAVltMl0QUkOMmsNMlVHtzoKxtp2sznECeSrpBc0PuhYU3R4
        WsIKtmYd2sczjNwoAI76m09EqpXXkpPeuVQpwmQ=
X-Google-Smtp-Source: AAOMgpeg8P8JEscMe7w9y6K4l2MGugaLCpL3bBiU7l7CsTw+nCizZveau+a3EZoVFbk0se8N0OrjyBi80tH+66XEZTo=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr20189607ion.259.1530489614547;
 Sun, 01 Jul 2018 17:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <1527507182-3858-1-git-send-email-kt.liao@emc.com.tw>
 <20180529180506.GB167092@dtor-ws> <000301d3f7e4$5c9e51c0$15daf540$@emc.com.tw>
 <20180622001632.GI79890@dtor-ws> <CA+55aFzLMkyAGdfaeDLUXeRE0MJUckRDsrbVy2yonT6R=wf-Og@mail.gmail.com>
 <20180701234419.GA250349@dtor-ws>
In-Reply-To: <20180701234419.GA250349@dtor-ws>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 1 Jul 2018 17:00:03 -0700
Message-ID: <CA+55aFwCdAuw+GuKTCzACWpQBDFAx_DsMM0uTCx2fZKBBU7X0w@mail.gmail.com>
Subject: Re: [PATCH] Input: elantech - Fix V4 report decoding for module with
 middle key
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     kt.liao@emc.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        ulrik.debie-os@e2big.org, phoenix@emc.com.tw,
        aaron.ma@canonical.com, josh.chen@emc.com.tw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 1, 2018 at 4:44 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> The reason it got messed up is I switched to pulling patches from
> patchwork.kernel.org as it collects Acked-by and Reviewed-by tags so I
> do not have to add them manually, but unfortunately it does not do
> proper UTF-8:

Ugh.

I made an 'issue' of it for patchwork:

  https://github.com/getpatchwork/patchwork/issues/194

and hopefully that can be fixed. It's sad when we corrupt names like this.

              Linus
