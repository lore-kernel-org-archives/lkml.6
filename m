Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47410C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E74720989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BR8PF6xa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E74720989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbeLET44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:56:56 -0500
Received: from mail-it1-f176.google.com ([209.85.166.176]:56231 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbeLET4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:56:55 -0500
Received: by mail-it1-f176.google.com with SMTP id o19so23336062itg.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 11:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R5bxCp8tdl9AgBDIOZU6e2WTW7sx6vs4eL/f98FBrkc=;
        b=BR8PF6xaH55Tqs6pS6GvxerX3iq8R03J0y21Y/Yzc1yAwzuacu7KB+VfkjT4/A3opt
         aSOuG7uKZq0iezQNXEKlNXHEA/Dk8KJcTrnOVaOOLp+7Ue0gIvp92YtQNG6MHyTnRCex
         FTSlOESL7bp0BRsIPoRQmxZRTI0ARccmRP06U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R5bxCp8tdl9AgBDIOZU6e2WTW7sx6vs4eL/f98FBrkc=;
        b=myVunJtbFz+rZL0vNoLWq/eLlZrPVCIU1G8inw89ny72IF/NO2Z+aQw7OYcizc34NF
         lr7lYvIXV8AjU3ff2o8+LOHno4ONton91PW5Ln0E2sm5SESikUEStPkH9ODW+D1YHFCB
         klLV8CWJxVh7CiBlRlEQH5j9VcpQp5lt5azQTEuc13g+1ahqwYvnvpDOTuVK9MHN9WHu
         TvqKPX8g7RrQjmDn1+p6dCnZL6e4luh75ENu4x2XloiEXU+maXwYqUGvyFanqDNC3rXr
         STPLkpg8lJGyOYYstDn7FLS7FhDZ8Jh460GQe0NiwR4cbxt3D/59G5v2Wzy62kDuqmXc
         Cj8w==
X-Gm-Message-State: AA+aEWb7Kz3qc8lz5j+qQ7fc1uwAWFaQU6HwsPkoN9Bo6IZQXhwxHShn
        C8UpCGB1CWeqZlGI9H2gB26MzKtHYSSB/v1tWIKODY+vF2M=
X-Google-Smtp-Source: AFSGD/Uw+vjyoG6CiT9HPywwihAVkmivGRLd9ZsQSEi06juBx+m7YOssqMl69H9Ayf3ftBUdSAXqRBl1xa+Hyr1Cezk=
X-Received: by 2002:a02:634b:: with SMTP id j72mr20146739jac.103.1544039814435;
 Wed, 05 Dec 2018 11:56:54 -0800 (PST)
MIME-Version: 1.0
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
 <20181203101547.16835-5-jagan@amarulasolutions.com> <CAGb2v67ocaKL05yt68F+juBeAq8BRQ49mB4uoHWijGRy8duamw@mail.gmail.com>
In-Reply-To: <CAGb2v67ocaKL05yt68F+juBeAq8BRQ49mB4uoHWijGRy8duamw@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 6 Dec 2018 01:26:42 +0530
Message-ID: <CAMty3ZAd9eZRkBM2Pitp_B+kVLsGjufL6ALMCJ=f7iUL=7SfsQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] dt-bindings: input: touchscreen: goodix: Document
 vcc-supply property
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 4:11 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Mon, Dec 3, 2018 at 6:16 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > vcc-supply property is need for some Goodix CTP controller like GT5663
> > where 3.3V external pull-up regulator connected via controller VCC pin.
>
> "External pull-up regulator" sounds fishy. Chips have power supply
> pins, either combined, or separate rails for analog, digital, and I/O.
> For Goodix chips these are AVDD28, AVDD22, DVDD12, amd VDDIO. The name
> and description you provide match none of these.

We have vcc pin in the connector to supply vcc-ctp, but indeed it is
AVDD28 supply as per the reference schematic design[1] Page 23.  Host
interface has AVDD pin which is connected to ADVDD28 on goodix chip,
so I can name this as avdd28-supply. is that OK?

[1] https://www.crystalfontz.com/controllers/GOODIX/GT5663/459/
