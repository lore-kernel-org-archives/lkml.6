Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47024C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33902083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIlo48s0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33902083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbeKFU4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 15:56:42 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36898 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbeKFU4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 15:56:42 -0500
Received: by mail-it1-f196.google.com with SMTP id j79-v6so5186928itb.2;
        Tue, 06 Nov 2018 03:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jsIXCs7xf/8317E/yvB0SQV6M93TpXRCXkYPCiNeFzo=;
        b=JIlo48s0s/QR2ouH3c7vm2Xt7Fh4kRklLB3KCezlvP3Sr/9n2sZbrT6xxcgwotR7TL
         HJp+QxM8TKgG/+tR9G07q84dK1reEKSEyiDuacRy519cJ9eDtyDTv6OAbu00isS9CA7/
         8avcOsJQQ9QJ1EhOtPv1PxA0MJ5fC6xNPo606kOMyEY64tkKt9iCu+aklusDsmrJsBaF
         YbCAShpX1LBOWK9aLj3sWKIEU1O/kqTigYisDJ7Y3yMcSDgCg9y5B9g4k55Y7PZ471MK
         ovLYSPFNnOJ9YOOGhk3MbnrmXPzRaspEw2FoDTvCDtAVEe2q6AvhbHHUXoEKlraasblK
         1sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jsIXCs7xf/8317E/yvB0SQV6M93TpXRCXkYPCiNeFzo=;
        b=CKj+Mhb1DDef2I3BPGHprfuT6GXbl2iG/kvSlPHgQ0Zn3vYPgJray4pUidl1VvVaUa
         jkjTIdqXRKlwhCUs3dgJG7zuUOtLvmzlKvaAdSxvByfaxnpDdrkuPKGoB/w+IGSUmZov
         IpmsXATifugABP6L9M0QLPvmiQvRqMOG75iGp8KCKApN+1cFS9cUrbBX7oxz47utz5+r
         Z/V8/uFfTglxCWdkCc8zbL93dIB/GY1hZLdTmW5bzf67CMwFQFnJHExL0qxnu1b19xpl
         jZQbSvQsU0saaW3mr+M1sFgPOClYqrp2VXxC+3uD0qe1GK2S9uwKzQSUfJDNROxLpmW0
         xW0g==
X-Gm-Message-State: AGRZ1gJhz3XtcZp69mAxV0pNH3lu0u+7m+6KLvTTsSQc8COToPiu+P4j
        pL2WqtmKF7RlulJh9gAhfyawUlrsV4T0aOojwtM=
X-Google-Smtp-Source: AJdET5eDBDikU6caFdQgJVilChURMk8e1SJ/dUw2R6DfsB5Kg/14bdfSRbohrlL5Ek/rC6tJtrONwey8pE4Z+/fFidY=
X-Received: by 2002:a02:c497:: with SMTP id t23-v6mr24989064jam.143.1541503915895;
 Tue, 06 Nov 2018 03:31:55 -0800 (PST)
MIME-Version: 1.0
References: <CAAGb-1fPZsJRqa4C3zDiatqE2sPAV8m-pGBoG+z=3nAd+Koj-A@mail.gmail.com>
 <CA+res+SDaTwjkKQpnREP1dW8XmtQsk7NGLj=heYGbGeL3Dr-OQ@mail.gmail.com>
In-Reply-To: <CA+res+SDaTwjkKQpnREP1dW8XmtQsk7NGLj=heYGbGeL3Dr-OQ@mail.gmail.com>
From:   Gregory Shapiro <shapiro.gregory@gmail.com>
Date:   Tue, 6 Nov 2018 13:31:44 +0200
Message-ID: <CAAGb-1eLHwRy2L5tp+skWdV5zJ7jfCwTe-1UnJq_n5yjQfdJug@mail.gmail.com>
Subject: Re: BUG: aio/direct-io data corruption in 4.7
To:     jack.wang.usish@gmail.com
Cc:     hch@infradead.org, jnicklin@blockbridge.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregory.shapiro@kaminario.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,
I tested it in 4.9.102 and I checked the latest code from elixir
(versions 4.19 and 4.20) and the error in code is still present there.
More on the scenario and the bug:
I experienced data corruption in my application (nvme based storage).
The issue was caused because of faulty hardware, but the real problem
is I got a correct number of bytes in io_getevents thus couldn't
recognize it correctly the error.
Looking at the /var/log/messages and  I saw the following errors in
time of coruption:

Oct 11 14:55:15 block01-node05 kernel: [19272.951015]
blk_update_request: I/O error, dev nvme2n3, sector 117359360
Oct 11 14:55:15 block01-node05 kernel: [19272.952786]
blk_update_request: I/O error, dev nvme2n3, sector 117359872
Oct 11 14:55:16 block01-node05 kernel: [19273.544374]
blk_update_request: I/O error, dev nvme2n3, sector 117360384
...
So the block level does receive information about the error, but I
don't see it in the application.
running ftrace and doing code reading I find out that dio error status
is overridden.
In dio_complete it is propagated in (dio->io_error and if
dio->io_error is not zero in we are in async write
the status is overridden by transferred.

static ssize_t dio_complete(struct dio *dio, ssize_t ret, bool is_async)
{
...
        if (ret =3D=3D 0)
                ret =3D dio->page_errors;
        if (ret =3D=3D 0)
                ret =3D dio->io_error;
        if (ret =3D=3D 0)
                ret =3D transferred;
...
        if (is_async) {
                /*
                 * generic_write_sync expects ki_pos to have been updated
                 * already, but the submission path only does this for
                 * synchronous I/O.
                 */
                dio->iocb->ki_pos +=3D transferred;

                if (dio->op =3D=3D REQ_OP_WRITE)
                        ret =3D generic_write_sync(dio->iocb,  transferred)=
;
                dio->iocb->ki_complete(dio->iocb, ret, 0);



For your convenience I am attaching ftrace log to for easier tracking
the flow in the code:


 26)               |                nvme_complete_rq [nvme_core]() {
 26)               |                  blk_mq_end_request() {
 26)               |                    blk_update_request() { <----
log is from here
 26)   0.563 us    |                      blk_account_io_completion();
 26)   0.263 us    |                      bio_advance();
 26)               |                      bio_endio() {
 26)               |                        dio_bio_end_aio() {
 26)               |                          dio_bio_complete() {
 26)               |                            bio_check_pages_dirty() {
 26)               |                              bio_put() {
 26)               |                                bio_free() {
 26)               |                                  __bio_free() {
 26)   0.045 us    |                                    bio_disassociate_ta=
sk();
 26)   0.497 us    |                                  }
 26)   0.042 us    |                                  bvec_free();
 26)               |                                  mempool_free() {
 26)               |                                    mempool_free_slab()=
 {
 26)   0.264 us    |                                      kmem_cache_free()=
;
 26)   0.606 us    |                                    }
 26)   1.125 us    |                                  }
 26)   2.588 us    |                                }
 26)   2.920 us    |                              }
 26)   3.979 us    |                            }
 26)   4.712 us    |                          }
 26)   0.040 us    |                          _raw_spin_lock_irqsave();
 26)   0.048 us    |                          _raw_spin_unlock_irqrestore()=
;
 26)               |                          dio_complete() {
dio_complete(dio, 0, true);
 26)               |                            aio_complete() {
dio->iocb->ki_complete(dio->iocb, ret, 0); <<aio_complete(struct kiocb
*kiocb, long res, long res2)>>
 26)   0.073 us    |                              _raw_spin_lock_irqsave();
 26)   0.114 us    |                              refill_reqs_available();
 26)   0.048 us    |                              _raw_spin_unlock_irqresto=
re();
 26)               |                              kiocb_free() {
 26)   0.171 us    |                                fput();
 26)   0.102 us    |                                kmem_cache_free();
 26)   0.902 us    |                              }


        }

On Tue, Nov 6, 2018 at 9:29 AM Jack Wang <jack.wang.usish@gmail.com> wrote:
>
> Gregory Shapiro <shapiro.gregory@gmail.com> =E4=BA=8E2018=E5=B9=B411=E6=
=9C=885=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=884:19=E5=86=99=E9=81=93=
=EF=BC=9A
> >
> > Hello, my name is Gregory Shapiro and I am a newbie on this list.
> > I recently encountered data corruption as I got a kernel to
> > acknowledge write ("io_getevents" system call with a correct number of
> > bytes) but undergoing write to disk failed.
> > After investigating the problem I found it is identical to issue found
> > in direct-io.c mentioned the bellow thread.
> > https://lore.kernel.org/lkml/20160921141539.GA17898@infradead.org/
> > Is there a reason proposed patch didn't apply to the kernel?
> > When can I expect it to be applied?
> > Thanks,
> >  Gregory
>
> Hi Gregory,
>
> Thanks for your info.
> Have you tried with latest kernel other than 4.7, is the problem still th=
ere?
>
> Could you share your test case?
>
> Regards,
> Jack Wang
