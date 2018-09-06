Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC781C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986FD2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R11S8aJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986FD2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbeIFVWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:22:54 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37876 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbeIFVWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:22:53 -0400
Received: by mail-oi0-f66.google.com with SMTP id p84-v6so21816583oic.4;
        Thu, 06 Sep 2018 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vBYBsj5C0+fa8O0738PilxaqO2r2+LY52dBEYr7H+1Q=;
        b=R11S8aJFi96fzd9fABY1ghJTwL5pz+y4SkO4fa9asMfsipxsljR9O/qiBGQkGLfdw7
         IczcVu4FXwBZvsIfFD0v3J/TNuAg07JnNKDDYtOdse8JQNZXSTTRuRHI1tGmHswuGL6L
         wvOOVF8O0uAFdVdvPT+3olodJrr5U5MNhUQn+FUQ1EvdoS66Nh3Ig1b0JE86vO0X3YZ2
         TSOC27uXpnMNBRVCuYsejIJegfc6yLWACKOxm4BzeXEN5mUUEfK0c/TqJ0VK93rVz8v6
         DY9CRBBWMH1ojzDepAEWrqP2ak8jSNwHdmrlrp52H5RBvJBaySxmCjnAsGjpR9K2ib1r
         Nelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vBYBsj5C0+fa8O0738PilxaqO2r2+LY52dBEYr7H+1Q=;
        b=QUU3x5i3OJayvbRpY62PVDnSaC0vYWcjJDh6mDv/F57CryzEPxCJ6/bLVa/f4SarM5
         FhY7nda/zRrRgwwSIeqGNlL//Rm/0/4elfWQWfdGCNYcTr9bYEmjtO2Wa/5Q8oZyAhGa
         0KGXaOoDZlMsgBF1EWYNymQUVMnYZRQSqfTPvVZIFE6BPMdbU9xj8WcIG2BZ/OEZT77J
         3uMGUmtFwMMWkv2i0t1onYGjnfi/ap7IlyZdIcJttNCdzC9tNZnj37T4gOXMEX7QQgPX
         L2RvZoSyVZM47oZsJqUONl+Wx1lYInZKBCjE1dIRCyqBRVtFFCLQwNxSSeMJ63qsJzrx
         Cv8A==
X-Gm-Message-State: APzg51Di6wVbeShb/nafSqQtAVwg4iKwM5EyepLHBlSyGosafQV9skeA
        xJgP3kbtvYC9J5lEaX78KRTRGp7KaSgsY89EX8c=
X-Google-Smtp-Source: ANB0VdaYBH/tjSAyK8jveOXEHHa68UfBiComyQ8g98DtFLUti++huVS3fIM/fYTXq1VFxX2SFViT3qlz8rZB2sz3BVo=
X-Received: by 2002:aca:401:: with SMTP id 1-v6mr3504647oie.28.1536252392830;
 Thu, 06 Sep 2018 09:46:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:cca:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 09:46:32 -0700 (PDT)
In-Reply-To: <1536204258-433-1-git-send-email-Anson.Huang@nxp.com>
References: <1536204258-433-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 6 Sep 2018 13:46:32 -0300
Message-ID: <CAOMZO5DzYBz3U=RT-HzzK5KMMnYipceCWh9eYuYRmBctkRZ_=w@mail.gmail.com>
Subject: Re: [PATCH V2] input: egalax_ts: add system wakeup support
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-input@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 12:24 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> This patch adds wakeup function support for egalax touch
> screen, if "wakeup-source" is added to device tree's egalax
> touch screen node, the wakeup function will be enabled, and
> egalax touch screen will be able to wakeup system from suspend.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
