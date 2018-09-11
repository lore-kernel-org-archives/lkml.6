Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F4BC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390EC20880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LXxYIWiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390EC20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeILCMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:12:41 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:59133 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbeILCMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:12:41 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 6b25c2c1;
        Tue, 11 Sep 2018 20:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=rsNyUsnt4voQvRR0zP0X+RMoemM=; b=LXxYIW
        iAJJTwoDAbgnEgKdw7TJ+cM2BIskzYwi2l4/wV3YkYeSDh3/e5fkYzqgDW8iYSlw
        +6YP/R+Am5/cUmIP/tETmtysA/9a6iQXD5YFMQ9/j0SDGQd4sVu01Ul+EWSdiRiN
        MgSoMhEJRzzxJ4uU3BmwBG81swmTioRXszXqv1PoQZgUeN8Bb4Lm+JyNM9jKBRY4
        avuitRjD+R19O4knsWdQA2Uq3JLERn32DoNwIBLwFRCBj1pl0MUZzRzQfSOwrbaj
        aXg1vJENdiYchjd2G1G7Nrj8UMAT0yjYFu+LNEygNz52EJvDnDnRRfN3Lbqp+Xpx
        DHz2KNvYZbu0y4KA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7cbd5aaa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 11 Sep 2018 20:54:47 +0000 (UTC)
Received: by mail-oi0-f44.google.com with SMTP id l82-v6so50043798oih.11;
        Tue, 11 Sep 2018 14:11:29 -0700 (PDT)
X-Gm-Message-State: APzg51BHSvyShk0ZnG09eEYaCN96YbhYlypJgpoCqpOUv8dKjBm9jWvp
        S/U+6YKKCFgK0Fq91KrVpVgy8KMPJgB6K1l7fHo=
X-Google-Smtp-Source: ANB0VdYME19b9BNww5WqC+SzQOieWW1LulkksQSRf/yezebd/QJsnINhYPEwCocUCTHErgCzeraLs2JxXVOCqPHoLpE=
X-Received: by 2002:aca:e795:: with SMTP id e143-v6mr29117182oih.252.1536700288812;
 Tue, 11 Sep 2018 14:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180911010838.8818-19-Jason@zx2c4.com> <201809112045.A5D7cAAW%fengguang.wu@intel.com>
In-Reply-To: <201809112045.A5D7cAAW%fengguang.wu@intel.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 11 Sep 2018 14:53:16 -0600
X-Gmail-Original-Message-ID: <CAHmME9rYrsXgZcQWKjxPjtmTFcv_v80RHA-r+duok4dh-NubXw@mail.gmail.com>
Message-ID: <CAHmME9rYrsXgZcQWKjxPjtmTFcv_v80RHA-r+duok4dh-NubXw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 17/17] net: WireGuard secure network tunnel
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi friendly kbuild test robot,

On Tue, Sep 11, 2018 at 7:02 AM kbuild test robot <lkp@intel.com> wrote:
> I love your patch! Yet something to improve:
>         make ARCH=um SUBARCH=i386

I've now fixed this problem and it will be in v4.

Regards,
Jason, a human
