Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CC8C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28363240BE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="sXHKanRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28363240BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754155AbeGESpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:45:38 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:35825 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753838AbeGESph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530816333;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=KxABIv/jHJH2JH01q/aaAniB6m0JM3Er5CP3K8z3d7g=;
        b=sXHKanRgBYTuP5JZTl2H6Q9DlTLdVDZ/h1y6NLrOCCV/oGjC16WeU5F9Xg/umMltPE
        YKTV2Us5ifVprgpqKZcZt0d4GdgLkdvt7/+Nm7oZRYgwlty2F4jDnoU/L9j9oJ9hbmAU
        hhRxyvl1tcexmwbC6IgAJGvLluVtX3u0jhCrMiSGyzV0xa52JFEf3Dw0/2gjLcM9M387
        JWhvLQVGrd6Y55P9U0UDD8jpeZxCvn/KPz3fwwu31tqeQJB/YejIiVqSddUItd2GQt/M
        Mrefxgqy1NTDxpC4O0dPiNWE7n7z9+DtFPwqW5ZVLJn7giHj5AUeEEDjLEWcoeVG6mX5
        m/Zw==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zT8DNpa83PTIZGviLi+9clHWaSvyKYsbBATS5P28vh0MoLa4Uw+f"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 43.12 AUTH)
        with ESMTPSA id t07687u65IjTAw0
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 5 Jul 2018 20:45:29 +0200 (CEST)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com>,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KMSAN: uninit-value in af_alg_free_areq_sgls
Date:   Thu, 05 Jul 2018 20:45:23 +0200
Message-ID: <1626520.Rx0128ICKU@positron.chronox.de>
In-Reply-To: <000000000000846e9e0570438176@google.com>
References: <000000000000846e9e0570438176@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 5. Juli 2018, 19:02:01 CEST schrieb syzbot:

Hi Dimitry,

does the syzkaller somehow uses the "---" separator as part of the URL?

Thanks

> Hello,
> 
> syzbot tried to test the proposed patch but build/boot failed:
> 
> failed to checkout kernel repo https://github.com/google/kmsan.git/---:
> failed to run /usr/bin/git [git fetch https://github.com/google/kmsan.git
> ---]: exit status 129
> error: unknown option `-'
> usage: git fetch [<options>] [<repository> [<refspec>...]]
>     or: git fetch [<options>] <group>
>     or: git fetch --multiple [<options>] [(<repository> | <group>)...]
>     or: git fetch --all [<options>]
> 
>      -v, --verbose         be more verbose
>      -q, --quiet           be more quiet
>      --all                 fetch from all remotes
>      -a, --append          append to .git/FETCH_HEAD instead of overwriting
>      --upload-pack <path>  path to upload pack on remote end
>      -f, --force           force overwrite of local branch
>      -m, --multiple        fetch from multiple remotes
>      -t, --tags            fetch all tags and associated objects
>      -n                    do not fetch all tags (--no-tags)
>      -p, --prune           prune remote-tracking branches no longer on
> remote --recurse-submodules[=<on-demand>]
>                            control recursive fetching of submodules
>      --dry-run             dry run
>      -k, --keep            keep downloaded pack
>      -u, --update-head-ok  allow updating of HEAD ref
>      --progress            force progress reporting
>      --depth <depth>       deepen history of shallow clone
>      --unshallow           convert to a complete repository
>      --update-shallow      accept refs that update .git/shallow
>      --refmap <refmap>     specify fetch refmap
> 
> 
> 
> 
> Tested on:
> 
> commit:         [unknown]
> git tree:       https://github.com/google/kmsan.git/---> compiler:       clang version 7.0.0 (trunk 334104)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=1207511c400000


Ciao
Stephan


