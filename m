Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535A6ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072C621470
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6Zeo7De"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072C621470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeIPF1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 01:27:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44185 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeIPF1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 01:27:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id v16-v6so13792162wro.11;
        Sat, 15 Sep 2018 17:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bgNgLC961skBy5HtNO1LgksgbADqp4D09FoqxMixTQA=;
        b=P6Zeo7DeC7NNabJpnrGcP9hi5V15SZYvAi99zLwjsVrA9RlQI4rtooYHWUaPfGd5a/
         teH+sG3dk1ZF26lFDxLEKBXE+hJaSu3cK7xsta1nKl1yl/tl4fTZ7rhD9+Nnn5Lmc6Hz
         lNlMFWDtEhpQxqsRcX6w35J2kDDNqMdbKx1xQhiNp4BuGSi28M39LGDcGxOEtQ/f80Ce
         XQVfQ4On9MDjGZ28LHOX1rAWUHBZ3BeP8VxknPyXHXiHq7xdbcaPNnzq8dnybshFqM7p
         TTT9BQ4LuiZ6J8oq0sfCZVe3GFisrQ08Lw8pzV9tGWlGqkUmTqSnWfyqA5rcNO23DAfJ
         krVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bgNgLC961skBy5HtNO1LgksgbADqp4D09FoqxMixTQA=;
        b=MP4vvPuw19E9yexP0cxqMtOsaHG/dP3IhE5k2lPNYVPOL5wkvnCW6PyRTr/U15iNDG
         vqyqznvoIIzV6eM+L+z6dCx06jW8HnYepCOt054WakhAGl32b7l31tn3EmWH8m19YR6E
         NS21ORZGaBkrUSB7dZIGU/GhR3xZbIXXPku0R3L5tE307HxBHIJ5Yq0k87QJR7I3+WHE
         836OrMPfYyUDte9FmNOn4ASkbqsLhkLnVuBPbQOF0ERBT5lZzk6ka7GD1LO4uJzFQ4p5
         jxEbTqwYRdnF8VraXkFAQVomS5zNACthXn6tO3cPiDIV02NIaZ64NK3zAtLivU5kNVH+
         vzPQ==
X-Gm-Message-State: APzg51DErvbt2IFCqm/owHGZOnjNGZEI/TlvuarYYzXefkfswrySkk4O
        MivdV4ZaoYgmpXwHdhCJaDZ4acSWRmks8Q==
X-Google-Smtp-Source: ANB0Vdb7SB0Cpj3cc33PUPXVE81K3tz1kI5HpWlfS5ZCty8GLS9VcyNnVzOWJTjhl7ynHtUnBgtBsw==
X-Received: by 2002:adf:8b98:: with SMTP id o24-v6mr14016154wra.110.1537056374941;
        Sat, 15 Sep 2018 17:06:14 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id z4-v6sm8500887wrt.89.2018.09.15.17.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 17:06:14 -0700 (PDT)
Date:   Sat, 15 Sep 2018 17:06:12 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: Clang warning in drivers/hwmon/scmi-hwmon.c
Message-ID: <20180916000612.GA29020@flashbox>
References: <20180915051032.GA23900@flashbox>
 <bb1167c5-d0d7-7d14-d2ba-0df3830ab53a@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb1167c5-d0d7-7d14-d2ba-0df3830ab53a@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 04:37:20PM -0700, Guenter Roeck wrote:
> On 09/14/2018 10:10 PM, Nathan Chancellor wrote:
> > Hi Sundeep and others,
> > 
> > A group of us are trying to clean up all the warnings we see with an
> > 'allyesconfig' arm64 build done with Clang and this one came up:
> > 
> > drivers/hwmon/scmi-hwmon.c:59:24: warning: address of array 'sensor->name' will always evaluate to 'true' [-Wpointer-bool-conversion]
> >          if (sensor && sensor->name)
> >                     ~~ ~~~~~~~~^~~~
> > 1 warning generated.
> > 
> > Would it be appropriate to just delete that check or does the check
> > need to be adjusted in some way (such as checking for the first value
> > 'sensor->name[0]')? Either option technically solves the warning but I
> > don't have the hardware to check if this breaks the driver.
> > 
> 
> Presumably the check is supposed to validate the content of the data structure,
> so dropping the test doesn't seem to make sense. However, one could argue
> that, if the _content_ is to be checked, it should be checked earlier,
> before the data pointer is stored (ie in scmi_hwmon_probe()).
> 
> Given that, I'll be happy to accept a patch to just drop the check; it
> does not change the behavior of the driver, after all. If a real validation
> is desirable, it can be added (into the probe function) with a separate patch.
> 
> Thanks,
> Guenter
> 

Thank you for the quick response and clarification, patch sent.

Nathan
