Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C767C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCE62077C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCE62077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbeJIVRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:17:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbeJIVRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:17:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 179C4307D853;
        Tue,  9 Oct 2018 14:00:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CEBB7A5CE;
        Tue,  9 Oct 2018 14:00:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <153903885366.17944.9795992149237942599.stgit@warthog.procyon.org.uk>
References: <153903885366.17944.9795992149237942599.stgit@warthog.procyon.org.uk> <153903883882.17944.17642727588248415623.stgit@warthog.procyon.org.uk>
To:     eric.dumazet@gmail.com
Cc:     dhowells@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 02/10] rxrpc: Fix the data_ready handler
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29327.1539093628.1@warthog.procyon.org.uk>
Date:   Tue, 09 Oct 2018 15:00:28 +0100
Message-ID: <29328.1539093628@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 09 Oct 2018 14:00:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

Note that although the loop you objected to is still here in this patch, it's
discarded entirely in patch 3.  I've kept the patches 2 and 10 separate since
they fix separate bugs, and 3 works around some of those in 2 entirely, but if
you want I should be able to push 2, 3 and 10 to the end and I could also
merge them, if that would help.

David
