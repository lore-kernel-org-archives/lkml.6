Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1F9C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6150627935
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xaptum-com.20150623.gappssmtp.com header.i=@xaptum-com.20150623.gappssmtp.com header.b="OzFUwjAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6150627935
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xaptum.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936471AbeF2NDR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 09:03:17 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44346 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935385AbeF2NDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 09:03:15 -0400
Received: by mail-wr0-f193.google.com with SMTP id p12-v6so8772019wrn.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 06:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xaptum-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=puNM3o7RFA9XdCbziUzAbRW4pZN78vOulGjLZKmgTSI=;
        b=OzFUwjAHOLpbFAXQykbf2NqtbYDUaXClCAvP+l/sVTaB9h9A891FUxcoXXHZHI44lg
         hUYfw+sxGlVsiuqLRURL2fALSA6K+YPNXFLXBsKTda90tQz0BuFl9DYNGtnJbMSwWrHo
         tETA4ebSlX87BtPlOwBChIaOCCPlqQ/7eBwYxIX4yBemjsvZ0/onaz0aaLovTts1PqWE
         vlttQOE35QbqALOW/wtPDZqywIU46zE5KjOm7kLdhOFhtasejQnYOQr0mZ9x/7tBOc1Z
         1kFIZTOohcnT8925nPG11u9GkylZw/G8oPG5Ixp8iIJurNSrBiFXVAoYIpNT/LUkvDxG
         7Z1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=puNM3o7RFA9XdCbziUzAbRW4pZN78vOulGjLZKmgTSI=;
        b=Jx17zauj2S6dEiorgN4DmD36k99RiN0KaVUvZmWzd616d3zh+ORXQ3CHZNmu0RBhxE
         djF0TszZskSHB6eQdznYgWwTwXDl/aloLWkRcZj+Lzx8pzceUnrCTxRbGj+NQ5F/a4tl
         vZHBk5C1BDiAnHD8+x6ibrfNrnLjuNS5/BVU1Q9FRgV+NbMKX9g1cck8z6H8EWmIiuna
         H0yZhLg37lsbI4LkJIKwhAsT2oqUy+SRg8lEdI1q1FsJjENo1SgYdYGbcNAwiq69H7bU
         Br+TA2j/CP1k9jAO0NKvmdJ9yoA1+Oei9JRoda3pmto6YSMRgJ8DEZ7ncVWSXDg1cveQ
         KRdw==
X-Gm-Message-State: APt69E33GMn2fha3XtRH1t+Hc2ibv/t8beI7JR4LO1QfoGLuH4BkRTvQ
        nQ/3nfG3/yBpJx8T/aUjsx1Lh1YstiNlCQ6UoMFKMA==
X-Google-Smtp-Source: AAOMgpeGKfILnfI26apDPgipICZgDN2aimsd1lxprNcBNU55aVf660wHDirlVTUo0uSO1itEZEh8++CwofCcEWXdwP8=
X-Received: by 2002:adf:a603:: with SMTP id k3-v6mr3388010wrc.39.1530277393978;
 Fri, 29 Jun 2018 06:03:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:2945:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 06:03:13
 -0700 (PDT)
In-Reply-To: <CAKNRAJVJD5b388iwhoOBVC5V-x=wV2YTZHJ+mRrBWv3H-pbNFg@mail.gmail.com>
References: <20180608065438.110109-1-louiscollard@chromium.org>
 <20180618180712.GB20697@linux.intel.com> <20180618193306.GF6805@ziepe.ca>
 <20180621162101.GB11859@linux.intel.com> <CAKNRAJVJD5b388iwhoOBVC5V-x=wV2YTZHJ+mRrBWv3H-pbNFg@mail.gmail.com>
From:   "David R. Bild" <david.bild@xaptum.com>
Date:   Fri, 29 Jun 2018 08:03:13 -0500
Message-ID: <CAAi9uDuxS7G+DaHskGJXnvigsdzXrW64J6zy-dgQCXJvv8be3g@mail.gmail.com>
Subject: Re: [PATCH] tpm: Add module parameter for hwrng quality.
To:     Louis Collard <louiscollard@chromium.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 1:11 AM, Louis Collard
<louiscollard@chromium.org> wrote:
>
> On some systems we have seen large delays in boot time, due to
> blocking on a call to getrandom() before the entropy pool has been
> initialized. On these systems the usual sources of entropy are not
> sufficient to initialize the pool in any kind of reasonable time -
> delays of minutes have been observed; the most common workaround is to
> mash the keyboard for a bit ;)
>
> Setting a non-zero quality score causes the hwrng to be used as a
> source of entropy for the pool, the pool is therefore initialized
> early during boot, and no delay is observed.
>

We have the same issue on our embedded devices and thus carry patches
in our tree that set the quality.  This would be a welcome change.

As a point of clarification (and correct me if I'm wrong), the TPM is
always ready used to seed the rng. It just doesn't update the entropy
pool estimate.

So, perhaps the default value for the TPM hwrng quality should be
non-zero (in addition to the module param that lets users override
it)?

As it stands, it encourages programmers to not use methods like
getrandom() or not check the entropy pool estimate before reading from
dev/urandom.  They know the rng was supposedly seeded by the TPM ---
the entropy estimate just wasn't updated --- so the easiest "fix" is
to just not check the entropy pool estimate.

I think the default config on a machine with a TPM should be that the
rng is seeded by the TPM and that the entropy pool estimate is updated
to reflect that.  Then programs that are written properly (i.e., use
getrandom()) will work correctly with no further effort from the user.

Best,
David
