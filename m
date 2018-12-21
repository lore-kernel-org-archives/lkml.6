Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344E7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CFF21927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Z/zz62n2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391904AbeLUVBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 16:01:17 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43898 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388454AbeLUVBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 16:01:16 -0500
Received: by mail-ot1-f66.google.com with SMTP id a11so6297414otr.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 13:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tdSqmT851/jOBfLgD8JJfBYraNp4YOLuVbpjxQe9m3E=;
        b=Z/zz62n2Ahb/3yK3M3KZdZ+qVq/Q9H6nTRGSmnuYTX3LPOJnx3HU0xooMr7EacNZLZ
         G/Eo4erkPn9S/ZWIXBSJmHBc5H7+0rRsbUW6GiYg235XkdZV+Y90QFowcT9seDg766Z0
         1WiNEMwruzwWc0K8QZ46xYuTN/Uc2enHqmG7XaHRWrRvMvh1tWyKi7twMSxPeL7RHWs1
         dyZFQ0vXF+LHEqIzp8ZJNkVJxwKfJ3VRR7wQ5azK7GABrAaD6dNt9MRopKWg5Iu42sZB
         A4bETpeUyd4OnXq6R8xy0qBnsYuxEetNi9ZoPjwmNSG2N/NdEDOXSnuDta8I3cFCGiet
         Ew+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tdSqmT851/jOBfLgD8JJfBYraNp4YOLuVbpjxQe9m3E=;
        b=L7qQodXRqt6Ukp61G5QoRk2gaZd1PfT5vNHFIF0XS2y1DfBfcPGa4Gl49KD/0SFEUa
         7OTf4ISGX8HxIYNg8WhU9QPUXRERSBNfjta6j+FWjhjOoYTrZYiyYN/hkIzkWvsf3hN7
         CptAD0OHGgf0RvEqwYG8ZsTnhbpFCR+gDmKM+SB1a6T0Yd2V2NbyvVMzcG+Qx4dE4OIJ
         oIv1DBYarXWHNHep4b38T9BMyHdKky1TrWdltqiKiPL42Vq1odcYNca8V7yAXRI1cfUt
         JimE5hynNZ4ggO/Cv2oBAp6ypLbN+HR1T9pPMWMX2jif24m/fQKZJTKWg3Hb76qUc6lT
         jEzw==
X-Gm-Message-State: AJcUukduUmDvql72Q2OH8003c3MFWptUXfw/FIMtlzsgLU4JKxhe9rdl
        /eCJvIybBsbSi4Kxa44iypI1Lc+WmjaYlsDX5ZIgHg==
X-Google-Smtp-Source: ALg8bN6rdaY0RYdoxJWwHvcFdbz9/7jKVMNIt80VdgpiCrinfybHdI7K4MG1JhvftAiqC/XoZ0H+IyT9K3j8VnkTadk=
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr2717624oti.367.1545426076162;
 Fri, 21 Dec 2018 13:01:16 -0800 (PST)
MIME-Version: 1.0
References: <20181221193244.3a6ed685@canb.auug.org.au> <8ae0ad4e-0c5c-a3dc-51b4-1616f459e45b@infradead.org>
 <CAPcyv4ic3Sf+KGcL3tDUx73GVY_gXmf4WPCxfA63jT6bW3LAEA@mail.gmail.com>
In-Reply-To: <CAPcyv4ic3Sf+KGcL3tDUx73GVY_gXmf4WPCxfA63jT6bW3LAEA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 21 Dec 2018 13:01:05 -0800
Message-ID: <CAPcyv4gfC12nDdhfsT1CVuWdR_oB4Kr3FPf-shXeNgypJ+qBwQ@mail.gmail.com>
Subject: Re: linux-next: Tree for Dec 21 (nvdimm/security.o)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 10:51 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Dec 21, 2018 at 10:44 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > On 12/21/18 12:32 AM, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > News: there will be no linux-next release until Jan 2.  Have a good break.
> > >
> > > Changes since 20181220:
> > >
> >
> > on x86_64:
> >
> > ld: drivers/nvdimm/security.o: in function `nvdimm_request_key':
> > security.c:(.text+0xbe): undefined reference to `key_type_encrypted'
> > ld: drivers/nvdimm/security.o: in function `nvdimm_lookup_user_key.isra.1':
> > security.c:(.text+0x1ea): undefined reference to `key_type_encrypted'
> >
> >
> > Full randconfig file is attached.
>
> Could you send me that randconfig, offlist is fine.
>
> It seems the "depends on ENCRYPTED_KEYS" I added is not sufficient.

Yup, I overlooked the LIBNVDIMM=y + ENCRYPTED_KEYS=m case.

I folded a fix into the problematic commit and added a Reported-by
credit. The option is now:

config NVDIMM_KEYS
        def_bool y
        depends on ENCRYPTED_KEYS
        depends on (LIBNVDIMM=ENCRYPTED_KEYS) || LIBNVDIMM=m
