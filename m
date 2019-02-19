Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5EDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A879217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zprfjkai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfBSFiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 00:38:00 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54504 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfBSFh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 00:37:59 -0500
Received: by mail-it1-f194.google.com with SMTP id f10so3384456ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 21:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1pV9lXDp01muHyAVZEjup76eYxXHTzAQfEtdRGAZvFk=;
        b=ZprfjkaiBZHTnA2NKYMXf6jQrPLBGFzHse+YKQB661zPyUMtpdhUNT9FS/By4vWA/H
         TZ//xmR35t0XrJLq/BQPfvMU+Sb7+aprWMSDpazjloxXBxhU9+Ljo6ecfzQoesd24TtD
         eNW6NAJGBYoDGGZl2+lll5XnsUvCu5QLVCsxSF6LpUlb2AEUjEATE1RWR1Rhl1/WkVBR
         Ht5pGHc3dvDmjzD2jxQmGZP+ntoI5Ioz1D50aUkCSs0ejDkCZvXdAukTQYD1gitxL64y
         LzXjVtjpYnDT4kv8wj1Kirxqw7rbDRdtIwseFvi1Cd6H73mraalDFyteNl5sd/HNfLhW
         4k1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1pV9lXDp01muHyAVZEjup76eYxXHTzAQfEtdRGAZvFk=;
        b=pyLi/mng5E22gnCCGQ+L6GpV8ortTwfDNhB1sN9/iuzuA5oaHKBCvDlhjtQRJmNmcJ
         46+8uutu6dsW1gCEUzjKZkSx+1OXU81rqvzcj+xIX+RI2i/2azyCVduQjQxou9DI26Xn
         UwMdP69Oz6zPf9nZmMp42gJSYPMiN27Oaw/4FodNlxgPYkaCBQS2oBj33hcqrx0csCGd
         nHkn+KQTc3Sluz69QvxB6CWcft2GefFugA0/5/zAr1lRwAvLlQnXpkRRR1+53S7BwR3a
         XNBBpl9njhEo1up4JMPeXMIuYx6iFrKmryaXjNB6Ns3bxqrOKfiQN3jUw30AI3gS+6n1
         rT7Q==
X-Gm-Message-State: AHQUAuZq+mg8E78g5VxGrhK2hBxQMgIkA9AuH5kbowArjpTM/weShjwt
        ysHJHTyHv6WQwbpX8j6Qybb/IO8nlWQ=
X-Google-Smtp-Source: AHgI3Ia62qwZ20XgPLNsFo0dE4plKVSJkyMP5rBodIYuYJXJxk7wziSoO6rzwp1evD1MecUGzmkr7w==
X-Received: by 2002:a02:1cca:: with SMTP id c193mr14764025jac.17.1550554678394;
        Mon, 18 Feb 2019 21:37:58 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id f13sm6405476iol.82.2019.02.18.21.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 21:37:57 -0800 (PST)
Date:   Tue, 19 Feb 2019 00:37:54 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Drivers: hv: vmbus: Fix sysfs functions that display
 monitor id and page data
Message-ID: <cover.1550549612.git.kimbrownkd@gmail.com>
References: <cover.1549619051.git.kimbrownkd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549619051.git.kimbrownkd@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the monitor id and monitor page data sysfs files display
incorrect data. This patchset provides the following changes:

1) Change the monitor_pages index in server_monitor_pending_show() to
'0', which is the correct index for the server.

2) If monitor pages are not allocated to a channel, return -EINVAL when
the channel's monitor id and monitor page data sysfs files are opened.
The data that is currently shown in sysfs is incorrect.

Changes in v2:

Patch 1: "Change server monitor_pages index to 0"
 - Added the "Acked-by" line received for v1.

Patch 2: "Return -EINVAL if monitor_allocated not set"
 - Changed the return value for cases where monitor_allocated is not set
   to "-EINVAL" as suggested by S. Hemminger.
 - Updated the commit message to provide more details about the monitor
   page mechanism as suggested by S. Hemminger.
 - Updated the sysfs documentation to describe the new return value.


Kimberly Brown (2):
  Drivers: hv: vmbus: Change server monitor_pages index to 0
  Drivers: hv: vmbus: Return -EINVAL if monitor_allocated not set

 Documentation/ABI/stable/sysfs-bus-vmbus | 15 +++++++--
 drivers/hv/vmbus_drv.c                   | 39 +++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 4 deletions(-)

-- 
2.17.1

