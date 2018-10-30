Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E43C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A925D2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A925D2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbeJaE1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:27:11 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33178 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbeJaE1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 00:27:10 -0400
Received: by mail-ot1-f67.google.com with SMTP id q1so2841224otk.0;
        Tue, 30 Oct 2018 12:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uk/maA6BLspR10tnwh6s4NYQudleC4WwHdDJbYoY2/4=;
        b=WuDYfQMqrqrd3Hc/wmNrzEE01l8cbjmtVeY3Wv8dFxTSo9dzBaYVYY5kYOIWn2A0bf
         0N/PfR/F10D2aK8Nm3Ojk1iSO22yyCjVPAWr4YNc061cBfS1bHCw5e7WCqYB8L7rtinO
         zocM2g0HMb7GK81oWcHQpaYnRUe75n2t8H2WcZLkWe1Kv3gGXp9zsgb2cdxIYFwv9L48
         vVRCibdAM/fN/coQSjWPkaGhHfAEcl4jkdhYKxIg0IzYL2HYesvbeMfDWmJOxOKvMYp6
         RBvCbATR0aamyZtbTAYYn/6HFmdA0vEKn0RHez76kXvUxfikAPsRLdUET8h567gV5fsn
         NfTQ==
X-Gm-Message-State: AGRZ1gJtym6Ola9ANUbouqnABKpYutWIb9i42pxfpTlmfMkPCEFwSgO5
        swjFiWqHfcc6GrhlNYHxPw==
X-Google-Smtp-Source: AJdET5fDEElTBJ9t4bel3Caj/rmn2TZ11K03Xjh/EpIwVsk1U0BUqpJ/6T5ntIfOsuz25OYqeAXeOA==
X-Received: by 2002:a9d:3f25:: with SMTP id m34mr30963otc.248.1540927942371;
        Tue, 30 Oct 2018 12:32:22 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h21sm2472941otj.9.2018.10.30.12.32.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 12:32:21 -0700 (PDT)
Date:   Tue, 30 Oct 2018 14:32:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>,
        Pascal PAILLET-LME <p.paillet@st.com>
Subject: Re: [PATCH v5 1/8] dt-bindings: mfd: document stpmic1
Message-ID: <20181030193220.GA29498@bogus>
References: <1540830122-2577-1-git-send-email-p.paillet@st.com>
 <1540830122-2577-2-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540830122-2577-2-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2018 16:22:04 +0000, Pascal PAILLET-LME wrote:
> stpmic1 is a pmic from STMicroelectronics. The STPMIC1 integrates 10
> regulators, 3 power switches, a watchdog and an input for a power on key.
> 
> Signed-off-by: Pascal Paillet <p.paillet@st.com>
> ---
> changes in v5:
> * removed st properties
> * added buck modes definitions in the header
> 
>  .../devicetree/bindings/mfd/st,stpmic1.txt         | 61 ++++++++++++++++++++++
>  include/dt-bindings/mfd/st,stpmic1.h               | 50 ++++++++++++++++++
>  2 files changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/st,stpmic1.txt
>  create mode 100644 include/dt-bindings/mfd/st,stpmic1.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
