Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE773ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BB3205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYS4hY4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BB3205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387968AbeGTRbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:31:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43913 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732083AbeGTRbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:31:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id b20-v6so10252076edt.10;
        Fri, 20 Jul 2018 09:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cMkkU5Nmvk1DSRjddhUbaSiS7q5QKoTKFjbR9HEg1Q4=;
        b=FYS4hY4GM1VVmQnGtLuNw2labnRqbLPtP5dJxPNWHGXsf3y+p4yKfRMNuA39016MxK
         GW7oLjz23G7PhlxsIsODk/1tvvCnLJp/hwcqPP77qaSSBk0OYZ0UMhmXu2VNyLzJNGoC
         JzsbU76hgvDzWQT0k7wHuKd+p9T9LIXO8ew0CIc1wa7zPscWb5fSctj3TQ7q9o8kzyNk
         hwMx1XHxoC7Vpb706jaztWiI6BYjTKp5wtH9ku822SnonvedGt6/d4+eLkBRK3SVKq8U
         Fgp2fJo1aJaxMAG5hRKWbsHtgGyWUu/9VvYyp03oWnV3PhnrR9PXf6Wg/mqpfne9vIZI
         gTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cMkkU5Nmvk1DSRjddhUbaSiS7q5QKoTKFjbR9HEg1Q4=;
        b=r7wM5mR5v+lwbW65YfXPrWu9wiu0y7PyXkYYGZv1G2FAxiU8CHxFGFhESNgBwxoJru
         K+wMLU6vZouv8Ha7/tJJd8Imx29p9ep1cpLR5ezulKATRxNlTnpjmbfg4bR0AQHOMJB5
         4zfaD8BXlkCRvDIPz03VQfgD4o9Yq4VMTkEk5CnNTyFiqfYAnF293pbAwr/YRHhMwXuh
         1d1LN+Hy0JHY9nkdz9ufiZix1Q8Z7t0qftd3AGJbRkWvhBghFhnADg7Rn0RViGUIxYuv
         sFHLfpNV4SxvJl/5aJjOmiEcXwpEvguSF11SKyePgO9LuCXMD5zPCNwMrKRPYOjDjC/7
         Nmxg==
X-Gm-Message-State: AOUpUlGfyu6RwYAHezHz+WQiqcY2ADPWvvP50vLtiSVuFIoFMITwXnxb
        m4/Bnl0rSD1O021vPxul7yg=
X-Google-Smtp-Source: AAOMgpcFb43jkZY1GHErZdTdCSKC0q367zN7vbc4n0E6xEuy5KdTo0Rkw5Ywu0ovaBJrRwK9TJXSBQ==
X-Received: by 2002:a50:c292:: with SMTP id o18-v6mr3484570edf.188.1532104968955;
        Fri, 20 Jul 2018 09:42:48 -0700 (PDT)
Received: from dimapc.localnet ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id v3-v6sm1086924edq.92.2018.07.20.09.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 09:42:48 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] memory: tegra: Don't invoke Tegra30+ specific memory timing setup on Tegra20
Date:   Fri, 20 Jul 2018 19:42:46 +0300
Message-ID: <33306633.pSjtQhAtFJ@dimapc>
In-Reply-To: <b0403eb2-2494-1924-dbe6-7a6019b6364d@nvidia.com>
References: <20180719132453.16860-1-digetx@gmail.com> <31916977.CHrX6e343J@dimapc> <b0403eb2-2494-1924-dbe6-7a6019b6364d@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 20 July 2018 11:02:04 MSK Jon Hunter wrote:
> On 19/07/18 16:38, Dmitry Osipenko wrote:
> > On Thursday, 19 July 2018 18:30:48 MSK Jon Hunter wrote:
> >> On 19/07/18 14:24, Dmitry Osipenko wrote:
> >>> This fixes irrelevant "tegra-mc 7000f000.memory-controller: no memory
> >>> timings for RAM code 0 registered" warning message during of kernels
> >>> boot-up on Tegra20.
> >> 
> >> Looking at the tegra20-emc.txt bindings doc [0], the 'nvidia,ram-code'
> >> property is also valid for Tegra20. In fact, I see this warning on the
> >> Tegra30 Cardhu because this property is not populated. So I think that
> >> this warning is valid and harmless.
> >> 
> >> Cheers
> >> Jon
> >> 
> >> [0] Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
> > 
> > That is the irrelevant binding, the relevant one for this driver is [0].
> > The warning is valid for T30+, but not for T20.
> > 
> > [0]
> > Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.tx
> > t
> Yes indeed, looks like we never supported this for Tegra20. OK, fine with me
> I guess this was introduced during the consolidation of the MC drivers. Can
> you add the appropriate fixes tag?
> 

Sure, I can send v2 over next week.


