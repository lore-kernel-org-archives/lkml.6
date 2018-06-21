Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D28C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7227D20837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="b5sQFNBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7227D20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933477AbeFUMZx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:25:53 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:32812 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933186AbeFUMZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:25:51 -0400
Received: by mail-ua0-f196.google.com with SMTP id m21-v6so1905262uan.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 05:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FeGaMAdD9a/9voXGk5Mi+oRN+npJtPtlCPyvWiIMt5Y=;
        b=b5sQFNBD+atQ2AIiD9bAzzXo1ZnMlY6Bklr6Bv+9hU2Ga+AxB/CF9W2+Mmv+MixBoB
         +2R08dxUVgtQhEBPkKhn+8y9wJBV0/EsiFLQHwBcXTfNucli4Wzdh+deYbhKw3QO6sci
         Zl9n4y6NvNN/VsGc5h6Cyd8WtHQECJ55KlylIe2MDr33jfajQkNtCctPHhF7Ud7tmck1
         0Titt+DP22eK9BlDBabJ/6XmSkt/G2/5c3oEbPtx+06nJ4QP5rxZbWzpx7ezwKPFQWE2
         qCAd0/o0nNj9DIGLPT2JPEHSznagztjWN6b/cB/6CwdRV6X58Da6Qcz16Qf1tXb12GuC
         CeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FeGaMAdD9a/9voXGk5Mi+oRN+npJtPtlCPyvWiIMt5Y=;
        b=jD92bwpH6oqcoogeiEmn2O7JcR7lgY6u/wGHUfwEHvja1JksqHv2eUxx/Uxx28+Alq
         uA7yDAea0iqFm1b0q1nKwVxR+vsKjXsJEJDLrV+FHLzpVHWZbGQjNrYfy1ezy/HuO8lu
         JgymxfZHSVPptF5UAAIOT+RfRYbTvFpcDnrQk8cktFaHvFrbeieP6tDLyGbECdpbfw37
         yJlbBRldzCNlP/re7wt1HFmxxPnxIPFyoALnkjejGPNTbnI71VZZJzEbtE8yvAjRKBUI
         gl5KI8VrOu4fxlnRv9OmNXd1HG/a3xFTHdVtqPANmV+OUf+8dX2TysbWLjkLeg89ucAV
         OD6A==
X-Gm-Message-State: APt69E2cg8HAKfQrxPA2zLyU8LQayLo/7sQfqKD1zCe/zXCWxOucb/21
        rt6hYvIV1So+A8QqUWmNc0eoowss3tSoWL7rWJYDVQ==
X-Google-Smtp-Source: ADUXVKISG+YnedINKOxDrAGziH5/1jWVsR4a1Qrb04R7fGTDZK5h7vMG66F0vCRK2P7WUDdSZbytmiJJOJW4txiBGIw=
X-Received: by 2002:ab0:50f0:: with SMTP id d45-v6mr16082551uaa.45.1529583950476;
 Thu, 21 Jun 2018 05:25:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3c4:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 05:25:50 -0700 (PDT)
X-Originating-IP: [217.140.96.140]
In-Reply-To: <1529581652-31294-1-git-send-email-hadar.gat@arm.com>
References: <1529581652-31294-1-git-send-email-hadar.gat@arm.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Thu, 21 Jun 2018 15:25:50 +0300
Message-ID: <CAOtvUMc0j+5+uYZH9=kwV=Ptx_df=qSRceGsuouf-FuV7Mkw0w@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccree: fix finup
To:     Hadar Gat <hadar.gat@arm.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Ofir Drang <ofir.drang@arm.com>,
        Gilad Ben-Yossef <gilad.BenYossef@arm.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 2:47 PM, Hadar Gat <hadar.gat@arm.com> wrote:
> finup() operation was incorrect, padding was missing.
> Fix by setting the ccree HW to enable padding.
>
> Signed-off-by: Hadar Gat <hadar.gat@arm.com>
> Cc: stable@vger.kernel.org

Acked-by: Gilad Ben-Yossef <gilad@benyossef.com>

Gilad


--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
