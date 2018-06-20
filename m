Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F592C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B4220874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B4220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754335AbeFTSCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:02:00 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:40988 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754144AbeFTSB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:01:57 -0400
Received: by mail-yw0-f195.google.com with SMTP id s201-v6so160214ywg.8;
        Wed, 20 Jun 2018 11:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R3Y5ViORQCAf202HU386zVa7yCVCukkCClp+AD5Hrlg=;
        b=G8+QV3WL6yYiB/vuFt6nL96C7RwhKm9yGxbuPz3PzDpo4V4E+I9tz/oXWZT8r81stQ
         nshC/wwUPyNPJ+zjodLH/yjkvHK9fpthTyyqIh1NaLhX3F0Ay8+fMsbBEmIYYaGZ8A8o
         HZmAU4MNnFmklqZHJwRUgyauQJ/4g7aB/YZx7IfiGwASR44b2L62JCaXS6rWyVsVvNqb
         /3WruMT7z8LHAChUCyuFKV3g4B7+s/f5sn6bQHa4JAkFUHY5oh01wtYTYR7YZW6x+SCo
         SM8y9DUFXUhmHtWMfvYd4kfdb/UwR95P7RBi0CzOHbNvWXxU/5VOkhd6T9Jlo0jQ3Vqe
         wv3Q==
X-Gm-Message-State: APt69E3kwUKo92wbaVDAS53vxTUbXr3/VhRzfBth3EbyHf/yjd4UwCrG
        i0QMQNLKHBGnzg0+ImoFng==
X-Google-Smtp-Source: ADUXVKLwCdaDJL7Wle1BS+DfvHWUlj3IZUTJ1uJQeasc4IxZGVH3FtuFlOQPcK5cFeRBvUhX69f80A==
X-Received: by 2002:a81:360a:: with SMTP id d10-v6mr11182429ywa.421.1529517716513;
        Wed, 20 Jun 2018 11:01:56 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id p22-v6sm1073890ywp.105.2018.06.20.11.01.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 11:01:55 -0700 (PDT)
Date:   Wed, 20 Jun 2018 12:01:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Sayali Lokhande <sayalil@codeaurora.org>, subhashj@codeaurora.org,
        cang@codeaurora.org, vivek.gautam@codeaurora.org,
        rnayak@codeaurora.org, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        asutoshd@codeaurora.org, evgreen@chromium.org,
        riteshh@codeaurora.org, linux-scsi@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Malaterre <malat@debian.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 1/3] scsi: ufs: set the device reference clock setting
Message-ID: <20180620180154.GA18559@rob-hp-laptop>
References: <1528981432-23065-1-git-send-email-sayalil@codeaurora.org>
 <1528981432-23065-2-git-send-email-sayalil@codeaurora.org>
 <bf87ec58-69c0-fe59-cfa1-8dc7dc80ca46@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf87ec58-69c0-fe59-cfa1-8dc7dc80ca46@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 10:26:07AM +0300, Adrian Hunter wrote:
> On 14/06/18 16:03, Sayali Lokhande wrote:
> > From: Subhash Jadavani <subhashj@codeaurora.org>
> > 
> > UFS host supplies the reference clock to UFS device and UFS device
> > specification allows host to provide one of the 4 frequencies (19.2 MHz,
> > 26 MHz, 38.4 MHz, 52 MHz) for reference clock. Host should set the
> > device reference clock frequency setting in the device based on what
> > frequency it is supplying to UFS device.
> > 
> > Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> > Signed-off-by: Can Guo <cang@codeaurora.org>
> > Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> 
> I have repeated my V2 comments below.  Please address these when you post
> V4.  Also please provide a change log for each patch version.

Do I have to repeat my V2 comments too? Please don't send a V4 until the 
discussion on V2 is resolved.

Rob
