Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C09C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FE32087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dCmgurZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfARLLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:11:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45518 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfARLLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:11:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so14506796wrr.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 03:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MU+d557iFzoQgxyJuKKMNzCTccSSo+Om4Ij1sV8T/lo=;
        b=dCmgurZPh5iqDD2hXGFZMNquWsSEISHeZyctshkwd5Zzi+uFGxtzYCsxe+XMG+/9G6
         pacYyZof6dbtjiSGlVIAu8vCUeIGv3maD8KvqzFFEg4W9VEkzvaLyAuR13XcJNeLlz62
         xwZCJW+4Bhtt12NL7nxK5tYD1pXQd/R0wmNn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MU+d557iFzoQgxyJuKKMNzCTccSSo+Om4Ij1sV8T/lo=;
        b=sTIm6Rkw9gghYPOxjPeCD39CXH96VUEKQxbU+RWMNdFLJNcgoWd9lOCAMEMBBQxjtF
         ji1t9hZmu5XhzWUiOTYuXZ7LTJdNMxxxM6JwBu3MW6PoN3GTCXXvmrrX9slZ/KhOiTej
         dwuQu6Wtjpx9aYGaGRTGDvlaqkyAYFYq/0m6tIX1Z6y+iWJI049YWyQPWPkZ4NAqeX/l
         YEBwtIyGzFn12bdMhNt50vuDLKdE6DBEWzIMLQ8KUnvc18J9X7+IwgwenaRFXk0HHNEh
         IVXAjH2htL83BMFnTcvxLsxltA5wx+uoSzli9P2utg1MP0am8T6h6p27Qp+XFpQ911eZ
         yF/w==
X-Gm-Message-State: AJcUukfJsW2gCJgk4O36NoELxyWGZcx2fv6ULRjWF+2Qi+QxE+0ZgIMn
        M3zXg3+d6Rx+0844OT1ia58h/g==
X-Google-Smtp-Source: ALg8bN4XlJXhCxjYIHxHF4fF6nqZlsO1iPQYnKfScNOlFH/dRopYgCspNCPtcsUXjHIM/iQpe6jLnA==
X-Received: by 2002:adf:9b11:: with SMTP id b17mr16259520wrc.168.1547809911060;
        Fri, 18 Jan 2019 03:11:51 -0800 (PST)
Received: from [192.168.0.101] (146-241-71-93.dyn.eolo.it. [146.241.71.93])
        by smtp.gmail.com with ESMTPSA id k135sm45091554wmd.42.2019.01.18.03.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 03:11:50 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [RFC PATCH 0/3] cgroup: fsio throttle controller
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190118111008.GA25335@xps-13>
Date:   Fri, 18 Jan 2019 12:11:49 +0100
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>, Vivek Goyal <vgoyal@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Dennis Zhou <dennis@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <08B91C51-C104-483A-AF15-74C40B5DAACC@linaro.org>
References: <20190118103127.325-1-righi.andrea@gmail.com>
 <E5872191-EE96-442E-B668-DD148157E665@linaro.org>
 <20190118111008.GA25335@xps-13>
To:     Andrea Righi <righi.andrea@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 18 gen 2019, alle ore 12:10, Andrea Righi =
<righi.andrea@gmail.com> ha scritto:
>=20
> On Fri, Jan 18, 2019 at 12:04:17PM +0100, Paolo Valente wrote:
>>=20
>>=20
>>> Il giorno 18 gen 2019, alle ore 11:31, Andrea Righi =
<righi.andrea@gmail.com> ha scritto:
>>>=20
>>> This is a redesign of my old cgroup-io-throttle controller:
>>> https://lwn.net/Articles/330531/
>>>=20
>>> I'm resuming this old patch to point out a problem that I think is =
still
>>> not solved completely.
>>>=20
>>> =3D Problem =3D
>>>=20
>>> The io.max controller works really well at limiting synchronous I/O
>>> (READs), but a lot of I/O requests are initiated outside the context =
of
>>> the process that is ultimately responsible for its creation (e.g.,
>>> WRITEs).
>>>=20
>>> Throttling at the block layer in some cases is too late and we may =
end
>>> up slowing down processes that are not responsible for the I/O that
>>> is being processed at that level.
>>>=20
>>> =3D Proposed solution =3D
>>>=20
>>> The main idea of this controller is to split I/O measurement and I/O
>>> throttling: I/O is measured at the block layer for READS, at page =
cache
>>> (dirty pages) for WRITEs, and processes are limited while they're
>>> generating I/O at the VFS level, based on the measured I/O.
>>>=20
>>=20
>> Hi Andrea,
>> what the about the case where two processes are dirtying the same
>> pages?  Which will be charged?
>>=20
>> Thanks,
>> Paolo
>=20
> Hi Paolo,
>=20
> in this case only the first one will be charged for the I/O activity
> (the one that changes a page from clean to dirty). This is probably =
not
> totally fair in some cases, but I think it's a good compromise,

Absolutely, I just wanted to better understand this point.

> at the
> end rewriting the same page over and over while it's already dirty
> doesn't actually generate I/O activity, until the page is flushed back
> to disk.
>=20

Right.

Thanks,
Paolo

> Obviously I'm open to other better ideas and suggestions.
>=20
> Thanks!
> -Andrea

