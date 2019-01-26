Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09611C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DEB218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfAZPom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 10:44:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbfAZPol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 10:44:41 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A2A3A0C27;
        Sat, 26 Jan 2019 15:44:41 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A15E17D40;
        Sat, 26 Jan 2019 15:44:41 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 5C0C441091;
        Sat, 26 Jan 2019 15:44:41 +0000 (UTC)
Date:   Sat, 26 Jan 2019 10:44:41 -0500 (EST)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Oleg Nesterov <oleg@redhat.com>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Message-ID: <1280032330.67094297.1548517481057.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190125130113.GA18589@redhat.com>
References: <20190125095744.3813-1-vdronov@redhat.com> <20190125130113.GA18589@redhat.com>
Subject: Re: [PATCH] HID: debug: fix the ring buffer implementation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.5.180, 10.4.195.19]
Thread-Topic: debug: fix the ring buffer implementation
Thread-Index: /hrE0E972A0RHSyTc+8mUa3jgrYh6g==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sat, 26 Jan 2019 15:44:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Oleg, all,

Thanks much, Oleg, these are really valuable additions:

> suspicious ;) if you add a comment the patch will be even better.

Great, will do.

> perhaps it make sense to move this check into the "if (kfifo_is_empty())"
> block.

Indeed, otherwise it kinda breaks the execution logic.

> is kfifo_is_empty() == T really possible here?

It looks like it is not. Reads are guarded by read_mutex and the only other
code which touches hid_debug_fifo is writer.

I will post v2 here soon. Lets see if it is ready for inclusion.

Best regards,
Vladis Dronov | Red Hat, Inc. | Product Security | Senior Software Engineer
