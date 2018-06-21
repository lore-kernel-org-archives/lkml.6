Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD4FC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA05120837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtTW49AP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA05120837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933162AbeFUOxZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:53:25 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44307 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932752AbeFUOxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:53:23 -0400
Received: by mail-lf0-f67.google.com with SMTP id p23-v6so4781683lfh.11;
        Thu, 21 Jun 2018 07:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rgDQafrKUYAP0fxI9mlpi6AOTEHHC5o9cEyC2DMImrw=;
        b=mtTW49APxKeBnKnR5xXUPP+LQSz4hmHbdINZ3PpaNWGDRE+4IUVXH/rhAoPkRJ8Ole
         S/XxhyuVM6LEICMHLbCyJXZHpbjs8okDAWmavu0YRfwurONeHlFaJ6KknIRR7sDISzKX
         i96P0+Eg+p+mhH+95HXn5EDwMsdqrzFylPYQeCzRLeHRixX37seF7xtkKWri1JeIDJwV
         7SLCtArtRfOY18o8MneZNWNk65LyEUaupiz86s9yxEH/2Nbd/bJD5N7oSKwl9i7nrjgy
         +nfPWanrSPzvFZMzA323+E2dvc3YoRTuOdY+9AUmNJ9+K6lPmuRD/Zjs4efETzjvQCIi
         UUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=rgDQafrKUYAP0fxI9mlpi6AOTEHHC5o9cEyC2DMImrw=;
        b=eWKZTe20CcXwd7oJ4qSmmwp5nyXKAuQMIAmwqAwTS3+t+eLQVahVAx90Ne1dj8VWTO
         B+45Zc0nDgdJCg1ohv4HPF0XFckPemdbupiTzdh0mMXr32eiJX/x0z+r5epGUET+qFfn
         3ZfkWPKOtYzeuwnIh3nKL1yvcPIVn8p+CIbR+/xg3lWWSobZt3k4eHGx5Ks9TaDcyM8R
         9P5YjylOIDgg3DqVoRnMymWPulESGvxkzx4cL0Y9tdCoEMrfLCjWrceV/fkPFZOViaZy
         2zAUPT8Y5Gn4E/qcymFXTNxYYYd14hNTkKsRvMuUt8m+BWUOZRLXzD+EuYOfTPe5omWP
         RMPA==
X-Gm-Message-State: APt69E1BBQ1STzyqaTHapWiI7/HW+w+jWMQiO3tZY2OsZdEdeqLGbFiB
        SoeV5nVEQCdWxn+3DLClCXKNToovgBCJsYSjXUk=
X-Google-Smtp-Source: ADUXVKITVm9aXJUtam2PMqGwE9Vvc5Ku15nmgnu/pxSB9i7aEl/soZ1oEiOOqEMzlZArqoCHX/lQwUYyc9WkStdPfbU=
X-Received: by 2002:a19:c203:: with SMTP id l3-v6mr8567638lfc.55.1529592801719;
 Thu, 21 Jun 2018 07:53:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 07:53:20
 -0700 (PDT)
In-Reply-To: <CAAM7YAk1WB_aVUbOdEMhNUYRNAVT-eq9vE3x2H5yr-hjja7qEg@mail.gmail.com>
References: <20180620155101.57685-1-arnd@arndb.de> <20180620155101.57685-2-arnd@arndb.de>
 <CAAM7YAk1WB_aVUbOdEMhNUYRNAVT-eq9vE3x2H5yr-hjja7qEg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Jun 2018 16:53:20 +0200
X-Google-Sender-Auth: UjskST6bSNDrNxfq_hsE158R1nE
Message-ID: <CAK8P3a1bXLXmjGf1Yx6JXbc4-Z8DjkZPZkfvesvjFXq3jw11NQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] ceph: stop using current_kernel_time()
To:     "Yan, Zheng" <ukernel@gmail.com>
Cc:     Zheng Yan <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        Chengguang Xu <cgxu519@gmx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 2:29 PM, Yan, Zheng <ukernel@gmail.com> wrote:
> On Wed, Jun 20, 2018 at 11:52 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> ceph_mdsc_create_request() is one of the last callers of the
>> deprecated current_kernel_time() as well as timespec_trunc().
>>
>> This changes it to use the timespec64 based interfaces instead,
>> though we still need to convert the result until we are ready to
>> change over req->r_stamp.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  fs/ceph/mds_client.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>> index dc8bc664a871..69c839316a7a 100644
>> --- a/fs/ceph/mds_client.c
>> +++ b/fs/ceph/mds_client.c
>> @@ -1779,6 +1779,7 @@ struct ceph_mds_request *
>>  ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
>>  {
>>         struct ceph_mds_request *req = kzalloc(sizeof(*req), GFP_NOFS);
>> +       struct timespec64 ts;
>>
>>         if (!req)
>>                 return ERR_PTR(-ENOMEM);
>> @@ -1797,7 +1798,9 @@ ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
>>         init_completion(&req->r_safe_completion);
>>         INIT_LIST_HEAD(&req->r_unsafe_item);
>>
>> -       req->r_stamp = timespec_trunc(current_kernel_time(), mdsc->fsc->sb->s_time_gran);
>> +       ktime_get_coarse_real_ts64(&ts);
>> +       req->r_stamp = timespec64_to_timespec(timespec64_trunc(ts,
>> +                                               mdsc->fsc->sb->s_time_gran));
>>
>
> does current_time() internally uses ktime_get_coarse_real_ts64()?  If
> not,  granularity difference may cause problem. see commit
> 56199016e8672feb7b903eda003a863d5bf2b8c4 for more information

Yes, current_time() is based on current_kernel_time64(), which calls
ktime_get_coarse_real_ts64(). I'm in the process of removing both
current_kernel_time() and current_kernel_time64() in favor
of ktime_get_coarse_real_ts64() for consistency. The resolution
is unchanged here.

       Arnd
