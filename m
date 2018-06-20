Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425CFC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1A520846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v9xMI7s0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1A520846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754618AbeFTSXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754444AbeFTSXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:23:23 -0400
Received: from mail-it0-f44.google.com (mail-it0-f44.google.com [209.85.214.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21E06208A1;
        Wed, 20 Jun 2018 18:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529519003;
        bh=Dtsb2syDoYaww3/Ab8aq7CbXEVOm4s5H7Mtgp6kVUgI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=v9xMI7s0Iyl6zNulY7WaFlWNn6o7MeexHVsRAyd1PL2BhoPYFWLYMfT8UfptB+D2+
         ZEaiKaB2SN6cmIXlpSFf/zEN7tSdxjGEjjTQhLDSfspQIkl3c/Q/huXesbdFx/qeFP
         SKTCAz79fm49k23zD9+5t6T9s9/bVCj+lqFIxq0U=
Received: by mail-it0-f44.google.com with SMTP id k17-v6so233272ita.0;
        Wed, 20 Jun 2018 11:23:23 -0700 (PDT)
X-Gm-Message-State: APt69E0yxHl770PojC+63U0fZMZSoKaEW5gS2hJmUBOFK/7UmfwVQzbo
        f88qn/xxVimpIOYVBtVgg2/A1Ov/EAXWHq2B/g==
X-Google-Smtp-Source: ADUXVKL6PwK7yi9YQeIle4c3b6SDSjPn3GCtoioDyp0iBzMRYcsJVJmNakoJ3aX/racD+KIer+y9ORX9WctxR0YOrkw=
X-Received: by 2002:a24:798f:: with SMTP id z137-v6mr2362804itc.19.1529519002541;
 Wed, 20 Jun 2018 11:23:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6403:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 11:23:01
 -0700 (PDT)
In-Reply-To: <1529251416-14814-1-git-send-email-frowand.list@gmail.com>
References: <1529251416-14814-1-git-send-email-frowand.list@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 20 Jun 2018 12:23:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJdp16D4svB8Y7jurNVdHzVgz8_pkOKBA6mFyhXkqWi6w@mail.gmail.com>
Message-ID: <CAL_JsqJdp16D4svB8Y7jurNVdHzVgz8_pkOKBA6mFyhXkqWi6w@mail.gmail.com>
Subject: Re: [RFC PATCH] of: overlay: update phandle cache on overlay apply
 and remove
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Alan Tull <atull@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 10:03 AM,  <frowand.list@gmail.com> wrote:
> From: Frank Rowand <frank.rowand@sony.com>
>
> A comment in the review of the patch adding the phandle cache said that
> the cache would have to be updated when modules are applied and removed.
> This patch implements the cache updates.
>
> Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")
> Reported-by: Alan Tull <atull@kernel.org>
> Suggested-by: Alan Tull <atull@kernel.org>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>
> Compiles for one configuration.
> NOT boot tested.
> Not run through my normal process to check for new warnings, etc.

I'm assuming you will resend a non-RFC version for me to apply.

I think it would be a bit better if callers didn't have to do free and
populate themselves, but just made an invalidate call (like a normal
cache) and re-populating the cache could happen on demand. Or if it
was done as a single call, you could just copy the old entries to the
new larger array. But maybe there would be a race condition in doing
that? In any case, all that could be a subsequent patch.

Rob
