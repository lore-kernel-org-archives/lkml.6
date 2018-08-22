Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D04DC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00D82148E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzSJKryf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00D82148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbeHVM33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:29:29 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40534 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbeHVM33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:29:29 -0400
Received: by mail-pl0-f68.google.com with SMTP id s17-v6so604469plp.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WSPAfKTqAURuuMHBFsdjYJISio3g6efb2gzMrkEOxT0=;
        b=TzSJKryfV1V/C6WHthb78sZgP7TWaNIwGr8w0rhSsdklTB8smayd+Afw0PirQy3Ro6
         ojfuGPXtLvX+zlHcw0LHgeWIXUoxHXafAWffQA37jcHeiyY0LGDwnCm2XRW5begTdciJ
         d3dygLUjc0tWyndoeyqBh4uMXZVFtZfAVilieOSFJR3xdVppAYssIfUg/BdpIPzMDXu9
         ePWk1D1T9n2APJ8yHcGhvFph44HKzGKgRHahf9cqDDhLoIdKMU3uwhs01Cm1Bfygv6Np
         zp9Roa9G9Jo+g5PUxagRWxO2PB4ePAZUqIdebI5ZSox3zKD9X5fyK5KH4PmdqvWtiKlB
         JsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WSPAfKTqAURuuMHBFsdjYJISio3g6efb2gzMrkEOxT0=;
        b=U1mrsX/nYewJJRcB0FoViQPOC9NRe+CU8y8v8Cgj/dtHLZ53c6EX/OQ+t0krC9AlDf
         Acvq7z6QWaAEleGJDC4jBNebDzS1qgMyfAPRrntIGINT4ORai+j0nUZ8nPyraMxJJhXg
         /fF991pcEb7lK+Q6rkZJ691qnilotIy3xOwqKl9QbTNOYDlpdx8CGtSGCoHeMp27QMrI
         txdrWf5Pwpf9Gxq3UKOf82FRbn09kJkVD/Zsrlzmce6PVI0hHksImksDn2WS8rhyUfVR
         q6Uan5GJ5fdZmjmK1Y/5DTbOZvl1Izhn+qrPtJ2Ibp0aTXwFi8xYKGh8NyrwzvE6Agif
         RPiQ==
X-Gm-Message-State: AOUpUlEotNemn6nCZVkzKcFvo7yvJ8rw6/W1kgXurrPg5VP6Ee8VHz4Z
        4QPffgdGPuBoTZ9yc3TUSDfFwjJG
X-Google-Smtp-Source: AA+uWPyE7eNqdJ57SJTeVEAMdXocLOCN0eTjyV9bBIPadbxB/oJJ41C9r7iHwF682vT3dcAsy8Lepw==
X-Received: by 2002:a17:902:49:: with SMTP id 67-v6mr9519044pla.206.1534928729731;
        Wed, 22 Aug 2018 02:05:29 -0700 (PDT)
Received: from Gentoo-PC ([117.204.240.63])
        by smtp.gmail.com with ESMTPSA id e82-v6sm1981723pfd.40.2018.08.22.02.05.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Aug 2018 02:05:29 -0700 (PDT)
Date:   Wed, 22 Aug 2018 14:35:32 +0530
From:   Bhaskar Singh <bhaskar.kernel@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: Fix spelling mistake
Message-ID: <20180822090532.GA2715@Gentoo-PC>
References: <20180821014428.GA7914@Gentoo-PC>
 <20180822081636.eu54b6z5g5s7wgfp@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822081636.eu54b6z5g5s7wgfp@mwanda>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 11:16:36AM +0300, Dan Carpenter wrote:
> On Tue, Aug 21, 2018 at 07:14:28AM +0530, Bhaskar Singh wrote:
> > This patch fix spelling mistakes in TODO.
> > 
> 
> Btw, it helps when you say which word you're changing, otherwise it
> takes a while to spot the difference.  We changed "HGz" to "GHz".
> 
> Probably someone smarter than I am would have spotted it faster...
> 
> regards,
> dan carpenter
>

Apologies for the inconvenience and thanks a lot for your suggestion.

I will definitely follow that.

Should I send the patch again?

Thanks
Bhaskar Singh

