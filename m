Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A94EC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18E120825
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="TiWRXad6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18E120825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbeJ2Sob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:44:31 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:32969 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729554AbeJ2Sob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:44:31 -0400
Received: by mail-vk1-f196.google.com with SMTP id l186so1887280vke.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 02:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=50449q8iGcINCtJ7cimQ1yuKOqLpxMohEE6QzK4fbBE=;
        b=TiWRXad6qHt9PX0pHIni01Npesnu6yOPz0ZxCOeKBHDpfP/pLu9TRfK1Z+Kz03LQsQ
         Q5LefLbUqsmO+4WCjjhkSIW+7AK0ZvjNx1za2u6ISsHpxC4ZCQgLA6lXhITVMMERPiIp
         5SJeqh8nn9QW2fSYrIZdvbo3ze27q8lgWFG4Vt7ZcK/Kx+i9w3vgoM1DGWxf5lwDax5K
         ZG5bKtPLuKvQ5d27f4GrhIzfKV1lpfGZE0md4tUzUI9QiOIUvGSXVkr3Pkr98TLgbdrN
         g5jHWVQ8qg0YxfdTnp0kHD8vT8K5BF9+iiiUrdDbkA9yEhXwiMmHomRCkq+gyV26Ey1o
         k8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=50449q8iGcINCtJ7cimQ1yuKOqLpxMohEE6QzK4fbBE=;
        b=Bu7YyiLuteY3MtCVeeAmYZMGWuJHMRfrDFY1iojJKrHyRyuylIxJEZK3AJJsBAxMQr
         a0H1IJmT7R4kOQwDXz+eo0n5EXr/MxljIG9EA7U5jbmjND0R8gwyAQQ4j1gKT42DV4cz
         aKNihRefIRMlCirpgfguZgX+8HAWKbnedCWCIy77wC7KLu3CsrW86JqDACeTOU6tRa2U
         MrDnY/zm+oJztodQ2XUa0OnLciNIvH3TWNIq2UqrRbZqxcRaKB6FnWFYGZ6qEEoIZ1XZ
         NF87IbKnlT81bHS/g9Yecg8teyFnBRFAyiiC1vlL9KL8CuZoBlCSwmSDRay89CqKj+/i
         czoA==
X-Gm-Message-State: AGRZ1gLcb+iHy3aWzXM7smHIMoDba5GAouLl7BtriLg3qo3e9kZHGhjH
        8+oG4As2jeqj73mKl3dki2ufTN61uxQxf7juFcMBX1AyvOC72w==
X-Google-Smtp-Source: AJdET5cfdn422FeDx+Eo+2l5j7+b4OfTbchnsoNa33TnEgTAY2fWvBwsJZ6NkEwTBT2qVpZQKbXRTGsQsPYtx5pYMaw=
X-Received: by 2002:a1f:1d4b:: with SMTP id d72-v6mr5685900vkd.34.1540806993713;
 Mon, 29 Oct 2018 02:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <1540541544-7761-1-git-send-email-hans.holmberg@cnexlabs.com> <e884c6c9-d875-e282-59dd-f1733ffc38fb@lightnvm.io>
In-Reply-To: <e884c6c9-d875-e282-59dd-f1733ffc38fb@lightnvm.io>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 29 Oct 2018 10:56:22 +0100
Message-ID: <CANr-nt0kcMYrGA5fmG1HBG+Hp6DUwi7B+SWTVfjYtHYE5EGELw@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: pblk: fix chunk close trace event check
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, Javier Gonzalez <javier@cnexlabs.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 8:49 PM Matias Bj=C3=B8rling <mb@lightnvm.io> wrote=
:
>
> On 10/26/2018 10:12 AM, Hans Holmberg wrote:
> > The check for chunk closes suffers from an off-by-one issue, leading
> > to chunk close events not being traced. Fix this.
> >
> > Fixes: 4c44abf43d00 ("lightnvm: pblk: add trace events for chunk states=
")
> >
> > Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> > ---
> >
> >   drivers/lightnvm/pblk-core.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.=
c
> > index 6944aac43b01..6581c35f51ee 100644
> > --- a/drivers/lightnvm/pblk-core.c
> > +++ b/drivers/lightnvm/pblk-core.c
> > @@ -531,7 +531,7 @@ void pblk_check_chunk_state_update(struct pblk *pbl=
k, struct nvm_rq *rqd)
> >               if (caddr =3D=3D 0)
> >                       trace_pblk_chunk_state(pblk_disk_name(pblk),
> >                                                       ppa, NVM_CHK_ST_O=
PEN);
> > -             else if (caddr =3D=3D chunk->cnlb)
> > +             else if (caddr =3D=3D (chunk->cnlb - 1))
> >                       trace_pblk_chunk_state(pblk_disk_name(pblk),
> >                                                       ppa, NVM_CHK_ST_C=
LOSED);
> >       }
> >
>
> Thanks Hans, Applied for 4.21/5.1. Note that you're sending from your
> owntronix email account. Checkpatch complains that sender and author
> doesn't match.

Ah, I must have messed up my git configuration.
Would you mind updating the patch author to "Hans Holmberg
<hans.holmberg@cnexlabs.com>" in for-4.21/core?

Thanks,
Hans
