Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9AQMCKhYHlt4BgAAmS7hNA
	; Mon, 11 Jun 2018 11:12:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6DDA060792; Mon, 11 Jun 2018 11:12:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E3432601C3;
	Mon, 11 Jun 2018 11:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3432601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932892AbeFKLMs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 07:12:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40870 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932405AbeFKLMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:12:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C6426805A52F;
        Mon, 11 Jun 2018 11:12:45 +0000 (UTC)
Received: from gondolin (ovpn-117-32.ams2.redhat.com [10.36.117.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 572D1112D184;
        Mon, 11 Jun 2018 11:12:44 +0000 (UTC)
Date: Mon, 11 Jun 2018 13:12:41 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
        Dong Jia Shi <bjsdjshi@linux.ibm.com>
Subject: Re: [qemu-s390x] [PATCH RFC 2/2] vfio-ccw: support for halt/clear
 subchannel
Message-ID: <20180611131241.06100c12.cohuck@redhat.com>
In-Reply-To: <0c1e1b26-0c6a-fdc2-0c1a-2e2d58c2cb73@linux.ibm.com>
References: <20180509154822.23510-1-cohuck@redhat.com>
        <20180509154822.23510-3-cohuck@redhat.com>
        <c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
        <20180515181006.0cb1dfc2.cohuck@redhat.com>
        <a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
        <20180522145208.310143ea.cohuck@redhat.com>
        <4e4001cc-540e-0f2b-bbd1-1f82ca594bb3@linux.ibm.com>
        <20180605151449.22aafbfc.cohuck@redhat.com>
        <e73038ff-fb2d-5865-8b84-e775990f3983@linux.ibm.com>
        <20180606142131.74ea2eb7.cohuck@redhat.com>
        <5b77ec9c-41b8-2e32-ce79-d9005b93fdd0@linux.ibm.com>
        <20180607115442.6a779ed9.cohuck@redhat.com>
        <10c8a0ac-fe61-d7c7-c7bb-0fffc6909cb3@linux.ibm.com>
        <20180607183407.1ea5ab89.cohuck@redhat.com>
        <0c1e1b26-0c6a-fdc2-0c1a-2e2d58c2cb73@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 11 Jun 2018 11:12:45 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 11 Jun 2018 11:12:45 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jun 2018 22:40:39 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> Your welcome. The discussion is kind of taking place all over the
> place. I'm actively trying to find the best place to answer, and avoid
> overtalking topics -- but it does not seem to work. Please bear with me.

To help with this discussion (and with vfio-ccw design and development
in general), I've created
https://wiki.qemu.org/ToDo/Channel_I/O_Passthrough to collect some
things. Let me know if any of you folks still needs a wiki account.
