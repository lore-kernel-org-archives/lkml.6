Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3571C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8860E20850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbzowK55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8860E20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbeLDWeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:34:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:57926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeLDWeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:34:02 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38AFF20850;
        Tue,  4 Dec 2018 22:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543962841;
        bh=vCMZ9PJeB5idzyOBaRrC173mOVB2bWx52XpWACZv38Q=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=NbzowK55/t59rd3Kdq/FL576f3svjDEdLuAzIx0llaLAeD72xN+2SKpq/A6XnIBq9
         n5xTsWkT0c+y1AsLQPSe6Prl5HnJtyBd7DSzU5oHuqKzWcjEX7Awwdu94K/Jbl+D6b
         B+k6qnAgnrK4rBG5SMFDEwLWR5TCB4aUAevY79MM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Alex Elder <elder@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <8dafe631-4b16-94cd-392e-84728f2bb382@linaro.org>
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, tdas@codeaurora.org
References: <1543895413-1553-1-git-send-email-daidavid1@codeaurora.org>
 <1543895413-1553-2-git-send-email-daidavid1@codeaurora.org>
 <154395145491.88331.1174781210192403998@swboyd.mtv.corp.google.com>
 <8dafe631-4b16-94cd-392e-84728f2bb382@linaro.org>
Message-ID: <154396284056.88331.12279283832884556349@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RFC PATCH] clk: qcom: clk-rpmh: Add IPA clock support
Date:   Tue, 04 Dec 2018 14:34:00 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alex Elder (2018-12-04 13:41:47)
> On 12/4/18 1:24 PM, Stephen Boyd wrote:
> > Quoting David Dai (2018-12-03 19:50:13)
> >> Add IPA clock support by extending the current clk rpmh driver to supp=
ort
> >> clocks that are managed by a different type of RPMh resource known as
> >> Bus Clock Manager(BCM).
> > =

> > Yes, but why? Does the IPA driver need to set clk rates and that somehow
> > doesn't work as a bandwidth request?
> =

> The IPA core clock is a *clock*, not a bus.  Representing it as if
> it were a bus, abusing the interconnect interface--pretending a bandwidth
> request is really a clock rate request--is kind of kludgy.  I think Bjorn
> and David (and maybe Georgi? I don't know) decided a long time ago that
> exposing this as a clock is the right way to do it.  I agree with that.
> =


But then we translate that clock rate into a bandwidth request to the
BCM hardware? Seems really weird because it's doing the opposite of what
you say is abusive. What does the IPA driver plan to do with this clk?
Calculate a frequency by knowing that it really boils down to some
bandwidth that then gets converted back into some clock frequency? Do we
have the user somewhere that can be pointed to?

Of course, none of these details are in the commit text so it's really
hard for me as a bystander to figure this all out.  So again, please add
these sorts of details to the commit text so we can be "sold" on the
idea of the patch instead of stating what the patch does.

