Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BC5ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441832083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441832083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbeJSCts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:49:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44466 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728432AbeJSCts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:49:48 -0400
Received: by mail-ot1-f67.google.com with SMTP id p23so30774762otf.11;
        Thu, 18 Oct 2018 11:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/iIcKDPE5JNc4EIJMSQqyTUV9WsHRwcOsiei8ozIcnI=;
        b=S7ZS/iLxLdr7/JcnIBDDyAZnRQURlBhP0gXQhBjJCcPBJs1PclDMtPLKAzgMYjmleD
         wwQDfQsuZlbzxkMO32aVZWLHD5sEHDoTaPh/WxEHMWSGnjXMzOfwS4FXChaJ3mdOm0hO
         js9kT9ErECX7PNTE3epPfkR4PryBa9BAoIJNKNsSAsSoa9J26n07qse2p0+/UdzDSggi
         uTBdRhoI5f1OWNU8p5gifptJMb8VYoCQcDH0oQ98ku35hLglpPFVNHeSQGGMtOX5ykYH
         J1lcv0rTdNrgB5CHxqmT/eub67N+ZZl+veww8862BCK1ezshMe72u4hWLK7wP3tAJ9J+
         0oDA==
X-Gm-Message-State: ABuFfoixHdrfszxJ0gFVgWezdQcmKOK9+oq3EA4xPiCpwEAliK7QzIJm
        4CQsRzUxITSdVFONF/bgKw==
X-Google-Smtp-Source: ACcGV63kb18Gu1W6jVMMnkSAgAvGVjzVUMenTxHvGY+pRrbXHFvseUi3/DMH3gsW9/urWI+cxc+AQA==
X-Received: by 2002:a9d:12a:: with SMTP id 39mr18325512otu.303.1539888448388;
        Thu, 18 Oct 2018 11:47:28 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d137-v6sm6449682oib.3.2018.10.18.11.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 11:47:27 -0700 (PDT)
Date:   Thu, 18 Oct 2018 13:47:26 -0500
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
        Pascal PAILLET-LME <p.paillet@st.com>
Subject: Re: [PATCH v4 1/8] dt-bindings: mfd: document stpmic1
Message-ID: <20181018184726.GA27696@bogus>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
 <1539853324-29051-2-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539853324-29051-2-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 09:02:11 +0000, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
> 
> stpmic1 is a pmic from STMicroelectronics. The STPMIC1 integrates 10
> regulators , 3 switches, a watchdog and an input for a power on key.
> 
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
> changes in v4:
> * remove interrupt-parent description
> * pmic1@33 renamed to pmic@33
> * fix indentation
> 
>  .../devicetree/bindings/mfd/st,stpmic1.txt         | 131 +++++++++++++++++++++
>  include/dt-bindings/mfd/st,stpmic1.h               |  46 ++++++++
>  2 files changed, 177 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/st,stpmic1.txt
>  create mode 100644 include/dt-bindings/mfd/st,stpmic1.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
