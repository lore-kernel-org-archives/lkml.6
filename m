Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36AFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B18420855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="CXCzduDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B18420855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mork.no
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbeKYV67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 16:58:59 -0500
Received: from canardo.mork.no ([148.122.252.1]:57975 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbeKYV67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 16:58:59 -0500
Received: from miraculix.mork.no (miraculix.mork.no [IPv6:2001:4641:0:2:7627:374e:db74:e353])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id wAPB7d18028721
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 25 Nov 2018 12:07:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1543144061; bh=n0DEOgC5VJU6Xd+bk9PoBYtQyU49tix3igGZic/sEsc=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=CXCzduDYmwdZy2ybmKbAVRCojuHkjKAwWeUf0h9Pswf09u3KE8krPNxOrBHAttV10
         ddJ3efQtLuqFNKM4iYyiMqeWO7q9EK3JJ7SKmY5e9qvYMoOotN+O7jpYgLcIu7FqHT
         erj09DtdKlnLBYeQocnixzb1h35gI9T3akENyYJU=
Received: from bjorn by miraculix.mork.no with local (Exim 4.89)
        (envelope-from <bjorn@mork.no>)
        id 1gQsGJ-00022n-Hv; Sun, 25 Nov 2018 12:07:39 +0100
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Josh Elsasser <jelsasser@appneta.com>
Cc:     intel-wired-lan@lists.osuosl.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ixgbe: recognize 1000BaseLX SFP modules as 1Gbps
Organization: m
References: <20181124205801.67828-1-jelsasser@appneta.com>
Date:   Sun, 25 Nov 2018 12:07:39 +0100
In-Reply-To: <20181124205801.67828-1-jelsasser@appneta.com> (Josh Elsasser's
        message of "Sat, 24 Nov 2018 12:57:33 -0800")
Message-ID: <87efb92z5w.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.100.2 at canardo
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Elsasser <jelsasser@appneta.com> writes:

> Fixes: 6a14ee0cfb19 ("ixgbe: Add X550 support function pointers")

Not that it matters much I guess, but I think LX SFPs were unsupported
at that time. The LX support appears to have been added under the radar
while refactoring ixgbe_setup_sfp_modules_X550em in commit e23f33367882
("ixgbe: Fix 1G and 10G link stability for X550EM_x SFP+")


Bj=C3=B8rn
