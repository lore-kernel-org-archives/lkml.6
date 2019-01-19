Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C91C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05522084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547915466;
	bh=ibT0sCQi5t9eGblvshfvampBmqj5GFccOn06+ET8Blc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sAaXZy95Pk40BnXZstUs1IWwYtT0gsGRg2553yI57E/UYOuM7Ixm8bkg0tCnJQ+xz
	 7LZUcNU0KLt3kEKSfd9llA0vIUwb5HDBpYDE4WTCkAdyz0Q7HDmnYJDnIPyg1HLa/N
	 tXUzOZRBp9UyQGrnbMuT8phom0VtKEdo5GbHVUFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfASQbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 11:31:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:54940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728387AbfASQbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 11:31:02 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 825F42084C
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 16:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547915461;
        bh=ibT0sCQi5t9eGblvshfvampBmqj5GFccOn06+ET8Blc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BheFCW3F5GbZyiseBz2fYtn0ZIcQqiGrOFUtlkbDbUA0Yy3pfXNQxdBtyC4ymBO7F
         QSMTeOyfcTe162S/wSDCY/WylLMbtGoPVTAc9NerurLV0KvT41jxIbvonZ2o7Ji1kT
         407TAW/8vCwmzaxcwtr2Smjaqbs566drdQqImFjo=
Received: by mail-qt1-f175.google.com with SMTP id t33so18635343qtt.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 08:31:01 -0800 (PST)
X-Gm-Message-State: AJcUukef6eMahSAnnz14rsPEGleRI7a4aD5b5hh3Zz7OZIThKk/tpRLb
        8fIm8aCdTqt0vcWIQqFWzSAIORXQQaie4Dysjg==
X-Google-Smtp-Source: ALg8bN73wh//Ipe4yjOdfezr1A+3x0hPSw5p173kUqE9cyBDQm8rdA5P8R+iiST0mItIQlHHLCRAvdyHWPZ6HOs2w6Y=
X-Received: by 2002:a0c:c389:: with SMTP id o9mr20075820qvi.90.1547915460751;
 Sat, 19 Jan 2019 08:31:00 -0800 (PST)
MIME-Version: 1.0
References: <1547914725-12125-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1547914725-12125-1-git-send-email-linux@roeck-us.net>
From:   Rob Herring <robh@kernel.org>
Date:   Sat, 19 Jan 2019 10:30:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKMUX4ZGZutPSs1RsnXXDjz_GVfkPHbbXCdQfogMXym-w@mail.gmail.com>
Message-ID: <CAL_JsqKMUX4ZGZutPSs1RsnXXDjz_GVfkPHbbXCdQfogMXym-w@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc: chrp: Use device_type helpers to access the
 node type
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 10:18 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> The node type can no longer be accessed directly, resulting in the
> following build error. Use accessor function instead.
>
> arch/powerpc/platforms/chrp/setup.c: In function =E2=80=98chrp_init_IRQ=
=E2=80=99:
> arch/powerpc/platforms/chrp/setup.c:541:33: error:
>         =E2=80=98struct device_node=E2=80=99 has no member named =E2=80=
=98type=E2=80=99
>
> Fixes: 8ce5f8415753 ("of: Remove struct device_node.type pointer")
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: of_node_is_type() checks if the node pointer is NULL, so there is
>     no need to check it before calling the function.
>
>  arch/powerpc/platforms/chrp/setup.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Already have the same patch acked by Michael and am sending to Linus shortl=
y.

Rob
