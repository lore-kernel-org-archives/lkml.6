Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664D2ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 21:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7D52087E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 21:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmHyIPKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7D52087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeIPC3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 22:29:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36672 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeIPC3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 22:29:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so5833876pfo.3;
        Sat, 15 Sep 2018 14:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GEUrdFSYUBaTgJxqR4suLHlpanCwla3EluAdYPc4EvA=;
        b=XmHyIPKBncEvEwLZ+XHihON3aLxOgA88bXU+OdaA/2F8DjCF4b8er558N5bVpjFSrJ
         aIuB+T8qcQ4XzK6cVbQIVSKkRcmpuXlyqPk6qDorLzlyoE0sw8uh+PpzjRPkRqDwCI/p
         sLCwCFWaKoJQPKixUhW0gGPvUV5z56FUo+2Ru84JyzAbBcZpM82xYBI/390ZSSSNvS38
         eF6B4YWuv64YjXT46iyAW0mOOO0Zh/8PvTf1veS8X1EVCUMMYcPW1i0JZD/CwGXKouS2
         UTHiDe2d0VaNbYONC8dSyn3xxN5sYMoLU8tCPly2/MGy23bhitzNgE0rjdRZmXlGfK/M
         hPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GEUrdFSYUBaTgJxqR4suLHlpanCwla3EluAdYPc4EvA=;
        b=U8EEUT9KckxUhWrBD/qXnG/w0cKNMzfNFIGuPbxpIyu+uHIYnbuzWmBrspUoNAa1TW
         ArbOSFhcoYFrVygOgjxqSOOJa7YQ/omCgJmDhUjPNEVq5+1Z+beEwsaulw2CviQjtMdd
         Hl43uIDTaNdF6gmn+V6Nl+j7eHD5bg2RmBE9TjuknerDxXdfwaQi6/6B6saTSEw2lZXW
         pqCu8+OcD6ITtMnKlQ0p8kOh0T31UchMIV52CmtG5hBf91d4gS8zj1CbvKGkeeE00AD6
         UwD5537TMWjES7LihyEDUVvkcc+dCF5io5v89iG4Tx/WhpAGPPNRlZpLzq6z7goe8YTQ
         rvyQ==
X-Gm-Message-State: APzg51ByXNObHH1RpfAYHGicXo3F6Q6MRyrpg+NQ/96NtPbMwL9PwOnL
        jswbhN5baedXPYmi8jyLlFQ=
X-Google-Smtp-Source: ANB0VdYizih24GctUAyhXW+oizV/buedIGtQG6NIDcMpOrjamZRs657fQptparGvKTbvn/p4ZnJbqg==
X-Received: by 2002:a63:3089:: with SMTP id w131-v6mr16977133pgw.79.1537045764215;
        Sat, 15 Sep 2018 14:09:24 -0700 (PDT)
Received: from [10.0.2.15] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id q80-v6sm15091800pfd.15.2018.09.15.14.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 14:09:23 -0700 (PDT)
Subject: Re: [PATCH net-next v3 07/11] dt-bindings: phy: add DT binding for
 Microsemi Ocelot SerDes muxing
To:     Quentin Schulz <quentin.schulz@bootlin.com>,
        alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <f392dafca9165800439fc09cd7d16e6a9506d457.1536912834.git-series.quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <712d5cfa-dfd0-dc15-8360-fec5499af273@gmail.com>
Date:   Fri, 14 Sep 2018 19:29:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f392dafca9165800439fc09cd7d16e6a9506d457.1536912834.git-series.quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/14/18 01:16, Quentin Schulz wrote:
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
