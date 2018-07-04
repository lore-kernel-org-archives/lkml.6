Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DB7C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 23:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902E6240B7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 23:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoDJ4ctL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902E6240B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbeGDXTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 19:19:08 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39724 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752899AbeGDXTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 19:19:05 -0400
Received: by mail-oi0-f66.google.com with SMTP id d189-v6so13335849oib.6;
        Wed, 04 Jul 2018 16:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=NB79TfTA82lxJ4/Zk2g9ie88lDq3JUbwj8UQczFvyKo=;
        b=QoDJ4ctLKfEibkFDUkN3G6apSdlMnXbJqHTloMSNZVtslMgdIiNdyqwELk2mTQM2uG
         CzfNdXf+FkgfRzmPA9180+pqiBl/SCkPhZe4/cuuuim/xWkDrB07vVcGQsYCaw//hazA
         +QOv614maHRNt4O9sPfPWqDwSUbvUoYr2ydiFxS0wgV+6g+I308pIRH5zuZ7McEI06uk
         tqnMyotKp6IEBHxO8h/jFOrZE+G3RQ3vY3O3DKG1sGaQaf9IKI6aTraP4wCzLuCaQ7lj
         YQx1SWytDe18oFyBUHDluIgzM64zfPSZBxeCONuGqHzEWXZkdAUuEHd4LArumiszdm5e
         iFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=NB79TfTA82lxJ4/Zk2g9ie88lDq3JUbwj8UQczFvyKo=;
        b=aOVDr7AT7cy4ofXRV8wH7NpL20JmYqeIxK8us1Btm09XeoA8zwMoHrMIQJ6DVXIF1s
         H2bUc84leXOLl3lP0Ne5T0o/ejrUT/JqNMOfixG4FHWIKJT1yMuStn+aTbLcIFsHN4SA
         5YQHp/aflk1y3NSkgRCjaE0OknT3w1XRZKsthyulxAArETt7Oqv1refyFp5OkJ94besz
         SG3C8c1QqxYxDczhHhdOIvZoqIeSKSFqMRK4UIeH/V0U6BsQiWDHONYxqvNDzXkjBhYg
         bDMpuvpVoDNHtQkat1dNWanz7IA8QC3weGwn37ybVmPGtlT3ZmAaGiI/fLK8cPr9qpJ4
         uMdg==
X-Gm-Message-State: APt69E1TJSmhTTBk6LksBvxZTQ1HxVjL8I10OtEuitQFTNUpN7Q9aYtf
        nYG/4rzSKIfV6vXTSebVo16ronfXwVapuq/O8sY=
X-Google-Smtp-Source: AAOMgpeu9Bwghr06PlMtJI8fqK1nPg6/Icl/XKtSuket4W1RBz778l8NnmR7iM2xpNidRpk+d3OiipFX08EPi3OXprc=
X-Received: by 2002:aca:ecd0:: with SMTP id k199-v6mr4520957oih.227.1530746344848;
 Wed, 04 Jul 2018 16:19:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 16:19:04 -0700 (PDT)
In-Reply-To: <52724c9d-4650-9095-fb68-c4dff21a48f6@codeaurora.org>
References: <20180627125056.12851-1-vivek.gautam@codeaurora.org>
 <20180627125056.12851-2-vivek.gautam@codeaurora.org> <5b2d17e8-2224-512c-e01c-212828ecf74b@codeaurora.org>
 <2991909.NMIP74eIIJ@aspire.rjw.lan> <52724c9d-4650-9095-fb68-c4dff21a48f6@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Jul 2018 01:19:04 +0200
X-Google-Sender-Auth: _XqAHFHmqjdYNQwgM5I4mD-xYKA
Message-ID: <CAJZ5v0jb2075fcabZDxPpE+7Bo=NpcFm7kEY5QfO-ZbcfGkDyw@mail.gmail.com>
Subject: Re: [PATCH 2/2] device core: Add flag to autoremove device link on
 supplier unbind
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 8:09 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
>
> On 7/4/2018 4:14 PM, Rafael J. Wysocki wrote:
>>
>> On Wednesday, July 4, 2018 9:16:20 AM CEST Vivek Gautam wrote:
>>>
>>> Adding Ulf and Marek.
>>>
>>> On 6/27/2018 6:20 PM, Vivek Gautam wrote:
>>>>
>>>> Add a flag to autoremove the device links on supplier driver
>>>> unbind. This obviates the need to explicitly delete the link
>>>> in the remove path.
>>>> We remove these links only when the supplier's link to its
>>>> consumers has gone to DL_STATE_SUPPLIER_UNBIND state.
>>>>
>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>>> Cc: linux-doc@vger.kernel.org
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> Cc: linux-pm@vger.kernel.org
>>>> Cc: linux-arm-msm@vger.kernel.org
>>>> ---
>>>
>>> Hi Rafael, et al.
>>>
>>> Gentle ping.
>>> Do you have comments on this series. I would really like to conclude
>>> these
>>> device link additions sooner, and get things moving on the long awaited
>>> arm-smmu clock/runtime support series.
>>>
>>> Thanks again for reviewing these patches.
>>
>> They are fine by me.
>>
>> I can queue them up for 4.19 if no one has objections (Greg in
>> particular).
>
>
> Hi Rafael,
>
> I will resubmit these 2 patches as part of the arm-smmu series, as one
> of the patch in the series depends on addition of
> DL_FLAG_AUTOREMOVE_SUPPLIER.
> So these 2 patches and arm-smmu series should go together.
> Can you please consider givnig your Ack?

I would prefer to apply them myself to be honest and put them on an
public git branch for you to pull from.

Thanks,
Rafael
