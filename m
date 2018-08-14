Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B4AC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C2921728
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eFQ+CzCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C2921728
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbeHNWDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 18:03:46 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:39047 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbeHNWDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 18:03:46 -0400
Received: by mail-yw1-f73.google.com with SMTP id u1-v6so27376416ywg.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 12:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OcVjpyfKbvfYYspn9GJwv1hBKYcy6MEdocAVxG39MTc=;
        b=eFQ+CzCx6EJTWcT5+41BhtJfVnkKy0DESbnXoo+M8NFUiYTRNhFyaVYeQH4ma+tfYp
         WZ+XQsJ4ki2hy2zUTnyiAGQmAFdAjghc6nEfdY2mPe+7JL5MS1xVCFtktCg2GNTkm1zp
         aBaHmbk8VCv1lCIuXuUdMUSHAUe73QTaWMaVxk0bG0ua0lsLz+OPULss0TRMb3eZtnpw
         tLZjDDM7p2eKx7S51xTh1mektJTkGywzcehgen7k/5uGM4igxqdIIuMSWg70GSLCxY+M
         mJtSzBVVdRH/rSPaPs+v47Q5Wn/kaYUwNDquZ4BQ6xlDR+9XFRcEig9uICldbHS44/BU
         easA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OcVjpyfKbvfYYspn9GJwv1hBKYcy6MEdocAVxG39MTc=;
        b=aZHaO4wN9DpGahyCglcPdwt8tcmOFzNjXlNubH8PxwVx+HfNbgzd1G5foyfKVKi+BO
         BS9HmYHl+g9yhWtQEnGi0y+oz/J/+hiQ9AS0YC1Tt9Rm+5kbTRDO7+jBWyUcuuOo32yd
         yEJc0WE6LFm06LMxiFPTRsh6UdP9QAUcvmLtqOm7eTxYkstAwMz99Gjirl509ZCknnX7
         klGd9LITfR3u1lLtdpQqUPlXU1nR/JefUofoEeDWmWtnLsvntvuRupRWd2oyNvWqy3Zb
         dYDh8Qs6AiuPLG5rX7CyC+5ffC+YX/PJBtvsTvrJCJYlnGQEjt+gebqRCdkCLOkxNlP6
         vJmg==
X-Gm-Message-State: AOUpUlEKufOAtEV7BHX95+HgnDx2i06Qc31FCS7kje3CA6NW0LoFFXny
        y5w2bt79dvPFPZ5ptMCTzjU54fqIkWAu
X-Google-Smtp-Source: AA+uWPzTeddr1g3N2dj3ufnhSNQ8uL87bY3y84lMXbuTh9ahg+uvTSJT+KTgr3yFbmTnvMYL7grMCc4A3WwX
X-Received: by 2002:a81:2e17:: with SMTP id u23-v6mr6573248ywu.136.1534274109066;
 Tue, 14 Aug 2018 12:15:09 -0700 (PDT)
Date:   Tue, 14 Aug 2018 12:15:06 -0700
In-Reply-To: <20180814090752.1681486-1-arnd@arndb.de>
Message-Id: <xr93mutosqth.fsf@gthelen.svl.corp.google.com>
Mime-Version: 1.0
References: <20180814090752.1681486-1-arnd@arndb.de>
Subject: Re: [PATCH] rds: fix building with IPV6=m
From:   Greg Thelen <gthelen@google.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:

> When CONFIG_RDS_TCP is built-in and CONFIG_IPV6 is a loadable
> module, we get a link error agains the modular ipv6_chk_addr()
> function:
>
> net/rds/tcp.o: In function `rds_tcp_laddr_check':
> tcp.c:(.text+0x3b2): undefined reference to `ipv6_chk_addr'
>
> This adds back a dependency that forces RDS_TCP to also be
> a loadable module when IPV6 is one.
>
> Fixes: e65d4d96334e ("rds: Remove IPv6 dependency")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Greg Thelen <gthelenq@google.com>
