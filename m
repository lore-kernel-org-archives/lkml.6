Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EBEC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF1424975
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="F2CSe/ap";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CGis7wg2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF1424975
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965689AbeF0Q2I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:28:08 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:46240 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965019AbeF0Q2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:28:05 -0400
Received: by mail-vk0-f67.google.com with SMTP id b134-v6so1527755vke.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 09:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xgGq9nQtClLYuIt3uTQFSXsq8Hfi0e8oJZ9Z764NjmQ=;
        b=F2CSe/aplyqfcS1iIcPnSgxRD3uONXADaItZ3rP7ShOssgsAROXsjz5zkEJomR1jc0
         W7uIMDXHQnWGq38PKGDiU37svB2egMCI0CMIahd0DitMIhSk8wKmWIf6CFeRyZQjD2Nw
         UXFqE/om8shjlrR1gulgDlV4/KGRGW4NENfZbt8litpmrx599hoSPTTIHHM4yha96dKk
         45r4Y/ol6UeptsrIIK1bLJV6GDATtg8Ynl8R8eJuceEee+ZXNSs3pq0ysZPLENCeLx5R
         mUBKKl8+ZMXYQrtKN5T4RJnJDs6SYnqVN4FDfaqS2AYOvFiKZ17Lpe/5sqzMDbZ7nBpE
         2NTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xgGq9nQtClLYuIt3uTQFSXsq8Hfi0e8oJZ9Z764NjmQ=;
        b=CGis7wg26lLh5Y3f5tCiyercOPHCfoS28vdMrFmFrwToG5UGeoMK3c1Lt+Kb+iiOTW
         V23IAiHykjykq9CCCmFu9D3xV8RwQpQ32siCrvpFFIzugO6tKtu/XeMYw/6M4eFiviTf
         N0zXzvt7QTJW3mby7bQrvFYdV8m3AeLv0l5Mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xgGq9nQtClLYuIt3uTQFSXsq8Hfi0e8oJZ9Z764NjmQ=;
        b=aOKltO5aTljJoJY0ABJKW8hD2i0oeFrTN8jb5ibQwfnkOaPNqSMgoqAal84xIlvTLk
         DFUW/kNS0c93k2MqJHy2++hn+NzdPt2YFkyyvwNFC64+RaeNJU8P8pOFKnvcqJkWxwhn
         HEXlTgl6KB297YCU+KrdMUzASxj4+QVLkqFK8th9notZBjOlL2gMQHux8iOMLP5CToZi
         wawnxhXjlo7hQMaTRudbbglqRNdJn5ojqTi9Ix2cRYD75yhMLb87fV4oZyxSKkpJzZ4r
         ssJmDZF5adBD3AdqNt8ddGdBQyTBFmKTu2PqeWQKUYr3PLSm6pTt6F1fgl1ahrs19O7B
         lF6w==
X-Gm-Message-State: APt69E0H5tqrBQjADxcKA+lXPO/EvDkRDME7CMK/ff03wg5tPY/GMW2l
        OIm4c/jVzMo2zCzuwiNZyaLknNgckRAwXfYVkbxkFw==
X-Google-Smtp-Source: AAOMgpeQovlLTOvFbtvlYMg1rDK4RTnbLat5RqlGxMHYBIQQFzoOuSz3FYOoScwijOiGQI5SPGv0xp5tqkBXJFYqOXU=
X-Received: by 2002:a1f:cd03:: with SMTP id d3-v6mr4067585vkg.101.1530116884417;
 Wed, 27 Jun 2018 09:28:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 09:28:03
 -0700 (PDT)
In-Reply-To: <20180627150126.GC5263@sirena.org.uk>
References: <cover.1529712888.git.collinsd@codeaurora.org> <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
 <CAD=FV=XVEEPgjBXxR+-46RgxLOq63Xvq-jtruoaCxccmMoKUuA@mail.gmail.com>
 <20180626120733.GD1779@sirena.org.uk> <CAD=FV=X1E8Cz=L93G-zJwhM0R=N3YuBBhkvCnLvWuxMU9KJkTw@mail.gmail.com>
 <20180626150203.GG1779@sirena.org.uk> <CAD=FV=WC_XWRk-6OELOFFWGnhRq1VeoiiveqXLSy+xqsVb22pA@mail.gmail.com>
 <20180627150126.GC5263@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 27 Jun 2018 09:28:03 -0700
X-Google-Sender-Auth: gnLDgPmTMlYcKNDRuPt8Inkncys
Message-ID: <CAD=FV=WYcCVjAiMpzf4zyAByw5y-oDMnuabip1HXqa-mQFRt2w@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] regulator: add QCOM RPMh regulator driver
To:     Mark Brown <broonie@kernel.org>
Cc:     David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 27, 2018 at 8:01 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jun 26, 2018 at 11:15:14AM -0700, Doug Anderson wrote:
>
>> I think he's still planning on re-shuffling his tree a bit.  When he
>> does this, do you need him to put the RPMh patches somewhere you can
>> merge into your tree?
>
> Well, I *think* there's no actual dependency here since it's a new
> driver with a Kconfig dependency.  It really just needs me to get round
> to trawling through what's a fairly large patch with a troubled history
> now you've reviewed it.

OK, great.  I guess I'm confused about the "|| COMPILE_TEST" causing
problems then?  I was worried that anyone trying to do "COMPILE_TEST"
on your tree (or linuxnext if RPMh isn't there) would get failures due
to the lack of header files.  I guess if it's a problem you could just
gut the "|| COMPILE_TEST" and it could be added back in later?

Hoping my reviews saved you time overall.

-Doug
