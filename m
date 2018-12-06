Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C194BC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B82214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B82214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbeLFMa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:30:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727996AbeLFMa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:30:28 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1785489AD0;
        Thu,  6 Dec 2018 12:30:28 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-105.ams2.redhat.com [10.36.116.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E63C55D9D6;
        Thu,  6 Dec 2018 12:30:20 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luto@kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        serge@hallyn.com, jannh@google.com, akpm@linux-foundation.org,
        oleg@redhat.com, cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, dancol@google.com,
        timmurray@google.com, linux-man@vger.kernel.org,
        keescook@chromium.org, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH v4] signal: add taskfd_send_signal() syscall
References: <20181206121858.12215-1-christian@brauner.io>
Date:   Thu, 06 Dec 2018 13:30:19 +0100
In-Reply-To: <20181206121858.12215-1-christian@brauner.io> (Christian
        Brauner's message of "Thu, 6 Dec 2018 13:18:58 +0100")
Message-ID: <87h8fq7s84.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 06 Dec 2018 12:30:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Christian Brauner:

> /* zombies */
> Zombies can be signaled just as any other process. No special error will be
> reported since a zombie state is an unreliable state (cf. [3]).

I still disagree with this analysis.  If I know that the target process
is still alive, and it is not, this is a persistent error condition
which can be reliably reported.  Given that someone might send SIGKILL
to the process behind my back, detecting this error condition could be
useful.

Rest looks good to me (with the usual caveats).

Thanks,
Florian
