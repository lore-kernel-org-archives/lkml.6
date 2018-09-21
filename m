Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4069ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582282150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="R/OTCBeu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582282150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391105AbeIVAH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:07:28 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35342 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732114AbeIVAH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:07:28 -0400
Received: by mail-oi0-f68.google.com with SMTP id m11-v6so12182598oic.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 11:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v0bpQO4OEAdC9kjVhyPT67HWRb0inNp8Z3gSwFnIbFg=;
        b=R/OTCBeuSTesD/MtlMtCjIyqpuP7Uv4TOGSkK9OdT2umr/HypMxHgUnrqAYPKe6PiF
         9bkQQfq7L52q9UXIWNzH+PcGwooH34FXm4yjdKz4dODtcb10PtGP4V154umUP7AboLmM
         fL47BXOG0tKlFwYhbP5M/4SCuTPaNEOJPGeJjt2bPQXi6dccyUnVwWPB1YLELoKzS2TK
         Cp7ox4n45fMy4/ARz/RLJTBte/9hK+tnp/68Q8mfIvHWdFfJcNA251yxFSjJvy1OR8xQ
         ww2PCcN2HhmLAyQdXpybkPUN/Nru9AtL9Cx7wTpAVbVibU3OT9fm6wu4W9t00FKLD4Rz
         FASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v0bpQO4OEAdC9kjVhyPT67HWRb0inNp8Z3gSwFnIbFg=;
        b=HGct8LfXXmMkSNZEOU0274vEYHSuhyeW19tppDTDro4lpQdf/wOUvGWywqECXptUIO
         DCBbP5uQSyQUXC6Ueng5ioCe1gydTxmH75DW82d+M1pIlCCGK8AoMefuMEX2yTQFsaKg
         1bBHTJi21n6Y46kxizwmeSHboOl3UdpXDGNlUXuCvaYvFd5lgqIcitWuPvgOEbJVV8yk
         5fSg68MQAoDPlHpGc4fZSz9Qlt1+ePStszxgODcjCzS/bkI77hxrStwjQ7UIFr3hx2ob
         noPEnm7eN5hJvu8AOqlrGF5sXq4Q+EJgDFBdiH/UR8uFlSAaeNjsexzRszfWVsB3KsNX
         Z2PQ==
X-Gm-Message-State: APzg51B7j0JhgJCjcg8Gw9ExI/w1KiTxtXseVcBJtn5P65qyyjdjDMvM
        zBG1u5XVoxnuQJFk72zXOpsyqy3LzOV8IzW03dpL5w==
X-Google-Smtp-Source: ANB0VdaGghsW/2I+JxDr5LiSCvx9Py8kCjn2OIy7EhDoPbiYJzhPo52FN4F4kDuP8MLOknBnhjl6yKZMwQaaGptHEp8=
X-Received: by 2002:aca:ce02:: with SMTP id e2-v6mr2255152oig.225.1537553844521;
 Fri, 21 Sep 2018 11:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536342881.git.yi.z.zhang@linux.intel.com>
 <4e8c2e0facd46cfaf4ab79e19c9115958ab6f218.1536342881.git.yi.z.zhang@linux.intel.com>
 <CAPcyv4ifg2BZMTNfu6mg0xxtPWs3BVgkfEj51v1CQ6jp2S70fw@mail.gmail.com>
 <fefbd66e-623d-b6a5-7202-5309dd4f5b32@redhat.com> <20180920224953.GA53363@tiger-server>
 <CAPcyv4g6OS=_uSjJenn5WVmpx7zCRCbzJaBr_m0Bq=qyEyVagg@mail.gmail.com>
 <20180921224739.GA33892@tiger-server> <c8ad8ed7-ca8c-4dd7-819b-8d9c856fbe04@redhat.com>
In-Reply-To: <c8ad8ed7-ca8c-4dd7-819b-8d9c856fbe04@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 21 Sep 2018 11:17:13 -0700
Message-ID: <CAPcyv4j9K-wkq8oK-8_twWViKhyGSHD7cOE5UoRN-09xKXPq7A@mail.gmail.com>
Subject: Re: [PATCH V5 4/4] kvm: add a check if pfn is from NVDIMM pmem.
To:     David Hildenbrand <david@redhat.com>
Cc:     KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        Pankaj Gupta <pagupta@redhat.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>, Linux MM <linux-mm@kvack.org>,
        rkrcmar@redhat.com,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 7:24 AM David Hildenbrand <david@redhat.com> wrote:
[..]
> > Remove the PageReserved flag sounds more reasonable.
> > And Could we still have a flag to identify it is a device private memory, or
> > where these pages coming from?
>
> We could use a page type for that or what you proposed. (as I said, we
> might have to change hibernation code to skip the pages once we drop the
> reserved flag).

I think it would be reasonable to reject all ZONE_DEVICE pages in
saveable_page().
