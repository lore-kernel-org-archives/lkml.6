Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A750DECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5885C20882
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="nUF4UGQv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S0kDXfLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5885C20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388431AbeGXQuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:50:54 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:45677 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388330AbeGXQux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:50:53 -0400
Received: by mail-ua0-f196.google.com with SMTP id k8-v6so3038898uaq.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZDb5ToJ+yA5W0L5Rqk5W2dIq8XyGzLZxKu7YNopl/H4=;
        b=nUF4UGQvC0n2hqioQyIhS06y/cJK8VwyMWdCdhZDfu6fx1/RTDzruu+vOrVPkzom/0
         R+/GTHl4SUQUf2xvnIzvYWIkZlifNGdWkV7drCydqQ0g+0YhvByIL81OQWCiMEYGyEzq
         D3owrcqiS7rRx1M8/WemwDKxqrfXIHHGiCoJMmbdCS3O1TbaGrKvCR1ujarJ2hA47hGq
         Qddj9llLshFOMR/cxm7Szwmh6+59B8ARa3TP8QnuDY8oOjiqlqH2IXnoS7/xDAHn8jvl
         KXuRMtrgNTA12hQUgjtUmkfyLzZJIFDRcfH0+0LbVKFAsxJXfy/sjgwQUWVj9bYRE52L
         xgvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZDb5ToJ+yA5W0L5Rqk5W2dIq8XyGzLZxKu7YNopl/H4=;
        b=S0kDXfLr8xy4EBSq9JJQbfgN6zl1uyhzo21Wl+EX0YZXhSFBBCaY4XHkAsGbf+5aSe
         t71wMz/N7G+DjXV/5J0gPMli9t8ZrITyVi0xGHDSfFhNZTE2uQ1hPY3QWkKMdbqtZrbE
         KqRAO2iouE1HVOV4KfEkskxyYq/B7zMeWx4bA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZDb5ToJ+yA5W0L5Rqk5W2dIq8XyGzLZxKu7YNopl/H4=;
        b=S70LB7vmTe+DWCRGxZBe3HQRShMnFhSdxr4gEiXe4OUmSWCbP+DXZyDqDhiQ0xb2F+
         iAuv5fgZ/IpJ1e75+L/rUUz5XpJophf6ILxqsDsCeU3v3ozyWyK+ZllvwW2iUU4MtjfW
         Zdva5l6W/ChsVDdhgxBtXlBXmnhgjgYjzP9rGYlyK1nPo3dXZWyucOTeyC4DBwwhz8oD
         B9drhxQ+mMM423g8zukY4tPpLW76Ed7DBq4H6DeAEZJGCY18H2ckoOVTUsN5FRZOFUML
         fwBOHnou9xi7boOPpx3xpD1RDKTPHrRbdyMmSDqQHeC0Ftg+wgbCwn6mtekUTSP2TmRf
         WEWA==
X-Gm-Message-State: AOUpUlHflqPIpHhDkPf6O++EUdIhcrnaDf+yk/kBauziQd2A8qAblWry
        TFdx+zQbW9pKrTk/q9CL7re+vpvrgwgfIZWkbyuong==
X-Google-Smtp-Source: AAOMgpdwhZz+0Smqe8uHVkubaHga3N4BkmGaT3aHozo98Y3gqU+cf1LTiNhURGkyGdcRVJw//AA0ESulKPNRVmSTs7M=
X-Received: by 2002:ab0:47e3:: with SMTP id w35-v6mr12080481uac.20.1532447027638;
 Tue, 24 Jul 2018 08:43:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 08:43:46 -0700 (PDT)
In-Reply-To: <20180724152514.GJ13268@sirena.org.uk>
References: <cover.1531531808.git.collinsd@codeaurora.org> <56b9d5c38cfe46da1228c54f001a49773c3e31dc.1531531808.git.collinsd@codeaurora.org>
 <CAD=FV=VmfqWRGRMEn+0dzZ8x4R5vVaHbkthXAN91Lm-XmP9Gqg@mail.gmail.com>
 <20180724145755.GF13268@sirena.org.uk> <CAD=FV=Uo8sT72a0gRitOVoK0SfC-_QixsovW94_LnL6H7QdKvA@mail.gmail.com>
 <20180724152514.GJ13268@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 24 Jul 2018 08:43:46 -0700
X-Google-Sender-Auth: hg7Q1U16AtIXl8CA0wMdZU-vy7s
Message-ID: <CAD=FV=WHJcAoR7Y_uhi7_GbVzy6K8FnovVFVRz8js0REONox=w@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] regulator: dt-bindings: add QCOM RPMh regulator bindings
To:     Mark Brown <broonie@kernel.org>, Andy Gross <andy.gross@linaro.org>
Cc:     David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 24, 2018 at 8:25 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jul 24, 2018 at 08:11:30AM -0700, Doug Anderson wrote:
>
>> RPMh itself landed in Andy's tree and he sent a pull request on
>> Saturday.  Feel free to refer to the request ("[GIT PULL] Qualcomm
>> Driver updates for 4.19") AKA
>> <https://patchwork.kernel.org/patch/10539125/>.
>
>> It doesn't look like arm-soc has picked up Andy's pull request yet
>> though.  If having it in arm-soc is a requirement then I'm happy to
>> monitor arm-soc and ping this thread again when it's there.
>
> There was also some other thing called command DB as well which was a
> separate series.  Ideally there'd be a branch I could pull as there's a
> build dependency on rpmh so I can't apply until the code has landed in
> my tree, don't know what command DB is exactly.

Yup.  That one landed in May and is already in mainline Linux.  Refer
to commit 312416d9171a ("drivers: qcom: add command DB driver").

Adding Andy to this thread (I guess he wasn't on it?).  Hopefully he
can provide you with the branch.

-Doug
