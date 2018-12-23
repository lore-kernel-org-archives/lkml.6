Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFD3C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 15:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2722B21971
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 15:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRvmOUKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbeLWPuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 10:50:14 -0500
Received: from mail-it1-f180.google.com ([209.85.166.180]:37792 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeLWPuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 10:50:13 -0500
Received: by mail-it1-f180.google.com with SMTP id b5so12857056iti.2;
        Sun, 23 Dec 2018 07:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WASiI+LGr+j54QgtHqz/Mb0c0vmWaC6GIOI+FQCQgEU=;
        b=ZRvmOUKHJ9VLidGEjVWY9F2e7Lpv3zF/sMZaB1bQp0RrNbPNXF1fsxZsoTN9f+Ru1L
         53W5xMM63U0ciniuM2auE7JgvtZFQDxR33+TQM063X3iJMEbHQwzDQX1NtmOcY7uePwl
         +AGk2xD6JIfC+OcadE/Dp8jVtzMMGbb4YlTaSutawUdmLuD+5m8vbojAWnccRSqBGUIT
         Q+kvqk0vAB/Jan0zArCnYPWj5toUUZy61tez6ubS+9gxzwKwSwoLg0AHkttmqPE+NfQ1
         tJkOgDsZpQded8u/iD6qAgr9/bdloJUo4RYOVcfbtgfgJZkACYEKq2NREbD+0fPCO+kX
         6IOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WASiI+LGr+j54QgtHqz/Mb0c0vmWaC6GIOI+FQCQgEU=;
        b=lEs7IP/MmlW2ahc3oTQOc86Eb+BaNvz2RahZHIWkiS0KFVgUP3MQ7jimDesJtpl0Y/
         6kQypf19nbSn+cfHoCYydTwYpbmH/Z7JdkZOWQa4p0Au5V+ZV2C+P24YR2H/PUUP7eSx
         EXC7MKaX7FLPAnLJ27XvVsgsmQEfKThaR1NYTZ608uUtsHNP0jiC3h8veiW96jsuV6Ea
         VQSYvGIm61aUISsAd5fHZF8D0zfhY/xZSw27zGs5c6OhGR+Trp3rQ5aJ+BaSPCqmcaZV
         mCv7Ydj29Yrg7R9uZsxFeG62kXfdmT9c5aYzhJwLKB9kBObr5FVHw9SrP1FJHeSjsa6R
         bzcw==
X-Gm-Message-State: AA+aEWZ11mvwxEsl0Mi10u+k1BuE8I1Oxi2k9o0ElAx1dnQYj5HjXova
        ExfboMUgSZ2N+MRFfljWKIPyPe+E24+Dq12fRdE=
X-Google-Smtp-Source: AFSGD/W34dmcpffHh9SghWrXOnooM9WHQS/7z8Dvy4baJmVfyOO7InwqsBhKMr+s1uop0UMnf12R+fHIlbHDwQBBOxo=
X-Received: by 2002:a02:9d27:: with SMTP id n36mr6224585jak.30.1545580212896;
 Sun, 23 Dec 2018 07:50:12 -0800 (PST)
MIME-Version: 1.0
References: <20181202065913.10377-1-tiny.windzz@gmail.com>
In-Reply-To: <20181202065913.10377-1-tiny.windzz@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 23 Dec 2018 23:50:00 +0800
Message-ID: <CAEExFWv4FNUMt=SbK8UtD5NF9k3uoAirP+n6JwZ4pcBMaMZ2MA@mail.gmail.com>
Subject: Re: [PATCH] scsi: convert to DEFINE_SHOW_ATTRIBUTE
To:     qla2xxx-upstream@qlogic.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, kartilak@cisco.com, sebaddel@cisco.com
Cc:     linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping......
