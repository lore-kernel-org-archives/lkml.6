Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EA5C04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B8A20861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ma+wSy5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B8A20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeINCtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 22:49:43 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41563 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbeINCtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 22:49:43 -0400
Received: by mail-yw1-f65.google.com with SMTP id q129-v6so1809470ywg.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 14:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6HsP4oWixye19tf2C60zo9Cx9OSZD481NFJNQc3TfyA=;
        b=Ma+wSy5E9+sWvPHjFn9r++a/snMvUJFw8W8zUR/niGZe1CLdoG6iESJscLOrBBarsQ
         7vjuM2faPqLfErytuOUQL8+XBKFXBjnDA+bsHb/jqhZf4YCSQvGd6hbBZ6CiFnK5BwuY
         Tbxq4uzi0U8hmw6ratbmkIJkFXc3CdsWYgAF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6HsP4oWixye19tf2C60zo9Cx9OSZD481NFJNQc3TfyA=;
        b=RkktomjQbWqd43X8eezFG9Rx+a7ctPkpYKTD3eIEFMlYiKHhN3Jd+YxwNvnlQ5Ka7h
         G656a8BQyvIOVs2IX7qSnKho1PULQ26z6X8ODWR0jMy1Yvm+4yjRoxBsFmUKUO3zToC1
         Dm/r55VGgB1aIPDEoBwVRuh51ejpLDZDUk4bcNRmlBvbGAltD1z/BwhbiJo57kkl2GA0
         4pvOGB9aTdwi16NGE4HXlpYSWdMnhS8eblX1dN4QKyRrrmVs0Zv0m2f73rJMld7AcDNQ
         aSoGnhR5CU+fk6dtDCHl7O/UQfV5wTRCEdDtMXpR2KW+Y/kFmLpZpcSJj5jHhL4DlxAR
         vjag==
X-Gm-Message-State: APzg51ALstx/lRehuIJBlMDcGT6tDhw2YcX6OeQmto1AxIR1oeQv6wT2
        2N/UXlO7Lz9pz9O10fIUHV1LBA==
X-Google-Smtp-Source: ANB0VdaGcYOpxQIMQ/i+R4W5CH3yetWSnfd9KuHbY4aP0LF3cegHa9mMFva/MW2jrydTpOcVWY25kQ==
X-Received: by 2002:a81:2707:: with SMTP id n7-v6mr4408190ywn.347.1536874704711;
        Thu, 13 Sep 2018 14:38:24 -0700 (PDT)
Received: from localhost ([2600:1700:141:4960:d83:1f22:960e:a1ad])
        by smtp.gmail.com with ESMTPSA id d6-v6sm1719871ywa.85.2018.09.13.14.38.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 14:38:23 -0700 (PDT)
Date:   Thu, 13 Sep 2018 16:38:22 -0500
From:   Andy Gross <andy.gross@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/9] soc: qcom: Allow COMPILE_TEST of qcom SoC Kconfigs
Message-ID: <20180913213822.GB15874@hector.attlocal.net>
References: <20180829075724.9095-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829075724.9095-1-niklas.cassel@linaro.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 09:57:14AM +0200, Niklas Cassel wrote:
> Since commit cab673583d96 ("soc: Unconditionally include qcom Makefile"),
> we unconditionally include the soc/qcom/Makefile.
> 
> This opens up the possibility to compile test the code even when
> building for other architectures.
> 
> This patch series prepares and enables all but two Kconfigs to be
> compile tested even when building for other architectures.

I picked up this entire set.

Regards,

Andy
