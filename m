Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC36C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E0120989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1D+TBdA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E0120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbeLGBsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:48:07 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33219 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGBsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 20:48:07 -0500
Received: by mail-lf1-f68.google.com with SMTP id i26so1874632lfc.0;
        Thu, 06 Dec 2018 17:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e1Ya7q8PJFfRBa3nYTO7w/J0oewGJoyyPktzMWNqq6Q=;
        b=C1D+TBdAgM37sAbicM/DLsfJvlePVSltTJorWMurBoEM707KoMrF79TghEYqTSspJ4
         Lr6ozmmxjjBDQtnoKGtPNi1/CahWINNeP6GboxVZaR/IMJRzM0e6PZ3BnZOJrhad9YIm
         SsGMV0WZsIJJxv3pyu2utQaBzYbUM6re+1H1b1pArivyEStP0FmNi4XHg1mch1Lv/iSv
         Fn4Lc/UMmehCuervTnKdJxRu2AUCzVYcTVn0F1LpAb9YP1sS9hVlD1Ah+Rlln4hNkzZQ
         P7y/pLuXFikGC+r9X45/58+hibS/7a6jI1hXlgJdJABB5O/NtB9/slcBl/uG8fd3wQB7
         KHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e1Ya7q8PJFfRBa3nYTO7w/J0oewGJoyyPktzMWNqq6Q=;
        b=e4TtvwsiIOynWVZwKK8uG0xDtHVDAZQjT7uzry4zZ+HUHB+m4ET6lC1op1izYcASuz
         ZtthiBDxTIcggEzpfrbB3ZH8PEGtFAmZqxOYlR+0lS2wT3OGKmTNSHH2k8hVBJvTQLOh
         Gpb2mcbRyLwomJ5rnrcwoj9hYQ8Rb9rGQTwWABcOhJuQX5CQ3W+CCC6Vsg/oIXfZ2gEQ
         65X8YQPDdHozNPp/F620AgTahZqTJ2Swu9ixYTe6XrkRw2YE90/LL2LhmL+AVhH7LdBN
         f6OR5PGR03cNo4IVnDyHR7/TnyLPQr1CYsoZCA1RBpbpJmWCNxxjeZ6vUuWl0QRi7qSs
         BasA==
X-Gm-Message-State: AA+aEWY95JX//o5MXDEH5dFS2PB3mu6hiFTSPDJjILy1OAtxqbljhtMs
        v4nGJekbRM3JRBfYQC+Ux2BYIAX1emN4+XDDlA==
X-Google-Smtp-Source: AFSGD/VZxoJ0TediQSS0xT2PH+sN6i9t/IVrVuqqsf0slJzr7+4fT3Up1gFgY8l7imJ7TSW9bD/GV6BMnc5lvISnv5E=
X-Received: by 2002:a19:1cd3:: with SMTP id c202mr146861lfc.33.1544147283626;
 Thu, 06 Dec 2018 17:48:03 -0800 (PST)
MIME-Version: 1.0
References: <20181206045106.10307-1-longli@linuxonhyperv.com> <CAH2r5mvvJ1-vP4o-hBUD04ySD+OvzGr12YcvyFBA9VWOs8gSGQ@mail.gmail.com>
In-Reply-To: <CAH2r5mvvJ1-vP4o-hBUD04ySD+OvzGr12YcvyFBA9VWOs8gSGQ@mail.gmail.com>
From:   Pavel Shilovsky <piastryyy@gmail.com>
Date:   Thu, 6 Dec 2018 17:47:52 -0800
Message-ID: <CAKywueRJVm9nPj436i3tat_c93mjKpdPON-S2BD5R0Pq6H0nmg@mail.gmail.com>
Subject: Re: [PATCH] CIFS: Avoid returning EBUSY to upper layer VFS
To:     Steve French <smfrench@gmail.com>
Cc:     Long Li <longli@microsoft.com>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        linux-rdma@vger.kernel.org,
        samba-technical <samba-technical@lists.samba.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve French <sfrench@samba.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=87=D1=82, 6 =D0=B4=D0=B5=D0=BA. 2018 =D0=B3. =D0=B2 00:29, Steve French=
 via samba-technical
<samba-technical@lists.samba.org>:
>
> Tentatively pushed to cifs-2.6.git for-next
> On Wed, Dec 5, 2018 at 10:52 PM Long Li <longli@linuxonhyperv.com> wrote:
> >
> > From: Long Li <longli@microsoft.com>
> >
> > EBUSY is not handled by VFS, and will be passed to user-mode. This is n=
ot
> > correct as we need to wait for more credits.
> >
> > This patch also fixes a bug where rsize or wsize is used uninitialized =
when
> > the call to server->ops->wait_mtu_credits() fails.
> >
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  fs/cifs/file.c | 31 ++++++-------------------------
> >  1 file changed, 6 insertions(+), 25 deletions(-)
> >
> > diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> > index 74c33d5..c9bc56b 100644
> > --- a/fs/cifs/file.c
> > +++ b/fs/cifs/file.c
> > @@ -2541,14 +2541,13 @@ static int
> >  cifs_resend_wdata(struct cifs_writedata *wdata, struct list_head *wdat=
a_list,
> >         struct cifs_aio_ctx *ctx)
> >  {
> > -       int wait_retry =3D 0;
> >         unsigned int wsize, credits;
> >         int rc;
> >         struct TCP_Server_Info *server =3D
> >                 tlink_tcon(wdata->cfile->tlink)->ses->server;
> >
> >         /*
> > -        * Try to resend this wdata, waiting for credits up to 3 second=
s.
> > +        * Wait for credits to resend this wdata.
> >          * Note: we are attempting to resend the whole wdata not in seg=
ments
> >          */
> >         do {
> > @@ -2556,19 +2555,13 @@ cifs_resend_wdata(struct cifs_writedata *wdata,=
 struct list_head *wdata_list,
> >                         server, wdata->bytes, &wsize, &credits);
> >
> >                 if (rc)
> > -                       break;
> > +                       goto out;
> >
> >                 if (wsize < wdata->bytes) {
> >                         add_credits_and_wake_if(server, credits, 0);
> >                         msleep(1000);
> > -                       wait_retry++;
> >                 }
> > -       } while (wsize < wdata->bytes && wait_retry < 3);
> > -
> > -       if (wsize < wdata->bytes) {
> > -               rc =3D -EBUSY;
> > -               goto out;
> > -       }
> > +       } while (wsize < wdata->bytes);
> >
> >         rc =3D -EAGAIN;
> >         while (rc =3D=3D -EAGAIN) {
> > @@ -3234,14 +3227,13 @@ static int cifs_resend_rdata(struct cifs_readda=
ta *rdata,
> >                         struct list_head *rdata_list,
> >                         struct cifs_aio_ctx *ctx)
> >  {
> > -       int wait_retry =3D 0;
> >         unsigned int rsize, credits;
> >         int rc;
> >         struct TCP_Server_Info *server =3D
> >                 tlink_tcon(rdata->cfile->tlink)->ses->server;
> >
> >         /*
> > -        * Try to resend this rdata, waiting for credits up to 3 second=
s.
> > +        * Wait for credits to resend this rdata.
> >          * Note: we are attempting to resend the whole rdata not in seg=
ments
> >          */
> >         do {
> > @@ -3249,24 +3241,13 @@ static int cifs_resend_rdata(struct cifs_readda=
ta *rdata,
> >                                                 &rsize, &credits);
> >
> >                 if (rc)
> > -                       break;
> > +                       goto out;
> >
> >                 if (rsize < rdata->bytes) {
> >                         add_credits_and_wake_if(server, credits, 0);
> >                         msleep(1000);
> > -                       wait_retry++;
> >                 }
> > -       } while (rsize < rdata->bytes && wait_retry < 3);
> > -
> > -       /*
> > -        * If we can't find enough credits to send this rdata
> > -        * release the rdata and return failure, this will pass
> > -        * whatever I/O amount we have finished to VFS.
> > -        */
> > -       if (rsize < rdata->bytes) {
> > -               rc =3D -EBUSY;
> > -               goto out;
> > -       }
> > +       } while (rsize < rdata->bytes);
> >
> >         rc =3D -EAGAIN;
> >         while (rc =3D=3D -EAGAIN) {
> > --
> > 2.7.4
> >
>
>
> --
> Thanks,
>
> Steve
>

Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>

--
Best regards,
Pavel Shilovsky
