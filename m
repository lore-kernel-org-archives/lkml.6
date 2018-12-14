Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1CEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F678206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind-com.20150623.gappssmtp.com header.i=@6wind-com.20150623.gappssmtp.com header.b="unIdA6Rd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbeLNQ3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:29:20 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:35623 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729551AbeLNQ3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:29:19 -0500
Received: by mail-lj1-f176.google.com with SMTP id x85-v6so5423112ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 08:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eSq5K7RDF9p4Zm0i/lxeURSsZydJRi/wcIz+onr3gvc=;
        b=unIdA6RdA2S4EDqxR0pQMdcTPVBNaS7p+lzhDIUWy5QNsupR2NNNlX2Bq2r8A+eMRM
         S1/PA34IaviNnEbeA492Fcranf0TQnilGu3eGDEO5rLjvuwB92KvkBv1OI0HnhoGzLVF
         bBX3lSKebR5zLQSfOieTbnvzrg8XX0ghJp/KLs2TmdX7xh5zLv2pLJ66tZLyv45hjKsk
         Tqdsh27Z7kY5FvJr1ppniyxqYlFGFsscN70ErbH5U0XFm3XLy/aAhx99JsQdm1avSOiT
         XC4nGuQUmw1RluwfiVyAXJW2bCC+oVvL7tyqz+GVlwe22YQUk0ZdZRP3J6ayd+ru7JZX
         56og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eSq5K7RDF9p4Zm0i/lxeURSsZydJRi/wcIz+onr3gvc=;
        b=GxMC7jHnbOWZg2zsBEsEkjNA1TzyBIdKbiNj/+HTP9JvWCmeKaHX36YVnXkNTXuQxS
         v4HUqcBy4IBGlKJZkrO97RJVjmlqmcHyXSIAHLee3DuSNfjbG7WeRxlWBQWhf3iQnvrw
         RNEPpKzSq0WiuAYVi55THrUaH/ah1NR3kB0YdCw/00m+CpZeY2+S97ry4bh4MR4971E1
         UqSbW7LyjkFEm9msspsYYkIzvjV7jphVCjRFz+8nnGOM1BP0d1P4m/nhEUzJxZqB8OaF
         5K8wOd4X8SkUgwVEfcEOii3uIqgIWrlvLqZf7vjoBmlkV2wfzRdtupP31kXpq6dTSWFw
         9LRw==
X-Gm-Message-State: AA+aEWbG0J7jfuUDS8ox+bTEhw5IDcy4XjKROoIH8FaFwIEs2IyoUNnx
        5Rq6vGwRF3UX5wDfX8Zfm0hzyRCp9gRXyElW2QWEHA==
X-Google-Smtp-Source: AFSGD/VmkbD9puuKOlI36GZRU3G7YC8lGQwsJm5ZeqXW+ix3FiRaY3444l4YL/z/idM8nsl10WQ7hjrHVLLJXSNlH34=
X-Received: by 2002:a2e:8643:: with SMTP id i3-v6mr1941987ljj.43.1544804957349;
 Fri, 14 Dec 2018 08:29:17 -0800 (PST)
MIME-Version: 1.0
References: <00000000000075fe86057ca6367e@google.com> <20181210124724.iuver2va3yjdsokf@breakpoint.cc>
 <20181210.095856.580441946779980596.davem@davemloft.net> <2559562.n5nkmlqv4s@stwm.de>
 <20181214143532.43zgy2hwkdskwfn2@breakpoint.cc> <CADdy8HpgzxLB-6QA+D5JfvhJmjyFUoFM1fQfz0rFAO6LEvRBAQ@mail.gmail.com>
 <20181214162333.utlut746n3butkuf@breakpoint.cc>
In-Reply-To: <20181214162333.utlut746n3butkuf@breakpoint.cc>
From:   Christophe Gouault <christophe.gouault@6wind.com>
Date:   Fri, 14 Dec 2018 17:28:47 +0100
Message-ID: <CADdy8HpctPiaYTEMC48x8f1OYKwPm7Tx_NLktn2GWYFH+y+tAg@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in xfrm_hash_rebuild
To:     Florian Westphal <fw@strlen.de>
Cc:     Wolfgang Walter <linux@stwm.de>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven. 14 d=C3=A9c. 2018 =C3=A0 17:23, Florian Westphal <fw@strlen.de> a =
=C3=A9crit :
> I won't send a patch to remove your work, at least not at this time.
>
> In case I'd do this removal (thresholds, hash table, or both)
> i will make these tests to see how large the impact is.

Perfect, thanks
Christophe
