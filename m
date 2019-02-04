Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F69C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350F12073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EZjsx4x3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfBDU1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:27:08 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33490 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728864AbfBDU1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:27:08 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so472563plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 12:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wdLSqhLPKN2EEKdx2B0HGi5sPc58D9gc3rPgD0nedGg=;
        b=EZjsx4x3T0oQiRaP7p9OJImga+MBjmPDT6b2gq8aT8WjJYRC2zQL1volGBIG6NTEIc
         VZOyiJfqlnXurJdFmDQk019b1xLIGT87O5XDaAPGjJz2bliWqjt+7ovWyF1tlqGFen42
         fbIy4wphTtfwH7GFwKDRMTuSyITER4ZsHVpI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wdLSqhLPKN2EEKdx2B0HGi5sPc58D9gc3rPgD0nedGg=;
        b=umdf+y4VrZSmT2wk5vI0rSYrf1rTDZt4bX83siUHmDR692cyWCArplTUCmGV4/lhhA
         lkQGvEC1LOJoU+oRvbnubQOZuerY324hJqCLt/4Hb1LzhA7pfc4lkD+Q6TkZhPl/t3Mi
         WKkq0H9GthPqCdJgB3tdXk6qij5Y40MVQ3gG5VAV17iPSN3jDQ8EQr+nKEQqaDaoEJas
         w4flY31uhP2wpBSvS33zUkuo3cEhqkmIZUVZf0ULol5y2vf7QNpT9EqLbpxSyPGNtc1Y
         HPC4VRcT7LKGuPdTsOhjuSITytdkfnIgihbiffQuFJAw6XazuPE6PLTMcJFAo++rs47u
         /3Yg==
X-Gm-Message-State: AHQUAubwUctAcKjpn4xRZYp8fnt4/eG+4TjajvXbx5wPEkveUdaTKTeD
        FdT5BYYDyV8fAGkrPmwM9oxndCyFvh8=
X-Google-Smtp-Source: AHgI3IaOqqLJX72XgHxWEnF3uIGvfa9nWMDQNvtU27kL5iN5g1h4bmaCbn4NDd8NQt/yCcO25DSVHQ==
X-Received: by 2002:a17:902:be03:: with SMTP id r3mr1246221pls.68.1549312027465;
        Mon, 04 Feb 2019 12:27:07 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r187sm2491204pfc.63.2019.02.04.12.27.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 12:27:06 -0800 (PST)
Date:   Mon, 4 Feb 2019 12:27:04 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        SCSI <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v3 5/5] Revert "scsi: ufs: disable vccq if it's not
 needed by UFS device"
Message-ID: <20190204202704.GA31919@minitux>
References: <e3c82a49-c601-effc-348f-f768656c659f@free.fr>
 <70618c25-83f0-b9db-51a3-c1d74b605a45@free.fr>
 <SN6PR04MB49255ADE41BBD35F894FD4CBFC6D0@SN6PR04MB4925.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB49255ADE41BBD35F894FD4CBFC6D0@SN6PR04MB4925.namprd04.prod.outlook.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04 Feb 11:51 PST 2019, Avri Altman wrote:

> 
> > This reverts commit 60f0187031c05e04cbadffb62f557d0ff3564490.
> > 
> > Calling ufshcd_set_vccq_rail_unused hangs my system.
> > It seems vccq is not *not* needed.
> This patch essentially implements the UFS_DEVICE_NO_VCCQ quirk,
> Which is needed for both Samsung and Hynix devices.
> Once acked by those vendors, can be removed from the quirk list as well.
> 

If a device does not need VCCQ, for some reason, then why is the VCCQ
supply specified for this device?

Disabling unused regulators is already handled by the regulator
framework, so why does the UFSHCD driver take this role as well?

Regards,
Bjorn
