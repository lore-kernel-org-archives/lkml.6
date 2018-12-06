Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C07C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA3F208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA3F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbeLFNor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:44:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727704AbeLFNoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:44:46 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D9D6D315485C;
        Thu,  6 Dec 2018 13:44:45 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-105.ams2.redhat.com [10.36.116.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B691D1001F5B;
        Thu,  6 Dec 2018 13:44:38 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     =?utf-8?Q?J=C3=BCrg?= Billeter <j@bitron.ch>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luto@kernel.org, arnd@arndb.de, serge@hallyn.com, jannh@google.com,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        dancol@google.com, timmurray@google.com, linux-man@vger.kernel.org,
        keescook@chromium.org, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH v4] signal: add taskfd_send_signal() syscall
References: <20181206121858.12215-1-christian@brauner.io>
        <87h8fq7s84.fsf@oldenburg2.str.redhat.com>
        <b0e946bcac12358841c9a99017da819b00794d9c.camel@bitron.ch>
        <87pnue6bp2.fsf@oldenburg2.str.redhat.com>
        <87efaun587.fsf@xmission.com>
Date:   Thu, 06 Dec 2018 14:44:36 +0100
In-Reply-To: <87efaun587.fsf@xmission.com> (Eric W. Biederman's message of
        "Thu, 06 Dec 2018 07:40:24 -0600")
Message-ID: <877egm6a7v.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 06 Dec 2018 13:44:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Eric W. Biederman:

> Floriam are you seeing a problem with this behavior or the way Christian
> was describing it?

My hope is that you could use taskfd_send_signal one day to send a
signal to a process which you *known* (based on how you've written your
application) should be running and not in a zombie state, and get back
an error if it has exited.

If you get this error, only then you wait on the process, using the file
descriptor you have, and run some recovery code.

Wouldn't that be a reasonable approach once we've got task descriptors?

Thanks,
Florian
