Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E3BC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C041D2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="ez/yAiQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C041D2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeLNDdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 22:33:13 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:34713 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeLNDdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 22:33:13 -0500
Received: by mail-ed1-f41.google.com with SMTP id b3so3839176ede.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 19:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=DYgY1y6LrJpp2taKM76NbqUzROVSq2xolGrGRVBYKbU=;
        b=ez/yAiQdAU0nd1bbP+cp23ZQX6ig4U4OR3GT0osDic8ZVVeZ30t10CYTH39bjrHEY8
         +zL6xRr3c6EVAqURELyWtZrThzPeVjm9KDHtJW2/jCTloBvAnvsGnSxCRTDkHzt2+p4b
         W6KpZZW1Wt7pZSK42lwLbEWehilQ3pgjxSZmI1v4LhhCvqc8b2OZxoRpwl5rXEfSE99T
         7kdrYhR4iwMELyfFAbZKweiPSe64NpbnQcordfUwCXYXY7RfLt4aVtoOuOPx7DYCJNUs
         0rLX+/QWQwAmam7IPPBixOGDNqv73wNKaGZP+tlkplRJ+NtbsQ1TclY2WuZxwb07H2M3
         btqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=DYgY1y6LrJpp2taKM76NbqUzROVSq2xolGrGRVBYKbU=;
        b=nqqyaNsX2zBLHYH5sgJDN7cd9cccL+oeXjH5j3UWxD+csjHPisHjvozRClzPNMw2uQ
         t9vELP+PSsfdaS1QyELGgCClNGpOtFNkZLFppnnf3ZTtoZTrDBzg7qPXuGcFIOU2GnSz
         5TMFvAGREF5vZTF/b7miGVH8aqCRTNAB+LeWMWMMTG8HSxvvcUbX+WVCt+mnlkkczJcP
         DwTkKvc9gYUZBiR7mdi4thCre3fqy8+POG8JEUoslRE0OJ6RuIoxwiZOHWVWzHakVE3X
         jpQbbECgzDCn3aWlHOxTh/DVxevxBI8UTgUAwjFxrO17UOGux2RoX9743Y2sn7S6xIdg
         F/VA==
X-Gm-Message-State: AA+aEWbualO3ka6JXLEOdFj/0WED6hFbyDiFYCrLPMUaPH3gL5rdLKLL
        UIZHe6k1jm1oxr1AGLYJWRM5ypqVW/IrdXBBHPD+nDO8
X-Google-Smtp-Source: AFSGD/U/CfDoyNoTamMWGBdM1H79//0Qc/imQ1SAc7d9REGVSGhHxhtNHSvK22c5w3yhPJSWYOne46AiufHjcJtE/Sw=
X-Received: by 2002:a50:c315:: with SMTP id a21mr1554238edb.160.1544758391706;
 Thu, 13 Dec 2018 19:33:11 -0800 (PST)
MIME-Version: 1.0
References: <CAB4CAwfH156yEd-XAkt==u+S8bO0U2=sg8nVr4o57C1q3K97Kw@mail.gmail.com>
In-Reply-To: <CAB4CAwfH156yEd-XAkt==u+S8bO0U2=sg8nVr4o57C1q3K97Kw@mail.gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Fri, 14 Dec 2018 11:33:00 +0800
Message-ID: <CAB4CAwc4ubdXn7kzPeu2L--ciATgZWYkO350fvFF43-jj180xw@mail.gmail.com>
Subject: Re: A weird problem of Realtek r8168 after resume from S3
To:     nic_swsd <nic_swsd@realtek.com>, davem@davemloft.net,
        netdev@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 10:20 AM Chris Chiu <chiu@endlessm.com> wrote:
>
> Hi,
>     We got an acer laptop which has a problem with ethernet networking after
> resuming from S3. The ethernet is popular realtek r8168. The lspci shows as
> follows.
> 02:00.1 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 12)
>
>     The problem is the ethernet is not accessible after resume. Pinging via
> ethernet always shows the response `Destination Host Unreachable`. However,
> the interesting part is, when I run tcpdump to monitor the problematic ethernet
> interface, the networking is back to alive. But it's dead again after
> I stop tcpdump.
> One more thing, if I ping the problematic machine from others, it achieves the
> same effect as above tcpdump. Maybe it's about the register setting for RX path?
>
>     I tried the latest 4.20 rc version but the problem still there. I
> also tried some
> hw_reset or init thing in the resume path but no effect. Any
> suggestion for this?
> Thanks
>
> Chris

Gentle ping. Any additional information required?

Chris
