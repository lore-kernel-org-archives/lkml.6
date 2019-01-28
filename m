Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB56C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C332171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfA1LSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:18:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfA1LSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:18:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 56AAA88E4F;
        Mon, 28 Jan 2019 11:18:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.163])
        by smtp.corp.redhat.com (Postfix) with SMTP id EECCB51F3A;
        Mon, 28 Jan 2019 11:18:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 28 Jan 2019 12:18:23 +0100 (CET)
Date:   Mon, 28 Jan 2019 12:18:19 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Vladis Dronov <vdronov@redhat.com>, Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "3.8+" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] HID: debug: fix the ring buffer implementation
Message-ID: <20190128111818.GA22143@redhat.com>
References: <20190126170722.8035-1-vdronov@redhat.com>
 <CAO-hwJJGux_5bQJmXgLrcj+v=n3n8hvqXfqPEu60aghYNJSfzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-hwJJGux_5bQJmXgLrcj+v=n3n8hvqXfqPEu60aghYNJSfzw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 28 Jan 2019 11:18:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/28, Benjamin Tissoires wrote:
>
> Oleg, can you provide some feedback before I push this?

Looks good to me, feel free to add

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

> > +               set_current_state(TASK_RUNNING);

I still think that

		    __set_current_state(TASK_RUNNING);

will look a bit better, but this is really minor.

Oleg.

