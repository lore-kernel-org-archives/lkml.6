Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C77C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D040521A74
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D040521A74
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zoho.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753215AbeGDQ4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:56:04 -0400
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25469 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753170AbeGDQ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:56:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=date:from:reply-to:to:cc:message-id:in-reply-to:references:subject:mime-version:content-type:user-agent; 
  b=NH/0WVHs8pl5r7c4SwmzFlzo30SkQTMHFrgv/+asfm3G+PavvDWfMPKBSjYMX+L/jPxGsysbaH8n
    BBfhHBImml6Znd6gVmDN9+O+U+Pw3GwCOra4zqzDEyJJbBMVWGV6  
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1530723327955366.6706706942804; Wed, 4 Jul 2018 09:55:27 -0700 (PDT)
Received: from  [123.120.80.137] by mail.zoho.com
        with HTTP;Wed, 4 Jul 2018 09:55:27 -0700 (PDT)
Date:   Thu, 05 Jul 2018 00:55:27 +0800
From:   Huaisheng Ye <yehs2007@zoho.com>
Reply-To: yehs2007@zoho.com
To:     "\"Dan Williams\"" <dan.j.williams@intel.com>
Cc:     "\"linux-nvdimm\"" <linux-nvdimm@lists.01.org>,
        "\"Ross Zwisler\"" <ross.zwisler@linux.intel.com>,
        "\"Matthew Wilcox\"" <willy@infradead.org>,
        "\"Vishal L Verma\"" <vishal.l.verma@intel.com>,
        "\"Dave Jiang\"" <dave.jiang@intel.com>,
        "\"Martin Schwidefsky\"" <schwidefsky@de.ibm.com>,
        "\"Heiko Carstens\"" <heiko.carstens@de.ibm.com>,
        "\"Al Viro\"" <viro@zeniv.linux.org.uk>,
        "\"Martin K. Petersen\"" <martin.petersen@oracle.com>,
        "\"Jens Axboe\"" <axboe@kernel.dk>,
        "\"Greg KH\"" <gregkh@linuxfoundation.org>,
        "\"Bart Van Assche\"" <bart.vanassche@wdc.com>,
        "\"Jan Kara\"" <jack@suse.com>,
        "\"Linux Kernel Mailing List\"" <linux-kernel@vger.kernel.org>,
        "\"linux-s390\"" <linux-s390@vger.kernel.org>,
        "\"linux-fsdevel\"" <linux-fsdevel@vger.kernel.org>,
        "\"colyli\"" <colyli@suse.de>,
        "\"NingTing Cheng\"" <chengnt@lenovo.com>,
        "\"Huaisheng Ye\"" <yehs1@lenovo.com>
Message-ID: <16466385fd1.ddcc3b7a51249.6994139134661160061@zoho.com>
In-Reply-To: <CAPcyv4hgk89NKGhmZ1Z3XsGFzJAn1y+46WJn_61r8rj5bmqv6A@mail.gmail.com>
References: <20180704163823.9980-1-yehs2007@zoho.com> <CAPcyv4hgk89NKGhmZ1Z3XsGFzJAn1y+46WJn_61r8rj5bmqv6A@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Assigning NULL to gfn of dax_direct_access if
 useless
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Priority: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org





 ---- On Thu, 05 Jul 2018 00:48:40 +0800 Dan Williams <dan.j.williams@intel.com> wrote ---- 
 > On Wed, Jul 4, 2018 at 9:38 AM, Huaisheng Ye <yehs2007@zoho.com> wrote: 
 > > From: Huaisheng Ye <yehs1@lenovo.com> 
 > > 
 > > Changes since v1 [1]: 
 > > * Collect Jan's reviewed-by. 
 > > * According to Dan's suggestion, update the unit test infrastructure 
 > >   tools/testing/nvdimm/pmem-dax.c for checking the validity of gfn. 
 > > 
 > > [1]: https://lkml.org/lkml/2018/7/4/81 
 > > 
 > > --- 
 > > 
 > > Some functions within fs/dax don't need to get gfn from direct_access. 
 >  
 > Any reason you are calling it 'gfn'? I'm assuming that is a typo and 
 > it should be 'pfn'. 

Oh, sorry.
I made a mistake, it is a typo. I will correct it right now.

---
Cheers,
Huaisheng Ye

