Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E305EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81EE921571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81EE921571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbeI0RJc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:09:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45060 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeI0RJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:09:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id h6-v6so3139283eds.12;
        Thu, 27 Sep 2018 03:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cgrd5DvhR+UrykmaohhiorrLYEVOq9JmpukxipJGfCA=;
        b=KvXbYe+K/E6GmC4XTxH61cyFcQevwDTuORPwikxYX/rg6w12HzfeRohQkQs8spPILT
         CAO4XVL5yY5Csvov+bUxkBsIfZMSyXR80xsK/BxEAX0BqKjLf2JEwzKgQ03TZszRoXFN
         6H/axlziBJ1fEGOTIQPs1QF9YBrfbMLS4fOnBwrQI3rt3gCmF39yBoAVmhlr5+mdOm6H
         hjMLdpp84TjLzs+xiMyoJ/i56JSiSdVVxfyvlnox8BnpCrDx5ykcTW88SOkyw4+P0Or8
         Aq/+eUDedcn6k/aactnkxtrJKx62e2qtElxBzmCPbrQHsH6OSye0ZVtC55vltQEieJhg
         ef7g==
X-Gm-Message-State: ABuFfojn3YQVQL28r4yl2fl9NZlhCkThaboWKxGAc/2HjkecakA0SElt
        rsZLBUwEmoYERfoN0gPpj1QJytY7
X-Google-Smtp-Source: ACcGV61yWWQdcOIjK3JCOFN/AqdEN+2u2CR+cIjwkt6YlaZYkkPUADZEFEo5bQ2yC/gkaXJpVZoK1Q==
X-Received: by 2002:a50:b128:: with SMTP id k37-v6mr17164689edd.183.1538045509661;
        Thu, 27 Sep 2018 03:51:49 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id e25-v6sm943864edd.35.2018.09.27.03.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 03:51:48 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id j15-v6so2049948wrt.8;
        Thu, 27 Sep 2018 03:51:48 -0700 (PDT)
X-Received: by 2002:a5d:6b01:: with SMTP id v1-v6mr8232353wrw.208.1538045508358;
 Thu, 27 Sep 2018 03:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180926170545.ogcmt36ff7jmqxkl@flea> <20180926194824.8832-1-rodrigo@tjader.xyz>
In-Reply-To: <20180926194824.8832-1-rodrigo@tjader.xyz>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 27 Sep 2018 18:51:35 +0800
X-Gmail-Original-Message-ID: <CAGb2v67iwJ--dc6V6Vb0fukd4x_2RbCv5wOnHMUYxpZOJvL-YQ@mail.gmail.com>
Message-ID: <CAGb2v67iwJ--dc6V6Vb0fukd4x_2RbCv5wOnHMUYxpZOJvL-YQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: allwinner: a64-olinuxino: set the PHY TX delay
To:     rodrigo@tjader.xyz
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 3:49 AM Rodrigo Exterckötter Tjäder
<rodrigo@tjader.xyz> wrote:
>
> The PHY found on the A64-OLinuXino requires a TX delay in order to
> operate properly. Olimex uses a 600ps second delay in their BSP, and
> that has been found to work, so let's use that value in the current
> DT.
>
> Signed-off-by: Rodrigo Exterckötter Tjäder <rodrigo@tjader.xyz>

Applied for 4.20. Thanks.
