Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C58C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE862054F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yo2gBsAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE862054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeJLBeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 21:34:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbeJLBeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 21:34:05 -0400
Received: from localhost (unknown [213.57.200.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7BFB204FD;
        Thu, 11 Oct 2018 18:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539281145;
        bh=DatiusO4ntQl1KdbLELexIP+IQb2+IEzb2lRHVioznI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yo2gBsAEOraovv2MZQeyi+ta/G0RhZ6eY6zOm2ewS7E0bQZZmRLl7RBcbrTn0BCNW
         EHgdUM+4CU5T6xIB6kwxD4314TClzAAjU6+7SQouHVEKV6mKEByYfsUMTo6lRDqB3l
         XUlEA/lDwEqyuZ5hbE9b3goBDYKo8ZGZ+kz21fOs=
Date:   Thu, 11 Oct 2018 21:05:41 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+71aff6ea121ffefc280f@syzkaller.appspotmail.com>,
        dledford@redhat.com, Jason Gunthorpe <jgg@ziepe.ca>,
        swise@opengridcomputing.com, markb@mellanox.com,
        linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, guro@fb.com,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Marcos Souza <marcos.souza.org@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: WARNING: ODEBUG bug in free_task
Message-ID: <20181011180541.GF3742@mtr-leonro.mtl.com>
References: <00000000000053a2ca0577ceddac@google.com>
 <CACT4Y+adu4sL96Dp7_m4=Q7bP0eL1w8zVce-2-+FZMAut+E9SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <CACT4Y+adu4sL96Dp7_m4=Q7bP0eL1w8zVce-2-+FZMAut+E9SA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 10, 2018 at 02:59:38PM +0200, Dmitry Vyukov wrote:
> On Tue, Oct 9, 2018 at 7:14 PM, syzbot
> <syzbot+71aff6ea121ffefc280f@syzkaller.appspotmail.com> wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    ae16eea39a86 Add linux-next specific files for 20181008
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16a493b9400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=42525ce985d1a955
> > dashboard link: https://syzkaller.appspot.com/bug?extid=71aff6ea121ffefc280f
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14567ae6400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14baa25e400000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+71aff6ea121ffefc280f@syzkaller.appspotmail.com
>
> This looks the same as:
>
> #syz dup: WARNING in __put_task_struct (2)
>
> The reproducer is all RDMA and also some task refcounting bug.
>
> +RDMA maintainers

Thanks, amazing reproducer, I'm looking on it now.

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbv5D1AAoJEORje4g2clinXSwP/3Zd/LWbjl2qpGicCpInFJJm
/qOpJDdBS7br18078JB52ODnHfE8DoHew6tUKIabIYbUsjlU3QSzCMDTLm1GMTyw
CTp9dZURJv/DGlmsRbRrIKtwpgX/KPbBPXtz+D1Y/dIAIXkxjrTIgoRFz0VjbEpO
FRC4RVGVqYfEDXEYkH3JKtyLXud3DLFzJNpyen4Y9zEPvY/vC5+TteMW397VYb+u
NkARS5L9AJ4UB09mJySvZqsS/DFEM6rwvLfi9xxRnpgA7/IGxq1ztzyqTrTp+J0K
3PmGspA9cI4hQESFc/iASyiD6ccqcgY0nEeyNICZuOAa3XqdSEhHo+DR86E6Cmm2
iKf++F11y2aWLKBsOUxTAGrZ21g9V/FxD36wRXfDatlIsJtbNsRsFf3L67zsJO1C
wNxKeKTIg/tCqcBXPGIAVzl9/kg0Pm5Je+mPBKQiqhUEU1cqASyiSf+spGP0IRry
H0R3hhVlBYiC0cdjuVAmOVpUjbnifxVfkjxDkHT17/Dvl0HqzPEsjLBcMAocMPL1
O9GfRo8ivzHQEQ0qx07F13dCyqc0ZsvTdWvOqmNgEaSx2pWjVLmjS2U8X6Dmg+Qi
ADzh0YPH6BcBG1qqzOyNSGYvNweaS0HaJrBdliCkXtPrv/PSFbCz+mnujTPU6cuw
f4REEYRO1gqTQGAf00Ai
=ml4y
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
