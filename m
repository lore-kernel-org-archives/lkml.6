Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AE6C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D29A20856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpUrA7qL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D29A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbeGSRzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 13:55:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44411 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731828AbeGSRzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 13:55:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so4326079pgp.11;
        Thu, 19 Jul 2018 10:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7pBPBWIoYEv6A7Xqcfh3h50W3c3O7LVp6eQHXg3DHxE=;
        b=HpUrA7qLd285Ey3unqTFuLWBEX7qvmMFI5CWRW2cJnEjMW2gr7WzlCQaLfg4SIOq7l
         2QNAaQ+ynUEuE24JdYwSGpsdCfiU+U7IC+uLFOgPFGqC7phZjxgPKjEYtmDRDDceCxVG
         yxP0PrGq6aMBb1uX2n3tWYFiJlwQi8NtoiYVPlqvDeKYu/BKR0rBw6d9fysjeuiLel8d
         nCrbBnjatNDXqLBNwUX+VXRUb/J2HCOA4AQYRpeO1KBYpmiNXyN0c1dwi7nqr7v4uRtS
         jYylvjBDm2wNd1ff5I85pmNs3JnWW4yT9mwPAA5z9ltroSJPx23iGHVc3qmVmrmaE4oF
         5Ejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7pBPBWIoYEv6A7Xqcfh3h50W3c3O7LVp6eQHXg3DHxE=;
        b=YrsX1jx0o6bKwRB6Fmuz0HE1a09JFWjrLHTigp0aksdIYEXVc46rKf2U8grwJfzmqy
         jMlUNg1DnAHIKohe+NszbX3HlLOBt8PWbbdcdiJ3tiXIa1ZfxA259xWMWVl/jOngQ1N0
         qZtEZIIg4P/rdP6c4dWHPutI1QUYywHQ9+jnvfztN2P7v9W2d+zWearc0N0dt3JD96Eb
         D50PKdd+yUJ6fKbKC4doU/8jLLF37Vjx6UcBUiwgZQS4FEMs7vsR1Vkd/uYEDsJyOtv/
         JTg+cRDswE3Dw31pXYNrnX7EtCLTAw5Bdm1sgYS0UQZ6olXdItP9RRFIo3ypg+rkfdl/
         Kzug==
X-Gm-Message-State: AOUpUlF1BaV+TBs/LnLdHtWkO85iQ49I3WHIEB1jmFpHg7MoF27LExU+
        gim6lRZQv9Bk/4Sm6eqEIFOGwZz9tqVN8YOWiAQ=
X-Google-Smtp-Source: AAOMgpfsCgPvtNA/oaF9kPneDuSZ+zFN44EfDSYopPdWTmYbadBI8itCtVGWjrc/oDpKuf1fMi5QliwwzLudAuDKJ+0=
X-Received: by 2002:a62:4c0f:: with SMTP id z15-v6mr10290673pfa.110.1532020255742;
 Thu, 19 Jul 2018 10:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <1a3f59a9-0ba5-c83f-16a6-f9550a84f693@gmail.com>
 <CAM_iQpWabZorkMNswyfHyS4KT=f_bgMtK8K35=84uah6Kfqxew@mail.gmail.com>
 <1a27e301-3275-b349-a2f8-afdfdc02f04f@gmail.com> <20180718.125938.2271502580775162784.davem@davemloft.net>
 <28c30574-391c-b4bd-c337-51d3040d901a@gmail.com>
In-Reply-To: <28c30574-391c-b4bd-c337-51d3040d901a@gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu, 19 Jul 2018 10:12:23 -0700
Message-ID: <CAM_iQpW4-JkZY7jXx0Q1b907hQ85UOL1eXv2YHwSukb5L=apUg@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT net-next 00/17] net: Convert neighbor tables to per-namespace
To:     David Ahern <dsahern@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        nikita.leshchenko@oracle.com,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Alexander Aring <alex.aring@gmail.com>,
        linux-wpan@vger.kernel.org,
        NetFilter <netfilter-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 9:16 AM David Ahern <dsahern@gmail.com> wrote:
>
> Chatting with Nikolay about this and he brought up a good corollary - ip
> fragmentation. It really is a similar problem in that memory is consumed
> as a result of packets received from an external entity. The ipfrag
> sysctls are per namespace with a limit that non-init_net namespaces can
> not set high_thresh > the current value of init_net. Potential memory
> consumed by fragments scales with the number of namespaces which is the
> primary concern with making neighbor tables per namespace.

Nothing new, already discussed:
https://marc.info/?l=linux-netdev&m=140391416215988&w=2

:)
