Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C29C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59582086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sL9oakTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59582086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389531AbeIUPGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:06:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36090 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389313AbeIUPGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:06:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1-v6so5784601pgo.3;
        Fri, 21 Sep 2018 02:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qbcdu2B5IGt2CH1nNVSWZwz+ED7Rbqjhkqs6sbUcTt0=;
        b=sL9oakTzvjsSooaNPYcIA2thAJvZiOd/6wE6YEbj0pKm+MFyKYPEYMlih2lV+KiFOL
         w991247jXnjBz06NB9IB7yuJzV7HipNb4xyu4/50c+PLjpWkpRD0WFPt9Q7iplakJyj5
         mAyzjaQeQ242zeczKsvooyWnvJ3kcKrKBAfPFDjsYZpndCrmYH4lMPluEhivZkg1Z83b
         yuN01F16NKOdfdjE2ecD9c6WpM2rPgqN0Bv2+05NYLhapA/YYR1UI4kjBNc1C/8mhg37
         VS8LUcICgKA+NvCRhikhvMxln0WSsu1Vse7rmYvRxbTA8io5B2BEKo+BqKRaDqUVjhOz
         i4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qbcdu2B5IGt2CH1nNVSWZwz+ED7Rbqjhkqs6sbUcTt0=;
        b=V/S6xTsryVA02WP9oa/bStKndYCFd324xc7DXpWorcioCuTLAyIRrg8bSBJWbwRMkU
         wacbpLfZ0z1loIwsAkAglZ0fh2v/a0Bo3HxgtoLd0Sahvne5887f4k+amyliriiBJRZ6
         n+0fnJtEcOpvxXpHkd5zDpvk/d9fzDzo8mjxXiJjdE1jYmAlTcsG/aawJfRO3/VVJoPu
         GnYLnGAvuestqjIvXeXPg1soRrN5oGqbphvGDA+5wtoGk9dl42Q3QXIjWVoJDA6OuoXc
         bGVEe6NHIo9nvQZu9V8pE9dtlq6nuh7/sjtTX38QpSj7gDUtUVZElMTWjeP5VonBYc6b
         1bEQ==
X-Gm-Message-State: APzg51AMz+6BINfv933pFABCzoXEO/5A4bfq9Az89MJ+KtZiBa9OJfmL
        Dx+ZBSxwkkkZ0w4YNMrOwZ8=
X-Google-Smtp-Source: ANB0VdYeTCvy2J8ddelAk9OOspU6quRaVibdLiTamJydBmvWI7oA+VLobnPXcX1FEnKr12P+vZiNmw==
X-Received: by 2002:a62:1b41:: with SMTP id b62-v6mr21912173pfb.172.1537521498776;
        Fri, 21 Sep 2018 02:18:18 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id z11-v6sm45469800pfi.4.2018.09.21.02.18.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 02:18:18 -0700 (PDT)
Date:   Fri, 21 Sep 2018 02:18:14 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: ina3221: Get channel names from DT node
Message-ID: <20180921091813.GA21564@Asurada-Nvidia.nvidia.com>
References: <20180921000753.21846-1-nicoleotsuka@gmail.com>
 <20180921000753.21846-3-nicoleotsuka@gmail.com>
 <21a6e8f3-c95d-43d0-ca3f-3f91ddfeff07@roeck-us.net>
 <20180921012038.GA23354@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921012038.GA23354@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 20, 2018 at 06:20:38PM -0700, Nicolin Chen wrote:
> > So if there are no devicetree entries, the user now gets a sequence of
> > "unknown" sensors ? I don't think so. Please keep in mind that there are
> > users of this chip who don't have devicetree systems, and other users
> > may not want to specify any specific name properties (or they use sensors3.conf
> > to do it).
> 
> Being enlightened by your comments below, maybe adding a
> separate group for channel names by attaching is_visible
> to it could be acceptable? Then, name nodes can hide from
> those who don't want to specify.
 
> > > +		/* Log connected channels */
> > > +		ina->attr_group[g++] = &ina3221_group[i];
> > > +		ina->channel_name[i] = str;
> > > +		ina->enable[i] = true;
> > 
> > I also don't see the need for defining the group dynamically. The
> > is_visible callback is very well suited for handling optional sysfs
> > attributes.

I tried is_visible but it looks like it won't be that neat to
implement as some attributes of this driver don't really pass
the channel index to the store()/show() but some other indexes.

If you are very against the dynamical group, I can drop it to
leave the sysfs node as it was.

And for the name nodes that I was talking about above, I will
add an sysfs store() function so non-DT users can set them,
and I also removed the confusing "unknown" default name.

I have been rewriting the DT binding and it should make a lot
of sense now comparing to this version. Will send v2 tomrrow.

Thanks
Nicolin
