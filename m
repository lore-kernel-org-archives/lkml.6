Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2D4C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D4A2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJFCP28L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfAXFeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 00:34:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36218 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbfAXFeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 00:34:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id p6so1655880wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 21:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jKVCod9gp3ntegj5kYXtLFx52Wy2A6WVJuIBMAyjPpo=;
        b=dJFCP28L0VEVQEsVFPiP+5bhzspoc/0i1KLRDwNwT26kEMojbPvAv5Vitlp+h6261J
         2AZ5O2N4tZhsFmKTlRztwYwpMw+F2Nscem40rSig056eg4/nD5T+xF1hEVSQeetayLVD
         tNSybmLd8B0Q+KDV0PyREyqbVv5Ri0iwjm0n9lWqBrduaNgohgpLXvDZ8Sg7VK5p2dTx
         hXRA6s6afQL9L+hCzajXuNO2nnIbWSxbRHpBXQSyZWpyOawuyYJX3WEgjEidrv/GkjKE
         l0lhxRQ+rPjci36Yui0zfW++iOML2aeSLAiEmhUgh57OH/f7PTyQTd0ZHU9k8rgrBzFC
         ZZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jKVCod9gp3ntegj5kYXtLFx52Wy2A6WVJuIBMAyjPpo=;
        b=iFVAW+waQBBeI9sdL3tZOmrWlJ8ISgnS/1iUgp8lXIYfYK4D0/eEEIxjCY/WNfHZqF
         RGN817zsuC9J7D461CQ3cS1nd42xPuZM7IubfST717P0qVnxMaGcnlOEgHcLXuQL9f5J
         0FPugMnmy6G/7iODRFth8bdI2tTlzgHJf3aVetTH17gAb4hS0Zc3F3c1LVQvldI3BwRv
         kcSDX6yPfptVX7kCRgDIFNid+heyOCKOUmEYaie35czcWGP8FdnZKS4cQ+eWLiuC6WQh
         ZJ3zKFdB0dbaQhw7lt3Xh+1nSAIbpgBMFDkiAqPAixPUXSbVCpHeat5L7c+Qp8z8mipm
         JQaA==
X-Gm-Message-State: AJcUukeBcdE5EnQEsSQ9r783V0pW7fEkYBhqp7rdIrIuQHbUiKe1wFLA
        oMuHLLefzcQpTzOymHrgkZoMPq/ETFzaz5GHwaU=
X-Google-Smtp-Source: ALg8bN5WzpsjDgSTjWVSpV78P1xz/XBp05HP6j3km6RuIsleuhcea/1TmsYv1rv1j/VO464uGALI1xPUM41UtwTunqw=
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr983150wmi.144.1548308038881;
 Wed, 23 Jan 2019 21:33:58 -0800 (PST)
MIME-Version: 1.0
References: <20181220010700.8598-1-andrew.smirnov@gmail.com>
 <20181220010700.8598-3-andrew.smirnov@gmail.com> <1547743553.4009.16.camel@pengutronix.de>
 <CAHQ1cqG+3K+SKptZJ-FQ6xAa+2LMs_W24TEgqyV+9kR_iAz+cg@mail.gmail.com> <1548240735.3904.8.camel@pengutronix.de>
In-Reply-To: <1548240735.3904.8.camel@pengutronix.de>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Wed, 23 Jan 2019 21:33:47 -0800
Message-ID: <CAHQ1cqH1F2ivi57SuAdhzm-iCV=YsNKf-E+_GfxxjabFVDt0qQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: reset: imx7: Document usage on
 i.MX8MQ SoCs
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 2:52 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> On Thu, 2019-01-17 at 14:38 -0800, Andrey Smirnov wrote:
> [...]
> > > To be honest, I don't like these two, I'm not convinced anymore that
> > > they actually qualify as reset signals. To me it looks like this is
> > > something that the PCIe glue code should handle via syscon like i.MX6.
> > > Leonard, Lucas, what do you think?
> >
> > OK, one thing to keep in mind about this is that those bits are
> > already exposed for i.MX7D and I think (correct me if I am wrong)
> > there's no going back there.
>
> That's not a reason to repeat the same mistake for i.MX8QM, but at the
> moment I'm still trying to figure out if it actually was a mistake.
>

It absolutely is. Removing those resets will not meaningfully simplify
maintenance burden for this driver (a one line change), but it will
cause additional code churn on PCI side of things. You may not agree
with me that it is a _good_ reason to not to remove those resets, but
it is a reason nonetheless.

> > PCIe driver already has the code to use
> > those on i.MX7D and, due to high degree of similarity, i.MX8MQ
> > actually re-uses the same codepath (at least for
> > IMX8MQ_RESET_PCIE_CTRL_APPS_EN).
>
> We can always switch to i.MX6-like direct syscon/GPR manipulation and
> just drop the resets from DT.
> Since if this is done, it should be done for i.MX7 as well, I see no
> reason for this issue to hold up your i.MX8M changes.
>

Cool, thanks!

Thanks,
Andrey Smirnov
