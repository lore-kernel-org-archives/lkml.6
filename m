Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694FFC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A0D2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A0D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbeIGS5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:57:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726033AbeIGS5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:57:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 828B240241F1;
        Fri,  7 Sep 2018 14:16:39 +0000 (UTC)
Received: from redhat.com (ovpn-124-199.rdu2.redhat.com [10.10.124.199])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3160F10FD2B7;
        Fri,  7 Sep 2018 14:16:39 +0000 (UTC)
Date:   Fri, 7 Sep 2018 10:16:38 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH net-next 06/11] tuntap: split out XDP logic
Message-ID: <20180907101606-mutt-send-email-mst@kernel.org>
References: <20180906040526.22518-1-jasowang@redhat.com>
 <20180906040526.22518-7-jasowang@redhat.com>
 <20180906131703-mutt-send-email-mst@kernel.org>
 <84ae17c1-f34b-610d-a5a1-ba8dce1732f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ae17c1-f34b-610d-a5a1-ba8dce1732f3@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 07 Sep 2018 14:16:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 07 Sep 2018 14:16:39 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 11:29:34AM +0800, Jason Wang wrote:
> > > +		if (act != XDP_PASS)
> > > +			goto out;
> > likely?
> 
> It depends on the XDP program, so I tend not to use it.

Point is XDP_PASS is already slow.

-- 
MST
