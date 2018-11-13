Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B7BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E934223D0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlvzzd01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E934223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbeKNCVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:21:46 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40385 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeKNCVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:21:46 -0500
Received: by mail-pl1-f195.google.com with SMTP id b22-v6so805556pls.7;
        Tue, 13 Nov 2018 08:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/BxN1TN9qFIrjRScCwvzKbApUsN855oEfxZOdW8dFS4=;
        b=nlvzzd01ozR3o7rl0JadYbDep0zx60ZCgmNlZTNkqN7hsZTrXxHny3Dt7VrC/idKBe
         E+VtdBEkAcgh23ZAjwGxyip7KzYIv8x/wZLTmRgJkPd5io2duzjEmp3RQw98hl9//2+E
         +DJw0I1zfRG+EHO18grnUoUQovb7zWiGrgwbnhfK9gpZe4N4683enenigZMLqL5ayE3u
         R5vDpfCSFjFQW3HAiaHyRAYzClAX8BWJ4+6IXM9C1ySU2O6KX+woNOLvVtdD5yo2wS9v
         I1TdcN2VVH3GKPqbVMHMhVkWqz0Jcv3/pXxfFxEtNhTiS+cTjkWpw/YUN5mUFcDngcRu
         U2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/BxN1TN9qFIrjRScCwvzKbApUsN855oEfxZOdW8dFS4=;
        b=Jh7wyKih5ao8OPMgQUjkksc2D+sT4AdODjajDhFaRpHkvYqPSwJNX5jzbJSF5XG9td
         5HV6/Ck5sHiXseV0GMziwT7igLsVcy1HgGA4kstyHvZ3wyQuASiI0sstNevThq/KFDmV
         wAoRxYzxm+y8vJeh0z5XLRNH5/1UvFehbkE1UtGEtp1vSv/jTNe4/zOw1PzC1Zg/O7du
         Hd4+JEoEGUg5QTtJ+7wobHUylIxldv0Ak9hy8VQFwHDMJKUTaAWBgQwRSMrx90c4LpDB
         QoKmX8QG+rC2W1ggx+6t56zBZOfjwduowpvtzWYfiwsj3cnfXAbJrf+whfR+BOL2LuQX
         ObcA==
X-Gm-Message-State: AGRZ1gLNtmId5A8vuZd7WHw64gfeodsOaMayknUkbJfyx4d49Ot+vW0x
        2r6z30/JOMmFqMyClwc0pgFTBdEjoDm4vmWmySc=
X-Google-Smtp-Source: AJdET5dawJvy6ProQpM2Qbqry93bUlcRx8loOIWYjzIeqnYRtIvlSnBx/cmhq5ME5ZW+cnDPkqxA7kTzgyxNIedqZ6I=
X-Received: by 2002:a17:902:654a:: with SMTP id d10-v6mr5494550pln.302.1542126178436;
 Tue, 13 Nov 2018 08:22:58 -0800 (PST)
MIME-Version: 1.0
References: <5beae8ff.1c69fb81.bd59a.b7fa@mx.google.com> <a34379dd-f6f0-b439-b6de-f2db142f1823@huawei.com>
 <13d3418f-49d1-d683-48a6-cedbc073d86f@suse.de> <1542125473.3042.6.camel@linux.vnet.ibm.com>
 <c58db296-87ec-5aaf-f6ce-1115d5d2a2c1@suse.de>
In-Reply-To: <c58db296-87ec-5aaf-f6ce-1115d5d2a2c1@suse.de>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Tue, 13 Nov 2018 21:52:46 +0530
Message-ID: <CAJr6mf299-x5RmX3Lm=pVwWoP_374sMi8sw3x=h8TgG0t0d0SA@mail.gmail.com>
Subject: Re: [PATCH] drivers/scsi/fnic/fnic_trace.c: Use vzalloc
To:     jthumshirn@suse.de
Cc:     jejb@linux.vnet.ibm.com, john.garry@huawei.com, satishkh@cisco.com,
        sebaddel@cisco.com, kartilak@cisco.com, martin.petersen@oracle.com,
        Souptick Joarder <jrdr.linux@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 9:46 PM Johannes Thumshirn <jthumshirn@suse.de> wro=
te:
>
> On 13/11/2018 17:11, James Bottomley wrote:
> > This is incorrect advice: there's no need to cast it to other *pointer*
> > types, but if you cast it to a non-pointer type (which this is doing)
> > the compiler will complain if there is no explicit cast.
shall I leave the typecast as it is?
> Right, sorry for that and thanks for spotting it James.
>
> Byte,
>         Johannes
> --
> Johannes Thumshirn                                        SUSE Labs
> jthumshirn@suse.de                                +49 911 74053 689
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N=C3=BCrnberg)
> Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
