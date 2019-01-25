Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF01C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0B3218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nn+reeA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfAYKh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:37:59 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45252 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfAYKh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:37:59 -0500
Received: by mail-qk1-f196.google.com with SMTP id y78so5074420qka.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 02:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klEb6fjdDLnRB0knxL2KW1PkKMB1j6jmIlkOzYEg8Ds=;
        b=Nn+reeA1iEmyvbUNE7l7T4l/suF7Z3aOzezbZodhKrELWeqDfc86oy+SEuQiTvaigE
         Wg3bIn1HK6fLbe7+lzyxDy3KF3cU0EWbN/hRp0vNl5QeDJzpUYbliyFSS5gSkuEQvYwi
         +RW1qbue9dP70wGD4QCW4mKHUcRiK/35CYeV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klEb6fjdDLnRB0knxL2KW1PkKMB1j6jmIlkOzYEg8Ds=;
        b=TOmo9l6J8k7gbNxa0NIOQQYHkRRjOF+TRSEKRxS89CzfYFtD4GerDOasO1KDm0bOMo
         aPMd8AmXEjzeCETzLZ6QsadNjFiX1719cFQO5fbGSwTnJyw6WIs/gn+xX8C6Z6ZFQWCb
         5DGU6IYtljiaSgq7N2qmJm5kDC668iH9W5v9PtJxmTYSIHqtnaRI2XsQfYYkoE4FwlZv
         5uu1sSgDkqdD3lkklY/Rr2XtQb67C1p1WSd7zOVSMYecLyPuCKN4Gg/MwRKsKLivLmH/
         zxLV7/E1Pu9XMicevz7hCym18g/Xvp4eTCR1/Qgdj8ULuxRNmVkSYV4dWUeNUKDW7qNO
         X33A==
X-Gm-Message-State: AJcUukcN7Fh+7VCUZIptU1cfL+q1EZvdqRbdYQjQfc87Bday0WYS53BU
        gQZJM98Zf6/OYynqTKr9vgQmA7aOeS4TZC7slzbe6A==
X-Google-Smtp-Source: ALg8bN4CExBMYPoHhulvoc6KO9PpBVUHI7JkcwQfBSmendId0IyIsMSRX9GTJJ0JMc5oazwg0ZBfD42Qmo6tcko06l0=
X-Received: by 2002:a37:b2c2:: with SMTP id b185mr8999350qkf.194.1548412678233;
 Fri, 25 Jan 2019 02:37:58 -0800 (PST)
MIME-Version: 1.0
References: <20181218215944.2444-1-mike.leach@linaro.org> <20181218215944.2444-2-mike.leach@linaro.org>
 <353c8f4b-f48f-863c-7149-342b764a02c0@codeaurora.org>
In-Reply-To: <353c8f4b-f48f-863c-7149-342b764a02c0@codeaurora.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 25 Jan 2019 10:37:45 +0000
Message-ID: <CAJ9a7Vh6McpjtyRuBDPSYMWec0TuWkXeOLBOpKvv8tWUU0sV2A@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 1/2] drivers: amba: Updates to component
 identification for driver matching.
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     linux@armlinux.org.uk,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sai
On Fri, 25 Jan 2019 at 07:20, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Hi Mike,
>
> Thanks for the patch.
>
> BTW somehow I can't find the latest series in my inbox, so commenting
> on this here.
>
> Mathieu pointed me to this patch series.This solves CPU debug module
> sharing same PID as ETM on MSM8996. I will be posting patch for CPU
> debug UCI table soon.
>
> But please find my one comment inline.
>
> On 12/19/2018 3:29 AM, Mike Leach wrote:
> > The CoreSight specification (ARM IHI 0029E), updates the ID register
> > requirements for components on an AMBA bus, to cover both traditional
> > ARM Primecell type devices, and newer CoreSight and other components.
> >
> > The Peripheral ID (PID) / Component ID (CID) pair is extended in certain
> > cases to uniquely identify components. CoreSight components related to
> > a single function can share Peripheral ID values, and must be further
> > identified using a Unique Component Identifier (UCI). e.g. the ETM, CTI,
> > PMU and Debug hardware of the A35 all share the same PID.
> >
>
> [..]
>
> > +static const struct amba_id *
> > +amba_lookup(const struct amba_id *table, struct amba_device *dev)
> > +{
> >       while (table->mask) {
> > -             ret = (dev->periphid & table->mask) == table->id;
> > -             if (ret)
> > -                     break;
> > +             if (((dev->periphid & table->mask) == table->id) &&
> > +                     ((dev->cid != CORESIGHT_CID) ||
> > +                      (amba_cs_uci_id_match(table, dev))))
>
> Shouldn't the check be (dev->cid == CORESIGHT_CID) ?
> Without this STM fails to probe on both SDM845 and MSM8996.
>
I believe the test is correct

To expand the logic here:

if  (dev->periphid & table->mask) == table->id) {
      //** match on peripheral ID at this point
     if (CID != CORESIGHT_ID)
               return table; //** not coresight - match on peripheral ID only
     //** or
     if (amba_cs_uci_id_match() )
                return table;  //** is coresight - match on UCI if
available - otherwise peripheral ID only;

However - looking at the coresight STM driver - this is using the
private .data field in the amba_id for a name - which I had not
spotted before.
I will have to revisit this patchset to fix either the amba id struct
or the method for getting the uci data into the amba_id.data which
allows for multiple uses.

Regards

Mike


> With this,
>
> Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>
> Thanks,
> Sai
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
