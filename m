Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA300ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6255820671
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFNkVbX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6255820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388198AbeGWSso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:48:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36738 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388124AbeGWSsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:48:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id s7-v6so896909pgv.3;
        Mon, 23 Jul 2018 10:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3v+nRBZ+PzNMuyRfKVns12rCdjsWMlcMianUMaNcKpA=;
        b=VFNkVbX4ReJGLw8OuEdrxmPj+kMBKo2C05WoEP4sujWlK/eq3qZf5DMjLcOE9ItX5d
         jk+Qxio7miBUmXiOoptPBo+nuyi9q1wwXHUmqctNs9VQZV+7y10gONHebvVzgl0j7yjC
         Cus5BLFW1HYsTqcoG1nZsd3TtwMg4++riZJ/GMcePn2BgIKRyEpfCv50g3V3or0tg0tq
         YQ8iusLtIhVGsDpg7NcxolEzfr98YDQFiU/oEBze/iue8u6MGZguhe0GhisEBvA+Il5G
         qjGTjV34aEgUfQQ4SsdOH6Zd6zj3ISw1Jgz9xp3aSeI7CzE4VO3m7O4Aupm1SJs12Jr+
         wT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3v+nRBZ+PzNMuyRfKVns12rCdjsWMlcMianUMaNcKpA=;
        b=ZID6NagYAz0urmZ3xX7idyhcR+L5A3ucEUv7XpHKtMrOnRAN6nxWI+//j+aw9vLkPU
         AExxETDrmPOzbWQBWKRoCeH9Uv9MKvh6pEBy4kJwazEG2NQeWl10RAa6qOZrBChNzrDi
         dA366wyHMrlANfgE6MyyG1ywuxJgDZtm25bcW9o7QZjbYGirDh2JjK/BcUHV4e+o3xUI
         XdE5tPU/y+3y4HhOWkmFBtF18rnuiZSCtxSG7kPFvv1gLMR2KMCm0d7fyrBwOgNMhOEk
         04xI6zO38idCxxortejiu2CsANi654wo/WXTF4rYv4//Ub9ntTxufk6kTYYR6Rkf563s
         GiPw==
X-Gm-Message-State: AOUpUlHftC2AxJfRUyQHD6GoeNDM2t8kW16ElUlrEaTEA4GVSfPVA4z2
        n8zEQXToBBp/LrFditKYwek=
X-Google-Smtp-Source: AAOMgpelSBBFDBO/kglhvs+G96jS6r3VTLYeH8kQsJ/5YEG09uGmNmAHbfp8tBzxQGDuIMW9ps6GmA==
X-Received: by 2002:a63:9f0a:: with SMTP id g10-v6mr13279419pge.324.1532367984232;
        Mon, 23 Jul 2018 10:46:24 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id q25-v6sm19540910pfk.96.2018.07.23.10.46.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 10:46:23 -0700 (PDT)
Date:   Mon, 23 Jul 2018 10:46:21 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dev-harsh1998 <harshitjain6751@gmail.com>, trivial@kernel.org,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Andi Shyti <andi@etezian.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] touchscreen: elants: Use octal permissions
Message-ID: <20180723174621.GF100814@dtor-ws>
References: <20180723131954.30739-1-harshitjain6751@gmail.com>
 <20180723131954.30739-4-harshitjain6751@gmail.com>
 <20180723133200.GA1167@kroah.com>
 <20180723171831.GC100814@dtor-ws>
 <e257bc89eb082e9fdc342d6f794c15a2805c98a9.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e257bc89eb082e9fdc342d6f794c15a2805c98a9.camel@perches.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 10:25:10AM -0700, Joe Perches wrote:
> On Mon, 2018-07-23 at 10:18 -0700, Dmitry Torokhov wrote:
> > On Mon, Jul 23, 2018 at 03:32:00PM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Jul 23, 2018 at 06:49:20PM +0530, dev-harsh1998 wrote:
> > > > WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> > > > +static DEVICE_ATTR(iap_mode, S_IRUGO, show_iap_mode, NULL);
> > > > 
> > > > WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
> > > > +static DEVICE_ATTR(update_fw, S_IWUSR, NULL, write_update_fw)
> > > > 
> > > > WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> > > > +		.dattr = __ATTR(_field, S_IRUGO,			\
> > > > 
> > > > Signed-off-by: Harshit Jain <harshitjain6751@gmail.com>
> > > 
> > > This name doesn't match up with the From: line above :(
> > > 
> > > Please fix up and try again.
> > 
> > dtor@dtor-ws:~/kernel/linux-next$ git grep S_IRU | wc -l
> > 7605
> > 
> > We either need to run a tree-wide script or leave this alone. FWIW I am
> > perfectly fine with either octals or symbolic names so I do not see
> > benefit of doing conversion for code that is not known to be broken.
> 
> About half of those are in one subsystem (drivers/hwmon)
> 
> $ git grep -w S_IRUGO | cut -f1,2 -d'/' | \
>   sort | uniq -c | sort -rn | head -10 | cat -n
>      1	   3846 drivers/hwmon
>      2	    748 drivers/scsi
>      3	    215 drivers/infiniband
>      4	    168 drivers/usb
>      5	    109 drivers/media
>      6	    106 drivers/input
>      7	    102 drivers/platform
>      8	    101 drivers/misc
>      9	    101 drivers/gpu
>     10	     91 drivers/edac
> 
> The generic reason is octal is readable and S_<FOO> is unintelligible.
> 
> https://lkml.org/lkml/2016/8/2/1945

Yes, but please also read this one as well:

https://lkml.org/lkml/2016/8/2/2062

Thanks.

-- 
Dmitry
