Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751745AbeFDAhr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 20:37:47 -0400
Received: from mo-csw1115.securemx.jp ([210.130.202.157]:46642 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751489AbeFDAhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 20:37:45 -0400
X-Iguazu-Qid: 2wGrB9zg0Z3h3TUwxH
X-Iguazu-QSIG: v=1; s=0; t=1528072633; q=2wGrB9zg0Z3h3TUwxH; m=dIWelfEpasRadKHeHvjULdnJseWkFarIFXh9obXHPUM=
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: "'Naresh Kamboju'" <naresh.kamboju@linaro.org>
Cc: "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'open list'" <linux-kernel@vger.kernel.org>,
        "'linux- stable'" <stable@vger.kernel.org>,
        "'Davidlohr Bueso'" <dbueso@suse.de>,
        "'Joe Lawrence'" <joe.lawrence@redhat.com>,
        "'Andrea Arcangeli'" <aarcange@redhat.com>,
        "'Manfred Spraul'" <manfred@colorfullife.com>,
        "'Andrew Morton'" <akpm@linux-foundation.org>,
        "'Linus Torvalds'" <torvalds@linux-foundation.org>
References: <20180528100202.045206534@linuxfoundation.org> <20180528100203.357731085@linuxfoundation.org> <005601d3f888$37f266f0$a7d734d0$@toshiba.co.jp> <20180531063408.GA7744@kroah.com> <000001d3f8b2$07fc2ab0$17f48010$@toshiba.co.jp> <CA+G9fYte-o6ALhcyd_uBs+B=Q5biogk6wFZUH8pjkCoS+zWWhA@mail.gmail.com>
In-Reply-To: <CA+G9fYte-o6ALhcyd_uBs+B=Q5biogk6wFZUH8pjkCoS+zWWhA@mail.gmail.com>
Subject: RE: [PATCH 4.4 011/268] Revert "ipc/shm: Fix shmat mmap nil-page protection"
Date: Mon, 4 Jun 2018 09:37:09 +0900
X-TSB-HOP: ON
Message-ID: <000601d3fb9c$2bea1f30$83be5d90$@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ja
Thread-Index: AQIIWZ/WGnaRCO8XjPKf6QObGDbsxQGPOkphAztm2LEBjYCP2QK2GXLrAkwA+AKji7L9YA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Naresh Kamboju [mailto:naresh.kamboju@linaro.org]
> Sent: Friday, June 1, 2018 12:55 AM
> To: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; open list
> <linux-kernel@vger.kernel.org>; linux- stable <stable@vger.kernel.org>;
> Davidlohr Bueso <dbueso@suse.de>; Joe Lawrence <joe.lawrence@redhat.com>;
> Andrea Arcangeli <aarcange@redhat.com>; Manfred Spraul
> <manfred@colorfullife.com>; Andrew Morton <akpm@linux-foundation.org>;
> Linus Torvalds <torvalds@linux-foundation.org>
> Subject: Re: [PATCH 4.4 011/268] Revert "ipc/shm: Fix shmat mmap nil-page
> protection"
> 
> On 31 May 2018 at 13:06, Daniel Sangorrin
> <daniel.sangorrin@toshiba.co.jp> wrote:
> >> -----Original Message-----
> >> From: 'Greg Kroah-Hartman' [mailto:gregkh@linuxfoundation.org]
> > ..
> >> Thanks for letting us know, but this was reported already.  See the
> >> emails on lkml with the subject:
> >>       Subject: Re: [PATCH 4.16 000/272] 4.16.13-stable review
> >> from Davidlohr Bueso
> >>       Message-ID: <20180528213039.yy2madue67njkmw5@linux-n805>
> >>
> >> where he discusses that the LTP test is incorrect and that the kernel
> >> change is correct and that LTP is going to be fixed because of this.
> 
> My two cents,
> If you are referring to cve-2017-5669.c
> LTP test case is been fixed few hours ago by Rafael Tinoco,
> 
> - shm_addr = shmat(shm_id, ((void *)1), SHM_RND);
> + shm_addr = shmat(shm_id, ((void *)1), SHM_RND | SHM_REMAP);
> 
> LTP patch pull request and it is been merged.
> https://github.com/linux-test-project/ltp/pull/324

Thanks a lot Naresh.
I confirmed that the latest LTP cve-2017-5669 now PASSes.

Thanks,
Daniel
