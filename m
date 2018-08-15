Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD5DC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE62F21557
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gPVMrU+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE62F21557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbeHPAEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 20:04:55 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40502 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbeHPAEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 20:04:54 -0400
Received: by mail-it0-f65.google.com with SMTP id h23-v6so3843537ita.5;
        Wed, 15 Aug 2018 14:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fVuTGbmOQP+TjUR5Ne0L+ZKzMy5t3wGUXZru1r5Sr0o=;
        b=gPVMrU+Bwdw/7l9HfdD56vRwWIMfuWFxr5lyfq3B/MK/9EFwzER4IN/9jPje1yzECY
         yN66axMagTqUxPvFbT14GAfdfSCTKJgtPSBKasmfAuBZBe2zR7nHxNlUvKA0/WLdtBGT
         xU+SCai+1jJedb4rN9YVXDW1tclzLh1NDvb0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVuTGbmOQP+TjUR5Ne0L+ZKzMy5t3wGUXZru1r5Sr0o=;
        b=k1+XmVyrIpPDBRa0jwGfkj+89tNJMVWUHasgBun54MGhnisjdrfQfAWPQutvF4tdcI
         T6NwGaGuwwwfFRsOqvxeGSR2HMEThMgf5r5OuOBLOXyRZ8c9NSZ5EnkRLJslQdoB17vW
         oW87GJEhJQPk1JjTNlAKo7xSsC5KN75ET6QvVf//LmmtSlme/EtqxPpACdzu+uyLXLGs
         oI5/HQEbHMwNrd0UhyI7roqemtsR0Um4X5vEvDLLAo4pWzzAHGkxADp/VaspGmqmEuta
         oGJkgcFuNP6OzZBluEe2Djhb+tObo5btLHbVKVBSEA4fvg9S7pyz3USXhtYQrzhpvmRr
         ebtA==
X-Gm-Message-State: AOUpUlFC8vhZ3miSsd3HqAd53w6S1ByxXiIsxSumSoPNT1hGd3wWYpGM
        IfQjU91oM79ZDAdoIQlzFPMHeiLDNhgtOXlUQmuowJO5
X-Google-Smtp-Source: AA+uWPyivP+X1x8WjVFfYhgwWDwEDEC5R6UcKcrIzNAzMy85IY0wSUY2UbvV0ENqRlqQjOc+sXYaM8xneTVunOc4n5Q=
X-Received: by 2002:a24:94f:: with SMTP id 76-v6mr19070019itm.113.1534367462280;
 Wed, 15 Aug 2018 14:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAT9p+YPmvasWPG1qdriM+dkauf6h3bqJLnxTcZo8LG_SA@mail.gmail.com>
In-Reply-To: <CAK7LNAT9p+YPmvasWPG1qdriM+dkauf6h3bqJLnxTcZo8LG_SA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 14:10:51 -0700
Message-ID: <CA+55aFxRPLjo_XnWDw5sYLnSjNhf8iPHGXomQitnGJjyuViXCQ@mail.gmail.com>
Subject: Re: [GIT PULL 2/3] Kconfig updates for v4.19
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 10:58 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Masahiro Yamada (15):
>       kconfig: make syncconfig update .config regardless of sym_change_count

This one is annoying me.

I don't care if it updates .config. But it does so *noisily*, so now
my build scripts en dup having extra noise coming out from them in the
form of another

  scripts/kconfig/conf  --syncconfig Kconfig
  #
  # configuration written to .config
  #

which is just distracting me and doesn't seem to add any value at all.

Ok, so it happens because I for legacy reasons have a "made dep" that
isn't useful any more (but my fingers have that as the "let's do a
kernel build" now macro), but it does seem to be entirely pointless.
Why make that big noise about something that doesn't even *do*
anything?

                  Linus
