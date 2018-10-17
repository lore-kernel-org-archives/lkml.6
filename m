Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF42ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E542087A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9gJqlS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E542087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeJREvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 00:51:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38331 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbeJREvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 00:51:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id f8-v6so13090953pgq.5;
        Wed, 17 Oct 2018 13:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZNLEpHYFgfB/ZmN+I8qX2cqzv4o3xc8+LcTVQ5vUD/U=;
        b=n9gJqlS2h9B8CmveTv0LlJNJK8/Jkv638dKTfX2xUDc/5xO1uwBU+NCSBz0v/bJnXc
         +IGoVkeeFlpsK2P0Ct5MpD5lH+VIlUTJHeGmyV7GCIjVjypg6vFtlt2OMW8NMP93S6bF
         eZqo0fxkKlMC+x5xkGSw3tELUe1mvsAoVkxkfgh+lDkDw7efmmB9vbDq/GcPMu7iRwIp
         IMXZ2Ac2EQXRJkhAvykihdAM+4+Fdr+eT+ierotERE48AYfZRA4PK0TN7DSuJK7I7g/L
         WKYQEnbU+9AZ9jzyUcahTd063PQH52QtwGWiyhRgiarV3Ot3Ay6oQJyewy9qwmz6eQLz
         iS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZNLEpHYFgfB/ZmN+I8qX2cqzv4o3xc8+LcTVQ5vUD/U=;
        b=RX2c3hhqJAQ81pF5RBbFnd5/1fHEV0oaaFUYgz0ycYfvLc/B+aSKsKpX/AMmlcKwo9
         Giy+Ov9nmHq72PiHigXJisiAKM8xSgQVgrSQRow9ksYxob+0Vh034wMcQRt1NZ8TEwnS
         Be6aKvVhXqjhn1KJzFTgOdbodPm7BYmT8AjNuafs1HlgHJkav5tS8bxUIfkjMGHIFN7f
         cqBtYROeQXM1nwRzXlneqM3KA7ERM0Z3++bVt1ooY6FGG1zOukINtnSdfX09RzmrAGzT
         S99vjWw3EktoqjLdkSrEOU80MydEo7s8/F460bGt0r+EmwvPwfVmzLHbPhF9VUxB3SqB
         I9NQ==
X-Gm-Message-State: ABuFfohDjxDdovg7EikUQ0GcgKLKKaOH/9K6CWDQfFE2mv5oJUoUjoV6
        3n1QGpOW7MUsEZI9maCpNFytrqv0
X-Google-Smtp-Source: ACcGV60x8AWlxREplcB6Jjd6qmIUC8lEHcXudG7U6yA8SBNXlve5DASZk9JKsAg245i84hQWNc768g==
X-Received: by 2002:a62:62c3:: with SMTP id w186-v6mr28048391pfb.5.1539809630995;
        Wed, 17 Oct 2018 13:53:50 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id y8-v6sm32298145pfd.168.2018.10.17.13.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 13:53:50 -0700 (PDT)
Date:   Wed, 17 Oct 2018 13:53:48 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] hwmon: (ina3221) Make sure data is ready after
 channel enabling
Message-ID: <20181017205348.GC15941@Asurada-Nvidia.nvidia.com>
References: <20181017012426.26958-1-nicoleotsuka@gmail.com>
 <20181017012426.26958-5-nicoleotsuka@gmail.com>
 <20181017165543.GA22822@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017165543.GA22822@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guenter,

On Wed, Oct 17, 2018 at 09:55:43AM -0700, Guenter Roeck wrote:
> > @@ -676,6 +701,13 @@ static int __maybe_unused ina3221_resume(struct device *dev)
> >  	if (ret)
> >  		return ret;
> >  
> > +	/* Make sure data conversion is finished */
> > +	ret = ina3221_wait_for_data_if_active(ina);
> 
> This is quite expensive and would delay resume (and enable, for that matter).
> A less expensive solution would be to save the enable time here and in
> ina3221_write_enable(). ina3221_wait_for_data_if_active() can then be called
> from read functions and would wait if not enough time has expired.
> 
> 	if (time_before(...))
> 		usleep_range(missing wait time, missing_wait_time * 2);
> 
> or something like that. This could be done per channel or, to keep
> things simple, just using a single time for all channels.

I was thinking something that'd fit one-shot mode too so decided
to add a polling. But you are right. It does make sense to skip
polling until an actual read happens, though it also feels a bit
reasonable to me that putting a polling to the enabling routine.

The wait time would be sightly more complicated than the polling
actually, as it needs to involve total conversion time which may
vary depending on the number of enabled channels. I will see what
would be safer and easier and apply that in v2.

Thanks
Nicolin
