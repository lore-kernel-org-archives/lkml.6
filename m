Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22847C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 02:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58BF266CE
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 02:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P7bgdSfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58BF266CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753023AbeF0CSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 22:18:14 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:43813 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752733AbeF0CSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 22:18:12 -0400
Received: by mail-ot0-f194.google.com with SMTP id i19-v6so495349otk.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 19:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Nt5oQ4t/pFP5fa76uKG2clAhLER6MHh5aTYjSMPpn/Y=;
        b=P7bgdSfKEZTz0GAPxNRi45cW1/HPudDiJuIMeTy5954Rx9NquX7A4bUlKHgAw5/KZP
         h+GFzThIdR33HdAbmy5NO6L4cpSCNuVrY+YU13RWs8D2xGMN51QlhwbB7fKa/edyyQAj
         0MSaCZoh8jeyewPDuSAsaFDBH9hgfqv7Oqmw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Nt5oQ4t/pFP5fa76uKG2clAhLER6MHh5aTYjSMPpn/Y=;
        b=HMj7H13Dso4dBXyhHA7gA0bRoddbAJ0kFK6jSSUVzJWu72KIm+dNMMEbRAIPIgPqnO
         KfKdRPug5vocafxtOoBWeqhvzt4WQcREGTFxN+/EN4HCVM2upPabNF8tw89BNzryj8A0
         /r1lemkXtkyV842oupkXTv88BQ58duxs8zU1oRX2MPH+DkBINgtquS28iSgF2g5NvqRm
         XncS04o6TqN960CMUWwnlp/FxzRONhk9H4l08CK/+ywsRPDkhV0bv051ES5YJZx6cnnY
         RVIjlK+8oZ9AOCcYakeNAITLqa+XkOuDST0PF5pp8nLAB4yHICfOiw3lK1S/88/2pHO0
         hO6Q==
X-Gm-Message-State: APt69E1b6OmF8LF6B9ytfZ3UISa8TrRysek9p+cSkhTtX343VVvYiLPS
        fKulxUf0gJPeulTbrYtKf6AJGkojqQ0RapLlDWWMjg==
X-Google-Smtp-Source: AAOMgpfPUVBVhzunklzUJpMuEinvlUjuLglTpwgUP4jx837fGXtl0rmnS2XIISk8Aqqm2QIRDFUfIPTXCbvGYmsyHOE=
X-Received: by 2002:a9d:2965:: with SMTP id d92-v6mr2192388otb.321.1530065891766;
 Tue, 26 Jun 2018 19:18:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 19:18:11
 -0700 (PDT)
In-Reply-To: <20180626205438.GG3206@builder>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
 <20180626205438.GG3206@builder>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 27 Jun 2018 10:18:11 +0800
Message-ID: <CAMz4kuJ8OVjV+m-RHhOBDB5RchGm5gjOcXL=g0YWtvc8zbAqYw@mail.gmail.com>
Subject: Re: [PATCH 1/8] hwspinlock: Add one new API to support getting a
 specific hwlock by the name
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 June 2018 at 04:54, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> On Fri 22 Jun 01:08 PDT 2018, Baolin Wang wrote:
>
>> The hardware spinlock binding already supplied the 'hwlock-names' property
>> to match and get a specific hwlock, but did not supply one API for users
>> to get a specific hwlock by the hwlock name. So this patch introduces one
>> API to support this requirement.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> Thanks Baolin,
>
> Picked up all but patch 6 from the series; including 7 and 8 with Mark's
> ack.

OK. Thanks Bjorn and Mark.

-- 
Baolin.wang
Best Regards
