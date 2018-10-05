Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BEFC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2382E20834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzw7wKRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2382E20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeJENt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 09:49:56 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46168 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbeJENt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 09:49:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id z144-v6so65972lff.13;
        Thu, 04 Oct 2018 23:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jt1XDUkDJwjd+wVG3yNiiUeavAxUfRp14JEm3JIWDV4=;
        b=mzw7wKRA24PHiDL0fygryCgGa3/JsjOchyQ6MuwFNdSPtUd3D8Zw3Xa+LZtHEWpMWa
         hvYYLvLPa91hYtiz/BaRWrbNHRQKbGoJZRC98FtPtwwWkp7YzPCFxAcyMgYdYOw+6ccp
         oVg9h0u0SedeaZ8JFjhqLX7nLEFGFGivCtBLbbFmS3rOrDl6g1uSP/Mr8d3WnTTp4La4
         mYQunDjJ20nYfWk6W1cTUywndUAybb4ZJ8ssoVI1JnaxYYyEUk+wWgt+WGVdW0QsHGF5
         HFhQ4vMFeuSPGuYBKwZtEwBIna34T66cfHqNsHsB+nsWZ7toV6pdmeNTEr/AaClXS3OW
         hdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jt1XDUkDJwjd+wVG3yNiiUeavAxUfRp14JEm3JIWDV4=;
        b=I1y3Hx6Kz7JzarQ2NWt363GnPxC9Rz9TmXeNQy6BG5ilQTMYnoSfGkuDWuc78YySav
         PzLXo1Btgh5wHFHFSsy6EtHqF3wioDu+MkizJmE5ecelY3YCUDwEr7Yill4uh23BubQN
         ayBXS9IWNxYEunu7tVUcvryrEkD2BNHW9IIXo0puJe5xpA915KPg6wEKVWvkgFQ9UJGR
         JI8p00SM342PfWmWjH+fLILD38j3y4uAAbp773ILOQTyL3Fbx+B8mYPtsiDG5XPpRqPw
         S08BhX7nxcYOZXn27xVECfR9PBgVQP7PjR66l464I4tWN++jr0wMa85jqjJeAoJucdDM
         kIew==
X-Gm-Message-State: ABuFfogEu9BmE8dduodpRS0gGWvAnNAHLOwOkFiJS9TKnL1ESIVQqch7
        MxCTvktbdtHdzwdVIxxCUBGPKE2nXsVGAFeCQN0=
X-Google-Smtp-Source: ACcGV61et6KjDNUGkjYfqMmFovNGlFDlehTto44c+dNdzdBH+6uFBLSYPZc2js40ezZCzdTYQEVMDg8diVUdXl1kEuc=
X-Received: by 2002:a19:d408:: with SMTP id l8-v6mr5980703lfg.25.1538722357206;
 Thu, 04 Oct 2018 23:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181002140858.16833-1-ricardo.ribalda@gmail.com>
 <d1bbafcb-1b6a-b137-1fd1-954c17e14836@codeaurora.org> <da760bcf-4716-e685-1ce4-1dbc6eb7c272@codeaurora.org>
In-Reply-To: <da760bcf-4716-e685-1ce4-1dbc6eb7c272@codeaurora.org>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Fri, 5 Oct 2018 08:52:20 +0200
Message-ID: <CAPybu_1qqdffE4K2BonCV0X_eYY+or6NSK9Bbco9A68N9aasVw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] gpiolib: Show correct direction from the beginning
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Timur Tabi <timur@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
On Fri, Oct 5, 2018 at 12:26 AM Jeffrey Hugo <jhugo@codeaurora.org> wrote:
>
> On 10/2/2018 9:21 AM, Jeffrey Hugo wrote:
> > On 10/2/2018 8:08 AM, Ricardo Ribalda Delgado wrote:
> >> Current code assumes that the direction is input if direction_input
> >> function is set.
> >> This might not be the case on GPIOs with programmable direction.
> >>
> >> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> >
> > I'll try to get this series tested on QDF2400 by the end of the week.
>
> 1-2/3 (v3) and 3/3 (v4) still fails.  Same issue.  Attempting to access
> config registers for GPIO 0 when the OS is not allowed to do that.
>

I think that I might found the bug. if gpio-reserved-ranges was
present the initialization was lost.

Can you try with v5

Thanks for your help

> --
> Jeffrey Hugo
> Qualcomm Datacenter Technologies as an affiliate of Qualcomm
> Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.



-- 
Ricardo Ribalda
