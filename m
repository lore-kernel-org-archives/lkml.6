Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A06BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CA320675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="nZ1QnFT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388683AbeLQSRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:17:12 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40303 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeLQSRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:17:12 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so6508724plq.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 10:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qbdXTd/0EpkT5V540myqgEFTzKaGadElIpBS2jT3Zho=;
        b=nZ1QnFT4RXoniyD9K9YkKqu3Nq+9E/FNHGFITs7dsD0eeGqiRDWQhspoCJgiTNLZQc
         Kb60sle3uahgXyNqTBs1AwrF/3GnLZlxa3+eWwYR+ugdXApVLc1hTFUsnJ1GusSvyYzw
         9Pd8vstFM7aOF0hIdbRvbIcmZpfTx1Zr9PncSL2Tx6ipDpFVsxRKP8OuDo6eaTFWEUmq
         BAWcUps6/LL2YX/vFONtOTKjc7JA3bn1CN4A88FtY0+j4AVq2Baz4vey/XwomqQ+6+Kb
         Q/EB12V+1kn3dikXngamLOz5CtsCUIiNPch2DzkED88mFZLKKK2QTBLUjZNzXRXvThUO
         +6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qbdXTd/0EpkT5V540myqgEFTzKaGadElIpBS2jT3Zho=;
        b=P9s/4TXT7Mpf76TULSkdDbxIoUsSHApza3UihNDNvu4jaicAFl9PiaL8arG6cKHrxv
         Lei1VyaCl6cKHwEr3nDLolTV6tjuAEoQzVtA7zPjNq6Y+bLYczd7UulNjtkvb1ktVagE
         9iWn/B/Mpcv+cC4kRWbSRkVz54XTHoR8E2uF7UUOHuJtE0bht4717ZuZ2rHVMlYe8c9J
         Y0jTitbuyGM8VPtfuqOFHmeM3x1udPj3IGCYj+SWpyx1NuiG2PQRFqietK9IGZKiU89F
         92/Y3P+zOq41FkeCf57L5RFmOyxPi7eCUnMaQeCld8fvs43lGphExJ2i1ujPWl6QcT96
         S0jQ==
X-Gm-Message-State: AA+aEWbhLQeQDZTah7yNzjjOGBV1BriuPdrgfWc3+skM/gN3C6v6Trf7
        lYCxFThQb9iCiw2B/f3l6rfAhQ==
X-Google-Smtp-Source: AFSGD/XmYzKqdn5pVoPd4LL2tiOa3tWuVG4ah+5K92ndW76G6F2qveRjdYT9UNzbz4vJcG5RCeOXaQ==
X-Received: by 2002:a17:902:24a2:: with SMTP id w31mr13337207pla.216.1545070631226;
        Mon, 17 Dec 2018 10:17:11 -0800 (PST)
Received: from xeon-e3 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id 83sm21505378pgf.57.2018.12.17.10.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 10:17:11 -0800 (PST)
Date:   Mon, 17 Dec 2018 10:17:03 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'devel@linuxdriverproject.org'" <devel@linuxdriverproject.org>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "'apw@canonical.com'" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Return -EINVAL for the sys files
 for unopened channels
Message-ID: <20181217101703.78e8bb3f@xeon-e3>
In-Reply-To: <PU1P153MB0169725E468897F135F2155BBFBC0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB0169DDAA2CBC2901505AE692BFA00@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
        <20181217091518.5004d4c7@xeon-e3>
        <PU1P153MB0169725E468897F135F2155BBFBC0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 18:00:29 +0000
Dexuan Cui <decui@microsoft.com> wrote:

> > From: Stephen Hemminger <stephen@networkplumber.org>
> > On Thu, 13 Dec 2018 16:35:43 +0000
> > Dexuan Cui <decui@microsoft.com> wrote:
> >   
> > > Before 98f4c651762c, we returned zeros for unopened channels.
> > > With 98f4c651762c, we started to return random on-stack values.
> > >
> > > We'd better return -EINVAL instead.  
> > 
> > The concept looks fine, but maybe it would be simpler to move it into
> > hv_ringbuffer_get_debuginfo and have it return an error code.
> > 
> > Since so much of the code is repeated, I would probably make a
> > macro which generates the code as well.
> > 
> > Something like this:  
> 
> Thanks, Stephen! Now the patch has been in char-misc's char-misc-linus
> branch, so IMO we may as well leave it as is (considering the code here is
> unlikely to be frqeuencly changed), and we have a smaller patch this way. :-)
> 
> But, yes, I agree with you that generally we should make a common
> function to avoid duplicate code.
> 
> Thanks,
> -- Dexuan

The old code was risky because it would silently return stack garbage.
Having an error check in get_debuginfo would eliminate that.
