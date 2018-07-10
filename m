Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8305C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C01208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C01208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732488AbeGJVNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 17:13:49 -0400
Received: from ms.lwn.net ([45.79.88.28]:35436 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732272AbeGJVNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 17:13:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A912E7DA;
        Tue, 10 Jul 2018 21:07:24 +0000 (UTC)
Date:   Tue, 10 Jul 2018 15:07:21 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Prashant Dhamdhere <pdhamdhe@redhat.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: admin-guide: Adding sysrq-key
 combination for System Z/S390 arch.
Message-ID: <20180710150721.7c189cb6@lwn.net>
In-Reply-To: <CAF1GLk=4==8GY22uT8_SXBj=jd6GfW4rTq7FPvU9uVhOG2j3GQ@mail.gmail.com>
References: <CAF1GLk=4==8GY22uT8_SXBj=jd6GfW4rTq7FPvU9uVhOG2j3GQ@mail.gmail.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018 23:04:47 +0530
Prashant Dhamdhere <pdhamdhe@redhat.com> wrote:

> Signed-off-by: Prashant Dhamdhere <pdhamdhe@redhat.com>

Thanks for working to improve the docs.  I do have some requests, though,
starting with: please provide a changelog for all of your patches.

> ---
>  Documentation/admin-guide/sysrq.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/admin-guide/sysrq.rst
> b/Documentation/admin-guide/sysrq.rst
> index 7b9035c01a2e..21deab9e542c 100644
> --- a/Documentation/admin-guide/sysrq.rst
> +++ b/Documentation/admin-guide/sysrq.rst
> @@ -68,6 +68,11 @@ On PowerPC
>         Press :kbd:`ALT - Print Screen` (or :kbd:`F13`) - :kbd:`<command
> key>`,  
>          :kbd:`Print Screen` (or :kbd:`F13`) - :kbd:`<command key>` may
> suffice.
> 
> +On System Z - Press 'CTRL-O-<command key>' on the hvc0 console.'CTRL-O'
> means
> +              pressing 'O' (not zero) while holding down the 'CTRL' key.

This patch has been line-wrapped by your mailer.  Please email a patch to
yourself and be sure that you can apply it before trying again.  You can
check Documentation/process/email-clients.rst for information on taming
email clients.

Also, please put spaces after periods.

Readers of this document will know what "CTRL-O" (or "^O") means, that does
not need to be spelled out.

> For
> +              3270 console or line-mode HMC console: Pass '^-<command key>'
> +              Here, '^-' means cap and dash characters.

This, though, is rather less clear.  What does "pass" mean in this context?
We all know what ^ and - are.  But what do we do with them?  Just type them
in sequence?  If so, please say so.  Do they have to be after a newline or
anything like that?

> +
>  On other
>         If you know of the key combos for other architectures, please
>          let me know so I can add them to this section.

Also, please format the docs with "make htmldocs" or the like and make sure
the right thing happens with your changes.

Thanks,

jon
