Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84004C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D872152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i97Xy1h1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D872152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeHXDOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 23:14:08 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34244 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeHXDOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 23:14:07 -0400
Received: by mail-io0-f194.google.com with SMTP id c22-v6so5744167iob.1;
        Thu, 23 Aug 2018 16:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0i86O/FxPDMpiaEIIgpp8ue+SQ44YCclyFTesUgQERY=;
        b=i97Xy1h1esTOiwQ1OqsgMOsLlP3uT/naWcJ+JL1ge9iVL4xWfKrnBjItXi9WsBxU73
         vieI81xercLBDeD/tfyvlmX/+A6FEqE3IQE3nInk4VWdZLEMaDA+chsggTiDQHOfmk8D
         dG4d5/AlLggcewL2BtDRSnJHpXycMlgp4iX+yJDg/KaZWoAYFjNv/eOTdGRNBGAcpNdv
         G9fImoo3vtqZ2Q3yrl4WtR7qpyLCL/B1wVy6m4IuI9w9uhjVVgWOfs8D8QYTHxE8F9+v
         /zNQ9GdQxn4Z4+yVyQtNX07PlEGfRGV2tZEWY3Yv8n2r9oK1ILbQVuzck8FpjhOmJaXu
         2CyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0i86O/FxPDMpiaEIIgpp8ue+SQ44YCclyFTesUgQERY=;
        b=R1HaIN+nwK+ncT5Mw+kognjutnp1gA3jN7ZW+fPM9HrczFZC54+1XvYXiQS/NQWw4t
         mkrZsPeXpFZBoCgt9HM5tlAdd8YxTlMdpUjcOmVXBBdkpjEgW9OgGhpGnV/rZuK0GlAV
         BtUctvwoFcT3+f6vtK47qWbEqYNVv68eyyUUbeUW7rngw99HNmEibPovCKI++nrJHOQX
         60YNqCp5tGbKRo5OffoThdlP9jjnHCBLksBWon5MpyAOeAxi9C1oWLRlcYr/AJE8+TQ3
         Q7RlI0989fYpxt3u0wpGFev7aD9ThY4IBBZobUdXK3VR5uacvc9CM74ZJaH1HqWxgMML
         C9uA==
X-Gm-Message-State: APzg51Bicsi4Dm4BkESGeI3gu7/QpWzxCAa7Y7tztGZl10sbq2AttP2O
        avIlox+AunXUjbD2IxtMErY3D2DQU4JwN6Y3rIQ=
X-Google-Smtp-Source: ANB0VdZbdeYEuAXpp6ULMDxemMdqo39N2ZsfnOpN6bM2u1aNSersz5OLIts7xgr7DMSixTqz6ux6OengNiDX9DdJ36U=
X-Received: by 2002:a6b:e05:: with SMTP id 5-v6mr22448442ioo.141.1535067727263;
 Thu, 23 Aug 2018 16:42:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:5a03:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 16:42:06
 -0700 (PDT)
In-Reply-To: <BN7PR12MB2593EA63572DBF05D75CC5CFF8370@BN7PR12MB2593.namprd12.prod.outlook.com>
References: <20180816192840.31166-1-mikhail.jin@gmail.com> <BN7PR12MB2593EA63572DBF05D75CC5CFF8370@BN7PR12MB2593.namprd12.prod.outlook.com>
From:   Michael Jin <mikhail.jin@gmail.com>
Date:   Thu, 23 Aug 2018 19:42:06 -0400
Message-ID: <CAO6F7D=RUfhf1RXwR9VBgoUisc=vt3uPh6kQO=Ay+r6ynLL1TQ@mail.gmail.com>
Subject: Re: [PATCH v3] EDAC, amd64: Add Family 17h Model 10h support.
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     Borislav Petkov <bp@suse.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 1:51 PM, Ghannam, Yazen <Yazen.Ghannam@amd.com> wrote:
>> -----Original Message-----
>> From: Michael Jin <mikhail.jin@gmail.com>
>> Sent: Thursday, August 16, 2018 2:29 PM
>> To: Borislav Petkov <bp@suse.de>; Ghannam, Yazen
>> <Yazen.Ghannam@amd.com>; Mauro Carvalho Chehab
>> <mchehab@kernel.org>
>> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; Michael Jin
>> <mikhail.jin@gmail.com>; stable@vger.kernel.org
>> Subject: [PATCH v3] EDAC, amd64: Add Family 17h Model 10h support.
>>
>> Add new device IDs for family 17h models 10h-2fh.
>>
>> This is required by amd64_edac_mod in order to properly detect PCI
>> device functions 0 and 6.
>>
>> Link: https://lkml.kernel.org/r/20180815114107.29797-1-
>> mikhail.jin@gmail.com
>> Cc: <stable@vger.kernel.org> # 4.10.x
>> Signed-off-by: Michael Jin <mikhail.jin@gmail.com>
>
> Looks good to me.
>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>
> Thanks,
> Yazen

Thanks for the reviewing patch v3.

Michael
