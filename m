Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5E3C04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B4920882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B4920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeILGFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 02:05:12 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:53774 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbeILGFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 02:05:12 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fztYo-0006TB-1N; Wed, 12 Sep 2018 02:03:14 +0100
Message-ID: <1536714193.3024.184.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 34/80] enic: handle mtu change for vf properly
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org,
        Govindarajulu Varadarajan <gvaradar@cisco.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Date:   Wed, 12 Sep 2018 02:03:13 +0100
In-Reply-To: <20180903164935.510879136@linuxfoundation.org>
References: <20180903164934.171677301@linuxfoundation.org>
         <20180903164935.510879136@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-03 at 18:49 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Govindarajulu Varadarajan <gvaradar@cisco.com>
> 
> [ Upstream commit ab123fe071c9aa9680ecd62eb080eb26cff4892c ]
> 
> When driver gets notification for mtu change, driver does not handle it for
> all RQs. It handles only RQ[0].
> 
> Fix is to use enic_change_mtu() interface to change mtu for vf.
[...]

This causes a assertion failure (noisy error logging, but not an oops)
when the driver is probed.  This was fixed upstream by:

commit cb5c6568867325f9905e80c96531d963bec8e5ea
Author: Govindarajulu Varadarajan <gvaradar@cisco.com>
Date:   Mon Jul 30 09:56:54 2018 -0700

    enic: do not call enic_change_mtu in enic_probe

which is now needed on the 3.18, 4.4, and 4.9 stable branches.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
