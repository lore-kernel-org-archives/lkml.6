Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCE9C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE2D2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fL/dDS4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE2D2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbeJYW7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:59:45 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44662 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbeJYW7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:59:44 -0400
Received: by mail-qt1-f193.google.com with SMTP id b22-v6so1013784qtr.11;
        Thu, 25 Oct 2018 07:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q/C2HmAGI05F0evtopnTPBns+gR4gstcwId44ORoTL0=;
        b=fL/dDS4jkAsugar45TXnH8avI8cZtZFN4rFsulvLICYMzS+Wg3kTlmxA3QxhexbQbd
         tVnjLPAzZiRu7G0WEr2VT9+9iZFpJDlRa1VegMKFdTKxUfiWc+lQT3ncqEhcpNKbBQTC
         bEatvfEtQ+yHqE5fXt+5DyhkUTTWPi7bEzlPqT7D/MqiBQ+2QkWg23DtpeQDLwauyUtt
         Q6dn2wnWOHPpUORVmOdKEK7ebsrKB0EzozSm4AldS1NRHsxdRKJwWthX+e+VeyY2sWnx
         9xZeAUCPPsxQ4qGmim2AA+FeiT090cMYZFWT2jMegPHOelr6qxEF7VMQixiQ2/ONxsqG
         Z89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q/C2HmAGI05F0evtopnTPBns+gR4gstcwId44ORoTL0=;
        b=sXgDPubr52eJ2UoC+4QLHQgIgWWhQakTT0/LGeDglYDjTLCjKdj7mYG0oyz0vxZMWV
         9FkREP9DNfP0WSHdSdYefJCPYHMx8yB16o5bmVpPQdBUrvaVOKwvUKzVLFlHPy++QflI
         G+mFdjZ2/RG8dVAljjJlC18MwIM2yc0zumGDO3TGLGeuXe1T1sBP8yul16igy/yJ4Rgb
         +qdBuaEkse8at4DXjKrdGp7IepCJSI6eT77u+ilXkM1rOsIq1Lhc4LnCQZ7grdYmncVt
         PIfNQQFpj+Lr1JQ/5NKALLx9qac6MRHj4tDkmBQ39jwFb5+uL/uDGqrMJ1N6q2fFaRMm
         F+sA==
X-Gm-Message-State: AGRZ1gIvV2aZhDUoNG3408UhV2vIbYI0VHNpX/KTJqJo3nQ2LzHlgLd3
        hL22KjdR9u4OdHbiQ5Q2QuI=
X-Google-Smtp-Source: AJdET5feInFOXyAETGNDzOtV8ejbrF16VSqD9PUknL5D0fL8Lrv+rw+lpMXIX3u3v1ilPmkJu70JYQ==
X-Received: by 2002:ac8:30cb:: with SMTP id w11-v6mr1713056qta.176.1540477604098;
        Thu, 25 Oct 2018 07:26:44 -0700 (PDT)
Received: from renatolg ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id y70-v6sm10685189qkg.40.2018.10.25.07.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 07:26:43 -0700 (PDT)
From:   Renato Lui Geh <renatogeh@gmail.com>
X-Google-Original-From: Renato Lui Geh <renatogeh@renatolg>
Date:   Thu, 25 Oct 2018 11:26:36 -0300
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Renato Lui Geh <renatogeh@gmail.com>, Michael.Hennerich@analog.com,
        jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, alexandru.Ardelean@analog.com,
        stefan.popa@analog.com, giuliano.belinassi@usp.br,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH] staging: iio: ad7780: update voltage on read
Message-ID: <20181025142635.3apgyaxzhr73kehc@renatolg>
References: <20181025133223.kn7cjlyep7bmx2mm@renatolg>
 <c958f5fc-2a58-8471-62a4-20b0c7267bd0@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <c958f5fc-2a58-8471-62a4-20b0c7267bd0@metafoo.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the quick review. :)

>But please create one patch per issue and do not put unrelated changes into
>the same patch.

Should I resend this patch as a patchset containing the two changes?

>Also your mail client seems to have replaced tabs in the patch with spaces,
>this means the patch will not apply cleanly. Check the
>Documentation/email-clients.txt file for some hints how to configure your
>mail client so it will not break patches.

From my end my original email patch appears to have tabs instead of
spaces. I redownloaded my email and vim shows that the indentation has
the ^I tab characters. But when downloading your reply it was converted
to spaces. Am I missing something?

Thanks again,
Renato

