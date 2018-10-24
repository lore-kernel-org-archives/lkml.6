Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCACC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF4020824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DL4sQRFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF4020824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbeJXV5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 17:57:07 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:42973 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeJXV5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 17:57:07 -0400
Received: by mail-vk1-f196.google.com with SMTP id m199-v6so1237295vke.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 06:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wsoFEiNJLakB7ct6YlFja9F63VVvqb40HY6OnEjnKBo=;
        b=DL4sQRFwwfhxovU/H+LN9cCunok0+R3k4qmxZ5N7a8vUjdxmGGuQP5h+cAu6+ZiRWa
         ertW6GBYEP9fN1byA+qE5YTEGP7ZnWhMpE3NTLqzdeyFwyvKver9IyDv+YYX4VaZbtuz
         QD3CyAxnw0GE8UiohXFbBMfTDmXQtuD12cIlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wsoFEiNJLakB7ct6YlFja9F63VVvqb40HY6OnEjnKBo=;
        b=r1AqpDRTXCzS8TJnEMHJwwLlUVROmvzZf3YIdgTzy8rQxTp9Pb7JMfbqMl8fBr1qLZ
         R6FcQWhVQE3nbxGbQnNYt8i68ZeNNQcacJbN65wzkSBVPe1ssDnmTPr8wa/OV3mtgsmf
         ZyE6HdzsbbGMeMk4sSnLQXcfgiqtzrqEDqT3jRGhB7O43j4UCpyt/1bKXJDUGe4OraSS
         yej7ejnjXWovBfLr6h/ANRqvIHLht1ed5+XR4teTnSXOExpNeSYeJpuPWizm/TDoznDe
         WXWlMHWNij7n9/jHTNHg4rthP+cOyFsIloCssB/F+cpmrP3j+T5WhhWNMiK9QF4fjtJ/
         /lgw==
X-Gm-Message-State: AGRZ1gJYSdQ/gUwvG7R38vo47YOYmEf+rv1BSss9pS2Wb29dtvb3OGcH
        3bXdc5fgogxpmwC1YOYjrAiEj/8hiakL1xEN2wtuwA==
X-Google-Smtp-Source: AJdET5fVF94KrxzinhpiyndW0oSHa4elGvmIDDHxyCxL8GofFAn05g/MIwo26/4DUBMjt1XVCsMc5sLAsYjEPqlXEII=
X-Received: by 2002:a1f:8011:: with SMTP id b17mr1117095vkd.31.1540387738504;
 Wed, 24 Oct 2018 06:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181023.202921.1185045750138652543.davem@davemloft.net>
 <CAHk-=whuhCGujWKO8JObGQaSdWOpJBXdkM-B-vD80QZifveScw@mail.gmail.com>
 <CAHk-=wh2H9jE2RXibQgWs3_Q539roj62_gzPXKjnhhKqSFcw2g@mail.gmail.com>
 <87lg6nu6k1.fsf@codeaurora.org> <87h8hbu5uy.fsf@qca.qualcomm.com>
In-Reply-To: <87h8hbu5uy.fsf@qca.qualcomm.com>
From:   Andy Gross <andy.gross@linaro.org>
Date:   Wed, 24 Oct 2018 14:28:47 +0100
Message-ID: <CAPBZ5QcpooNi=YnGJJxM020LO=Z_GAM_teGiE5gLKX-g9xhcHQ@mail.gmail.com>
Subject: Re: [GIT] Networking
To:     "Valo, Kalle" <kvalo@qca.qualcomm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        govinds@codeaurora.org, "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        jeffrey.t.kirsher@intel.com,
        Niklas Cassel <niklas.cassel@linaro.org>,
        David Brown <david.brown@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for spam, I am resending in cleartext because the previous
missed the lists.  Thanks Google for resetting my config when you
'upgraded'.

On Wed, 24 Oct 2018 at 09:05, Kalle Valo <kvalo@qca.qualcomm.com> wrote:
>
> Kalle Valo <kvalo@codeaurora.org> writes:
>
> > Linus Torvalds <torvalds@linux-foundation.org> writes:
> >
> >> On Wed, Oct 24, 2018 at 7:01 AM Linus Torvalds
> >> <torvalds@linux-foundation.org> wrote:
> >>>
> >>> Hmm. Tentatively pulled, but there's something wrong with the Kconfig rules.
> >>
> >> Confirmed.
> >
> > BTW, our emails crossed and more info in the other email[1].
> >
> >> I did a978a5b8d83f ("net/kconfig: Make QCOM_QMI_HELPERS available when
> >> COMPILE_TEST") to fix the breakage.
> >
> > Thanks, though I don't see it yet as I guess you haven't pushed it yet.
> > Do note that it _might_ conflict the other commit which I suspect is in
> > also coming to you:
> >
> > ccfb464cd106 ("soc: qcom: Allow COMPILE_TEST of qcom SoC Kconfigs")
>
> git.kernel.org is alive again for me so I can now check both commits. It
> seems that Niklas' commit[1] is more finegrained than what Linus did[2].
> I guess either of the commits should be reverted when Niklas' commit
> goes to Linus tree, or what's the best course of action?

Yes this will conflict with Niklas's patch which is part of the 4.20
pull requests.  I would prefer that we revert Linus's and take
Niklas's unless there is a compelling argument to have it fixed before
-rc1.  That said, if you didn't, the merge conflicts would be minor
and easily handled.

Regards,
Andy Gross
