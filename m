Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62F5C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCB12087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j977q82v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfAHErS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 23:47:18 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40090 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfAHErS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 23:47:18 -0500
Received: by mail-yb1-f193.google.com with SMTP id x201so1087319ybg.7;
        Mon, 07 Jan 2019 20:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iwEkgDQSJTeLUzK1szAoyZh+UnfbSE7vRq05ds6HCvI=;
        b=j977q82vS/Hlt+Aa2ymjSyMPSqvJSYDE4vtpxfWQ34FMXf/VPjufqqYeHcOnLcjUWI
         OOkVsofx/XFlbQkikFCbE2Nq6Uj54KEbv0wxB7sQkX7+2oV4XT86bbECJOz7pUrlXrpY
         VuN3yHCyIbbjeOD0raB7ZP24/m0GBnRjONRaiOjeIXjKoY4xco+caXf+yEp4hqhF5O4+
         8bj/yFwXhIi1AyUfgzSfDSPhogRL8/60teC41QPmbw4ZV54TzwMmvHyNo0DINbZqCQSA
         c3QLiJ7ei0IkTfOVRuckp2mdu0QDowbQpGusWFfpACp7oYecDwPKRu/lemn6eDxrFOL7
         ogrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iwEkgDQSJTeLUzK1szAoyZh+UnfbSE7vRq05ds6HCvI=;
        b=U+CKwCQYwOy5df3d0GgDo4wso4hwKh5GHyrNgDPIERxQtpgC3wmStwktJza2/IDLE3
         IXJLOYSRSn/kc8EUhoYHySFtOKG+9ikiLW6mN6/3nYcZ8AvYSLFBDBnVWNiaLRWcdBkW
         LPvSwZSw6KT75ynARolYhJ2VTHsR6QXNX1u4eSwlvmoDt22y3Ot/vrKC5nUVUY8RwXE6
         uZdYo7ufNcEyOcMqRNyeOisBo2ie9CWWsgrgr2lNI2La3YeBm5qRTFxSmQz18J7dl6Nm
         70eXvWeR70sGguN0D6fvAdnvgfukuRfo7fwbVXAI3gxvImFSVtVczrrneWWjwsNiJcVZ
         pZKg==
X-Gm-Message-State: AJcUukeXuQhmDQb1bJzYg+14LKxay1h637yKFXjnH/xo6dIGCdUZbIII
        Ow7Oet0fGWKeOReKfA7WPCuyXXG3husZepzY9Po=
X-Google-Smtp-Source: ALg8bN6nwJjBj8Jll+7gH2KVRHX6bkM2K13Fi0kr6NzrKlfiouazLjcw1UvPTazPIr+VKh7LMCLFjAmB1fqjdrwKFoI=
X-Received: by 2002:a5b:902:: with SMTP id a2mr193481ybq.445.1546922836980;
 Mon, 07 Jan 2019 20:47:16 -0800 (PST)
MIME-Version: 1.0
References: <20190108032657.8331-1-deepa.kernel@gmail.com> <20190108032657.8331-2-deepa.kernel@gmail.com>
In-Reply-To: <20190108032657.8331-2-deepa.kernel@gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 7 Jan 2019 20:47:05 -0800
Message-ID: <CAMo8Bf+BA-Z78E-VQ3QNPrQVFD0kJrhJdmUZw=ZchfP6iYg_dA@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] arch: Use asm-generic/socket.h when possible
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Chris Zankel <chris@zankel.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "open list:IA64 (Itanium) PL..." <linux-ia64@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 7:28 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> Many architectures maintain an arch specific copy of the
> file even though there are no differences with the asm-generic
> one. Allow these architectures to use the generic one instead.
>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: chris@zankel.net
> Cc: fenghua.yu@intel.com
> Cc: tglx@linutronix.de
> Cc: schwidefsky@de.ibm.com
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-xtensa@linux-xtensa.org
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/ia64/include/uapi/asm/Kbuild     |   1 +
>  arch/ia64/include/uapi/asm/socket.h   | 120 -------------------------
>  arch/s390/include/uapi/asm/Kbuild     |   1 +
>  arch/s390/include/uapi/asm/socket.h   | 117 ------------------------
>  arch/x86/include/uapi/asm/Kbuild      |   1 +
>  arch/x86/include/uapi/asm/socket.h    |   1 -
>  arch/xtensa/include/asm/Kbuild        |   1 +
>  arch/xtensa/include/uapi/asm/Kbuild   |   1 +
>  arch/xtensa/include/uapi/asm/socket.h | 122 --------------------------
>  9 files changed, 5 insertions(+), 360 deletions(-)
>  delete mode 100644 arch/ia64/include/uapi/asm/socket.h
>  delete mode 100644 arch/s390/include/uapi/asm/socket.h
>  delete mode 100644 arch/x86/include/uapi/asm/socket.h
>  delete mode 100644 arch/xtensa/include/uapi/asm/socket.h

For xtensa:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
