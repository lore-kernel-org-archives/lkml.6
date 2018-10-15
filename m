Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022C4C71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67EF2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="DPPbqanN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67EF2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mork.no
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeJOUdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:33:41 -0400
Received: from canardo.mork.no ([148.122.252.1]:57913 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbeJOUdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:33:41 -0400
Received: from miraculix.mork.no ([IPv6:2a02:2121:2c7:70e5:c8fa:53ff:fe7c:53d8])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id w9FCmCYW024287
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 15 Oct 2018 14:48:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1539607694; bh=+qzCWwwjFNSVHyH2HitQ0ucenqmwM+Q4JD6uedsWU1s=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=DPPbqanN0tns6J3Sr+DSCOrhqMApAY6+U5awPq27ksC2yBZ19/VZW3U8mcNJzsc1h
         7QK0EAHC4K50l6btObXE4vAoGuCE16sbBBjgoiDihaFp9jcavStn+4lsE8S1UgTWL+
         rz6xDrisnOrKx0ywBiA4OF9wkm5w2DqAymNzjhkY=
Received: from bjorn by miraculix.mork.no with local (Exim 4.89)
        (envelope-from <bjorn@mork.no>)
        id 1gC2I3-0006VN-Cb; Mon, 15 Oct 2018 14:48:07 +0200
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     netdev@vger.kernel.org, oneukum@suse.com, davem@davemloft.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk
Subject: Re: [PATCH 2/8] usbnet: smsc95xx: add kconfig for turbo mode
Organization: m
References: <20181012083405.19246-1-ben.dooks@codethink.co.uk>
        <20181012083405.19246-3-ben.dooks@codethink.co.uk>
Date:   Mon, 15 Oct 2018 14:48:05 +0200
In-Reply-To: <20181012083405.19246-3-ben.dooks@codethink.co.uk> (Ben Dooks's
        message of "Fri, 12 Oct 2018 09:33:59 +0100")
Message-ID: <87d0sbz88q.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.100.1 at canardo
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Dooks <ben.dooks@codethink.co.uk> writes:

> Add a configuration option for the default state of turbo mode
> on the smsc95xx networking driver. Some systems it is better
> to default this to off as it causes significant increases in
> soft-irq load.


So there is already a module option allowing you to change this, using
e.g kernel command line or kmod config files.  It's even writable,
taking effect on the next netdev open, so you can change it at runtime
without reloading the module.

What good does this new build-time setting do, except causing confusion
wrt driver defaults?

Note also that the smsc95xx and smsc75xx drivers are pretty similar.
Both have the same turbo_mode setting.  If you change the defaults, then
they should at least be kept in sync to cause as little confusion as
possible..




Bj=C3=B8rn
