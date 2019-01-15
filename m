Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3738C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB9A20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6fF8bXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfAOFcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 00:32:39 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51598 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfAOFcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 00:32:39 -0500
Received: by mail-it1-f195.google.com with SMTP id w18so3331697ite.1;
        Mon, 14 Jan 2019 21:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/Olo4Zo97UTApRdojgY9u8WeJGg3GDT9ZjHatNwaRQ=;
        b=m6fF8bXIVc6PWxgcCfFajs4IaHv7C0LorIWbySRC2P5gkUZfYyidyACmBfCbkdlqBu
         2SvZXnzDqtsqwAadvs/m29LnUoU6VaRQ8HJ+qamcCGIUZl/IaWKwjTn/YKcqnkSr5bCF
         +XCiNjzzt9f5jrM3uvakBSKBl3BRCMTtaDmW7fNREoIt7cn2cQfV8CXqoSAk7kwkHUpr
         V0UxIg6vkn1RQJpHm2me+/aeajx6MYJbMk5dO6TdCrp8pVEzBvdN3l6mX3l82+pyDDz8
         GRFQwIHqf2Qazm0YwazgrIE3Pv6/b4KxxuN2dYE3a78RDocIkp+lThSHLxl+rB+8Lgdq
         K2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/Olo4Zo97UTApRdojgY9u8WeJGg3GDT9ZjHatNwaRQ=;
        b=re8mJygaEsJX/th2Inn1ASCORFWOC20l4UHl8kucn4EvC2xlvBXEs+m9Kfs2bPobIL
         lFEuWawIAH83LfTZsbFs0xMxhzF4goixqa0GoC+ERI1ThBM2nKGdE3LwofNNPiVLPD7K
         CIn4iOCNBKltDStOx4OC9CpchlIaDsP/4Rydgs9s+ZXuIXTqmxRdg4WKJ3NFEJ2oBEm4
         9rhwoYEd35uQfWJjiHJQhoEiX0FEe2EnmOJRKi3UG5Qwo/lXry8kgO9FrLF5pm92F+aR
         pQXQFjQpY0QxRICnqxlxvFX/b/HSJfmRGVs0jwjL65lRnShJquDd7fxeRy2wje2yeiOh
         Xz9g==
X-Gm-Message-State: AJcUukf9VsnFkmXX+NNVWEYM711zK+PUDSv9AxxS/NAEOlAb/eUMgjD7
        SsBWA3caXebloUvjXs8yc03L5cUxiVI1yz3jEQFnEvbzjQ==
X-Google-Smtp-Source: ALg8bN5O2lFzZTWu9TqA8JEFzWVvOWjL1NUo8it6as3mUcu/spjDS7kq3BiHGG9R0CwV9dXZcpnV/rdIvwa6dDOvGok=
X-Received: by 2002:a24:7a94:: with SMTP id a142mr1314367itc.88.1547530358246;
 Mon, 14 Jan 2019 21:32:38 -0800 (PST)
MIME-Version: 1.0
References: <20190114082416.30939-1-mhocko@kernel.org> <87pnszzg9s.fsf@concordia.ellerman.id.au>
In-Reply-To: <87pnszzg9s.fsf@concordia.ellerman.id.au>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 15 Jan 2019 13:32:26 +0800
Message-ID: <CAFgQCTsEtjKnCdUb=0d9aTNL94L1=XQGDtot=2MqmqQ-fqmr1g@mail.gmail.com>
Subject: Re: [RFC PATCH] x86, numa: always initialize all possible nodes
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Tony Luck <tony.luck@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> >
> > I would appreciate a help with those architectures because I couldn't
> > really grasp how the memoryless nodes are really initialized there. E.g.
> > ppc only seem to call setup_node_data for online nodes but I couldn't
> > find any special treatment for nodes without any memory.
>
> We have a somewhat dubious hack in our hotplug code, see:
>
> e67e02a544e9 ("powerpc/pseries: Fix cpu hotplug crash with memoryless nodes")
>
> Which basically onlines the node when we hotplug a CPU into it.
>
This bug should be related with the present state of numa node during
boot time. On PowerNV and PSeries, the boot code seems not to bring up
all nodes if memoryless. Then it can not avoid this bug.

Thanks,
Pingfan
