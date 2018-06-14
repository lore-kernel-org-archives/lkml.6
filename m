Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 28093C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 03:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D946E208B5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 03:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D946E208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936034AbeFNDhp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 23:37:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935870AbeFNDhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 23:37:43 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2B406C049D5C;
        Thu, 14 Jun 2018 03:37:43 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1716B20156A1;
        Thu, 14 Jun 2018 03:37:43 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id EE3444BB78;
        Thu, 14 Jun 2018 03:37:42 +0000 (UTC)
Date:   Wed, 13 Jun 2018 23:37:42 -0400 (EDT)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        CIFS <linux-cifs@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Aurelien Aptel <aaptel@suse.com>
Message-ID: <1114776191.8123837.1528947462817.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAH2r5msZ1Zi-MEqCE2eF-7Y50r=Kh4BUVYc6dwORC0iByJ+tBQ@mail.gmail.com>
References: <20180614090135.1d71babb@canb.auug.org.au> <CAH2r5msZ1Zi-MEqCE2eF-7Y50r=Kh4BUVYc6dwORC0iByJ+tBQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the cifs tree with Linus' tree
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.64.54.65, 10.4.195.27]
Thread-Topic: linux-next: manual merge of the cifs tree with Linus' tree
Thread-Index: TzbEhuxTjLQmwQw98+VJOoTrUGfz2g==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 14 Jun 2018 03:37:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steve,

Looks good. It builds and seems to work in my testing.
Thanks.

----- Original Message -----
From: "Steve French" <smfrench@gmail.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Cc: "CIFS" <linux-cifs@vger.kernel.org>, "Linux-Next Mailing List" <linux-next@vger.kernel.org>, "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, "Kees Cook" <keescook@chromium.org>, "Ronnie Sahlberg" <lsahlber@redhat.com>, "Aurelien Aptel" <aaptel@suse.com>
Sent: Thursday, 14 June, 2018 10:40:43 AM
Subject: Re: linux-next: manual merge of the cifs tree with Linus' tree

Ronnie,

I fixed up that patch and repushed to cifs-2.6.git for-next.  Seems
trivial. Let me know if any issues.

On Wed, Jun 13, 2018 at 6:01 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Today's linux-next merge of the cifs tree got a conflict in:
>
>   fs/cifs/transport.c
>
> between commit:
>
>   6da2ec56059c ("treewide: kmalloc() -> kmalloc_array()")
>
> from Linus' tree and commit:
>
>   1560d69e21c6 ("cifs: push rfc1002 generation down the stack")
>
> from the cifs tree.
>
> I fixed it up (the latter removed the code modified by the former) and
> can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-cifs" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
