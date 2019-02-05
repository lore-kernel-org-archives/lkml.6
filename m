Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95A3C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE7E20818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="iZ4dUDiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfBERMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:12:12 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37743 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfBERMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:12:12 -0500
Received: by mail-ot1-f65.google.com with SMTP id s13so6969842otq.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 09:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=siT1Rz6sNVDgAQHwKHBhG+aM93/lgONHMZBEYh6CWq4=;
        b=iZ4dUDiVVFZ4KnvAcVdwCjBYTEWr5NR0CIw5+fnHjT6qXGRiBif97uOMiCmFe4by1U
         Mmm4gXIaD0KBTHCyAs32d6NsycJ/axa7KuBTHmzPP3ZLxek078NlGoRgCdDVf14l4e8g
         zrDQuSDz17HC3Ld4JqwL8JS/KV9q4ESp2LLDrLApHXMfByOQyJaT3fAcYT3AGbxRjGt9
         ZqsrabnCY12xHJ785Ra5Ijwmia1BI4FYgXqBSLlrgMQ9pr4+0uZRr16I+IUmbysQ4Up/
         KNzpHPEV6S5OzjcFmYMaMqnAISDdC4Gjm4RbDBafwk0556auO1T0x2bCiO0ogESfhiyf
         Utvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=siT1Rz6sNVDgAQHwKHBhG+aM93/lgONHMZBEYh6CWq4=;
        b=LeEkzwcznwk+oMypq+6ZBWARq4yI/lqLD5ilJ2R0L2lr/eEqoa3VVoDiuAQ/mGnE2E
         MteTmj2TukCnkHdzZFyFH690llEDvu851H+nEW61kfuwuz9Nra3HK24J1wNpfLM9rDDM
         Wzxom3a/uC95T8SJaUelcv0mpnO6iQzbS8sODd3tss3HeyDS6fJAzIx6YHcNJMNOSc9T
         7ou2+olLDEEIcMLuqR5ygGRP8+apyWaa5Dj7D0hms70MpIRO0jrM6lDDBO2D6sFxCaY6
         jtmGGjslNrw7eJeyRG4aoSldLxuuNw0ALDCpTMKOeftIQfTT/srYznBRLdDmj5QggBam
         TDeQ==
X-Gm-Message-State: AHQUAuYF7+8OiMwFK6aEeJ4u1zmxuj+4u+XQjrc2Iq+7R8FymRn7JByU
        oJt34qQT5T2EkRQQM0UCF9+FkTkistVRLBmKcVdf5Q==
X-Google-Smtp-Source: AHgI3Ibqu73JEbssl7jftSSk4xszQtX+93SFZE3GpNqUv7tvdVVWkGewDG3panj1OfWKCyAPr8uE5Jldlbw7HR6RpPI=
X-Received: by 2002:a9d:6ac2:: with SMTP id m2mr3102995otq.353.1549386731450;
 Tue, 05 Feb 2019 09:12:11 -0800 (PST)
MIME-Version: 1.0
References: <PU1P153MB0169977604493B82B662A01CBF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <154915640488.3541628.4947340559510114602.stgit@dwillia2-desk3.amr.corp.intel.com>
 <PU1P153MB0169BD9237F2DC1FA64721BABF6C0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4h0B0sBMjiAC=Tk=Mu58A4vZ5F9yUPQsXqf5jyYF37VCw@mail.gmail.com>
 <PU1P153MB0169F7C111EEC5890D3F840ABF6C0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4iMau=fvOfubDvK=cg5v5287TvXqBCm=p8nqbz2es6YEg@mail.gmail.com> <PU1P153MB0169997F36D28D8EA80923CFBF6E0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB0169997F36D28D8EA80923CFBF6E0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 5 Feb 2019 09:11:59 -0800
Message-ID: <CAPcyv4h6xBmsO+KrJas2YcsZRayn50UVGp1Sjs3nv4+_6XwGLA@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm/dimm: Add a no-BLK quirk based on NVDIMM family
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 8:53 AM Dexuan Cui <decui@microsoft.com> wrote:
>
> > From: Dan Williams <dan.j.williams@intel.com>
> > Sent: Sunday, February 3, 2019 11:14 AM
> > > ...
> > > As I understand, the essence of the issue is: Hyper-V emulates the
> > > label mechanism (i.e. it supports _LSI and LSR), but doesn't do it
> > > right (i.e. it doesn't support _LSW).
> > >
> > > To manage the namespaces, Linux can choose to use label or not.
> > >
> > > If _LSI/_LSR are supported, Linux assumes _LSW is supported as well
> > > and chooses to use label (i.e. the label mode), but since Hyper-V doesn't
> > > support _LSW, Linux fails to change the namespace configuration.
> >
> > No, that's not quite right. The reason Linux does not see the fsdax
> > mode configuration is due to the missing "address abstraction GUID" in
> > the label produced the default Hyper-V configuration.
> Hi Dan,
> Do you mean NVDIMM_DAX_GUID?

Correct.

>
> > In label-less mode there is no "address abstraction GUID" to validate so
> > it falls back to just using the info-block directly.
> In the case of not using label storage area, as I understand the info-block
> resides in regular data storage area. Can you please tell me where exactly
> the info-block is and how its location is decided?
> And I suppose the info-block contains the NVDIMM_DAX_GUID?

The info-block always lives in the data-storage area, even with
labels. It's placed at namespace base address + 4K.

When labels are present the label gives the namespace a uuid and the
info-block "parent uuid" field must match that value. Without labels
the "parent uuid" field is unused / filled with zero's. Also with v1.2
labels the address abstraction uuid must match the info-block type.

> I'm asking because I found I lose ~500MBytes of the 32GBytes Hyper-V
> NVDIMM device, when the namespace is in fsdax mode. When it's in
> raw mode, I'm able to use all of the 32GB space.

Yes. A portion of the capacity is reserved for page structures.

https://lwn.net/Articles/656197/
