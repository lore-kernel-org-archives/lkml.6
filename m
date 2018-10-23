Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74668C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CCE20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CCE20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbeJXAuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:50:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:41242 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727746AbeJXAuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:50:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D5BAEAD38;
        Tue, 23 Oct 2018 16:26:14 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 07EECE0093; Tue, 23 Oct 2018 18:26:14 +0200 (CEST)
Date:   Tue, 23 Oct 2018 18:26:14 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Mahesh Bandewar
         =?utf-8?B?KOCkruCkueClh+CktiDgpKzgpILgpKHgpYfgpLXgpL4=?=
         =?utf-8?B?4KSwKQ==?= <maheshb@google.com>, mk.singh@oracle.com,
        linux-netdev <netdev@vger.kernel.org>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bonding:avoid repeated display of same link status change
Message-ID: <20181023162613.GA22291@unicorn.suse.cz>
References: <20181023152924.24033-1-mk.singh@oracle.com>
 <CAF2d9jjM+5twGtwnB-JvOaaFbU9-n1oNyMXF6wx=s-0fVn9-6w@mail.gmail.com>
 <65f98009-1ce0-d6fd-06dc-233aa115abc9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65f98009-1ce0-d6fd-06dc-233aa115abc9@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 09:10:44AM -0700, Eric Dumazet wrote:
> 
> 
> On 10/23/2018 08:54 AM, Mahesh Bandewar (महेश बंडेवार) wrote:
> 
> > Atomic operations are expensive (on certain architectures) and miimon
> > runs quite frequently. Is the added cost of these atomic operations
> > even worth just to avoid *duplicate info* messages? This seems like a
> > overkill!
> 
> atomic_read() is a simple read, no atomic operation involved.
> 
> Same remark for atomic_set()

Which makes me wonder if the patch really needs atomic_t.

Michal Kubecek
