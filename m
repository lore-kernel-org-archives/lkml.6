Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB36C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 03:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5251821718
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 03:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IxlaJ3RE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5251821718
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbeHNF6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 01:58:53 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34958 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729426AbeHNF6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 01:58:53 -0400
Received: by mail-oi0-f45.google.com with SMTP id m11-v6so31115144oic.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 20:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ANCHhM1DyJD/ylNhFS1aabwqzXf7xwozd0U5GYas1Vk=;
        b=IxlaJ3REcDyWKXGRzxinbi5e1BbOx2ym79rMpVwv1UxqNBN+2mO9qrjgMVyLzefGw7
         fjee8WKtvhGls/nFTzbobNZwcKF/5/I+Yk7QnQWO3GFFvjdp9+L2MB5CL2ZWT7z3Mi6W
         3TfRQLGoP/clQy7ctWlNfq5BcLGHqypfXSik0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ANCHhM1DyJD/ylNhFS1aabwqzXf7xwozd0U5GYas1Vk=;
        b=XYjLNuu7cNbyJEBfoEVJGsiQKDx//o67k5eG9Uk7LLP3wWU87qbWToDpNviibrmOgU
         YIl1UurBTnBXE+rxj7GOHwFNJ3KH9zTppcyog+u7yZ2FxypYLFxKiI9UPiNaUx9HG8oh
         wypx3AL5+W1omRjG7apWde/53KPwG2awOmMgAu0k53Y4PnIR/xt5ueT4NbZknNsGxfsg
         iHkbYCAcPKlkTMsiIS9vwlm8QH9c7/cY1eC0AE2l3IiIQC+qGrzLq7uok8ohQmjNqn0H
         KbTe2hZp/Ap6snd3ZcPh5lPgAOjIUm9rCt/aWnra7tlWyAPfo9JPz6iRhG9IhW6JUisW
         2//g==
X-Gm-Message-State: AOUpUlFAz1dQ/C6Ve+/nKQWSypj0l8WlX/rgzymlsn4GGBW5i4MHeTT1
        i55rnbYrDdqlsKMXKUFedUbHHuHdnhym+D0b8wdNbw==
X-Google-Smtp-Source: AA+uWPzf4z2k6sfEufvDZbiZ9Yew+JCXnW6O25B4l9QBAQPCwBrQ+iwImQG05rjJSdV4A8AH9kOwg3qiSg40LJUBoEw=
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr18846770oia.154.1534216424875;
 Mon, 13 Aug 2018 20:13:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6043:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 20:13:44
 -0700 (PDT)
In-Reply-To: <20180814015416.GA29046@jc-sabre>
References: <1499432825-15820-2-git-send-email-srinath.mannam@broadcom.com> <20180814015416.GA29046@jc-sabre>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Tue, 14 Aug 2018 08:43:44 +0530
Message-ID: <CABe79T4sjn=BwjYtSd2N_HmDhCzrqr61DBu-ZZxC4DNnAswzmQ@mail.gmail.com>
Subject: Re: [1/2] dt-bindings: phy: Add stingray usb phy documentation
To:     Jayachandran C <jnair@caviumnetworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi JC,


On Tue, Aug 14, 2018 at 7:24 AM, Jayachandran C
<jnair@caviumnetworks.com> wrote:
> Hi Srinath, Ray,
>
> On Fri, Jul 07, 2017 at 06:37:04PM +0530, Srinath Mannam wrote:
>> Add DT binding document for stingray usb phy driver.
>>
>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>
> The Broadcom Vulcan chip (now Cavium ThunderX2) uses the same USB PHY
> from what I understand. Our hardware team reports that there are some
> failures seen without the a custom PHY driver.
>
> Do you require this PHY driver on regular operation on Stingray? Or is
> this for some specific functionality? I am asking since the issue
> reported here is on switching between a USB 3.0 and USB 2.0 devices.
We need it for regular operation in stingray.
>
> Any plans on submitting this driver again?
I will submit it ASAP.

Regards,
Srinath.
>
> Thanks,
> JC
