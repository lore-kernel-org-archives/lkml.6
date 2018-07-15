Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EACECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 14:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4832124D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 14:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEgdI3y9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4832124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbeGOOou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 10:44:50 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45607 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbeGOOou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 10:44:50 -0400
Received: by mail-io0-f194.google.com with SMTP id l25-v6so35341508ioh.12;
        Sun, 15 Jul 2018 07:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jwrHmSwaKFEj7UAzOiGtg/R2tT5uN81aJzsvscf64Zw=;
        b=mEgdI3y97Fu6e4ldcWAOAEbzsC8aAFR5fxceJ4JESjNiAdhvl+UZ1pl5U+hxUNFtrk
         ANn4TbnKHFPa2Hl08mCg/Uw5Aa10RVFt5jPiNIbqEMpn4ZclLGf0KNXSE3cisTQFRJNd
         Vi93OwuhokafpGufptDxTuPiMhXRTv5H2US8Ja/EqD8A2JKCfX0jHU+cDrkO51qx2DGD
         qvp882W/jJg00L5RloWtIvO5sOW8DACrB7rWbJ0LsmMpJeagrX0eJS7pMqpJP+8CsGU5
         OvVrIqa62bza1VwhNJ2tBCipgdCgK2bfelOs0vUCp4oDmAmIdymMuc4cuKOMj3Q7Dci2
         7r0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jwrHmSwaKFEj7UAzOiGtg/R2tT5uN81aJzsvscf64Zw=;
        b=e8sOPLxvPZWM5z1OAIIPnoD/m2wWW5Utk7ZLIMpbCBVti580257egtE/TNUJ6IQUPT
         uIp9XjQD+MteGM3GHbl558kRimigpZpKZ7hPGBDqKhia9gzv4SrzAOXyDRWf6L/6avx8
         yIav9LWFW9R40BbPTCJHrXOfSoyCxuS5UqoSpgvn2dUdHOVTBOkjUIyiSP/omO51vC5+
         IOXt/b9y207DQY5XhLf9f9jastt6DizwnSF6Nv+gLKS5py186gRB/UjZnqt+EwuwV+tD
         S+fJAc/eq2Szt0ucKMcoZ6unRsqltUW1uChMDrNBOHRG2U6EzmBJ1SH2YjSUNF1L8XFF
         7UGA==
X-Gm-Message-State: APt69E38bhOpUL/YMZlObhd3Lbu8lEJFlSpNa9+a0ZdDtx2cwGichxX0
        hRTIMBeC1631rp94XIW6jn9sZXtdN59ByuUlHA==
X-Google-Smtp-Source: AAOMgpdu+QMPTpDosa0vVVeKibAU0ea8qUyPHMDJ8zzx2YmsihrjPZrjufLITOfnx3WZPCb2ODlLqpgZUlhoA2qb1fI=
X-Received: by 2002:a6b:c8c8:: with SMTP id y191-v6mr36779929iof.295.1531664503224;
 Sun, 15 Jul 2018 07:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180711053122.30773-1-andrew@aj.id.au> <20180711053122.30773-2-andrew@aj.id.au>
 <20180711200450.GB17291@rob-hp-laptop> <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
 <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
 <b6ced4cad4d7ff78330181b2c893855c23103953.camel@kernel.crashing.org>
 <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>
 <a521b9fc-4c10-06c1-fd73-5c64379538f6@yadro.com> <bc2d6bd30ce243768d07b2aa5ed9cee4@AUSX13MPC105.AMER.DELL.COM>
 <20180713190320.GB30539@kroah.com> <8dfaea969aeb4b0fbd049b4e48389b43@AUSX13MPC105.AMER.DELL.COM>
In-Reply-To: <8dfaea969aeb4b0fbd049b4e48389b43@AUSX13MPC105.AMER.DELL.COM>
From:   Avi Fishman <avifishman70@gmail.com>
Date:   Sun, 15 Jul 2018 17:21:31 +0300
Message-ID: <CAKKbWA4xBwZJir0DJ+GnXYs+b9bkark4QZO-QxSkKqsRYoQ=yA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC
 control fields
To:     Eugene.Cho@dell.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        a.amelkin@yadro.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stewart@linux.ibm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ my vote as Nuvoton's BMC FW provider.
On Fri, Jul 13, 2018 at 10:07 PM <Eugene.Cho@dell.com> wrote:
>
> >> Dell - Internal Use - Confidential
> >Really?  To a public mailing list?  odd...
>
> Ha yea sorry - I was so excited to show my support, that I jumped the gun :)
>
