Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29DEC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC20206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC20206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbeILBRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:17:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58486 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726720AbeILBRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:17:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 868BA7DAC2;
        Tue, 11 Sep 2018 20:16:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C6B32166BA3;
        Tue, 11 Sep 2018 20:16:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CACT4Y+ajxhUaRg+XSuqQZN8rD96S820yMTWx2GpRVRb9Maz50g@mail.gmail.com>
References: <CACT4Y+ajxhUaRg+XSuqQZN8rD96S820yMTWx2GpRVRb9Maz50g@mail.gmail.com> <0000000000006082bd05752f92bb@google.com> <29979.1536223287@warthog.procyon.org.uk>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     dhowells@redhat.com,
        syzbot <syzbot+762a577f56cfb1574647@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Levin, Alexander" <alexander.levin@verizon.com>,
        LKML <linux-kernel@vger.kernel.org>, linux@dominikbrodowski.net,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        nikolaus.voss@loewensteinmedical.de,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: linux-next boot error (2)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23631.1536696987.1@warthog.procyon.org.uk>
Date:   Tue, 11 Sep 2018 21:16:27 +0100
Message-ID: <23632.1536696987@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 11 Sep 2018 20:16:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 11 Sep 2018 20:16:29 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrei Vagin spotted a missing change to apparmor:
apparmor_fs_context_parse_param() needs to return -ENOPARAM, not 0.

David
