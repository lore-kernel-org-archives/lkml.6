Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1148366-1527131897-2-13487030229576096019
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527131896; b=DegEc20NHqA6Rg652iEWiRYiFxe3onHGgZEZHL1+oQn47ynt4K
    dbH3LrvZv6YAw8tJk+kkVLYPIZwR4v7u4DNCvWPqUKGMHET//b1OQmeqR8pz/1bM
    RyiyotgdFgeW80MSVJohYMPrV6zw+rIPUa5ApbOGf3IqZGBnYe0trcFJqx6PxDmQ
    ZeY8mMut1ID6RPcFDR9iHVrI420Z4g488huQCRBurR34QXNdYIUj6UzXcNS+gAeq
    y2ug/Roz5SKfAXClgB3cOEp3pbNRczTCbAYCG7l+JMnIrIO7TBpAcANpzDJG/To3
    4YqktZw1Vw0+HcULSDY5fzF/v35ZedgWHtyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527131896; bh=E8VXeDXQE5BSmzzCip8FryxfZd8Iydrt3d0SDc5abt
    g=; b=AfoSffejizyXBX1ge/tVK3VWSWWDPu/fXQecGAVbuP8qSupigsML8c8Bgj
    3HGh1R999Ducxdwss7AJuuCTa3f4GIrw6OuJuRXpvV+/8xx5UqaERHA8s4tXk3As
    RKovngPs1DHaoBDlHSSJzbzH5Ik5qsfhiMUUh0HTxRd1/tz+k2wjcM/oJ/e7lTv+
    ZSrAnLZOKOnx23dUiutFrcWePX2GcvsSCVJ7emU/lOlbl6jSHu0Aq4IbowOyK448
    7XD2l+w0bm5ANEr7b5OiMk2en5wEo8u+YfyenoXOzKr59Dsuo8yDlvN5C2OcAAew
    O/uwppYeNPH/z+1T1vJZ4l8FIc0w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
    header.d=intel-com.20150623.gappssmtp.com
    header.i=@intel-com.20150623.gappssmtp.com header.b=GUlDVjAS
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=B3RzVpPN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
      header.d=intel-com.20150623.gappssmtp.com
      header.i=@intel-com.20150623.gappssmtp.com header.b=GUlDVjAS
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=B3RzVpPN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGhhnCNPma6E1JYEqQ0lDz3MZLHx8yfYQQFlKCTchxR/U1NXhU7SfzIpF54nf8aNP1CbEYhF9dxNMNCy2CQTUA1ogbfTILIaIFfG6DpCKwVSIKGo/1fl
    AE+GVlA0wrtovBNmM0+73JP7KpNo2LYomanj7xzVONR2eC04jW9zmgI8UXyiykIFTqCT0PC3rkoN9NJ5Umvdgc3RiK/GmbJugWRzTmU/xXAgnk3VYLSbXtlr
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=QrjCYY90UPdwV6Eg7CMA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935361AbeEXDSN (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 23:18:13 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:34775 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935171AbeEXDSM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 May 2018 23:18:12 -0400
X-Google-Smtp-Source: AB8JxZqk8jCDSm5o5ktzru265kSIybd8l2hRsAz1wjDe7yYvvLdGcuRlrf79ucZBx3++YaABaO2c29wMlaMPzo+4aeA=
MIME-Version: 1.0
In-Reply-To: <20180524001026.GA3527@redhat.com>
References: <152694211402.5484.2277538346144115181.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180524001026.GA3527@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 23 May 2018 20:18:11 -0700
Message-ID: <CAPcyv4hVERZoqWrCxwOkmM075OP_ada7FiYsQgokijuWyC1MbA@mail.gmail.com>
Subject: Re: [PATCH 0/5] mm: rework hmm to use devm_memremap_pages
To: Jerome Glisse <jglisse@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 5:10 PM, Jerome Glisse <jglisse@redhat.com> wrote:
> On Mon, May 21, 2018 at 03:35:14PM -0700, Dan Williams wrote:
>> Hi Andrew, please consider this series for 4.18.
>>
>> For maintainability, as ZONE_DEVICE continues to attract new users,
>> it is useful to keep all users consolidated on devm_memremap_pages() as
>> the interface for create "device pages".
>>
>> The devm_memremap_pages() implementation was recently reworked to make
>> it more generic for arbitrary users, like the proposed peer-to-peer
>> PCI-E enabling. HMM pre-dated this rework and opted to duplicate
>> devm_memremap_pages() as hmm_devmem_pages_create().
>>
>> Rework HMM to be a consumer of devm_memremap_pages() directly and fix up
>> the licensing on the exports given the deep dependencies on the mm.
>
> I am on PTO right now so i won't be able to quickly review it all
> but forcing GPL export is problematic for me now. I rather have
> device driver using "sane" common helpers than creating their own
> crazy thing.

Sane drivers that need this level of deep integration with Linux
memory management need to be upstream. Otherwise, HMM is an
unprecedented departure from the norms of Linux kernel development.
