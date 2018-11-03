Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66DCC32789
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 02:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C82720833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 02:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBpfkCAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C82720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbeKCLJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 07:09:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbeKCLJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 07:09:35 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AF502082D;
        Sat,  3 Nov 2018 02:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541210400;
        bh=G2Ls3GCgU3sipY7+nwNxvbv/yAvPj8Z/T9bZNvYsL8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GBpfkCAGuAk8Y5QKXEcR7nis7kLcu2haAwr8KUAWPMXw0dfdvVT1CgZC3D33eO521
         eRXKKV+NP1wWLbg+w60ADPP2kzV1+7sC7ozNN+hd8Yl2L0rQFHp/BxdBxATIi4QluS
         ygxQYtArsh5pD3ZOlkh851fl4onj+M765OrM1YYU=
Date:   Fri, 2 Nov 2018 21:59:59 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, israelr@mellanox.com,
        maxg@mellanox.com, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 4.14 060/143] net/mlx5: Fix mlx5_get_vector_affinity
 function
Message-ID: <20181103015959.GJ194472@sasha-vm>
References: <20181102182857.064326086@linuxfoundation.org>
 <20181102182901.906765329@linuxfoundation.org>
 <CADVatmPo5-ehCRKP_i+5M0hoJNGF-JNKTTPdR+HEd-GKfRi60A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CADVatmPo5-ehCRKP_i+5M0hoJNGF-JNKTTPdR+HEd-GKfRi60A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 07:59:39PM +0000, Sudip Mukherjee wrote:
>Hi Greg,
>
>On Fri, Nov 2, 2018 at 6:52 PM Greg Kroah-Hartman
><gregkh@linuxfoundation.org> wrote:
>>
>> 4.14-stable review patch.  If anyone has any objections, please let me know.
>
>There is another upstream patch which fixes this one.
>e3ca34880652 ("net/mlx5: Fix build break when CONFIG_SMP=n")

I've queued the fix, thank you!

--
Thanks,
Sasha
