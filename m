Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A898ECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364A22081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364A22081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbeJaIAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 04:00:48 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34001 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeJaIAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 04:00:48 -0400
Received: by mail-oi1-f194.google.com with SMTP id f21-v6so8864802oig.1;
        Tue, 30 Oct 2018 16:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+BGQUn8O/MadF0I/B4KPslB03N1P81OtCpTke4UgNVM=;
        b=s33oL4jNmBvWLa+o8ixEQrSoltF+283mMU1tZVDi1CE3vBC48EN5D7GWqsBCUMbxD2
         Qyen83CopNuS37ZZ9iYjoT+stafOqdojqdn4qGMl3RLXCrRSrYGJghLYCUZgzrNPmkhG
         E/msbQXv3XCrPLtOniGxq5IXEHr2X2Pq7AW08y2YAi4ULOU/BTIedgRijK/l7/sdwgo7
         Yan9R112T0hrOMEjoyG/ifCRcesbjMNaYGREgh68BZpWFn/hBLz6XPKtYkUDyGHfMxXe
         lu3xh8iPJ9ZprqQM0P3kkaAtKWi2z7Hn3/o5mR+NiVDkymec3vFwWGQletHiHrsVWipv
         pMJg==
X-Gm-Message-State: AGRZ1gKPp+u2Yb0dEJSoBfD82BJxXGT3iC5N2GQX3uLzSwIJ2VlXKAft
        GUwBDKrDQ03g3jnpMQkHCA==
X-Google-Smtp-Source: AJdET5fkkPmhjOao8nuRJjSZwZf9aFMpIy2/zTa0z2q12hrTHxu39M286RAvL2X7KhUvISqepMHXsw==
X-Received: by 2002:aca:f40d:: with SMTP id s13-v6mr449059oih.102.1540940720509;
        Tue, 30 Oct 2018 16:05:20 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 2-v6sm2756798oig.17.2018.10.30.16.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 16:05:19 -0700 (PDT)
Date:   Tue, 30 Oct 2018 18:05:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alex Gonzalez <alex.gonzalez@digi.com>
Cc:     thierry.reding@gmail.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, shawnguo@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alex.gonzalez@digi.com
Subject: Re: [PATCH v1 1/4] drm/panel: simple: Add AUO G101EVN010 panel
 support
Message-ID: <20181030230519.GA13247@bogus>
References: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
 <1540480173-12009-2-git-send-email-alex.gonzalez@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540480173-12009-2-git-send-email-alex.gonzalez@digi.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2018 17:09:30 +0200, Alex Gonzalez wrote:
> The change adds support for the AU Optronics G101EVN010 10.1" TFT LCD
> panel.
> 
> Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
> ---
>  .../bindings/display/panel/auo,g101evn010          | 12 ++++++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 27 ++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/auo,g101evn010
> 

Reviewed-by: Rob Herring <robh@kernel.org>
