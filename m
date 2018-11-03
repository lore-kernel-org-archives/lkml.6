Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C127CC32789
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 02:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A54C20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 02:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHMrt50B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A54C20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeKCLMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 07:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbeKCLMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 07:12:00 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03FB02082D;
        Sat,  3 Nov 2018 02:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541210545;
        bh=0a5D2LnrcsBVeU9qajiI2KzSddOFUsT5VUmvodAlO+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qHMrt50B/n0xpTLQGHmVyk4Gobtsfls70TYJ0O9jYw8crqBlGiO0diACLEYGaeLoP
         BH50BEPDHJZl34Tg99Zv1Tet2MpzV9k74+psorWPWoqfQs/6y04BFyxVGG9qS0qAk4
         UkAWv3k25CiXsnzmJpr/5fZ+5nIPnMIEk7eUmTvk=
Date:   Fri, 2 Nov 2018 22:02:24 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, marcel.ziswiler@toradex.com,
        digetx@gmail.com, Rob Herring <robh@kernel.org>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH 4.14 069/143] ARM: tegra: Fix ULPI regression on Tegra20
Message-ID: <20181103020224.GK194472@sasha-vm>
References: <20181102182857.064326086@linuxfoundation.org>
 <20181102182902.797148907@linuxfoundation.org>
 <CADVatmOX9FfVGZhFgAZ1sVvnigucFD9DuUu+K8444mTN=Qr+6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CADVatmOX9FfVGZhFgAZ1sVvnigucFD9DuUu+K8444mTN=Qr+6w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 07:56:57PM +0000, Sudip Mukherjee wrote:
>Hi Greg,
>
>On Fri, Nov 2, 2018 at 6:53 PM Greg Kroah-Hartman
><gregkh@linuxfoundation.org> wrote:
>>
>> 4.14-stable review patch.  If anyone has any objections, please let me know.
>
>It seems this has already been reverted upstream:
>9bf4e370048d ("ARM: dts: tegra20: Revert "Fix ULPI regression on Tegra20"")

The commit log of 9bf4e370048d suggests that this issue was fixed
somewhere else which made 9bf4e370048d unnecessary. Can someone point to
that fix? If not, I'll just revert this commit.

--
Thanks,
Sasha
