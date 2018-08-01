Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36860C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A0120844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcCIgFa0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A0120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389324AbeHAPM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:12:29 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40004 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389198AbeHAPM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:12:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id j19-v6so16852101ljc.7;
        Wed, 01 Aug 2018 06:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UoFqLs3ue9V5JjxfEGB8gdcuoEhoXamDeqk+0EVnS5M=;
        b=JcCIgFa02yo1+RJCFhGuD+2uJynw5HgD3hBWoXO9391XnRooS/43PLgeI9OucTIhqo
         oGJu3iqYrqiwwYbYE5WYNv2+n8G5AzngsQJbtWpvxTW0VpE/dfuaaOljWL+IISHS5k07
         f5WAOEkGegl0KaWQxg+Bq/thPbLiioQZmlqY+RmfQQ0ElN7UH9WNTm+X1OWnpKaUuRAz
         K6jLvNGm216y1tCCMR0nYU9P1dI6p0/4XLboqsUAQT2ywNslXt8nCueO6IxYxlw6O4TO
         s5nXnWvP8Kf14Ym8UKDkTL54V48jHiiv3IA+Sg17B7XqCHErP7LYh7VA9dhecilPX34+
         W0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UoFqLs3ue9V5JjxfEGB8gdcuoEhoXamDeqk+0EVnS5M=;
        b=agyqGJA3QHtN8D3VfJO7J0H25xVSlHJdo6GJ/27P9WhaCsTtZ1/5qgVHn0ewyLPyRb
         +RBqsynfmOLxq/HBvD4fnysViLqm4Vrri3eqvqv1ENK8NQxiXNre+TA7wZdJRONlAOOr
         QiBUy6Vlxas0ZkP8GtR7qx8vK5Gn1zm616KfE2iMgzC4uD7G7HGXbPe39kI+6s3nDsq8
         MQuv0eSYlgtGcmUPJZ26CXMqTTAZFZ5+Yof96UBlTDNP9IzZESWzGcZ584CY8ffg02r8
         H67Bvb+jYn9NOwD+U6JknPVKPWRYcEzo40YElx03DJ17j3R4HekdqEMDAp+QEqXleO5h
         ROGQ==
X-Gm-Message-State: AOUpUlHGeGyi4Wqc1r637Xl3wKy4nP8NfLF6Xo9QrhKSYOI8jDS6y+U8
        kbfRdo63zaVwFnMDXTiPs2zW+e1E3mrFXcHTmOA=
X-Google-Smtp-Source: AAOMgpcOwQd88ImEr90yMTQ3tPEylLpvsqcnvKwvKRJtDxlCNsDIERiSDsf2KR3LjnV8z5I591i7/lNHE2FR8EwaMTU=
X-Received: by 2002:a2e:5243:: with SMTP id g64-v6mr18985373ljb.144.1533130000450;
 Wed, 01 Aug 2018 06:26:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 06:26:39 -0700 (PDT)
In-Reply-To: <20180801131330.GA4734@bombadil.infradead.org>
References: <20180728085000.GA9136@jordon-HP-15-Notebook-PC>
 <20180801125512.GA10761@thunk.org> <CAFqt6zbxpj5DS=ONUGTJ9zaeH5k=qZpQYy-J+08tr9y0gOsCAg@mail.gmail.com>
 <20180801131330.GA4734@bombadil.infradead.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 1 Aug 2018 18:56:39 +0530
Message-ID: <CAFqt6zYJv7SdkntY7KOBvNyfk-9MRaXBMmkbsc4J7P-tq616DA@mail.gmail.com>
Subject: Re: [PATCH] ext4: Convert int to vm_fault_t type
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Greg KH <gregkh@linuxfoundation.org>, kemi.wang@intel.com,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 6:43 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Wed, Aug 01, 2018 at 06:34:45PM +0530, Souptick Joarder wrote:
>> > The fact that ext4_page_mkwrite() returns a vm_fault_t, while
>> > block_page_mkwrite() returns an int which then has to get translated
>> > into a vm_fault_t via block_page_mkwrite_return() is I suspect going
>> > to confuse an awful lot of callers.
>>
>> We have also changed block_page_mkwrite() to return vm_fault_t, but in
>> a different patch. Hopefully that patch will be in linux-next tree soon.
>
> I didn't sign off on that, so that's not "we", but "I".  And this is
> completely against everything I've been telling you for this whole effort.
> Patches should each make sense individually.  You can't make this patch
> dependent on another patch without putting that in writing.

It was mistake form my side. Sorry about it.

>
> Leave block_page_mkwrite() alone for now.  Eventually it should return
> a vm_fault_t, probably.  But that patch needs to be delayed at least
> one kernel cycle.

As caller of block_page_mkwrite() are -
fs/ext4/inode.c
fs/nilfs2/file.c

I will merge both changes in a single patch and send it.
