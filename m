Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDC1C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 00:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3216B25398
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 00:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPalcSyP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3216B25398
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752305AbeFYAwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 20:52:54 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32781 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751979AbeFYAww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 20:52:52 -0400
Received: by mail-pf0-f194.google.com with SMTP id b17-v6so5642475pfi.0;
        Sun, 24 Jun 2018 17:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zTaiXmolGUlWYYbUELJ5DSwnRuznK/vgrgbC62AVoeI=;
        b=YPalcSyPGz5mT2wIdSQZnEsXi0/RPfF5G78uvUSdZuyYirrL9h9OyeAikCBgxRt97P
         zJNfyRF8YBlhDfSMGtYgSXtnjCRsmDHL+H6V0ChwLG2bIF+7lsyiGUOVkho6jfDhOzNN
         olp7Ccm4iSQymjGI9MOp+Ol0Z4aemn4RTSVWCUaq5TPkchRYjv4yVymEsfA4QH7Vmeqh
         ls9MPAJgc5b0n1gS+06fNHylACdtgN6vVgK93vTQ4/i9nP3tQGlzRKtIqEBlQjR/lIri
         y4qmSWsjHbr1mX1cLxnN2YCUMwaenqgC9LTtmhwI15js7kUH/1ZKe6WSD3Gm3z/LXwY2
         4m9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zTaiXmolGUlWYYbUELJ5DSwnRuznK/vgrgbC62AVoeI=;
        b=j6xNwHLJsKayUjvAO/O+GTe9Im3/g7oScC87P3cY75SMBfq3kEz5Dg/z5unVfnFLWZ
         JTaDSW3yKCDcdEFz54DB5/zrCYR9kd4mJOmtiLMaksg39n7wihN797ZqjMFwBAK/ZJIm
         DBJ+dTHviS/dehBuP80OcRI/Fz/BwRcWXpQwRevK7KUOmmu9B/PY1r/t8gY7oqxeRYIU
         zgWV7XjHuPa2sIkoqIUICdItXainaq4wSQtDuuA7ocoIkEndhmkjX/W1gADaQ54HzzQ3
         Bl+avHmgdMApPi5qHBOdrhWQ8UbszpgQSkSZaOshnKpP4kbhM6tqxwU+Qr/Lf18930Aa
         +MXg==
X-Gm-Message-State: APt69E0VcOgs8o+WNFafEu/8qUndn271eCVuguTA/btlZjrHPBYiq7YK
        8uruAL1ipYHwG5XtjI/bLqN6Tjz3XJq/xPjsQsiO3g==
X-Google-Smtp-Source: ADUXVKIcci5wf7RztqQqi4vxlV3BvkhXA3lEu+GZUgTOKY6a9LHfA+lkAMpayFQ1foFaVnwzBgJraqYrWn5hR5xvbto=
X-Received: by 2002:aa7:808f:: with SMTP id v15-v6mr10890183pff.38.1529887971689;
 Sun, 24 Jun 2018 17:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180625091531.60fe90e9@canb.auug.org.au>
In-Reply-To: <20180625091531.60fe90e9@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 24 Jun 2018 19:52:42 -0500
Message-ID: <CAH2r5mu3-5BjqhhG9XO8a3hTW5Gq67WKoVMXRjrcaZ5riFmNfA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the cifs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should be ok now - It was missing an update that Aurelien and I worked
on for that patch - so I backed that patch out.   It was also
suggested that that Kconfig parm and #ifdef be removed since SMB3.11
is strongly recommended to be set (which would have avoided this as
well) and will be added to the default list of dialects in the future.
On Sun, Jun 24, 2018 at 6:15 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the cifs tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>
> fs/cifs/smb2ops.c: In function 'smb311_queryfs':
> fs/cifs/smb2ops.c:1543:11: error: 'struct cifs_tcon' has no member named 'posix_extensions'
>   if (!tcon->posix_extensions)
>            ^~
> At top level:
> fs/cifs/smb2ops.c:1534:1: warning: 'smb311_queryfs' defined but not used [-Wunused-function]
>  smb311_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
>  ^~~~~~~~~~~~~~
>
> Caused by commit
>
>    ("smb3: add support for statfs for smb3.1.1 posix extensions")
>
> # CONFIG_CIFS_SMB311 is not set
>
> I have used the cifs tree from next-20180622 for today.
>
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
