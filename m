Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC210C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB24620842
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550763263;
	bh=wwAPMEhYtVcOn5aXGGayEeTVcRs/Bctzi/TedrlPz38=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=L0bPgC0Sd3+hr1SimuqK1YJTTkccQT9HFribCz1iHfXuIaM61GBc7pyVIBfGeKgmY
	 TLi+Mpc9DLzm24HGN3IS+Dw3EB6bvVtP3dfT5MrETMetzB8ZJnj7zUpmsu9nQrZqNr
	 gvNpe4BOcQIvL5k0DUI2SQkrXDVkaZwNhg9j6AwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbfBUPeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:34:22 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:35968 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbfBUPeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:34:19 -0500
Received: by mail-pl1-f171.google.com with SMTP id k2so5000804plt.3;
        Thu, 21 Feb 2019 07:34:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XPqRx3G1zDibY5f11Kqd711bReAyQUyuceYskmJlDgk=;
        b=RAq/nOTgaUz8QTrQthUrzxjB4+4yBaXNVkFDPTnCRYtdvSNlO3HUoVJev+T7CadpIk
         /k0zPi5SWDDWVswkJZwoczJqwzVkziqSHYIBn6XfdIATMKr0YY2WLAm8wp3TTrYu+33l
         OWM9j+RI+mxlqRUv8nJXSoosTYdlfAG+y5gdVw1hAQn39TvEQ2XQO0X4pgI9a0qY5QCC
         MTxuYWHhPnx1I2YVBO908d1eU8KI3X3oyin18PX5RZUKdFvvcUl6S8/oESZ1ZGrqVnWg
         U3quDQDj1fUzBrwUtG5nzPj1a5qmiWEMT+BDdgLrIzOvxvlUr8VIde1hrvGHp4F1zHFk
         TBAw==
X-Gm-Message-State: AHQUAuajaahaymSALzojtMR+fkbAkPjV2YRpLn/slp2prrvlSkY6uRm7
        dZnMzhZ3kZgCQuCgSbSnqjc=
X-Google-Smtp-Source: AHgI3IbQhHLkj+rQEswB+BoVSLMBa9mIIZ3HP92lYutjhoqXwJf0K2FXjHuJFvPPK+SFR0rkJuuRpA==
X-Received: by 2002:a17:902:9003:: with SMTP id a3mr15817741plp.2.1550763258257;
        Thu, 21 Feb 2019 07:34:18 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id a20sm34713724pfj.5.2019.02.21.07.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 07:34:17 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 21 Feb 2019 07:34:15 -0800
Date:   Thu, 21 Feb 2019 07:34:15 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Sasha Levin <sashal@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Steve French <smfrench@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <20190221153415.GL11489@garbanzo.do-not-panic.com>
References: <CAOQ4uxjMYWJPF8wFF_7J7yy7KCdGd8mZChfQc5GzNDcfqA7UAA@mail.gmail.com>
 <20190213073707.GA2875@kroah.com>
 <CAOQ4uxgQGCSbhppBfhHQmDDXS3TGmgB4m=Vp3nyyWTFiyv6z6g@mail.gmail.com>
 <20190213091803.GA2308@kroah.com>
 <20190213192512.GH69686@sasha-vm>
 <20190213195232.GA10047@kroah.com>
 <1550088875.2871.21.camel@HansenPartnership.com>
 <20190215015020.GJ69686@sasha-vm>
 <1550198902.2802.12.camel@HansenPartnership.com>
 <20190216182835.GF23000@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216182835.GF23000@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 01:28:35PM -0500, Theodore Y. Ts'o wrote:
> The block/*, loop/* and scsi/* tests in blktests do seem to be in
> pretty good shape.  The nvme, nvmeof, and srp tests are *definitely*
> not as mature.

Can you say more about this later part. What would you like to see more
of for nvme tests for instance?

It sounds like a productive session would include tracking our:

  a) sour spots
  b) who's already working on these
  c) gather volutneers for these sour spots

 Luis
