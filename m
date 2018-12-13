Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC79CC67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C4220870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544729836;
	bh=ejtaZwYjIq0oaCPXl+gglkcFVMbh5ya83sSIE2eEJNc=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=N1Tz4dRolzucXeErjQNk1sXQxNohxVp/nsoTXatFTykUCQniwjcY7Z+h3/RCxoqN+
	 VUwrTGuSK9WqWN0yI3+KeI0Ogn7g2ixGycKqbbET/vZPOdIofhs8SFyRjM0/y+Jj5+
	 WMISkpj+HSwOKHKksB6QhfuN5bbekAiwGvKle7ww=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C4220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeLMThQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:37:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:56596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbeLMThP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:37:15 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC7C12086D;
        Thu, 13 Dec 2018 19:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544729835;
        bh=ejtaZwYjIq0oaCPXl+gglkcFVMbh5ya83sSIE2eEJNc=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=pR2zI/KCmMWjMzlQ3wvB3M7Hc/5XMzlLbFpZHTl2bKfXU3oprOaJx9wBFgqB2xRA2
         Os8pl4cjAkOVASO4AUStCc5m5nGfqf9pahEXLaKX7IwmcUAdbMVKp1yyZvqzsrazxW
         yGlWoKq1OxWRsZvoVUKPKzXu9yDjvcKSchPiG7C4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1544719454-10638-1-git-send-email-jhugo@codeaurora.org>
Subject: Re: [PATCH] clk: qcom: Drop unused 8998 clock
To:     Jeffrey Hugo <jhugo@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, mturquette@baylibre.com
References: <1544719454-10638-1-git-send-email-jhugo@codeaurora.org>
Message-ID: <154472983431.19322.17756691177399008729@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        marc.w.gonzalez@free.fr, Jeffrey Hugo <jhugo@codeaurora.org>
Date:   Thu, 13 Dec 2018 11:37:14 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2018-12-13 08:44:14)
> gcc_lpass_trig_clk is not used downstream, therefore there is no reason to
> expect it to be needed for clients.  Lets remove it because messing with
> the clock has been observed to cause Linux hangs when the qdss_clk is
> initialized by rpmcc.
>=20
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>

Fixes tag?

