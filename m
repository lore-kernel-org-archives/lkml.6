Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68A6C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0FB020837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7cAtvh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0FB020837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933279AbeFUO5V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:57:21 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42947 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932963AbeFUO5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:57:18 -0400
Received: by mail-lf0-f67.google.com with SMTP id z207-v6so4817630lff.9;
        Thu, 21 Jun 2018 07:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=JjJDpYrp1ZqrftXZ9az+npr+RsGHDvUIftSG0wiHdZU=;
        b=U7cAtvh5D1uxobXzDrfgEpE/+lIJV2vKPoc1kPPjBp1ytkY8mL3RJnDlUTHstK59nw
         XxQjiMqK9/BhG8Ct/vNBqXjAVKPaKTnIHky7gxBdD7MbpbR6xF9T0Pb+W3B0o7VOvvNR
         zSc8oFz/UyKKdzKNrMVDwrt7dC+Kh1yJ2EC+C8P8AyTlPUTuGY7RonPGu4azwSCP+IMl
         hF1oyKAig1D0nVXUcpO+87i/Bpq+Mz2LY5l0dOruldIK5KebjBPb+1EwHbEPqJ5iUX0G
         ArIwI/X/S0QiWqc1V1eCB81LTtOUnfnLTdN582jqz6F72BxjvKACep+FfWckks8Jq7E6
         NbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=JjJDpYrp1ZqrftXZ9az+npr+RsGHDvUIftSG0wiHdZU=;
        b=J74CYWfqGZrdZrQDC7tUfrzLU7iWwkE9DmJtwqYSvlO/HIK1qQrZn5Y71TC8ngEBWw
         /tVelFUoDKG2we0G77d7tzsEa/O8KQLyngtlCLVBixVDDBYr6IytW+V/uvy79kOKUYcE
         XeuZ4FlwTusj895ldiGhKYSPeFmzUeWaa91OyYdJg4TTbw1+HZlTYvK2xiBTDKghv7Ni
         5oEjH0JG122QdrrO4YygclaORLXBaSMRJPO9iP0ohGGahNiTRr0wyn7bRDR7vgg4avyl
         Kyb7Jyi+gfnfF1BrJ189xG8nfq69kX2xrJ+itPJctjBQdkxQ7M/hKfatb6+poOo1QbhK
         tJlg==
X-Gm-Message-State: APt69E2qgjd71lpbmvgl/OoFKTXB3OBvhitZnyq3VXLfnSbBxTviminH
        6XOa/R7k1QrSfvILShSnR7zEK3mUzpwqBkdjTRw=
X-Google-Smtp-Source: ADUXVKL2k32LpWzoDUfw+bAE2yP5nNnUQvlUxuS/wnDRjRSsFNFsVhkMgFpmdxIWCWStZT1zbgVU934qGzqBqZ64yrQ=
X-Received: by 2002:a19:d5c7:: with SMTP id m190-v6mr6435699lfg.12.1529593036963;
 Thu, 21 Jun 2018 07:57:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 07:57:16
 -0700 (PDT)
In-Reply-To: <CAAM7YAko88Bq0Nbh4EcYifEcnzHTJ500YvofWA-uMxrwqANzpA@mail.gmail.com>
References: <20180620155101.57685-1-arnd@arndb.de> <20180620155101.57685-4-arnd@arndb.de>
 <CAAM7YAko88Bq0Nbh4EcYifEcnzHTJ500YvofWA-uMxrwqANzpA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Jun 2018 16:57:16 +0200
X-Google-Sender-Auth: ks_wwwxcYO7y8GxgRJW5Wo2dAA4
Message-ID: <CAK8P3a2sq8_S94n8KczWTL6ZGJvR7Zw3bP2Cihyr5bmxFTjCQg@mail.gmail.com>
Subject: Re: [PATCH 4/5] ceph: use timespec64 for r_mtime
To:     "Yan, Zheng" <ukernel@gmail.com>
Cc:     Zheng Yan <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alex Elder <elder@kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Miller <davem@davemloft.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jason Dillaman <dillaman@redhat.com>,
        daniel.m.jordan@oracle.com, Jan Kara <jack@suse.cz>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 2:41 PM, Yan, Zheng <ukernel@gmail.com> wrote:
> On Wed, Jun 20, 2018 at 11:55 PM Arnd Bergmann <arnd@arndb.de> wrote:

>> @@ -1013,7 +1013,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
>>                         truncate_inode_pages_range(inode->i_mapping, pos,
>>                                         (pos+len) | (PAGE_SIZE - 1));
>>
>> -                       req->r_mtime = mtime;
>> +                       req->r_mtime = current_time(inode);
> this change is not needed

Good catch, no idea how those two changes ended up in here, I'll
resend without them.

Thanks,

      Arnd
