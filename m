Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057E2C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC46C2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ukRMHOua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC46C2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbeJHWIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:08:11 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54615 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeJHWIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:08:11 -0400
Received: by mail-it1-f193.google.com with SMTP id l191-v6so11819488ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 07:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3MU0FRVwtyxREGUt3pr07bjMmmAUa61FYU+Ei0ub3BA=;
        b=ukRMHOuaRdcPsQZjSw9LCn/H5PcttTStkB6w+io4wATUsskP99NqwG02EAD4d3dOr1
         1RStIHs6QMU2JIr40ZlkgVVTO4g8ParSwM/OJs6TAaWqk3rQhnPE+KG+0Chi9jK90Jpi
         aWKG4hJmgTPFgr9DpJ9oiIQ7/n6jH9Q+hjfj6Zz++VEh+GJlvyEspDgLUAZ+pwe+CNUE
         ekN/G+MZr2xHYA77fHVswv/wzzv/Se374KsZaRQkviF3kC0P+zvbj3St9u4/M6vmUJC0
         H13OQwN4IziTxWbRdWF3BZCT5ejT+xKlNqJJ2C6bys3X3br0FRktwQ9cbVc/qr2Nmi/P
         KnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3MU0FRVwtyxREGUt3pr07bjMmmAUa61FYU+Ei0ub3BA=;
        b=BiTnLeRjM5RJXvEUWVoEQzdYLaqoVhrbYedol6jjmgCQNII44pv7JyslnvPjeb+qS5
         z52kE3UM15uqlCb054W0YCQoZoaRuWFpweKn5TDB9RSTJKVyrB2ZBZA8elhVzkAxg0gP
         IpWCOz0HF2v1bUgtGJm8Vr1WjgdRzhxpzFw2hWVD5kdn9xCeGuvrTPiGnnKuOEt+EPE/
         C6TX161T5nzXBsaLskh/nMoAYQBmLeV6I9jDnoWPs50Lcjz1rReH0rKEkI3W1xrl1z44
         KBfqdARw9/ad9BHJHPbpCIkLzCgdreqru4RLEY3i4u8a18R39ECqCUhsh9TU1owfphQv
         pP3A==
X-Gm-Message-State: ABuFfojL/z7lCOLlI/RLSQInlqxA75sh+jsOC0ha3eN+2wsgYp6cSamE
        ZPcBRnE5U7ntpq1e+KzP7u1z8i8zjn+lBYOYVmo=
X-Google-Smtp-Source: ACcGV62dJvH3AwLMbkr+M2xwHFaZB2mweB5kvkB0QyXZGiZOV12cNYJdfJOdFu04R4i8JjAjhxyl6oUXtxNGBURfvOw=
X-Received: by 2002:a24:9981:: with SMTP id a123-v6mr17180478ite.133.1539010563961;
 Mon, 08 Oct 2018 07:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181008141409.2624-1-loic.tourlonias.lkml@gmail.com>
 <20181008142228.GB13359@kroah.com> <e9620bf6-5f3f-108d-b9f1-91af1ad603d6@huawei.com>
 <20181008144335.GA15968@kroah.com> <a460f98f-d566-1d9d-b395-e8604519b442@huawei.com>
In-Reply-To: <a460f98f-d566-1d9d-b395-e8604519b442@huawei.com>
From:   =?UTF-8?Q?lo=C3=AFc_tourlonias?= <loic.tourlonias@gmail.com>
Date:   Mon, 8 Oct 2018 17:00:18 +0200
Message-ID: <CA+XxOSG+cJ3FZ4S7qcRWWDcktDpStuoa7nTuAUOr+U-uTTUcYg@mail.gmail.com>
Subject: Re: [PATCH v2] staging: erofs: add SPDX identifer
To:     gaoxiang25@huawei.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, yuchao0@huawei.com,
        loic.tourlonias.lkml@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gao,
On Mon, Oct 8, 2018 at 4:48 PM Gao Xiang <gaoxiang25@huawei.com> wrote:
>
> Hi Greg,
>
> On 2018/10/8 22:43, Greg Kroah-Hartman wrote:
> > On Mon, Oct 08, 2018 at 10:36:39PM +0800, Gao Xiang wrote:
> >> Hi Greg,
> >>
> >> On 2018/10/8 22:22, Greg Kroah-Hartman wrote:
> >>> Why delete that line?
> >>>
> >>> But wait, why do we even have this file at all?  What's wrong with the
> >>> lib/lz4/ code that we have in the kernel today?  Shouldn't the code
> >>> using these files be moved over to use the lib/ code instead and this
> >>> file be deleted?
> >>
> >> EROFS uses customized LZ4 decompression code for now (which has been offically
> >> supported in lz4 1.8.3, I have updated it in
> >> https://ozlabs.org/~akpm/mmots/broken-out/lib-lz4-update-lz4-decompressor-module.patch
> >> if it is shown up in Linux 4.20, I will remove all the customized LZ4 decompression code),
> >> but lib/ code lz4def.h isn't export to include/.
> >
> > It should show up in 4.20, so you should be able to remove this all
> > then.
>
> Yes, that is correct. I will fix it in 4.20 if the updated LZ4 is already there. :)

So no need to update the patch since the file will be removed. Am I correct?

Too bad, I'll make my first patch later... ^^

Thanks
Loic
>
> Thanks,
> Gao Xiang
>
> >
> > thanks,
> >
> > greg k-h
> >
