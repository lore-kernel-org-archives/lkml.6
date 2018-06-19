Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6FAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D3920693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CjORZhRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D3920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755815AbeFSFRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:17:55 -0400
Received: from mail-pl0-f45.google.com ([209.85.160.45]:46870 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755487AbeFSFRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:17:53 -0400
Received: by mail-pl0-f45.google.com with SMTP id 30-v6so10269776pld.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 22:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i4Gr+GfcsJD3AZ/+crHjHeXV/wVk7nMn5POiGrTLGOk=;
        b=CjORZhRL39dgRl4lYSonZT0PAo/3IMCfw1ZlJkEqj8Fe//d6OuNbD/N5BMm4A5umel
         7l9HD/8TiZ5LPBOj003kYWwXg+j19P7A+EufckjfaiPK95ZXbdx1IIZfhG4vLmNP+gH/
         hSn/aXMI5co2RQdT6kODt6VDhm4RXMQArpm6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i4Gr+GfcsJD3AZ/+crHjHeXV/wVk7nMn5POiGrTLGOk=;
        b=OXCqv2IROPY9rnTeCtXGTLXKTyU1PvKB3MQCmeusByzvRnQHcqHe7Vq6ooZ5cmoI4E
         VNrHh27nZjT0WGc50qyzS5pJz/6kmnfr+RH+lHM4pYXasVZin/9qQmwMeg7TXBFRPdAd
         1W/FUbYXn5g8LEQWFnRiQyaGnNMWQRBrWFPT/cDdHM+yw174ivKgi13UmwXQyz5S+/xt
         U/e/dCPI+ccTe7P1+rP/3OOaB6TutNdyqYczNhdookJn3JEGndro1MqEyX52k5ncwDE6
         KMtcHupABqV4LsG11C9NrLR5es5PhjNjVPlv3yk59buzhmnEZzi15QdmY1HzKTM2DxTU
         L+CQ==
X-Gm-Message-State: APt69E3Ir6JIw5gdKh2sQMCiW/0qgUVUHbYbauqlY2qmOtinv++HyzVX
        o6SGnSYOwUgfZ9pEfvMqev/7eg==
X-Google-Smtp-Source: ADUXVKJodrCbKkJQ8Vz0uP20jL/G+AR+zVDDWd9hlNqsRRnpcl9HgN+Nf9zdHALFqFo4lFpdjam85A==
X-Received: by 2002:a17:902:1566:: with SMTP id b35-v6mr17293286plh.107.1529385473156;
        Mon, 18 Jun 2018 22:17:53 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c27-v6sm40180035pfl.63.2018.06.18.22.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 22:17:52 -0700 (PDT)
Date:   Mon, 18 Jun 2018 22:20:10 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Raju P L S S S N <rplsssn@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org,
        mka@chromium.org, ilina@codeaurora.org
Subject: Re: [PATCH v11 03/10] drivers: qcom: rpmh-rsc: log RPMH requests in
 FTRACE
Message-ID: <20180619052010.GA15126@tuxbook-pro>
References: <1529329040-2606-1-git-send-email-rplsssn@codeaurora.org>
 <1529329040-2606-4-git-send-email-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529329040-2606-4-git-send-email-rplsssn@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18 Jun 06:37 PDT 2018, Raju P L S S S N wrote:
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 39d3a05..cb6300f 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> +CFLAGS_rpmh-rsc.o := -I$(src)

Please rebase v12 onto v4.18-rc1, to make sure that the series apply
cleanly.

Regards,
Bjorn
