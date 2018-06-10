Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id HG4gLLSzHFu4JQAAmS7hNA
	; Sun, 10 Jun 2018 05:14:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 883FC60795; Sun, 10 Jun 2018 05:14:28 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="YvHCDTvk"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A06756074D;
	Sun, 10 Jun 2018 05:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A06756074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753707AbeFJFOX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 01:14:23 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:43728 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753529AbeFJFOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 01:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VEATabDMIveFi8k9HprtUk61xp7OPIOwzHaa5//qwQ4=; b=YvHCDTvkdZkFSlb9Rnqh2MyU1K
        o3dLb+iy1rPnSla6smzy6+uYveCyxvftXysMh+kN5C6eWr66mDtZZRrkxT26UVhqtio8jaHAEe6aC
        C+DC7PK/Hi5X9PIJbxhAHGWtGMy3XJpv1iiNBc/Oyo9H0eFO57fTWDDhr7/Mpone/ot34FKbc5niE
        LMGJsUsJ/7vqmZndBYO6sL5GCkk3I7ZtRvnmMKV02xppjL7MRTCTyS+XbdMv0zFtUhkthdFJ39Gtz
        sVFaPMZRTNRnxqOUi90D3SHKMjCBJm6be9UQ13Ve69bmfzuf/83g/xIp65IB3obg6tTw33qEmy4hV
        8kmnx3BQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54612 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fRsgH-00Fumz-Bz; Sun, 10 Jun 2018 05:14:21 +0000
Date: Sat, 9 Jun 2018 22:14:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Chris Ouellet <rabbit.of.war@gmail.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Ryzen 2700 Temperature offset?
Message-ID: <20180610051420.GA22601@roeck-us.net>
References: <C85830A6-BCC7-4137-84E5-38503873F278@canonical.com>
 <20180607154915.GA7061@roeck-us.net>
 <54EAD835-C48D-4751-9BFF-71536241129A@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54EAD835-C48D-4751-9BFF-71536241129A@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 03:03:47AM +0800, Kai-Heng Feng wrote:
> at 23:49, Guenter Roeck <linux@roeck-us.net> wrote:
> 
> >On Thu, Jun 07, 2018 at 11:03:13AM +0800, Kai Heng Feng wrote:
> >>Hi Guenter,
> >>
> >>A user thinks the Ryzen 2700 temperature may not be correct [1].
> >>Can you take a look when you have time? Thanks.
> >>
> >>Also, where can I find all these temperature offsets? I googled but with
> >>no
> >>result.
> >Problem is that the offsets are not documented in public, making it
> >difficult to find out. For Ryzen 2700, there is currently no offset
> >configured; I was told that there is none. For Ryzen 2700X, the offset
> >is 10 degrees C.
> 
> I am still quite interesting where you get this information...
> 
Primarily lots of online research. Windows tools usually support the
offsets, so screendumps help in some cases. 

> >
> >>[1] https://bugs.launchpad.net/bugs/1774817
> >
> >The key here is the commit mentioned in the log (1b59788979acd). It does
> >not only adjust the per-CPU offset, but also takes a configurable offset
> >of 49 degrees C into account. You'll need to apply that patch in your
> >kernel, or the temperature may be off by 49 degrees C.
> 
> So unless AMD shares these offsets value, we can never know what correct
> offsets are?
> 
Unfortunately that is correct.

AFAIK the information is available from AMD under NDA. I can not sign such an
NDA, and even if I could and would, I could not use the information in an open
source driver. Kind of a loose-loose situation. If you (Canonical) have any
influence at AMD, it might be useful to let them know that their policy is
not very helpful.

Guenter


> Kai-Heng
> 
> >
> >Hope this helps. If not, please let me know. Note that I am travelling;
> >responses may be delayed.
> >
> >Guenter
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-hwmon" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
