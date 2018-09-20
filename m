Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225ECECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C494F21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HBkvwHuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C494F21525
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbeITPPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:15:46 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36733 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeITPPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:15:45 -0400
Received: by mail-vs1-f66.google.com with SMTP id z19-v6so2745612vso.3;
        Thu, 20 Sep 2018 02:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bln1JSpK5nPnwJwatmFgd4ZK6jRNa3cLVGaUAwD+qoA=;
        b=HBkvwHuSgmYR6lKXxunzcUh3TL5b864ywURFsFflKOENms9P7fPNZGzY300hU85v/I
         4U7jAoxempSp1IK8gk1Oe2Tnq7vrhr5w0trNA75WioUjKhPQuMF6PfVuFURlqPR2++th
         Vs/fNR9wuTDXYprLxbXYsmXtsyARE1KvY3s9ZpVVnfv/UERvrWz40NTMzqAMPElo+9zZ
         extjFbSOcWg0z1dj3Sf5mL2tmPknARPttsOBJJXTCqrD+OP2DGBflrDmZVc983kJf6Ey
         gNKsMXL978U7Z+1PorRSlAKK8FTeWTvQ/rjop+qcnSKMckMsQ3yDgHREJg2n+Gi456bW
         Y31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bln1JSpK5nPnwJwatmFgd4ZK6jRNa3cLVGaUAwD+qoA=;
        b=bVMKorvKfNXooCFo1gbXTIxfGntXay5PfWHdz4pjpFH4Y8+WZ/zsu8TyKuo1rbv3uy
         MRfd5vCf3vXacTG8mGn/ArlLmhc0I7fHBRf7TCEvrClq7z/Uuxttl5q1e46/a7418tSS
         NycCGSxB4sVqsJORmGQj8byjGydA0lmfN19NN2Am/cgkkLB4s4W11ESTQd+7u5U+Vyns
         SaCbRaWvgVEdFZqs+IVaOpcVy0YBLWDXvKpMcc7sbyvQ24paIeZ0fdGYeDZo8QZMX4tr
         7LxYqKfiAJQF2qx7eusXy46rONm8EiEwTJNUfSxfoHY7DNDRv0qTwURmXDTi9QrFyOx8
         KCUQ==
X-Gm-Message-State: APzg51D0VlO42uHs29an+3+x21EcZ1aSABPLjYeOP7FHBL1qedoFnZmY
        qvi2noDyj/vw7QFuMFAP/i2f5FP5GZFTH/CnSzI=
X-Google-Smtp-Source: ANB0VdbcVovimVPIYWAdn90o5fAMHoylPcTREplznMyT3Ze9vm5Y5CVCdYI+Dgwsz0lQsq3gbuQeAUFqQX0PLEO7OJQ=
X-Received: by 2002:a67:f60f:: with SMTP id k15-v6mr11044816vso.71.1537435990944;
 Thu, 20 Sep 2018 02:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180919231402.4482-1-cgzones@googlemail.com> <75b3fed9-e549-4ed0-c435-ec4795fc1e39@schaufler-ca.com>
 <20180920085048.tps2v4jkko7zjav4@breakpoint.cc>
In-Reply-To: <20180920085048.tps2v4jkko7zjav4@breakpoint.cc>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Thu, 20 Sep 2018 11:32:59 +0200
Message-ID: <CAJ2a_DfGCRXaH9BkBj=0R1Cr3jiHQHgq-pU2HGuWudvWCSKLQg@mail.gmail.com>
Subject: Re: [PATCH] netfilter: nf_tables: add SECMARK support
To:     fw@strlen.de
Cc:     casey@schaufler-ca.com, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, davem@davemloft.net,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, jmorris@namei.org,
        serge@hallyn.com, selinux <selinux@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +   for (i = 0; i < ARRAY_SIZE(nft_basic_objects); i++) {
> > > +           err = nft_register_obj(nft_basic_objects[i]);
> > > +           if (err)
> > > +                   goto err;
> > > +   }
> > >
> > > -   for (i = 0; i < ARRAY_SIZE(nft_basic_types); i++) {
> > > -           err = nft_register_expr(nft_basic_types[i]);
> > > +   for (j = 0; j < ARRAY_SIZE(nft_basic_types); j++) {
> > > +           err = nft_register_expr(nft_basic_types[j]);
> > >             if (err)
> > >                     goto err;
> > >     }
> > > @@ -248,8 +260,12 @@ int __init nf_tables_core_module_init(void)
> > >     return 0;
> > >
> > >  err:
> > > +   while (j-- > 0)
> > > +           nft_unregister_expr(nft_basic_types[j]);
> > > +
> > >     while (i-- > 0)
> > > -           nft_unregister_expr(nft_basic_types[i]);
> > > +           nft_unregister_obj(nft_basic_objects[i]);
> > > +
> > >     return err;
>
> Do I read this right in that this is a error unroll bug fix?
> If so, could you please submit this as indepentent patch?
>
> Fixes should go into nf.git whereas feature goes to nf-next.git.

No, that should not be a unroll fix.
Currently there are no objects registered by the main nf_tables
module, so for nft_secmark_obj_type I had to introduce this new logic.

> > > +   if (err) {
> > > +           if (err == -EINVAL)
> > > +                   pr_notice_ratelimited("invalid security context \'%s\'\n", priv->ctx);
> > > +           else
> > > +                   pr_notice_ratelimited("unable to convert security context \'%s\': %d\n", priv->ctx, -err);
> > > +           return;
> > > +   }
>
> Please remove these printks(), they do not really help as user can't
> take any action anyway.

Aren't they helpful?
"invalid security context" can pop up if someone supplies an invalid
SELinux context (nft add secmark inet filter sshtag
\"this_is_invalid\") and uses it
"unable to convert security context" can pop up if no LSM is enabled
"unable to map security context" should never happen, but one never knows
"unable to obtain relabeling permission" can pop up if e.g. the
SELinux permission "kernel_t ssh_server_packet:packet relabelto" is
missing
