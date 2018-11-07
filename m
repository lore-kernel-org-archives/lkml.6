Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27F0C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 07:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8187B20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 07:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t36K2qG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8187B20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbeKGQiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 11:38:09 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41900 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbeKGQiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 11:38:09 -0500
Received: by mail-vs1-f65.google.com with SMTP id t17so8857930vsc.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 23:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i4aXIufFeaQSmxnYst6Kt+KnglVPwrsiWIg1D/ihOPk=;
        b=t36K2qG04eMIyAKpIwLZOo4sMEL/T5041fsN8uWCn0fZ3XyPTcGlsjok/yb+FxVb+U
         doQEAhBiopHZBzcHJocrd1tp/q4mkx+MVZwIg/vmBD3c86Gu6jldeH/p1eLkn/1T0aSd
         f3j6SQvUTVk8LVkMbx9upoiLnOAmJJMev6sM4OvTXvVoPE7NfoN95fuj3avnk+VgErOo
         qGdqSsPPoeeFEcanxBFU0UzjVmLz6Qgz3nOHIFmMAxZMDwoeRHAb1Y7KZZA3N+Aii4vR
         KyMqIX9j30sKZ+O4vgf/ewJpKeJsxm7RT88auXglAAeg7+vA65n+dqJBDGT+TTXEV6q3
         ht6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i4aXIufFeaQSmxnYst6Kt+KnglVPwrsiWIg1D/ihOPk=;
        b=oZE38dq2rvC1BsiuJ9ZYcXAHzImFXofZcGvILHvAzJcUxxdcIcW2ALDBrPWO7acrh4
         SputXlMRfw5g9sXM+rjkAaSTQ79fVX3dvnzJXKymY5RSatXEd1g3h005gJOEdSIYAszO
         jFpkKN+R2KNPRPLMqzOuFYKWc+l9+QByw8lmTaTcNw7BkS9TQE7JbqoBBLUyYz7fqT25
         BzW+Io1bGCvlrS4e1LoAtpRwAo4QRmEW8hP1Hl7ElCmFe/m2+UcUmSP1Bp99IJVFG+ao
         2rVtxEXfPm7dDCXl9b0BsHNQgA8+FnWo02eDlH5GpqDCtvIoQ7X3y6SZJc5Z4bkOce4j
         rVPg==
X-Gm-Message-State: AGRZ1gIn+PWZgraKkUpWY7sMsUgk7oZ7aFKWB9HuQX/1WX2QSnXO/lay
        3knV1c4SaxYZwBmSrb1NfyeCRVAoUaNC+Mc3ZncwA9EauXE=
X-Google-Smtp-Source: AJdET5c/7ZFWoCtZikQAA0JkzbVWdjfjoIHOFQsYoDzSG2xFy8j63LU/CAOqe1ofjrF0Ik2xtXdVs2wpr5MS8f+1fxY=
X-Received: by 2002:a67:2603:: with SMTP id m3mr284934vsm.160.1541574546358;
 Tue, 06 Nov 2018 23:09:06 -0800 (PST)
MIME-Version: 1.0
References: <20181107053000.12374-1-nylon7@andestech.com>
In-Reply-To: <20181107053000.12374-1-nylon7@andestech.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 7 Nov 2018 15:08:29 +0800
Message-ID: <CAEbi=3eXpUWkf_iaYVnWp01g1N0ddS9EHASNz5Ua_MFLHSx1tA@mail.gmail.com>
Subject: Re: [PATCH 1/2] nds32: Fix the missing "fpu_dp" message.
To:     nylon7@andestech.com
Cc:     Vincent Chen <deanbo422@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nylon7717@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nylon,
Nylon Chen <nylon7@andestech.com> =E6=96=BC 2018=E5=B9=B411=E6=9C=887=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=881:32=E5=AF=AB=E9=81=93=EF=BC=9A
>
> The "fpu_dp" should be added to hwcap_str table to make sure the cpu feat=
ures displayed correctly.
>
> Signed-off-by: Nylon Chen <nylon7@andestech.com>
> ---
>  arch/nds32/kernel/setup.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/nds32/kernel/setup.c b/arch/nds32/kernel/setup.c
> index eacc79024879..e39274a21481 100644
> --- a/arch/nds32/kernel/setup.c
> +++ b/arch/nds32/kernel/setup.c
> @@ -71,6 +71,7 @@ static const char *hwcap_str[] =3D {
>         "mac",
>         "l2c",
>         "dx_regs",
> +       "fpu_dp",
>         "v2",
>         NULL,
>  };

Thank you for providing this patch however I just found the order of
dx_regs and v2 is not match to HWCAP_V2
and HWCAP_DX_REGS.

Would you please based on next branch in
https://git.kernel.org/pub/scm/linux/kernel/git/greentime/linux.git to
re-gen the patch and send again? Thank you. :)
