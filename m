Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A310C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A122077C
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JK1CxeB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A122077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbeKOGA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 01:00:57 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:33718 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725757AbeKOGA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 01:00:57 -0500
Received: by mail-lf1-f43.google.com with SMTP id i26so12444083lfc.0;
        Wed, 14 Nov 2018 11:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dd0qW2SW8bZvPPvTykweCYSu1g+SkRdZh1v5wtYP+jM=;
        b=JK1CxeB6tTvcy5YjCBZxXcqJDo9ItV9tLWkqd5czyjIgo0RAxOEZPLEgdoSISD8IOe
         +3Vu0q1w00g/s/J/KnIJxTXV2vdvk2B4Zvl5gHry3VlBPUmL0fnJhLVYdR0Nro4InIZl
         AI8+sHImMGHO//S7bL7LGK/3B0tPKTodCk9ME1h58HBc0bK9WNAse2OsGeIra6VhUoXU
         i/9O65wSWnJIcySNeMnXr2g8S6BZcFLo8JjWy768AvLgdUQWP290CmSc9gojn79mSKFp
         Aqky8LlcqswPnS9AOXjzA+NiNDjISShp6CK3sRsXXVtWqNKduH4ExS6v5v83i6OTgS7r
         3qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dd0qW2SW8bZvPPvTykweCYSu1g+SkRdZh1v5wtYP+jM=;
        b=MiUYATPeN7yBNTLndq4kZalAhIpl7uaaf0NLY71JvsKvGZqw6Ml3VOYdevR6QjT8r/
         4lQVkioWv/4EEMW1dQ9oo2g4Ag9VcJmrlNjJgUD9la7Gx0V6i15BXeUYXla5uBQaUTwV
         Jxl3V6OsCOO0y476ptkIfcegzp6NE8ljYKhKi5dpEgQxt5H5/Ooofq2dD1aHEXyOU20n
         j2nIDtBwHq/gCHRV4Hc5e8hQ3W0KROFmav7uFkpyTzLI9qkcfPbLlbsqs5420no7CQI3
         ZbAZORQvYV0CD2yUa3EQs3N+QyrG10HbUNZnFzGobceaVMYZgDMzmg+wDiCqLtoqVupD
         fKdw==
X-Gm-Message-State: AGRZ1gI/gr4cZzSZ0vzsGALZWL4/cCPzuR0j1ZYJCr2A4V40+1qF5N0/
        YWZsXiIf4bvkdMs8678nSqI=
X-Google-Smtp-Source: AJdET5d+Dw8G0tGsdkL++7r4tQNxfWs+KLDq1F4z/BU8yrmeeFH5fp/L5rfTc5SHOrUDoDJSK9aX4A==
X-Received: by 2002:a19:40cc:: with SMTP id n195mr1806520lfa.40.1542225379235;
        Wed, 14 Nov 2018 11:56:19 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id g66sm3969967lfe.42.2018.11.14.11.56.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 11:56:18 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gN1Gq-0002At-A0; Wed, 14 Nov 2018 20:56:16 +0100
Date:   Wed, 14 Nov 2018 20:56:16 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Johan Hovold <johan@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the gnss-fixes
 tree
Message-ID: <20181114195616.GG19900@localhost>
References: <20181115063321.401ebe38@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115063321.401ebe38@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 06:33:21AM +1100, Stephen Rothwell wrote:
> Hi Johan,
> 
> Commits
> 
>   9ac9252b4bcd ("gnss: sirf: fix synchronous write timeout")
>   b1a003961711 ("gnss: serial: fix synchronous write timeout")
> 
> are missing a Signed-off-by from their author and committer.

Thanks for spotting this. Now fixed up.

Johan
