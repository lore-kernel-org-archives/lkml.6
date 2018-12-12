Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2705C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6167120870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oX1KcE3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6167120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeLLMvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:51:45 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:38518 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbeLLMvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:51:44 -0500
Received: by mail-oi1-f182.google.com with SMTP id a77so14895220oii.5;
        Wed, 12 Dec 2018 04:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qcmt923j8A2lCObwQjindbK1wLTPcKYHQ+hJn/I5s/I=;
        b=oX1KcE3CZcARz8a4I6pgsoe/NDC9Z9yGm2qNPD5ry9Q4SvZkUSduMFDL5VFzhHnnTE
         1G3ds2JH56V8uyTOppLIx5kuQCW7iExqXb0Y8dk1yg3k6Iu4Fs01lmY95sQUS5oGmhMy
         A916ip8C0X8zF3xkBW0q+mC51XjQfRzkT61gPoDLBuOvn4hZ7wAAVETcfTzshKunGZgz
         GOOZHdkF843THNa7QazJIWjUgAbO6p1Ig8xmbuEE9Qb+gb99kGmxarHGmZsPuC2BH8fX
         ypoosWJW5UNgekkIfzjWoPyUpXFAIkO2itc0n/po+qko0MhwSNUNszhsGQgYNMZxv7TC
         MOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qcmt923j8A2lCObwQjindbK1wLTPcKYHQ+hJn/I5s/I=;
        b=EUrsLjnehHyxGICW+fj4uIfT/Uo5WNdHZyrNghpsAxyalUv3TG6GnMnuCVXgpzOguL
         k3rI+YHJVOQcXm9Np1GwLNRwNdqosdLmQeyCup+bGG2aDyfA6guF0Hc7GY5dPKiupzI3
         kT3LqzAlRbVEWigJtPuqACPGFfYhsvPIkXO9Uw9Pwnn6M/+OzopSkLBTER0K8YzzzLFX
         3g60F8bR2dROSZEV68vSh+R/5hTVoRRN3QCfo+ei1A9N21xVO75XOYBoz/3rWPl/35lJ
         ZKa8J2zp3a//Bpk9QrYjmSQkBLmEKL7cKW0TL+CF+XkRQJTwN2Ch8X9Yt0WCwoYIhpZZ
         n8mQ==
X-Gm-Message-State: AA+aEWaaKvV+dFO6O4G8F8D2VX1/Dl/uqIN/5VTNE5MX8pvJ0gkC2oO7
        96CTQm4c+qNZVUjTCcmKIAkoH39F0LzrZI/kjZY=
X-Google-Smtp-Source: AFSGD/U6oJ+MVZlTY2/lNhsoCJDIgatIl0JRqDGvDahkxSQiUnQAMTnVne71ePURybKKSuccTTXH0/ICRPFR19HbbNA=
X-Received: by 2002:aca:d056:: with SMTP id h83mr341829oig.67.1544619103622;
 Wed, 12 Dec 2018 04:51:43 -0800 (PST)
MIME-Version: 1.0
References: <1544425521-775-1-git-send-email-Anson.Huang@nxp.com>
 <20181210232358.GA11621@bogus> <DB3PR0402MB3916E1651ABC07F6F788B265F5A60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAL_Jsq+sP_fsQaoT6FpZNRxjhPAhCcE8e-0xffUUxShcC2LuHw@mail.gmail.com>
 <DB3PR0402MB39164538D3969FE51C649B65F5A70@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAOMZO5DXNpn18pzngmAt+hyiWNtfwckafxCzbJ17EgndjABwWg@mail.gmail.com> <96906A60-5318-46E5-B302-207C1FC7578B@nxp.com>
In-Reply-To: <96906A60-5318-46E5-B302-207C1FC7578B@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 12 Dec 2018 10:51:39 -0200
Message-ID: <CAOMZO5DuiSNxkMdV6r7AypnF6ptMLFchH2fMJvwxc3mYO_eshA@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: iio: light: isl29018: update power
 supply name
To:     Yongcai Huang <anson.huang@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Wed, Dec 12, 2018 at 10:49 AM Anson Huang <anson.huang@nxp.com> wrote:

>         Since the datasheet of isl29018 states the vdda and vddd MUST be =
shorted externally, and the later chips even remove vdda, ONLY has vdd one =
supply, so I think adding vdda does NOT make enough sense. Looks like the v=
cc they added is just for prepare, the driver did NOT support regulator ope=
ration at that time. So can we just use vcc in driver accordingly? Do we ha=
ve to use the name =E2=80=9CVDD=E2=80=9D in datasheet for regulator name?

Ok, understood. In this case, I would suggest keeping the existing name.
