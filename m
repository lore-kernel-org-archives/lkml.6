Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6A821C07E80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D6320839
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yoj6Ygia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D6320839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934386AbeFKSYi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:24:38 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55494 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934096AbeFKSYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:24:36 -0400
Received: by mail-it0-f68.google.com with SMTP id 16-v6so6827477itl.5;
        Mon, 11 Jun 2018 11:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EIRrKUCuoy62BBZ0NppoxusTJo43weGZNVinmsKVmvM=;
        b=Yoj6Ygiau72n5UcIteFSleE+Z6N88ZAuEmLCRoD5OXkdiG6cCXXgV/2Vu0/srDP/86
         Wthv6egn4scdN5T21x52iTpI8gA/4xrRhGEiEZFM0jm2F7pFwfNXPvTpxiLJagYQ7z+C
         y0wXWs/loYj8RPg9Uur/jWQesl9r5UWRG4qmmbiuk178zyPmFdeVeP8I26eT0sa1PLci
         bk4yaz174aHmjTKn4NCvrSrjFjeS38x1gEoASYrfDz0pXy5Mcmdmkb/EOqL2WDiGvzgT
         MhaehsUXao+9LrDJHJvXXr7FW5MtN019NglzSSddYxOptEsIDv8F6on3QkjgyDWdF8p5
         86qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EIRrKUCuoy62BBZ0NppoxusTJo43weGZNVinmsKVmvM=;
        b=c5G8R6xcIa+MHdKpbTTgaNcdS+h0goLU370yxCbKNYidzcU2MxqLCMIJVe2fCitJR2
         remJK4cAocDLEB321+RXG/gZcpRhFal8iLpONB0M7ZuGLAqFp96FYXrAtYk1WojXA4jk
         V8AtgAr+gTN36LaXP/0B1SCLyblWwx8hLAJQGoZaPO3RFBnbSoDMEVnYdHN0z09ROkqF
         e5lBZpBsICkxFd88Z6Fb1mD6guhJiOKmfY1vypwrgpKp0Ekjw4B85VhCiBAzXnUnjSOS
         YpmQPao9DOrxMMCeAPAHyaXhScybT0NCVDqAEDn1WiyRE67xPCN3Ced9AjpLvbC+2ndY
         Zwmw==
X-Gm-Message-State: APt69E1cp20Q4jq8k/FGV1scbPOXb/MNjeqAiFwX+oekRyMkLDKTSeD+
        Lq+AKEeK2w2LVcPh61mjgVXJ2RC8fWvsckA6vQ==
X-Google-Smtp-Source: ADUXVKJjOidjikFxt9DLAh2M1r3AS1FoZ+tFd4V33rXG5wWJbn5tT7fcmd3YW2oGSES4hUz9K0C886B4MXC4IVEGbN8=
X-Received: by 2002:a24:2e43:: with SMTP id i64-v6mr126342ita.0.1528741475786;
 Mon, 11 Jun 2018 11:24:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:ba01:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 11:24:35
 -0700 (PDT)
In-Reply-To: <20180611181646.GA5537@rob-hp-laptop>
References: <20180607145821.322979-1-avifishman70@gmail.com>
 <20180607145821.322979-3-avifishman70@gmail.com> <20180611181646.GA5537@rob-hp-laptop>
From:   Avi Fishman <avifishman70@gmail.com>
Date:   Mon, 11 Jun 2018 21:24:35 +0300
Message-ID: <CAKKbWA4gm1x8VazdMjZ6a9bwGmt=_mZYS2S3FnB2x36Ng+cjCQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: usb: new ehci-npcm7xx dt
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        mathias.nyman@linux.intel.com, bjorn.andersson@linaro.org,
        jhogan@kernel.org, albeu@free.fr, chunfeng.yun@mediatek.com,
        Tony Lindgren <tony@atomide.com>, baolu.lu@linux.intel.com,
        Alex Elder <elder@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        hdegoede@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 9:16 PM, Rob Herring <robh@kernel.org> wrote:
> On Thu, Jun 07, 2018 at 05:58:20PM +0300, avifishman70@gmail.com wrote:
>> From: Avi Fishman <AviFishman70@gmail.com>
>>
>> Device Tree documentation for Nuvoton npcm7xx EHCI.
>>
>> Signed-off-by: Avi Fishman <AviFishman70@gmail.com>

Reviewed-by: Rob Herring <robh@kernel.org>
Rob, if I understand you want me to add another version (v5) with the
above line (only on the dt)?

>> ---
>>  Documentation/devicetree/bindings/usb/npcm7xx-usb.txt | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/usb/npcm7xx-usb.txt
>
> Please add acks/reviewed-bys when posting new versions.
>
> Rob
