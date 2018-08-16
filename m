Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B2BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 01:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD2B20C03
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 01:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U6rn3EJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD2B20C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbeHPEWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 00:22:43 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:43329 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbeHPEWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 00:22:42 -0400
Received: by mail-io0-f194.google.com with SMTP id y10-v6so2564853ioa.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 18:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cp+Vd2CqjE9CJpCrkxq7SJAjpjNShTfd0HpbUJ/KAwU=;
        b=U6rn3EJXJj/BWQu6mYKUJlQwbC3VcSD44tSfQMUA7LmBmRHTweNJDJpN1L00J/xp5o
         wvK9rOrvqKHIbdFe4STo1CTp9aGvoJ3hFSQG8YTSgAXWtxeveGATXD+XUlfVXZX11f6f
         ogFdJloYGtgGmr/RBqtKoTxkDqLpkOObIg610=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cp+Vd2CqjE9CJpCrkxq7SJAjpjNShTfd0HpbUJ/KAwU=;
        b=BGDcOY3UKDCUipEoSTOfeC1JvevgblG5V7/qVQRHDSGa3tF2ysLEAMhxg8wvfT+Paq
         OoDRRwJ5ojUxXlpLyj/oZO8MmpooENhwTgPibul2Vrg9WwsqWySSj5vGLIXhiAHlSSZQ
         1BFuOMELSEVjfKaa9ai4f0czTeNCGnyH6ndgKRBukD2W8zrxed9sXDMasD1ceJz0/7EI
         Coeo5VwdjWd8CxUElR4tWbDI2BXwzNhJ1Fs8K+gd9MZ9qaUjueAPKXwu+knO3vQMtQO5
         80HaxCSOjM+dKcSqpu+Nnn2Lvpx/tenX2dMx4g8ewe2LRIIARp1P1k+xKB2ztU8QcRRS
         C6SA==
X-Gm-Message-State: AOUpUlGMDQCqQdr7kGohVmGWMQXl3ImqRg9+LPMXUJeamWkdMwtnOoJW
        pR3nnxiaIKZ7Q79b2ftPs02QAJJauohvpP76j60=
X-Google-Smtp-Source: AA+uWPx+0kEE06bdJaumi0M6Zofr6cvQ8KfaOFCZRRrelZ8msq+oI7zxDvJTBw5ukAN+mIIjSEvH+dcEsuR7ktuTU40=
X-Received: by 2002:a6b:f609:: with SMTP id n9-v6mr7509281ioh.259.1534382871458;
 Wed, 15 Aug 2018 18:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <s5h36vhazyp.wl-tiwai@suse.de> <CA+55aFx_ZgBBGoFCqQDCBTs6jq7t4SmVpzc1zzvd-B2E65mJEw@mail.gmail.com>
In-Reply-To: <CA+55aFx_ZgBBGoFCqQDCBTs6jq7t4SmVpzc1zzvd-B2E65mJEw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 18:27:40 -0700
Message-ID: <CA+55aFy5GGpyxQCZoWxOooGu+i5psz7OogvzGpWmuEJ1g7OYgA@mail.gmail.com>
Subject: Re: [GIT PULL] sound updates for 4.19-rc1
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 3:47 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> Uhhoh. This doesn't work for me on my laptop. I get this
>
>   BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
>
> But iooks like something jumps through a NULL pointer.

I have no idea _why_, but it's consistent, and it bisects down to

  c647f806b8c2 "ALSA: hda - Allow multiple ADCs for mic mute LED controls"

where the previous commit works fine, but that commit definitely
causes the problem.

It still seems to revert cleanly, so I will double-check that a revert
fixes it on current master.

             Linus
