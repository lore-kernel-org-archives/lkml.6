Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC13C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD46423DEE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnKWo+Pe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD46423DEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752390AbeGBNKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752282AbeGBNKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:10:01 -0400
Received: from mail-yw0-f169.google.com (mail-yw0-f169.google.com [209.85.161.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C276E24025;
        Mon,  2 Jul 2018 13:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530537000;
        bh=LIPnhyWgTRyYbCxcYWExIVlJ+Hfjvphp1FrFuhUFPcE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=YnKWo+PeFZI7R2Syuf7aaAvsXuC3TBVrFDTYd8B34kHN84Mkh8PZ3xUtmN4cp2274
         vGZxOue3Uc66fZD6TydtAqiwEKQSZXM3Gg1cAZIfrAbx0J3BG41k2U+z/z0+QFK0d8
         kChHdhhsunO5gdIHXUG8xlNXKPevVazixnX+FmU4=
Received: by mail-yw0-f169.google.com with SMTP id l189-v6so241396ywb.10;
        Mon, 02 Jul 2018 06:10:00 -0700 (PDT)
X-Gm-Message-State: APt69E35trfyfNDk0XEwSisBcznZ5OccxJPpenZAOOgAPiQUealqaZsC
        +OWS0gr7Y1tC339HeN6d/q+i0he/FfTF/I4Xb9o=
X-Google-Smtp-Source: AAOMgpeUXmCaGd8GY+0g4JfLNrFAx5ZP9F5KmtvTSCzzjdAHa94ZXd+vpC2OrVox2IHTbknInS8rS7G9ym63C5f77DU=
X-Received: by 2002:a0d:e64f:: with SMTP id p76-v6mr4126658ywe.483.1530537000037;
 Mon, 02 Jul 2018 06:10:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:8182:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 06:09:19 -0700 (PDT)
In-Reply-To: <1530320016-24712-1-git-send-email-hao.wu@intel.com>
References: <1530320016-24712-1-git-send-email-hao.wu@intel.com>
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 2 Jul 2018 08:09:19 -0500
X-Gmail-Original-Message-ID: <CANk1AXQuEezWohY5-dWHSwtVBX7TmLhczUu09Sb8ctBvDpA4_Q@mail.gmail.com>
Message-ID: <CANk1AXQuEezWohY5-dWHSwtVBX7TmLhczUu09Sb8ctBvDpA4_Q@mail.gmail.com>
Subject: Re: [PATCH v7 00/29] FPGA Device Feature List (DFL) Device Drivers
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 7:53 PM, Wu Hao <hao.wu@intel.com> wrote:
> Hi All,
>
> Here is v7 patch-series adding drivers for FPGA DFL devices.

I've pushed this to a branch on my linux-fpga kernel.org git repo for
robots and humans to look at.  Branch name is
for-review-next-20180702-intel-fpga-v7

Alan
