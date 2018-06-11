Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5A1A8C07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFAD20660
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFAD20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934161AbeFKSKq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:10:46 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38291 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932740AbeFKSKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:10:44 -0400
Received: by mail-pg0-f67.google.com with SMTP id c9-v6so10132838pgf.5;
        Mon, 11 Jun 2018 11:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=f0qjpwP9/TY/PRKllZrVG6XOuM1+NYREpRux9xZlXUk=;
        b=DLqd3TbR9zpvv4rsYMfZ5GPb8JtF+8XuTjc0QeU/I0Z1DxiHm/IQxK2KvJGOhVqi7F
         FycjR8ISWwZbRdGCa3HiFWLGMwaYZLCoNmtnzJLLYwF4qGCKINXdUiFZe6ULH4ag0cvN
         jgQ7zflP11SpTF4hC53vPtF6eHDasm0nlh4U+6aqIGOWiAL+SrAJjMW/m1h2bDRtdD6Y
         gmugyjB2X6Zef6W3oPcOVJfp5o28nfnx8bZIRSpxTJOryZaZRlKZoWc7Q2peBl3csJ60
         Rj7p+8W/DasR98DzzHsuAqiN9Pp6XtLqMDw5bKkskU3SQTRHA8UUHCXO8RcLEmuq02lR
         OP0Q==
X-Gm-Message-State: APt69E1qn6WMnwE2Jqd6PcilIU+Jw+CBe/xgfBTWxOoe9RBQUYQF4UpN
        /cM/5iar+AtAmPNZqg78GE1LSWU=
X-Google-Smtp-Source: ADUXVKKzsxQA/SeEF4DidA2+XOKz95Jq4EKyuZa3RKCeHCr+l1ovVDKNBi44+h/xkRB0pqG7sCkwDw==
X-Received: by 2002:a62:918:: with SMTP id e24-v6mr277456pfd.30.1528740643994;
        Mon, 11 Jun 2018 11:10:43 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id y15-v6sm3892265pfm.136.2018.06.11.11.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 11:10:43 -0700 (PDT)
Date:   Mon, 11 Jun 2018 12:10:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?iso-8859-1?Q?Cl=E9ment?= Peron <clement.peron@devialet.com>
Subject: Re: [PATCH v6 3/5] dt-bindings: timer: add i.MX EPIT timer binding
Message-ID: <20180611181042.GA30888@rob-hp-laptop>
References: <20180607140544.22268-1-peron.clem@gmail.com>
 <20180607140544.22268-4-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180607140544.22268-4-peron.clem@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 04:05:42PM +0200, Clément Péron wrote:
> From: Clément Peron <clement.peron@devialet.com>
> 
> Add devicetree binding document for NXP's i.MX SoC specific
> EPIT timer driver.
> 
> Signed-off-by: Clément Peron <clement.peron@devialet.com>
> ---
>  .../devicetree/bindings/timer/fsl,imxepit.txt | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/fsl,imxepit.txt

Reviewed-by: Rob Herring <robh@kernel.org>
