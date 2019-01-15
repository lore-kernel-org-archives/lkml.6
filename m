Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055D7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C537A20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547582394;
	bh=7nRwx6i+9kTdS/0+zpcHVPETENeL6PFJRYSThlK0TEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=akcjmoCDwryeHsJT8Rr+6sl+D+Io9TxZNmkiF+Ytz2Tvma/WykSEBNkMrotH9+vAi
	 VtQvete6JDPZE4RDbVT+vAl/udGWvvF/m8hVvoy26D7N5sjh9l5D2vRycBKasw77x8
	 xZ9AWgdNFKkoa+J2/eKxCX1xXX1FMNGYM0yHCoyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389570AbfAOT7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:59:53 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44436 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbfAOT7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:59:52 -0500
Received: by mail-ot1-f68.google.com with SMTP id f18so3660420otl.11;
        Tue, 15 Jan 2019 11:59:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DmSKzXrxjL7Qo6w/em0jPsHUoPR4e9N57t/OqS7sV7E=;
        b=cxs2b2OXVmQz9hTuhobYjSYa0wBSDbNBU7hr0sVsU/KLgKwasz7zk2q/RsOILXu2RY
         X/F8/LYtPSgeeloi8ZCWujy3Q4LefT03qvxVGi4qYFD2niJU70TRxauRv8sBlI7vqNU0
         VNkUoG1SxKLSR3Cfr1LqI81fhLF2k6dBFcmcT2VnZS8y4Ygl1S7be96ghTw2k1wenB8o
         ORga+ZVsy7spNoKkK/wW1C026mgNYBdzpTmOcyYC8sMWJ3F0w1Pv68HZ6Mb5x84cJKGk
         Hry9LnD6qjswbXyVfwf0AK+06+ohU+Cln1r1zY6VFAMGH9PF2vHDEOfoHzvLDGeKyfgM
         v5pQ==
X-Gm-Message-State: AJcUukcXNjW86kc+61idVIX70kHgyPvnZROLXtYW2uq9nf4K+Y4mzZuv
        6YR3nPBXtk0Pcc9jj6eA6w==
X-Google-Smtp-Source: ALg8bN57Axo2OMwnsaLjmKek1jimcRhva0o/3bNYRS2KFqvty04E3VcNPVcpXuBIu7BqoZx5ErFKOQ==
X-Received: by 2002:a9d:721e:: with SMTP id u30mr3421490otj.203.1547582391831;
        Tue, 15 Jan 2019 11:59:51 -0800 (PST)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id v3sm3152879oib.57.2019.01.15.11.59.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 11:59:51 -0800 (PST)
Date:   Tue, 15 Jan 2019 13:59:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        henryc.chen@mediatek.com, Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v11 1/9] dt-bindings: opp: Introduce opp-level bindings
Message-ID: <20190115195949.GA8255@bogus>
References: <20190110040209.6028-1-rnayak@codeaurora.org>
 <20190110040209.6028-2-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110040209.6028-2-rnayak@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 09:32:01 +0530, Rajendra Nayak wrote:
> Add opp-level as an additional property in the OPP node to describe
> the performance level of the device.
> 
> On some SoCs (especially from Qualcomm and MediaTek) this value
> is communicated to a remote microprocessor by the CPU, which
> then takes some actions (like adjusting voltage values across various
> rails) based on the value passed.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
