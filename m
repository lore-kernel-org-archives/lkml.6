Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5430DC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A142083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="HQXE4/KM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A142083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeJBKV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 06:21:29 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34682 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeJBKV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 06:21:29 -0400
Received: by mail-ot1-f68.google.com with SMTP id i12-v6so556889otl.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 20:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5LmNChT2FqakflaI0eoeujOMlUtoNDGib77Ji7q4/fs=;
        b=HQXE4/KMCIwJkbHCEbioXsnei36wmkUbzks0czq7Z7ssxfDOlq1WKEn+2YZOWksYvH
         HZL9K3Sk0B0sB4K3EmxwXCtiC80t5fLwC5vql3pIHZZJAPHmMgIcC183qRcvV58HzM2e
         BBaPJomTwb1fukmefBQvy+ARYXzjCM9ZAVEzWXIW/nRtOqnisH4CoLsRnZfXblKKQLiN
         OH8d+1T4UyeeFDWEJCdGKE6GzutspsjoM2hbw7AgfZ5lk9waPiqW+vjVv0X420HqySBk
         h3TlgpoE4ifcUk1lfsKCEcIXLKvZRFxG7FRVWqTzb5tnkkATol4iMk4JHKl7KL3PwEXZ
         DRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5LmNChT2FqakflaI0eoeujOMlUtoNDGib77Ji7q4/fs=;
        b=IlnqCiHyd2LknoTRXQCn1MyO1QFmQmrMP9e8tOvLQmA6ilUV36ld+Pv2MizMuM7Ipi
         5rQQyXe0XmMeHYwO9+T9cLXCQaq6ecNVkaeSFzgnR2svJ5s6LJ0l3tZ4pZCvFPKEMdFi
         VIRwoAQnjD0nAUegVxkFtuVoG4z2sM18kXWatXm71Iu5QbdOiimElRpZK2LAi+ky+xj3
         8fz/TxBly1RejRggs38D0uLCelTG5M/MD9V9YEaMhFQTVMNjD3/AR+TLbMJy7HJ5Kysb
         kIKnnzVo6ZwpWcHbCq9xXKBQNO14Ofz3SFIbZpy5NtA26SuHa65K6kfe/9BQLi/lE/YO
         yNNQ==
X-Gm-Message-State: ABuFfohFFVwjThMyVoWJ3KEw0qudSnh/hUV4KcOZDma/ubFQnCFyQ8lp
        a5yPqPCV+RFLVqByFyj3g1ULQwe8sBfdb2AuFvutmQ==
X-Google-Smtp-Source: ACcGV63HPPO1Q/U/9FSGygqkkKBz/hkS5Yjtd5ihIKGCSLeyyFpSgJYQ+VbKR/Fx3tPMW/i45ID9BDEE48KAyhX7WYA=
X-Received: by 2002:a9d:525b:: with SMTP id q27-v6mr8005663otg.229.1538451624961;
 Mon, 01 Oct 2018 20:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20181002033500.3383-1-fugz2012@zoho.com>
In-Reply-To: <20181002033500.3383-1-fugz2012@zoho.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 1 Oct 2018 20:40:13 -0700
Message-ID: <CAPcyv4hfDDrXsKnVwkHYX4WRZPw8NiWkOEjm46uMt_TNqPo3Rw@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm, namespace: Drop the repeat assignment for
 variable dev->parent
To:     fugz2012@zoho.com
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Guangzhe GZ1 Fu <fugz1@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 8:36 PM GuangZhe Fu <fugz2012@zoho.com> wrote:
>
> From: GuangZhe Fu <fugz1@lenovo.com>
>
> The variable dev-parent is assigned twice with the same &nd_region->dev. I think we could drop the second one.
>
> Signed-off-by: GuangZhe Fu <fugz1@lenovo.com>

Looks good, applied.
