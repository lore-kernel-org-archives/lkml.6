Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B51C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443152075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443152075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeJWX7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 19:59:13 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43638 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeJWX7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 19:59:13 -0400
Received: by mail-oi1-f194.google.com with SMTP id s69-v6so1461273oie.10;
        Tue, 23 Oct 2018 08:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1MjRKFjYeOjWz9+fE7VI0pqay85XOqnZuNg5wXzUHA0=;
        b=ubz42GVqIlTxQGGu19WppP5eChomMtr/mRQE8JYv+L1FqeI1X2xb64sXmcF6GAcRzx
         66c8lgwMLw0G302rP2utjMCQhK3wtPLCmtP+d7c1MA8crlMorCC+SRynl7nwVkdRN8Q4
         xgGWU0EXyJ8I5EdSLlYfdrvs4q3VstCaMGs22HzFEOErC3wsclkZpqVe0unoiTVSrSSV
         07btJl2apq/rpYCklNmgKFXvTF6bXxX7wmU0KuSRjyZBvFq6IRxid4hTi85aJOAcTMdi
         68hTqZYzTRGKn6f9jZtkaofEmH8nWvPLf1EszX/IUUu19AsI9R4r0Ca88F1CFcbE7ufR
         W6Rw==
X-Gm-Message-State: ABuFfohS8tp4vYW4gYTGXO2uu6H0CfILknDb4h10QRJFnTJ/d6ZjgFhk
        PFzqiboOsvTR2yaiNw1MrHHY+uE=
X-Google-Smtp-Source: ACcGV61Mto//9/p9XEekM/zfhRETnFOXGOqP6O2DbTIEHhTsjpQwq5b5MDQIGXTWY4g05AgqPhCVXA==
X-Received: by 2002:aca:3388:: with SMTP id z130-v6mr27340726oiz.184.1540308919423;
        Tue, 23 Oct 2018 08:35:19 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s192-v6sm465433oih.41.2018.10.23.08.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 08:35:18 -0700 (PDT)
Date:   Tue, 23 Oct 2018 10:35:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        Can Guo <cang@codeaurora.org>, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: phy-qcom-qmp: Fix register
 underspecification
Message-ID: <20181023153517.GA24710@bogus>
References: <20181022205102.74825-1-evgreen@chromium.org>
 <20181022205102.74825-2-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022205102.74825-2-evgreen@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 01:50:58PM -0700, Evan Green wrote:
> Add register regions for the second lane of dual-lane nodes.
> This additional specification is needed so that the driver can stop
> reaching beyond the tx and rx register allocations to get at the
> second lane registers in a dual-lane PHY.
> 
> While in there, document #clock-cells as optional for PHYs that don't
> provide a pipe clock. Also, document the pcs_misc register region, which
> was being quietly supplied and used.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> ---
> 
> Changes in v3: None
> Changes in v2:
> - Added dt bindings change, corresponding driver fixup, and USB PHY fixup

Please see my reply on v2.

> 
>  .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 73 +++++++++++++++++++---
>  1 file changed, 65 insertions(+), 8 deletions(-)
