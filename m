Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE1AC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B242081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B242081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbeKHQ1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:27:51 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45068 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeKHQ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:27:51 -0500
Received: by mail-ed1-f65.google.com with SMTP id w39-v6so11060127edw.12;
        Wed, 07 Nov 2018 22:53:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6R7JR2mJsQOSTOVPVeH5Le8gwFk6RF346dYDbs14ZjQ=;
        b=ixuwT7G0v2aFnAaY0ep9OCogihpcSozPo9kVDoi1dQ5c/3H2rxCbvx3gCATFqaKL59
         T6Inqc8Y70T4wNKrCWSbOKm9alAGSDIojtqujSLRuj7E5+6RaqMfecXRoNcIKBkYEzgl
         IVLL9ON94GO3prHPWkFosD3WEHAFHJWBxe2LzHzySb71ldtmFSLhEmlI1nsr5x8q0vsz
         QQnQTuj4U90uMhqQpNPLtUEtUYujY4A624RCI9ZjUa3LapJtP0EzizuetknAkbszgNw+
         GPuZ4w1uXvSBP/wPxHp/rbLnvjaHK1i7qJiaugqILzBivuwjhLb2I2ZkcIa6GlAVqG1g
         +EAg==
X-Gm-Message-State: AGRZ1gIU8mFCRqAxRTLhotjeHqyq7OfAQPU2qxALboP5wxFC6PR+dq5t
        Br2FUiaZHkbgE29o8YYcvWeQ1xZ7YaI=
X-Google-Smtp-Source: AJdET5dKfpD/cnT5/X3l/KlTxDcrPMg6ayJiWSNpc02O+ZhzQyY/nYHlfUScg02K/tYlaUUC+DZG7A==
X-Received: by 2002:a17:906:c44a:: with SMTP id ck10-v6mr2180534ejb.25.1541660027992;
        Wed, 07 Nov 2018 22:53:47 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id d6-v6sm837503edl.61.2018.11.07.22.53.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 22:53:47 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id 74-v6so19933154wrb.13;
        Wed, 07 Nov 2018 22:53:47 -0800 (PST)
X-Received: by 2002:adf:de89:: with SMTP id w9-v6mr2710599wrl.41.1541660026691;
 Wed, 07 Nov 2018 22:53:46 -0800 (PST)
MIME-Version: 1.0
References: <20181107101308.7626-1-wens@csie.org> <20181107101308.7626-12-wens@csie.org>
 <20181107203608.ff32gmb4u54kcvep@flea>
In-Reply-To: <20181107203608.ff32gmb4u54kcvep@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 8 Nov 2018 14:53:33 +0800
X-Gmail-Original-Message-ID: <CAGb2v64asgNbYch6gwj0BTTz84=Jfbmu9th0Dyfdx_o8N5tNXg@mail.gmail.com>
Message-ID: <CAGb2v64asgNbYch6gwj0BTTz84=Jfbmu9th0Dyfdx_o8N5tNXg@mail.gmail.com>
Subject: Re: [PATCH 11/15] Bluetooth: hci_bcm: Add BCM20702A1 variant
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-sunxi@googlegroups.com, loic.poulain@gmail.com,
        linux-bluetooth@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 4:36 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi!
>
> On Wed, Nov 07, 2018 at 06:13:04PM +0800, Chen-Yu Tsai wrote:
> > From: Maxime Ripard <maxime.ripard@free-electrons.com>
> >
> > The BCM20702A1 chip is a single-chip Bluetooth 4.0 controller and
> > transceiver. It is found in the AMPAK AP6210 WiFi+BT package.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> if you resubmit it, could you do s/free-electrons/bootlin/ ?

OK. And for the author as well?

ChenYu
