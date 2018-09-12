Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF548C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7309120882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7309120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbeILMvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:51:07 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42064 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbeILMvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:51:07 -0400
Received: by mail-lf1-f67.google.com with SMTP id z11-v6so807797lff.9;
        Wed, 12 Sep 2018 00:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=32uzHNiSUlYDSkcbxnrU9KjC1juslLDUX/2EzVBnWGU=;
        b=qEjUfTnoDcU6hYcGl16IezqsgN2DtMai2/0QO94QhOhwY7FIRRqp6vGmpatcZovbzU
         603Iqu7L6rBeyg5OzoB/R/z2PqNrzt1LjL59E/TYyvr37EWw59eNc1OmlyR/cl6fBK8s
         88hIrPXKkHMOuGXnbO0zJzB3SjEFc3XNSnHhaNZ53FdsLv5PsVDAV0ZZjD6EKnHhnTvw
         BrzKRpoAAmcqC+7CUvLBbfvMFPffJ/dBY+o8mnC8RjgPlZWAwBHNWnoG/9efFHhbIae/
         5ebxrDTylcryK+o3WzfMsVbShH+lZcvb34sg6hqmgPUTNNqeRuP5HJdLk8hsjdoB2uV1
         lIPg==
X-Gm-Message-State: APzg51Co/bWLwKqJshWrDXHPajecvAbBHg5R+J3NLKnTQ1zlLHaZmi6E
        7ySVTT2h164t56jYMltG7Mg=
X-Google-Smtp-Source: ANB0VdY5N697rrLYFEFAVbYilhCV7CVuy6/9nX5MVUGvdyhypwJ/6ENIe7RzxGkPFPoK+tFOT9L2Yg==
X-Received: by 2002:a19:1819:: with SMTP id o25-v6mr523053lfi.50.1536738468095;
        Wed, 12 Sep 2018 00:47:48 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 6-v6sm57252lfv.36.2018.09.12.00.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 00:47:47 -0700 (PDT)
Date:   Wed, 12 Sep 2018 10:47:45 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: Re: [PATCH 1/8] regulator: bd71837: Disable voltage monitoring for
 LDO3/4
Message-ID: <20180912074745.GD2381@localhost.localdomain>
References: <cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
 <cad2e7baeb7af2d6efbc6afba831b0513087d832.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
 <20180911124029.GO4185@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911124029.GO4185@dell>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 01:40:29PM +0100, Lee Jones wrote:
> On Wed, 29 Aug 2018, Matti Vaittinen wrote:
> 
> > There is a HW quirk in BD71837. The shutdown sequence timings for
> > bucks/LDOs which are enabled via register interface are changed.
> > At PMIC poweroff the voltage for BUCK6/7 is cut immediately at the
> > beginning of shut-down sequence. This causes LDO5/6 voltage
> > monitoring to detect under voltage and force PMIC to emergency
> > state instead of poweroff. Disable voltage monitoring for LDO5 and
> > LDO6 at probe to avoid this.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  drivers/regulator/bd71837-regulator.c | 19 +++++++++++++++++++
> 
> >  include/linux/mfd/rohm-bd718x7.h      | 33 ++++++++++++++++++++++++++++++---
> 
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

I m not sure if it is relevant but I think this was already applied to
Mark's regulator tree.

Br,
	Matti Vaittinen
