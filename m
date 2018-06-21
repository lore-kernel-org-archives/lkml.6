Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DA2C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E7B20837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=profitbricks-com.20150623.gappssmtp.com header.i=@profitbricks-com.20150623.gappssmtp.com header.b="VJAv8+ej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E7B20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=profitbricks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754280AbeFUIlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:41:24 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50823 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbeFUIlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:41:19 -0400
Received: by mail-wm0-f66.google.com with SMTP id e16-v6so3745874wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 01:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profitbricks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MngMSYj/LUMoHDL8Hi+3HKaF/k/9jENECPPbHKOO+cU=;
        b=VJAv8+ejMrXTo1ZnvakozkyT3BQRHwaDxp3AdwL8a6MSQ8nG4njgD0pctZP7J9fqXU
         oaFvN5arv8qYf46X/BlJZgnf8YSoWH3/rreOpwMrc8OvTdDti+bZr23TwwfxRlYLeDgn
         K5CZo4upbebNTux6XAikMs3aiYfWDRKji1zzXJrcvMHQt7FPwSypcIKSWoouNenBepEk
         UlDvDFXYBuDBPm0tfnWSPKsTUcCX8YG5HjKBSG4rE7VDGEnRbR4u6Ki8VFQrtc6iN3et
         HWnkWnxih6sOsDIfvkBjW5/9TNVDF3zmbTwQTyNzUa3r6PNqwnYZfTFNuOlstVrgWfEU
         5CwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MngMSYj/LUMoHDL8Hi+3HKaF/k/9jENECPPbHKOO+cU=;
        b=HUIMOooMg74KV33Hakd2/QezAc3Ox+vcFrwq3PNRfdFbfBaLKx03AaepAI3dijJp/+
         SVjmq0COw6VV9PQyqSWoBYP9/vzQoc+kThny8c6CBVQ3/v43+5W/p2Jdd9PO5/LX3+Ua
         TKu5xoJ0Wj5IWfs5mbVm77mKwVcROaUtMSp8PiwReL1KEj5ZPIbVMKtgZmcuCJMCc9XT
         HRtFOao2WNNbj7ce2XAnjmR6Ddyx/e7zZIRer3wJFJ/ZmkO7pHWwLGZE/994dTvhLANZ
         GU8jc6QKT+OX8PGspTtwq9dH8bwsPHshuQjBJtpdmjWvK/kFSG1hWhiPEBMbIpbmnmaE
         FCeA==
X-Gm-Message-State: APt69E1jdLi5/fMFl4uJSlJajpn9MkODMWAMqhIXzQlOoB7tehsaTw0G
        vRpn7+2rQL+wVnMwos0gSYtWBY4PduUKZxOcTA5lwg==
X-Google-Smtp-Source: ADUXVKIcgYPC6/d3E/0LCQzr4WeOhZzaIOS8634BzKE02QbjFtagchDxc0QgZLkt+GPHOe5eQ9M7OzSHbRErr2JWmQY=
X-Received: by 2002:a50:8c41:: with SMTP id p59-v6mr21459347edp.207.1529570477920;
 Thu, 21 Jun 2018 01:41:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:de8e:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 01:40:37
 -0700 (PDT)
In-Reply-To: <20180621011656.GA15427@ming.t460p>
References: <20180609123014.8861-1-ming.lei@redhat.com> <CAJX1YtaRtCGt7f8H0VEDrDkcOYusB0JoL-CNB_E--MYGhcvbow@mail.gmail.com>
 <20180621011656.GA15427@ming.t460p>
From:   Gi-Oh Kim <gi-oh.kim@profitbricks.com>
Date:   Thu, 21 Jun 2018 10:40:37 +0200
Message-ID: <CAJX1YtbmOhXh7rfb72hY=d+EumOfacqCxUY_8t0u39+0R4emcw@mail.gmail.com>
Subject: Re: [PATCH V6 00/30] block: support multipage bvec
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@fb.com>, hch@infradead.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>, dsterba@suse.cz,
        ying.huang@intel.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, "Theodore Ts'o" <tytso@mit.edu>,
        darrick.wong@oracle.com, colyli@suse.de,
        Filipe Manana <fdmanana@gmail.com>, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 3:17 AM, Ming Lei <ming.lei@redhat.com> wrote:
> On Fri, Jun 15, 2018 at 02:59:19PM +0200, Gi-Oh Kim wrote:
>> >
>> > - bio size can be increased and it should improve some high-bandwidth =
IO
>> > case in theory[4].
>> >
>>
>> Hi,
>>
>> I would like to report your patch set works well on my system based on v=
4.14.48.
>> I thought the multipage bvec could improve the performance of my system.
>> (FYI, my system has v4.14.48 and provides KVM-base virtualization servic=
e.)
>
> Thanks for your test!
>
>>
>> So I did back-porting your patches to v4.14.48.
>> It has done without any serious problem.
>> I only needed to cherry-pick "blk-merge: compute
>> bio->bi_seg_front_size efficiently" and
>> "block: move bio_alloc_pages() to bcache" patches before back-porting
>> to prevent conflicts.
>
> Not sure I understand your point, you have to backport all patches.

Never mind.
I just meant I did backporting for myself and it is still working well.

>
> At least now, BIO_MAX_PAGES can be fixed as 256 in case of CONFIG_THP_SWA=
P,
> otherwise 2 pages may be allocated for holding the bvec table, so tests
> in case of THP_SWAP may be improved.
>
> Also filesystem may support IO to/from THP, and multipage bvec should
> improve this case too.

OK, I got it.
I will find something to use THP_SWAP and run the performance test with it.
Thank you ;-)


--=20
GIOH KIM
Linux Kernel Entwickler

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Tel:       +49 176 2697 8962
Fax:      +49 30 577 008 299
Email:    gi-oh.kim@profitbricks.com
URL:      https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Gesch=C3=A4ftsf=C3=BChrer: Achim Weiss, Matthias Steinberg, Christoph Steff=
ens
