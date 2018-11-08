Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1401AECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD15A2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuK2nKQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD15A2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeKIECF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:02:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:54096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbeKIECE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 23:02:04 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EEC42081C;
        Thu,  8 Nov 2018 18:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541701519;
        bh=zBej8b1EIgM6Z5fGvQ5vBuWgaZp/uFKbFPA+IwXp0EQ=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=uuK2nKQkuO+3WB3DQwDmYIxggGWiYE8qye63l7Q7qJicq8MHTlKqyKBxJaUUqNSuZ
         wEOqTilO7p/1dlzfT6TLLCN7Zvnr5pqPb5G5iyII5PMjy4mrsFSwfvO7HxJSmDQRHE
         E0xKdHArk0/d1A/5ZCErpZ4RGZ+W0KrX4gIPrSSA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <32c2e69a-2070-5b6d-257a-627e2ad063e3@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <1540712140-26913-1-git-send-email-tdas@codeaurora.org>
 <1540712140-26913-2-git-send-email-tdas@codeaurora.org>
 <154117671164.88331.752297297364277275@swboyd.mtv.corp.google.com>
 <8d495713-d601-dcc8-23ee-dc31185e6a7c@codeaurora.org>
 <154152457264.88331.5152287370260040686@swboyd.mtv.corp.google.com>
 <32c2e69a-2070-5b6d-257a-627e2ad063e3@codeaurora.org>
Message-ID: <154170151864.88331.3913955115537863015@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v8] clk: qcom: Add lpass clock controller driver for SDM845
Date:   Thu, 08 Nov 2018 10:25:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-11-07 22:43:43)
> Thanks Stephen.
> =

> On 11/6/2018 10:46 PM, Stephen Boyd wrote:
> > Quoting Taniya Das (2018-11-02 20:16:20)
> >> On 11/2/2018 10:08 PM, Stephen Boyd wrote:
> >>> Quoting Taniya Das (2018-10-28 00:35:40)
> >>>
> >>
> >> How about moving the QSPI clocks too under this qcom property? Later
> >> could add the support?
> > =

> > Yes the plan would be to have QSPI clks there too. Bjorn has sent the
> > patch now.
> > =

> >   https://lkml.kernel.org/r/20181106055013.11271-1-bjorn.andersson@lina=
ro.org
> > =

> Would you be merging the code soon and then I should submit the cleaned =

> up LPASS next series?
> =


Yes, if you want to resubmit on top of that series it would make it
easier for me to apply these patches. I'm currently waiting for any DT
review from Rob Herring, and having the patches ready and staged can be
done regardless of that.

