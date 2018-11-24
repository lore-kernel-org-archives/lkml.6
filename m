Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2499C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 19:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603572086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 19:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmwQrzZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603572086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbeKYG11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 01:27:27 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42275 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbeKYG11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 01:27:27 -0500
Received: by mail-ed1-f66.google.com with SMTP id j6so12679416edp.9;
        Sat, 24 Nov 2018 11:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MJauIUUR05o509ms87wJD1Ne93AxQ8C68CVD1azviDc=;
        b=hmwQrzZnAFgL00/m/OndaHNs77up+o/UfKiqSME1898N1bF8QROTl/Njj7OjYokXyi
         tpWQpG3DPiiOYCGwBFW8tGRlHT2PByoEV0RHQum7idmpDZ38PFw03zkxdnpPDFOGcDNA
         ZYvN884QrL16UR6PThiG69R4Os8ptDeoJ8zJpHW9urlUE51l1WLh9kpdQ+8uO0tnAX2x
         nJGHLJjob4lq7fHtWt8DAVO7JA5PbLMe1wLwBECxyf0IiMiZiZRT7IT7tRRBCZYa5cqk
         LVzdEddDe8gNAEzodGDxEGueUDMRtnwTSscWIrYEOjMRXNdVt2Dl0czFVoNxJqEdJB8S
         Mylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MJauIUUR05o509ms87wJD1Ne93AxQ8C68CVD1azviDc=;
        b=HPXvSUJiV/JBkoth+uee3rZMA8zCF8uFW/dqdnUlOtQs9R5FEjYlI/4mPa6Al6SFsI
         QRDSW4mA4tJi0EkCEZYDKIGOuM26MonnPZqYCW9PbL3wA9v/nrk2SFfHp20PsFLuZCnG
         aJWj1gkFpjwSXx/C/cZIkD8iRfhphFBeKxf2QpJFRXEyR2AceSMmC7Yu9rp3BkdG788l
         zmFaMHt3o1lEi+KMwwbnwZ6MagmU0kHc6J3fzm/v+bTZzvWto2NVss2Gn55ro6Vt35LL
         mTIrDy+Gkbzod2P/cAddH7Wbnggg/GbW2/z3dVJJwdA2xW798pc1txfd9rhAxgNkPyLB
         00lQ==
X-Gm-Message-State: AA+aEWbS6o9QibcU/E2YoZhIX60nb2NONMiziFwNMHZVcduztysu0Fw8
        29o1tdmh91FwnEhMVwcbJNq7uLSkPDOVXYdffsVtRg==
X-Google-Smtp-Source: AFSGD/UEeezGvrTMgiQknXfOndsnjQbjepBFcVDZmoJIrLonyvaVvniQuUjpMpTrqaKQiR2upBxQD6oKeedR/hMLqgQ=
X-Received: by 2002:a50:ae8f:: with SMTP id e15mr17918418edd.250.1543088298981;
 Sat, 24 Nov 2018 11:38:18 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com> <20181124022035.17519-7-deepa.kernel@gmail.com>
In-Reply-To: <20181124022035.17519-7-deepa.kernel@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 24 Nov 2018 14:37:42 -0500
Message-ID: <CAF=yD-+1BJHuajcW=2bpeAp5XOAX2fObyvhOdH-YsiGY3-_J4Q@mail.gmail.com>
Subject: Re: [PATCH 6/8] socket: Add struct sock_timeval
To:     deepa.kernel@gmail.com
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 4:00 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> The new type is meant to be used as a y2038 safe structure
> to be used as part of cmsg data.
> Presently the SO_TIMESTAMP socket option uses struct timeval
> for timestamps. This is not y2038 safe.
> Subsequent patches in the series add new y2038 safe socket
> option to be used in the place of SO_TIMESTAMP_OLD.
> struct sock_timeval will be used as the timestamp format
> at that time.
>
> struct sock_timeval also maintains the same layout across
> 32 bit and 64 bit ABIs.
>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> ---
>  include/uapi/linux/time.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
> index 04d5587f30d3..106f9398c285 100644
> --- a/include/uapi/linux/time.h
> +++ b/include/uapi/linux/time.h
> @@ -70,6 +70,11 @@ struct __kernel_old_timeval {
>  };
>  #endif
>
> +struct sock_timeval {
> +       long long tv_sec;
> +       long long tv_usec;

should these use fixed-width type __u64?

even if all data models define long long as 64-bit, that might be more
descriptive.
