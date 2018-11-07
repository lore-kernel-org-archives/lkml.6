Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517F3C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0A720844
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/S+UrFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0A720844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388832AbeKGKU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:20:56 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52801 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388174AbeKGKUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:20:55 -0500
Received: by mail-it1-f194.google.com with SMTP id t190-v6so14955200itb.2;
        Tue, 06 Nov 2018 16:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t9j/cKf563KGuUeOr8jihBw0WRQ5qoT1qNX2hOXdaUw=;
        b=H/S+UrFBurH43Jfe0bwc/mBHpA/yE/PYZBQ9J9zgCT36xMwsV8dZDG0yqaRA/1M2Ku
         n3PvqcPHsrIemhkTnObMHvlAQB26vuniO5+gtYyZ6h/gGusBQ4LfIdG9+APULobAv8jQ
         lu3LVydcSJZvUR5QL5NkRr1qSj7ey43eMuLsM6ApvIA8uv0CxDVLgrajvPrP2s5gS5zy
         mNWMAOPxKhXlsfSUJHYX6qjKO51cCvm4wXiC5BBPVxLcCoXA5CaSRQeYT9lN1tbQKuWq
         v//vqzIhACsYkzoFt+0/vfDjZyBKti4xF+LdFaNCTMvYzMiwdTBcHf6yAMH8wruD8zAz
         k8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t9j/cKf563KGuUeOr8jihBw0WRQ5qoT1qNX2hOXdaUw=;
        b=eKSi91czli1/MgKeTFAKxiaGDBcn0RUrdD7o/9BqkuL5iWR+49WwRbS0sNuai2qKU/
         N2nYIDKoKE0sR7CSkSBoJXP6yXM7QuU7/TSQA2yHeVYhoSs4PyLSBcogZgNX0S/5cjJ2
         s4XOznAnDlXe1mIRHjmPgcSpilbWxammq6uoLhSNUmCPlY2+iY5d7oYVSzMXlorCvSKb
         1RenMBaFBEhN+r5HXAMrddP9ct4oaaXDYrg0XnxCCGVxZ3ai1P05uGyt0aF9SQamfY9V
         GWL3ef/Tb8+tTmIBZr/F/+gzhsxCQtqdNbA0gZCbeHsdRy1bVcuPxFJlvjkB8b/+nTA3
         u4Lw==
X-Gm-Message-State: AGRZ1gKO8DmIqJC43/Bc2HK4civjE4vTLbCUaC/pq3jw5lSsbASNJlsU
        /I9/3gIfLUEurx5/Gx8Vc0Y79BNN3IAZB8FqoYU=
X-Google-Smtp-Source: AJdET5e0ggr2RgVUkzQrIwcfczSByhgrlr9a0xD8ifq/sjUfJf5AWbRa5EEtQeL0255Dj/8hq3ivdG7Ix2d7yVTQfEM=
X-Received: by 2002:a24:5308:: with SMTP id n8-v6mr168714itb.146.1541551976471;
 Tue, 06 Nov 2018 16:52:56 -0800 (PST)
MIME-Version: 1.0
References: <154145232484.29224.1635232599636954462.stgit@ahduyck-desk1.jf.intel.com>
 <201811061228.iteFLO2p%fengguang.wu@intel.com> <1541548274.196084.197.camel@acm.org>
In-Reply-To: <1541548274.196084.197.camel@acm.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 6 Nov 2018 16:52:45 -0800
Message-ID: <CAKgT0Ue61y6qMH3sKH6-M_eHy4Lc5p6k27LFXwmVooAL48KyYQ@mail.gmail.com>
Subject: Re: [driver-core PATCH v5 5/9] driver core: Establish clear order of
 operations for deferred probe and remove
To:     bvanassche@acm.org
Cc:     kbuild test robot <lkp@intel.com>,
        alexander.h.duyck@linux.intel.com, len.brown@intel.com,
        linux-nvdimm@lists.01.org, Greg KH <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, jiangshanlai@gmail.com,
        LKML <linux-kernel@vger.kernel.org>, kbuild-all@01.org,
        pavel@ucw.cz, zwisler@kernel.org, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 3:51 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Tue, 2018-11-06 at 12:10 +0800, kbuild test robot wrote:
> > Hi Alexander,
> >
> > Thank you for the patch! Perhaps something to improve:
> >
> > [auto build test WARNING on driver-core/master]
> >
> > url:    https://github.com/0day-ci/linux/commits/Alexander-Duyck/Add-NUMA-aware-async_schedule-calls/20181106-093800
> > reproduce: make htmldocs
> >
> > All warnings (new ones prefixed by >>):
> >
> >    include/net/mac80211.h:1001: warning: Function parameter or member 'status.is_valid_ack_signal' not described in 'ieee80211_tx_info'
> > [ ... ]
>
> There are plenty of references in this report to header files not touched
> by patch 5/9 in this series. I assume that this report indicates a bug in
> the 0-day testing infrastructure?
>
> Bart.

It isn't a bug. It is pointing out the same thing you did. I didn't
document the async_probe value so it added a warning to the list.

>> include/linux/device.h:1056: warning: Function parameter or member 'async_probe' not described in 'device'

I'll fix it for the next version.

- Alex
