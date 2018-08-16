Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB87C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8058E208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJAiQPyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8058E208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbeHPUUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 16:20:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45769 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbeHPUUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 16:20:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id w16-v6so4253242ljh.12;
        Thu, 16 Aug 2018 10:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ZJvtxvHx8QJRq1ahNLOQ4m3E5ivFh6BM00/T/GSmJ8=;
        b=DJAiQPyTVTE3ziu2HJA0JGptEiGjUe7i94MKtMSCGXPqUJ1K1IqQj7OprqWnL6y4R3
         ggZX5f4L8JzSNWJ6g0qjyLRo8GQfAyLuzL5UrD92eVEjRASe2tUjsMlVnpoJqAU94luA
         HrGvO5ryouWGdLGsMssX3A25R85b+v/7btiqswVEgPLiREXuHj5uukDEqZElgCmAW3cn
         UwVlfgSG7/qK3yfve30PhBHLVXH3BGxkD4lRjO6li2QemYLTaxEVq/MB2IKd128SYnYn
         tjZVURGRLciLMhLlVwYDdL2MXglM3umKr+ci5jVCssgq2pjx2R7dtpgysRMbbBcFXmDs
         xHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ZJvtxvHx8QJRq1ahNLOQ4m3E5ivFh6BM00/T/GSmJ8=;
        b=f9B1Yy1lRGpDWc8Lar896XVxz6uInNO/6omHyeMzqW9v1tMfEH9/Es2v+EHo7UGEUg
         tm0oZE5+3eHoDPCESkJNsTGOmER4hgqPuHZZnrv7DpbpGCP4kLdz/dRhFozyTFAce3x8
         OOcsktzlyTwDQjJ1XnLjflk8N4YPcupFPoSJjqGqAau6zx6tC5882+sj9foMaIrXaRIx
         cdpA4vX6ZVFrnTjD65eUZraMyaCrBeDMp4WKWt+Q6jv/u9f0TyKFYWssqVwFBcbtPhlo
         wgp5vVESF2EPNfZvudLhpZRnSCWiP3r4bM1E7dahvUwKMV91h+BenkssyBzp41SJ9m4s
         PJ0Q==
X-Gm-Message-State: AOUpUlFCyJfMJkKNgDPNuJerDJJsmd0bvDrUDHmMxPdL8qfCiAJiurnA
        YLMip0yuZvjPZtbNyxmeqs8=
X-Google-Smtp-Source: AA+uWPxghjz2KBhMJd0j6ZTMNXxmEQMLrogRUCes3Txs8txzBn5kI/9hO+dWigaRS4Nf3GcsWdeOJQ==
X-Received: by 2002:a2e:750d:: with SMTP id q13-v6mr16611412ljc.148.1534440029309;
        Thu, 16 Aug 2018 10:20:29 -0700 (PDT)
Received: from dimapc.localnet ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id f136-v6sm5164656lfe.71.2018.08.16.10.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 10:20:28 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mikko Perttunen <cyndis@kapsi.fi>, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gpu: host1x: Ignore clients initialization failure
Date:   Thu, 16 Aug 2018 20:20:26 +0300
Message-ID: <3610451.84tSEqHynW@dimapc>
In-Reply-To: <2093022.0kn10W7Lqi@dimapc>
References: <20180809231211.26182-1-digetx@gmail.com> <2093022.0kn10W7Lqi@dimapc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 13 August 2018 20:48:25 MSK Dmitry Osipenko wrote:
> On Friday, 10 August 2018 02:12:11 MSK Dmitry Osipenko wrote:
> > From time to time new bugs are popping up, causing some host1x client to
> > fail its initialization. Currently a single clients initialization failure
> > causes whole host1x device registration to fail, as a result a single DRM
> > sub-device initialization failure makes whole DRM initialization to fail.
> > Let's ignore clients initialization failure, as a result display panel
> > lights up even if some DRM clients (say GR2D or VIC) fail to initialize.
> > Actually VIC fails if initramfs misses the firmware file, so with this
> > change a serial console isn't needed anymore to figure out why display
> > isn't working.
> > 
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> > 
> > Changelog:
> > 
> > v2: Added WARN_ON() that should get more attention than just a error
> > message. Made clients_lock to lock around the lists modification, that is
> > in line with the rest of the code.
> > 
> >  drivers/gpu/host1x/bus.c | 20 ++++++++------------
> >  1 file changed, 8 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
> > index 815bdb42e3f0..07bb6b6c1260 100644
> > --- a/drivers/gpu/host1x/bus.c
> > +++ b/drivers/gpu/host1x/bus.c
> > @@ -199,19 +199,23 @@ static void host1x_subdev_unregister(struct
> > host1x_device *device, */
> > 
> >  int host1x_device_init(struct host1x_device *device)
> >  {
> > 
> > -	struct host1x_client *client;
> > +	struct host1x_client *client, *cl;
> > 
> >  	int err;
> >  	
> >  	mutex_lock(&device->clients_lock);
> > 
> > -	list_for_each_entry(client, &device->clients, list) {
> > +	list_for_each_entry_safe(client, cl, &device->clients, list) {
> > 
> >  		if (client->ops && client->ops->init) {
> >  		
> >  			err = client->ops->init(client);
> > 
> > -			if (err < 0) {
> > +			if (WARN_ON(err < 0)) {
> > 
> >  				dev_err(&device->dev,
> >  				
> >  					"failed to initialize %s: %d\n",
> >  					dev_name(client->dev), err);
> > 
> > -				goto teardown;
> > +
> > +				/* add the client to the list of idle clients */
> > +				mutex_lock(&clients_lock);
> > +				list_add_tail(&client->list, &clients);
> 
> This shall be list_move_tail(), v3 is coming.
> 
> > +				mutex_unlock(&clients_lock);

I just realized that DRM won't load if any of host1x drivers fail to probe. I 
think the behaviour should be consistent in a case of driver-probe and client-
init failures. It looks like changing drivers probe error handling will be a 
much bigger change, hence let's keep the old behaviour at least for now.


