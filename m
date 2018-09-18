Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC95C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DDB2150B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="saV9/EHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DDB2150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbeIRXmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 19:42:13 -0400
Received: from mail.efficios.com ([167.114.142.138]:40630 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729946AbeIRXmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 19:42:13 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id EE28823F800
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 14:08:24 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id jR-9XXvPnxEm for <linux-kernel@vger.kernel.org>;
        Tue, 18 Sep 2018 14:08:24 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6B05623F7E9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 14:08:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6B05623F7E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1537294104;
        bh=kLSqyAh2vzgVDoxpAsmhT8aATGytO7+qJrGEt2PWi7w=;
        h=MIME-Version:From:Date:Message-ID:To;
        b=saV9/EHINrCIVrV3V1SaW81jJ/wIxhiId2Ge24wym6JRreaSdq2qAmLeTL5b5vGsa
         4QzdBQrdVw7NWYBFNcyViA4THcGJ/+khQcMoN6B4aEgDUYiDeBQAk02SNDDKSg8U5F
         8qFVr/6eynCPA0wMaXRt3DzkGUi9iSAsrPFQ1vh6fbzPrG04q2kp/H9TxpvOUhRiIV
         Ld7ErygfqxCmLZ8qX5HT5FVRT+GdPyVmEl/gz1SKUdyls3CVAQ91I3eopUV+a5+AlE
         e6V4vi1xb7mDARxp/Be+QXzmaXuNmkYrXmtrCKhyvWCwrshbMIYgn9y0EHwHWI8eYp
         77eTwxezU9CLQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id R3n3ZWcyLVDR for <linux-kernel@vger.kernel.org>;
        Tue, 18 Sep 2018 14:08:24 -0400 (EDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        by mail.efficios.com (Postfix) with ESMTPSA id 1511323F7D1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 14:08:24 -0400 (EDT)
Received: by mail-lf1-f43.google.com with SMTP id e11-v6so2699341lfc.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 11:08:24 -0700 (PDT)
X-Gm-Message-State: APzg51AqYLrtPDkd18KZjOokYDsgdWyBRjlVpDaXBYvYqoyvFhLWrQHO
        9e8GNYpSDyHewoCZ6EDX4wgHj+kjQWiZRF4diY8=
X-Google-Smtp-Source: ANB0VdZrYvIPhzfn9wR996hgU+DMaGTl9/FNc33n5P1xT59/wVrzTorO/+6o9dweUQWSXkYx/SeQP2m/A0NVTvOmQV0=
X-Received: by 2002:a19:3b0f:: with SMTP id i15-v6mr2867047lfa.56.1537294102317;
 Tue, 18 Sep 2018 11:08:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:5b96:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 11:07:41
 -0700 (PDT)
In-Reply-To: <20180905160918.GB29759@krava>
References: <20180829201648.19588-1-jeremie.galarneau@efficios.com> <20180905160918.GB29759@krava>
From:   =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= 
        <jeremie.galarneau@efficios.com>
Date:   Tue, 18 Sep 2018 14:07:41 -0400
X-Gmail-Original-Message-ID: <CA+jJMxvHN0-=vByU0=mdnDZJ0BsfCAf240ShQ=Obm1J=Nd=mpQ@mail.gmail.com>
Message-ID: <CA+jJMxvHN0-=vByU0=mdnDZJ0BsfCAf240ShQ=Obm1J=Nd=mpQ@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Initialize perf_data_file fd field
To:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

Anything I can do to help you with this patch?

Thanks,
J=C3=A9r=C3=A9mie

On 5 September 2018 at 12:09, Jiri Olsa <jolsa@redhat.com> wrote:
> On Wed, Aug 29, 2018 at 04:16:48PM -0400, J=C3=A9r=C3=A9mie Galarneau wro=
te:
>> Building the perf CTF converter fails with gcc 4.8.4
>> on Ubuntu 14.04 with the following error:
>>
>> error: missing initializer for field =E2=80=98fd=E2=80=99 of =E2=80=98st=
ruct perf_data_file=E2=80=99
>> [-Werror=3Dmissing-field-initializers]
>>
>> Per 4b838b0d and the ensuing discussion on the mailing
>> list, it appears that this affects other distributions
>> and gcc versions.
>>
>> Signed-off-by: J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.c=
om>
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> thanks,
> jirka
>
>> Cc: Jiri Olsa <jolsa@kernel.org>
>> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> ---
>>  tools/perf/util/data-convert-bt.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-co=
nvert-bt.c
>> index abd38abf1d91..f75d4aa612c5 100644
>> --- a/tools/perf/util/data-convert-bt.c
>> +++ b/tools/perf/util/data-convert-bt.c
>> @@ -1578,7 +1578,7 @@ int bt_convert__perf2ctf(const char *input, const =
char *path,
>>  {
>>       struct perf_session *session;
>>       struct perf_data data =3D {
>> -             .file.path =3D input,
>> +             .file      =3D { .path =3D input, .fd =3D -1 },
>>               .mode      =3D PERF_DATA_MODE_READ,
>>               .force     =3D opts->force,
>>       };
>> --
>> 2.18.0
>>



--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
