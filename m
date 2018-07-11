Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F40C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2283420C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxZN4o/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2283420C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389773AbeGKQk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:40:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51338 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388013AbeGKQk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:40:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so3027737wmc.1;
        Wed, 11 Jul 2018 09:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0KHZt+ay/U0tE/vnL9dbSRWks2knzUFE0q2HIBH8y1c=;
        b=sxZN4o/5zzT12C8HQDkZXNg3OwCW1GMvNXX4lVS1U3nx0W56Y6w3tTctfArl3dtKXz
         1h8jbXaJXBF871b4fwzIuxQFss716O2vclu/Yk/5qTKoIG+1iWrfDmai5+KeYMVhvDtX
         Mw/OtgaLnD/oAH3uYgeaRUs0VRvGJY9ld7krFhgp4LSBFYVXLpSy4plHfqjjNpTFlIam
         0ZZ8GJH0LN+wK4AuZDJaI0TuYkkW53QNuLiy+vytTIDwWtfqsJrzJMVimx8twxI/7Mc5
         3EDZSkEBOa8USWhTYwsI12kzyg0XyCIUQIk2YoZ9YUTdlJR+DTpIwD3lg82a5mU7y4yk
         yHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0KHZt+ay/U0tE/vnL9dbSRWks2knzUFE0q2HIBH8y1c=;
        b=eoDpNuhXAMc/fWBms5ERS6nvxvc8gIjh9Wf4mi35EayurX5DOLtvI8ujGKCsB1w2Jz
         9+jSEmaXrgG2XUug8AxlEigfFysEzR2TxEJnYzKA7dTJlsCXvGUgO3xGRm+eMeslQydJ
         gSPKZ3m7PdehfJDoBFlicGP2LY8IMmtyMr4/Mg4Da9dQO9mVyWOO8Oq678Bbc1TBiUBY
         MCxHxX8M0Khv8MJcpFVC8YVasUMMcnb+oeyPRv9MDlG4AEvZliU7X25Flqge/8PZUZwx
         vfAVPGpILiJAtQ7OPLwLBblbuCc38QwoaCGr/LFZJ+PX2vI+V5GT+gCEjtn/9Jnp2/PE
         pbjA==
X-Gm-Message-State: APt69E0R+ezGlaL3pewWKeTmC4e8Z1A0/DHck2jBeqdOVhOzP5B0tmNi
        CohFjxwBQUuufZHbYvXwFpo5BBbF6b8HO6BJ77RBGQ==
X-Google-Smtp-Source: AAOMgpe6LZywWGVnrJjKNA6mVbBnbipJ1M5McC/JrZ12uGsc0ywDF1k9ZmJoU87cCZRv6Pny7ZZd+qrm8Gvk8pAyTYw=
X-Received: by 2002:a1c:1745:: with SMTP id 66-v6mr17182987wmx.38.1531326918893;
 Wed, 11 Jul 2018 09:35:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:9c8:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 09:35:17 -0700 (PDT)
In-Reply-To: <6cf082e4-6fff-21dd-4df5-a6e9e4f2847c@intel.com>
References: <20180704085356.10888-1-jthumshirn@suse.de> <yq1d0vupjq2.fsf@oracle.com>
 <6cf082e4-6fff-21dd-4df5-a6e9e4f2847c@intel.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Thu, 12 Jul 2018 00:35:17 +0800
Message-ID: <CACVXFVOSssuveZDN185FUYpjX1i0ma59Cn30XBSJ1dAHDKLnLQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: switch to scsi-mq by default
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 4:31 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 11/07/18 05:52, Martin K. Petersen wrote:
>>
>> Johannes,
>>
>>> It has been more than one year since we tried to change the default
>>> from legacy to multi queue in SCSI with commit c279bd9e406 ("scsi:
>>> default to scsi-mq"). But due to issues with suspend/resume and
>>> performance problems it had been reverted again with commit
>>> cbe7dfa26eee ("Revert "scsi: default to scsi-mq"").
>>>
>>> In the meantime there have been a substantial amount of performance
>>> improvements and suspend/resume got fixed as well, thus we can
>>> re-enable scsi-mq without a significant performance penalty.
>>
>> Applied to 4.19/scsi-queue, thanks!
>>
>
> But there is no runtime pm support, is there?  I tried enabling runtime PM
> for UFS SCSI devices with scsi-mq and it didn't work, which is a regression.

I just posted one RFC patchset for supporting runtime PM on scsi_mq, and
looks it works in my test on usb-storage.

https://marc.info/?l=linux-block&m=153132657922233&w=2

thanks,
Ming Lei
