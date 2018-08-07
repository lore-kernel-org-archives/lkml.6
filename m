Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010F9C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE3B2192C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE3B2192C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389401AbeHGTJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:09:40 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34091 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbeHGTJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:09:40 -0400
Received: by mail-io0-f193.google.com with SMTP id l7-v6so14585758ioj.1;
        Tue, 07 Aug 2018 09:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CbB6tS0x/gdpp/In2iS6CxZE/GXLhErtFMLWsJ0loTw=;
        b=VheWxyAiN+hoaZbO7DBFh4uLURDQkkWpcvtNITxe7/ukQsAcDGW9WpXTpJ3Phbd1A+
         QI1R8aX8sIAeuOVmRISQrCiMb9F71barP7ymzwoUR5jCAIY0ZqiAy3eQKahTrxEhw9EV
         t9zy2SdtkeNUfwoX2lsozi1Dx0E1o4bAykz3GRzksys9wMpAHLJODK3hrb4pfXGsybeo
         DrBjd0XYMTj14pnPPs9maDPSzRhaNPTwL+LTSQWjGZ+CoulVjPf2VTpzSKrdbTL1yTDW
         QzuvrmZ0VOupmCRjPnxtG5yrvLxKyzZozNCegDYY8AU6folW6OmT3d6r+8MizSEdwhN2
         8B3g==
X-Gm-Message-State: AOUpUlGRDuASG1+jX5lqQOzBIGKvvfVEi67G5M/GYFsyKNisXERnLzs0
        X9OUGXknc0vJGXik0/0zSQ==
X-Google-Smtp-Source: AA+uWPzqmuKybcKOcd3vnv1f+jlLRbFRYYW59lVHjtFUGrXc3CrkV/nmuRnixPpTmyBSScY5rX0wnA==
X-Received: by 2002:a6b:26ca:: with SMTP id m193-v6mr20020600iom.91.1533660868093;
        Tue, 07 Aug 2018 09:54:28 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id e19-v6sm506404ioc.46.2018.08.07.09.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 09:54:27 -0700 (PDT)
Date:   Tue, 7 Aug 2018 10:54:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Brian Masney <masneyb@onstation.org>, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, jonathan@marek.ca,
        jmaneyrol@invensense.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mkelly@xevo.com, fischerdouglasc@gmail.com,
        bshah@kde.org, ctatlor97@gmail.com
Subject: Re: [PATCH v3 4/9] dt-bindings: iio: tsl2772: add new bindings
Message-ID: <20180807165426.GA7007@rob-hp-laptop>
References: <20180803001900.25371-1-masneyb@onstation.org>
 <20180803001900.25371-5-masneyb@onstation.org>
 <20180803224838.362d6cf5@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803224838.362d6cf5@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 10:48:38PM +0100, Jonathan Cameron wrote:
> On Thu,  2 Aug 2018 20:18:55 -0400
> Brian Masney <masneyb@onstation.org> wrote:
> 
> > This patch adds the new properties amstaos,proximity-diodes and
> > led-max-microamp to the tsl2772 driver. This patch also removes the
> > driver from the trivial-devices.txt.
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > ---
> This and the implementation look fine to me, but I'll leave them for
> now to give Rob time to take a look if he wants to.
> 
> Thanks,
> 
> Jonathan
> 
> > I got a Reviewed-by: Rob Herring <robh@kernel.org> on my last series but
> > didn't include it due to the new file tsl2772.txt in this patch. Device
> > tree bindings need to be complete.
> > 
> >  .../devicetree/bindings/iio/light/tsl2772.txt | 37 +++++++++++++++++++
> >  .../devicetree/bindings/trivial-devices.txt   | 10 -----
> >  2 files changed, 37 insertions(+), 10 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.txt

Reviewed-by: Rob Herring <robh@kernel.org>
