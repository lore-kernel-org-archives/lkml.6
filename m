Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6930DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28761208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28761208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbeGaOk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:40:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732080AbeGaOkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:40:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0E8A4021700;
        Tue, 31 Jul 2018 13:00:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6396E2142F20;
        Tue, 31 Jul 2018 13:00:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180731122801.GA14972@amd>
References: <20180731122801.GA14972@amd> <CA+55aFwY1nQ0LG8CeC8chugWO40kOGKpovBOadpGOOMBinNhbg@mail.gmail.com> <20180730183847.GB5544@bombadil.infradead.org> <CA+55aFzpisX0+T_ipwUdOCXY+tkhe2Ao3KDZxx+UPpguVmirnQ@mail.gmail.com> <20180730194938.GA12962@bombadil.infradead.org> <20180730210209.GY21725@thunk.org> <20180730235849.GA19692@bombadil.infradead.org> <20180731005802.GB21725@thunk.org> <18974.1533031913@warthog.procyon.org.uk> <20180731113422.GA22939@amd> <20180731120752.GA23378@bombadil.infradead.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 36/38] vfs: Add a sample program for the new mount API [ver #10]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4950.1533042037.1@warthog.procyon.org.uk>
Date:   Tue, 31 Jul 2018 14:00:37 +0100
Message-ID: <4951.1533042037@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 31 Jul 2018 13:00:41 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 31 Jul 2018 13:00:41 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:

> Regexes do not work in presence of arbitrary strings in the
> message. If we had a way to tell start / end of string inserted in the
> message, yes, the problem would be solved.

You could use quotes around arbitrary insertions, ie. you always do '%s'
inside the kernel if %s doesn't correspond to a specific set of text
constants.

David
