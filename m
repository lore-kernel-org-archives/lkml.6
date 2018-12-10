Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EACC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32AB20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="rWaAWT1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32AB20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbeLJVYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:24:01 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33679 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbeLJVYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:24:00 -0500
Received: by mail-oi1-f196.google.com with SMTP id c206so10285908oib.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 13:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OdkOVSV3MZdsC92ag/QL7r3SwF4wvUqy8pgndFMPeFE=;
        b=rWaAWT1unrZ0fHsjmcxBUQUJpCRbeYVgM6/PzPLgRbqa1Bdfa6K197vfkBYc27R1gq
         RBMpHa7K259uQ0DXn1D72b9YIkk0PO8Q5b3EtiaZ2k0Eu6zvziZ2JcLjh5GMq6kLXQUO
         WxJk3Nsdgb0Vh773sqreJlB6Phoc2zx4kl40GApHZZklad/HR2dVywyNzrIGyCQmy0hT
         JY3yDgM4QASu15zZX6GBGsRHPyaSuUh8JYg3a7Fn2GNZppdvTMFba4kTASbq1gPzU8Z0
         Ad5emCp1lqa02nc8JwNmk57A1t5veVNXkGDc6QSO+LGBI+QWf1Gb0sG+ENl9Iu5qseBB
         U/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OdkOVSV3MZdsC92ag/QL7r3SwF4wvUqy8pgndFMPeFE=;
        b=X/pw6WcFn2Uu3aHwBFfEsRpL4BYeq6kwMNAiUViHvq0Ux5K/BPhIeOBTbY5HgKH7X1
         5+n5nI4xkBqy7BYusT1AbtzYlpBoHNF6+5I1AcqIdvaomVTHl8IDK8ZbiXlL+vHrPSBq
         PoSmxH05I3pYkCNxHC04Mow03dhlB7X1ilqhCr4lN4XLwpI0QIkJQRnnxIbQyHAkZKty
         5pHuAn+RzVDVvgYyWPORHhxuXOBDFzlim28TSlyS5KqwgsGvEfDU8ottqbhOIV5yhLLk
         zP9es+VnzLHAzfW/Eguyk2EqCJ9L6KyjTM0HD8cmbfAzk3pq2pmzLDqKQiqTU2bM20EO
         73gQ==
X-Gm-Message-State: AA+aEWbKqlYwVvv7WO4tDm81QlrKz1B3z77/lN83C2aixh7OiLiKeYFB
        rHKfNdzHkwyMwHG6ifd/HvpXGEz96OCWmBGvyf2tzFljQcM=
X-Google-Smtp-Source: AFSGD/VBwnEe6vQ/6t4jqGxMk4C+osawdZon+pfWqzOu4LhWmQuL4CDzJYXq6EloyTOpgmzE74O3gIbtU/NkcsjXv4M=
X-Received: by 2002:aca:b804:: with SMTP id i4mr8076128oif.280.1544477039490;
 Mon, 10 Dec 2018 13:23:59 -0800 (PST)
MIME-Version: 1.0
References: <154403054034.11544.3978949383914046587.stgit@ahduyck-desk1.jf.intel.com>
 <154403072403.11544.10419282512791659652.stgit@ahduyck-desk1.jf.intel.com>
 <CAPcyv4jH_Op-xHTd2FwQizPaWFx_2FE-pVsOLLmZAEK8EVPrYg@mail.gmail.com>
 <15b6817fd945a1622afe673b46b028bacefad72b.camel@linux.intel.com>
 <CAPcyv4i1RTrKYX0YpyCRE=pqt3pHBRiCGQq1wYUriLjKKTVA7A@mail.gmail.com>
 <bd92d0a3ff60097bf4424ff4c556a5369e66da6d.camel@linux.intel.com> <CAPcyv4jDG_2VwFr4oDGCURFrA=B0Bs2HGN9exLE47vDj0P3_8A@mail.gmail.com>
In-Reply-To: <CAPcyv4jDG_2VwFr4oDGCURFrA=B0Bs2HGN9exLE47vDj0P3_8A@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 10 Dec 2018 13:23:48 -0800
Message-ID: <CAPcyv4hrML3SKnFP9UANC-hdTrpnOx4nWX=b-yhLsLuujL5oAA@mail.gmail.com>
Subject: Re: [driver-core PATCH v8 2/9] driver core: Establish order of
 operations for device_add and device_del via bitflag
To:     alexander.h.duyck@linux.intel.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        jiangshanlai@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        zwisler@kernel.org, Dave Jiang <dave.jiang@intel.com>,
        bvanassche@acm.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 1:15 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Dec 10, 2018 at 12:58 PM Alexander Duyck
> <alexander.h.duyck@linux.intel.com> wrote:
[..]
> > Also the context for the two functions seems to be a bit different. In
> > the case of __device_attach_driver the device_lock is already held. In
> > __driver_attach the lock on the device isn't taken until after a match
> > has been found.
>
> Yes, I was only pattern matching when looking at the context of where
> dev->dead is checked in __driver_attach() and wondering why it was
> checked outside of __device_attach_driver()

...and now I realize the bigger point of your concern, we need to
check dev->dead after acquiring the device_lock otherwise the race is
back. We can defer that consolidation, but the larger concern of
making it internal to __device_attach_driver() still stands.
