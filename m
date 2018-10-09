Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B51C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADC321479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUO3mH6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADC321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeJIUgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:36:49 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35934 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJIUgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:36:49 -0400
Received: by mail-vs1-f65.google.com with SMTP id c205so1451723vsd.3;
        Tue, 09 Oct 2018 06:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L5nkQDF61tD+oN0Jh1oODSDLvjM8xXjuRj5bYr8Sk/0=;
        b=hUO3mH6xtNRDA4C0FxnzSnEgnPLncLlFqtfyobx8MzrVwjv8mZbl1d7qeHH8iPABmc
         XAHOmcjduZ0WeBo7CD2jxFhKVBNlrnrAVgL2+DK4Ze31eboFXJm2Px7f8bByPNH6+Y+T
         h5EwjTaPhZH/8yNPg8j8DYb2LN4pKyCjHZho2reqCXn+k2SjZ17OlVD2inj6Sil1p3DN
         Iwl7Onco1mJnrtPvIyXcFCdgA5Whl9HUURFDEigooqEzJTCS0reI6rRf652mfVbCWOno
         r3Viv3X4cn7lYzxOzWVoviTIvh+fSWsSo4QxS+KiBqSf4P3nNEbwLE9Hwq48vJjKdxSU
         a0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L5nkQDF61tD+oN0Jh1oODSDLvjM8xXjuRj5bYr8Sk/0=;
        b=R6KBSbRn0VEtrxwH00UsmnL/JmyAQme6p0Bk1hzi/39UtFPz2MUxrMHtazexDiXObc
         tzd+LqKJKWjzd6gOHT+hNU06AycyaJF5xNJXltts58kudFBuIrnoPt15+jxcCkFMh2f2
         Mgo5369hghoqM0ZfegUfsy/8Sy2v0+G3jjuf//B15jvBI6gum+jBeWBYPZOz3xe+ebV5
         9wcE713AtzEz1BP6UC2n7nuCccpztqnCqbQVzGXy3sRm5aPIbFBq4XF6FZNMDu6djYNO
         Z/vBz5JQf/eBzDxQNm8GyIn+7oQstPikmu9xePKFhcF1H71fn+BNlypfb0F8nrw6ZaoY
         lnMA==
X-Gm-Message-State: ABuFfoiLc3MBRYGyVdtGDQWCeLn3VLWbODvQmuy7KkwbnYprbPnnqxG4
        6lni0QLODZAnJYk8xaUsDtPkPT3QeiNBugAVELxNi+k4wD8=
X-Google-Smtp-Source: ACcGV61aO12KReQFtZZTMAgCDFqrFdJBQkkFzkaCzJwweEo+347AODOAkZKzcrNaIxkkudBezeLmTnEHGMo75HEc3As=
X-Received: by 2002:a67:3bc9:: with SMTP id l70mr7457063vsi.44.1539091193546;
 Tue, 09 Oct 2018 06:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20181009020949.GA29622@nautica> <1539057956-23741-1-git-send-email-asmadeus@codewreck.org>
 <1539057956-23741-2-git-send-email-asmadeus@codewreck.org>
In-Reply-To: <1539057956-23741-2-git-send-email-asmadeus@codewreck.org>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Date:   Tue, 9 Oct 2018 15:19:42 +0200
Message-ID: <CAAHj5qgBteZQOkjF-n3OXvN9e0v6NYEsqg3YOitEKW0jikTpng@mail.gmail.com>
Subject: Re: [PATCH 2/2] 9p/trans_fd: put worker reqs on destroy
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Dominique Martinet <dominique.martinet@cea.fr>,
        v9fs-developer@lists.sourceforge.net,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno mar 9 ott 2018 alle ore 06:06 Dominique Martinet
<asmadeus@codewreck.org> ha scritto:
>
> From: Dominique Martinet <dominique.martinet@cea.fr>
>
> p9_read_work/p9_write_work might still hold references to a req after
> having been cancelled; make sure we put any of these to avoid potential
> request leak on disconnect.
>
> Fixes: 728356dedeff8 ("9p: Add refcount to p9_req_t")
> Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
> Cc: Eric Van Hensbergen <ericvh@gmail.com>
> Cc: Latchesar Ionkov <lucho@ionkov.net>
> Cc: Tomas Bortoli <tomasbortoli@gmail.com>
Reviewed-by: Tomas Bortoli <tomasbortoli@gmail.com>
> ---
> Noticed we could leak a ref while looking at the syzbot report,
> this should be safe enough after the work has been cancelled...
> Probably.
>
>  net/9p/trans_fd.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index a0317d459cde..f868cf6fba79 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -876,7 +876,15 @@ static void p9_conn_destroy(struct p9_conn *m)
>
>         p9_mux_poll_stop(m);
>         cancel_work_sync(&m->rq);
> +       if (m->rreq) {
> +               p9_req_put(m->rreq);
> +               m->rreq = NULL;
> +       }
>         cancel_work_sync(&m->wq);
> +       if (m->wreq) {
> +               p9_req_put(m->wreq);
> +               m->wreq = NULL;
> +       }
>
>         p9_conn_cancel(m, -ECONNRESET);
>
> --
> 2.19.1
>

LGTM
--
Tomas
