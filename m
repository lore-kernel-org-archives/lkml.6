Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60475C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 00:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC282086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 00:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1jMf6jG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC282086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbeKHKWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 05:22:39 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37167 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeKHKWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 05:22:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id p6-v6so8663979pll.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 16:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SAI/qhIspGkU24feKQaREDDTBaq4w1zpaqs865bdTWA=;
        b=u1jMf6jGFVSk8wvoN0ht+DWvnn2cAyP2RqynnIGPE4xQ5j4kqJ6197qnZT2yysJ7I3
         4oypq8fsVWqIe2Z3iS4ZK7T0CU+WqaD1PGExiIWZOv1stskzl4uAIsoUvXaH7ymO9kjO
         MAHjtHw2VYVyXCOb4IB2iHl+6/+OkPJmRSOJKrcoIjRnS2IRzoJ0hhZXfS5ymexhUh3b
         V50UivR+ZqOKYhpIyy3MCq/+84uMJGUiMAtqBVUd266c0BI4JepBmQKMBlpUz4KjJPyo
         9U4Vu+/Q+/rF72J2sgcQ8hifym5ysE5IA4EDHMP4OnGA2SjYhDzeY880YZIzaYAp22qG
         MR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SAI/qhIspGkU24feKQaREDDTBaq4w1zpaqs865bdTWA=;
        b=uATlRmWVpig9/PLC91EuOMGLcx2GPH2FTEcAAHMLu7GLWo7Xdm6BbwEyZCfkCTdvl5
         6xHqBHtSi1U6pMoHVKiOEc+dyIHILM3EgphiZmI7MjTQaqivdbPUy6gbOHZG5sLZWAx8
         0zXFDIq4bfK+rtzH9o/9ONnSK7+v/VSk7qSuvQfyJApKrOoeHMDWyq3mw4JDILW1saro
         Q41QKltsoywkjqF7bIsPLMx3igW8s4CjCBXo2WoBqV5U+TT9BSANCYkjQDDKUuevxH0j
         h8/9CWrIBu/0Ned5U/bOIteSFQPv5DxmDMRK9FQBod4l0XyLPYAB9UnRpNzXnAwLC2W5
         GxoQ==
X-Gm-Message-State: AGRZ1gKlKUg4zLTIb3j1ihTD/V1auhD5J8OWRvBIcz20Qva5LwYd2XKg
        l77DUePiM5OQchM4ThedNng=
X-Google-Smtp-Source: AJdET5cwwHevNc00warMbdp7hu0E8NL14HgkiTjMzXmVrkeXZ82B0hGrFs85jQaYTqMf77zVljHOeg==
X-Received: by 2002:a17:902:6bc9:: with SMTP id m9-v6mr2576165plt.106.1541638184856;
        Wed, 07 Nov 2018 16:49:44 -0800 (PST)
Received: from [172.17.196.190] ([123.51.210.126])
        by smtp.gmail.com with ESMTPSA id d24-v6sm3107747pfe.40.2018.11.07.16.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 16:49:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3] driver-staging: vsoc.c: Add sysfs support for
 examining the permissions of regions.
From:   wahahab <wahahab11@gmail.com>
In-Reply-To: <20181107091504.GD31015@kroah.com>
Date:   Thu, 8 Nov 2018 08:49:41 +0800
Cc:     =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>, astrachan@google.com,
        ghartman@google.com, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F0E33A6C-B2CC-4D8F-8B98-AE096704E038@gmail.com>
References: <20181107023043.GA18052@ubuntu> <20181107091504.GD31015@kroah.com>
To:     Greg Kroah-Hartman <greg@kroah.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 7 Nov 2018, at 5:15 PM, Greg Kroah-Hartman <greg@kroah.com> wrote:
>=20
> On Wed, Nov 07, 2018 at 10:30:43AM +0800, Jerry Lin wrote:
>> Add a attribute called permissions under vsoc device node for =
examining
>> current granted permissions in vsoc_device.
>>=20
>> This file will display permissions in following format:
>> begin_offset  end_offset  owner_offset  owned_value
>>           %x          %x            %x           %x
>>=20
>> Signed-off-by: Jerry Lin <wahahab11@gmail.com>
>> ---
>> drivers/staging/android/vsoc.c | 48 =
+++++++++++++++++++++++++++++++++++++++---
>> 1 file changed, 45 insertions(+), 3 deletions(-)
>=20
> What changed from v2?  And where was v2?  What about v1?
>=20
> You need a change log here of what you did different from the previous
> patches.

Sorry for the mistakes I made, I shall read the document about patches =
more carefully.
Here is the change logs:

Changes in v2:
	- Display permissions information in sysfs insureds of debufs.
Changes in v3:
	- Remove unnecessary null terminator after snprintf.

>=20
> And why ignore my response saying that this type of sysfs file is not =
ok
> at all?
>=20

I didn=E2=80=99t mean to ignore it but I haven=E2=80=99t receive the =
response you described,
May you send the response to me again so I can do further revision as =
well as
change logs and resubmit the patch again?

Thanks for your patience

Jerry=
