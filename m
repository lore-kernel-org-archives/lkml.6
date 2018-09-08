Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AB8C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A24B2086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDTCZUsx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A24B2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbeIHOW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 10:22:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36981 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbeIHOW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 10:22:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id v9-v6so14119070ljk.4;
        Sat, 08 Sep 2018 02:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7mnGV3HSCwo2zDXyys4d8xt2vh7KULBGL1RC67BRCco=;
        b=mDTCZUsxKP+ZDEi5gb+xnDRX7FbI5c4VOt6XoBzhuUZTvAEH6KM7fs51CUEXZeoSwJ
         aKYdFBDN2cfE0Lrk2wrWDMaeB5NedXPadpmotgszL9QcAgMgjM7MpiVdT04+22zZYPBk
         J5U1XMWuxLuyhWFnO38DH0NB6sh18/Fac3Kpn1Sc/3EBy45XvaDAOeJFAEGW5Pc9A0bK
         6PvMu290tijbN3P4a7KirJkdqadKOgATWYgaU3lGbeeTVb2ro/hWZsWxWC19bPhf0AKt
         5LDx6KuEd4jhEdCKUr9gZYpdr7IiB3g6qvAWgMFTfg+nphiVkUTfOn/QECB+peVdPNk7
         mBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7mnGV3HSCwo2zDXyys4d8xt2vh7KULBGL1RC67BRCco=;
        b=QLuTcmsiFn+44WGMoFPfbQzzPLvS/0N+So/VS+aOEsar+yaFYQN23ZSUsIW6ffoN8l
         lNuG3j5Q8x2mcL9mF5xGHgaRNzGhdhUjcJ3ZhgI3qQwjB1g8KMFE6NWI3OxbXucpaIm/
         /qXgyzvey3/C8fP3fMJWu+9GXGWY/kBnMFgLabSCJdONqAUMVWwsSi/Wez8RH2XJE4oe
         5NO7OK+DmFpoD96kON8dkDwdBVzT1Q1mjYLqklgQlR2ZXfvelcDqReIloF55jqSMmH8K
         5nx8f6bhSe3Xd9QGa7itNs9B7sw4PnH/wl7YqXgCLTXwr9rawURHwNtk4TnacXdrxAHS
         F5SA==
X-Gm-Message-State: APzg51AJ8i1KT0hu8DFk1nyZKfnNAwB+ED2/tTQeApDRsqogF6QsOx27
        qQCATxVM+3aQizMNSdOD41z/GExYbVPzjvdTafA=
X-Google-Smtp-Source: ANB0VdaZP8aPN7cL5QX4ijuhOSMqU/cBS1z4tal9RYt68bFrDsITyDmBehu7OoMSvm4TqQ2Z0iyWPrmaMLWw1asAOR4=
X-Received: by 2002:a2e:4619:: with SMTP id t25-v6mr7606341lja.96.1536399467340;
 Sat, 08 Sep 2018 02:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <1536325173-16617-1-git-send-email-p.paillet@st.com> <1536325173-16617-5-git-send-email-p.paillet@st.com>
In-Reply-To: <1536325173-16617-5-git-send-email-p.paillet@st.com>
From:   Antonio Borneo <borneo.antonio@gmail.com>
Date:   Sat, 8 Sep 2018 11:37:29 +0200
Message-ID: <CAAj6DX2tnT5wjmy9nfRx7ut62_6rsQ00RNjaXX3WxMsB+mSHYw@mail.gmail.com>
Subject: Re: [PATCH V2 4/8] regulator: stpmic1: add stpmic1 regulator driver
To:     p.paillet@st.com
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, lee.jones@linaro.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, wim@linux-watchdog.org,
        linux@roeck-us.net, linux-input <linux-input@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, benjamin.gaignard@linaro.org,
        eballetbo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 3:15 PM Pascal PAILLET-LME <p.paillet@st.com> wrote:
>
> From: pascal paillet <p.paillet@st.com>
>
> The stpmic1 PMIC embeds several regulators and witches with
> different capabilities.

While fixing Kconfig, as Mark suggest, would you mind to fix also the
typo s/witches/switches/ in the commit message?

Antonio
