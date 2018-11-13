Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9916AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C58E2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ab3qVvAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C58E2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388287AbeKNCDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:03:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32871 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731439AbeKNCDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:03:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id w22-v6so6243195plk.0;
        Tue, 13 Nov 2018 08:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MjgWDcycwUYJ7xw3Zc08pk27UC03bcmNgm1wCjb0p0w=;
        b=Ab3qVvAvS95tsC8ROD7avvpH7417DxztpEbHLr9BLxMo0E7/G7tNxT0iCleSgaPya7
         gK/aj+Qsaqw/xpsJIQ3fxUoeEO1F93ErhRUMZVPECzvGCntg21iYAA2maYU5vwccKCCa
         CU169IoO/nhDA9nie5Jk5085bNfu78DIJnq7tL9wHa1T7aho+iIvN62lBcXC1SEn2xG7
         hqVeFl21SiHpkhZJuXaUIA5PCamJq2Pkl2aEqUmJZx8uIjQ4NhDygd4My7mIO9bzXgNQ
         x0UUqTHelaF08T9VyO4RdsKkj4muueejD5GURNlwHnWugOL8VgKulk5MvDa+fQVHJ6Zu
         weCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MjgWDcycwUYJ7xw3Zc08pk27UC03bcmNgm1wCjb0p0w=;
        b=HwNrnFpN2TA1SaatnX06y0eUBnDNiSIVtPbfLXHVDj0JXOF9n/wOxZMwuZbX7y0GSL
         gvs0tzMUPRwa7rtCKEuRn5bbzmQ7+pQrxL2gU5f7mL8HDK7LozkN6qOc6l97goQRxjFL
         zXBCq4kY9O8OvnYosjqvqZa5LtrHCF1Empg5XEUmaqNue4yKtX4Gx0h3yJ5GYaqaBzyh
         JTGAiMLYAKK/PuutRpY5riVv8KLpjJeXGYyeFNi3uWb+btOCU3mEQN+r/fO68auDov7I
         L8uO1I3cWlfm44zW/P1NGKZ51Y+2AlPLTmijEMRRE9ZpGthG4cAgCqqLdYvLOaeXL2jc
         TeBQ==
X-Gm-Message-State: AGRZ1gIx8H0CUt5EcIseFKLu9TJtxY7didEpgNPArIS0c7sW7SnGED/3
        WkuzAH0HI88Bak5YSGob4hq7aggU30jFN22znUE=
X-Google-Smtp-Source: AJdET5dExk0Yh4FRwdV+jNsJjEXze2OoYgpFueEJte1KTnQ8UftG+Y2kTj8XGng47smCeODhrJU+SWgzXSWhC3x+Lgs=
X-Received: by 2002:a17:902:7442:: with SMTP id e2mr5605381plt.67.1542125111136;
 Tue, 13 Nov 2018 08:05:11 -0800 (PST)
MIME-Version: 1.0
References: <5beae8ff.1c69fb81.bd59a.b7fa@mx.google.com> <a34379dd-f6f0-b439-b6de-f2db142f1823@huawei.com>
 <13d3418f-49d1-d683-48a6-cedbc073d86f@suse.de>
In-Reply-To: <13d3418f-49d1-d683-48a6-cedbc073d86f@suse.de>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Tue, 13 Nov 2018 21:34:59 +0530
Message-ID: <CAJr6mf1Og4uNG3gOu56EBrm+2MQGg9=SZ2mCn9hQ=+8Er-WkBw@mail.gmail.com>
Subject: Re: [PATCH] drivers/scsi/fnic/fnic_trace.c: Use vzalloc
To:     jthumshirn@suse.de
Cc:     john.garry@huawei.com, satishkh@cisco.com, sebaddel@cisco.com,
        kartilak@cisco.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com,
        Souptick Joarder <jrdr.linux@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 9:23 PM Johannes Thumshirn <jthumshirn@suse.de> wro=
te:
>
> On 13/11/2018 16:44, John Garry wrote:
> > On 13/11/2018 15:08, Sabyasachi Gupta wrote:
> >> Replaced vmalloc + memset with vzalloc
> >>
> >> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> >> ---
> >>  drivers/scsi/fnic/fnic_trace.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/scsi/fnic/fnic_trace.c
> >> b/drivers/scsi/fnic/fnic_trace.c
> >> index 8271785..129ab27 100644
> >> --- a/drivers/scsi/fnic/fnic_trace.c
> >> +++ b/drivers/scsi/fnic/fnic_trace.c
> >> @@ -468,14 +468,14 @@ int fnic_trace_buf_init(void)
> >>      fnic_max_trace_entries =3D (trace_max_pages * PAGE_SIZE)/
> >>                        FNIC_ENTRY_SIZE_BYTES;
> >>
> >> -    fnic_trace_buf_p =3D (unsigned long)vmalloc((trace_max_pages *
> >> PAGE_SIZE));
> >> +    fnic_trace_buf_p =3D (unsigned long)vzalloc((trace_max_pages *
> >> +                                PAGE_SIZE));
> >
> > If you remove the extra brackets in vzalloc() argument then you may not
> > spill onto the next line.
>
> And remove the unnecessary cast. vzalloc() (just like vmalloc()) returns
> a void*, so no reason to cast it.
>
> --
> Johannes Thumshirn                                        SUSE Labs
> jthumshirn@suse.de                                +49 911 74053 689
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N=C3=BCrnberg)
> Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
 I will remove it and send v2
