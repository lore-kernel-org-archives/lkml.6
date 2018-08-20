Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9081C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7048620C03
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLrkQjy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7048620C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbeHTLmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 07:42:05 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:32864 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeHTLmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 07:42:05 -0400
Received: by mail-oi0-f68.google.com with SMTP id 8-v6so24439880oip.0;
        Mon, 20 Aug 2018 01:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+yAn4YpLN693Kq2hrCk2uJEjIaysp5qOUsLDa7QnDnM=;
        b=BLrkQjy2GBgrBa45C1a1XL6leF5K+6KOaa7LmDaU1LPsQxYu7c1Yv3sNJfW/9IahvY
         i3nGl1gUro5Yw1/ewFs2ZgzAgYI43ffKeezr37h596oNZV9sN5uTe3doFQWFSitAPtte
         rZhvjErQO72eRHobcY7wwKLU2RZjKGSXD1zUemjW/Pq3QPTB6BLfOmmamIxo6N9FWlf/
         shcNH1YxfoX4BfVJyW++xeVnFm/wG63HkRrA1IxGGAGlo64yRe33OKirxO92hdNPNCgO
         UsS6SAQ/pHRehrnbv/+iGTLEYmUamkRkFsCAI+TOx79c9aRg4YgVpVUaP1bg+7/3XFXG
         KjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+yAn4YpLN693Kq2hrCk2uJEjIaysp5qOUsLDa7QnDnM=;
        b=N1pkOqGl+r/0MPIyjx0eFEeP7l+r4JsZicg0TEHS44z8iq6dizb2oaMEYXLAfTwJD0
         EnHmPxuK0gA0ZtUzfdhu2llyrHsWBcX9M0EVsZ2WWQivOXyH+FQsUPa807FNSWtcIWhu
         eNWWq585MBaOsPRFCZDCKguKSL94Zy/0h7xOsqoQDfDQqbllHY7r3Oj/339uAnF2GSyz
         Ha/JHpbKC6Enmc/YZuHeBnYjBuikDAUJBugi1IAJ4l9yb5xIcPBd7zrDmpxs84nV5QN9
         CFq6PSQ2Qo6IS+r8NJ5FBFkatb7BM6zZWLRvvrwoScZcdI5rR4ctdDm4sQVycI5WjmCG
         ya5Q==
X-Gm-Message-State: AOUpUlG9iD5tKQmmRZZWuprEBs5mRJ8Y3HBL/EDmN2KOiGDdLMRejqh+
        T+SSE2I1VLONPpVkrO8JD55Y2/Pda3hpfjDEVkA=
X-Google-Smtp-Source: AA+uWPwLUSvOrLhx4Gwi3B6QY1Fk1FFQ8cmPXLrtIUX8k8PoaiDn3T1Vz4+z5Upqo/yO7p6LCnmsCT7GCo1+QTHQ+ww=
X-Received: by 2002:aca:e754:: with SMTP id e81-v6mr13901070oih.203.1534753644813;
 Mon, 20 Aug 2018 01:27:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2e47:0:0:0:0:0 with HTTP; Mon, 20 Aug 2018 01:27:24
 -0700 (PDT)
In-Reply-To: <CAJKOXPdW3TBCqZkTmoZ+gbtu+nFeS_RR_0Z92NHa0K450iqtgg@mail.gmail.com>
References: <1533154189-23311-1-git-send-email-snawrocki@kernel.org> <CAJKOXPdW3TBCqZkTmoZ+gbtu+nFeS_RR_0Z92NHa0K450iqtgg@mail.gmail.com>
From:   Sylwester Nawrocki <sylwester.nawrocki@gmail.com>
Date:   Mon, 20 Aug 2018 10:27:24 +0200
Message-ID: <CAB_H8rvgAKLJ8fwMdHSsE7yivzLRrGdK-CaEAH+a7nVjDnD=eA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update my e-mail address
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, sboyd@kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        bzolnierkie@samsung.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2018 03:40 PM, Krzysztof Kozlowski wrote:
> Sylwester,
>
> It still did not reach linux-next... do you expect someone to pick it up?

No, please disregard this patch. I decided to drop it as it would
really be needed
for less than one release period.

--
Regards,
Sylwester
