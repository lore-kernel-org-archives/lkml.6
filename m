Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A13EECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 15:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA19121479
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 15:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RwFLh3eP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA19121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbeIWV3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 17:29:19 -0400
Received: from mail-ua1-f49.google.com ([209.85.222.49]:37795 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbeIWV3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 17:29:19 -0400
Received: by mail-ua1-f49.google.com with SMTP id q23-v6so1106677uap.4;
        Sun, 23 Sep 2018 08:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=drY0lrlt2nW9zRWED7ynXdM4iWAIMoLYUEXJokh3iiA=;
        b=RwFLh3ePPBlWKhu6PCLKvFZbVHbEiKIFFJulbCwmVUkFFNAicsu2T3zxBLEBQWlxEi
         n1iccATWxWmsOxF4uAFlgsoeWfaUCj4874ziwc0fjJMlfq7y+texclyHi+38m4VXAF8i
         8d+IINOh9jPDxEb5sefg9rTZNwUXKfDtmpKUcR+c1zoN9n4YlhjQqZHnmBBBTvEaqgnm
         Wu4ugU4fjjih7w2FByy3gdTmppAoa9eIIChktNdw5Fne3iS3IQLF/9Eo8bwmSoEXmide
         +UxKAME6YPlvboeW4FxDhXJlfKor+cMW0vAjQSUZ3ph9/scehUTtm7g5Fqys9szL43+9
         ur1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=drY0lrlt2nW9zRWED7ynXdM4iWAIMoLYUEXJokh3iiA=;
        b=HgnVWNm4l2rYifXnGUUKJQIaV+HO2XXKBJWdtGDlGyt4d2WWmYMQjZ5zs/VPDR/Oet
         3Fc6bv7InG7lxAdcyqNjcNDMtWZeYaSnTrKzoxNr/ShppM3C7dFYdUDe/7itpWfNpD3e
         I+8IROUjcYBkqPFSQph0mnJNjaihGmbOmO32t1kQWxWfzu5iJ5awGXetMM1CLJTHJK9u
         SxvaM1lh3sevPqsuNy6WdxxZudPMKU+7u0W/MxgANkT6EKs/0FoRN3eF4jd7KYvYkRlA
         20qeIsgtxrFsf1I0jc0AzsjrIyVFJzeB7UybSjlpHA7CyORgde4I+GMuAtfGIfLq/L/j
         cOvw==
X-Gm-Message-State: ABuFfohcVnKY9eC9OD2fcFoTNziBS8r4b3cKwEn0cYYafAbm9oT2wHy+
        osW9Cv3Mg2VEMePL0foaO32ixjHGHwEbnjhmcRmfrGDhB12qDg==
X-Google-Smtp-Source: ACcGV61/uTTInWkK+sJTnHlq4dAQwC5TlBw8KAJddj4OjvyyHy3gkFyDq1ijUHrFyVoyEya+4WO0/RBqu2ZRchJnnY8=
X-Received: by 2002:a9f:2c87:: with SMTP id w7-v6mr1601710uaj.21.1537716687989;
 Sun, 23 Sep 2018 08:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180923091611.19815-1-cgzones@googlemail.com> <20180923135555.7kwa3kyachwcfy24@breakpoint.cc>
In-Reply-To: <20180923135555.7kwa3kyachwcfy24@breakpoint.cc>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Sun, 23 Sep 2018 17:31:16 +0200
Message-ID: <CAJ2a_DfCmbFmpTngFnXzYy07gvEzN5UhAhrE8Cd8PowevrLUNw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] netfilter: nf_tables: add SECMARK support
To:     fw@strlen.de
Cc:     pablo@netfilter.org, kadlec@blackhole.kfki.hu, davem@davemloft.net,
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

> > +struct nft_secmark {
> > +     char ctx[NFT_SECMARK_CTX_MAXLEN];
> > +     int len;
> > +     u32 secid;
> > +};
>
> Can you change this to:
>
> struct nft_secmark {
>         u32 secid;
>         char *ctx;
> };

Does the nla_policy struct needs an update too? (regarding then .len member)

+static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
+        [NFTA_SECMARK_CTX] = { .type = NLA_STRING, .len =
NFT_SECMARK_CTX_MAXLEN },
+}

NFT_SECMARK_CTX_MAXLEN might be dropped then..
