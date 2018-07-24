Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E865C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EB420685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52EB420685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388719AbeGXW7p convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 18:59:45 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36057 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388488AbeGXW7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 18:59:45 -0400
Received: by mail-io0-f193.google.com with SMTP id r15-v6so4699355ioa.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 14:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1yqp9sw96nf6iRMIc7/i74VIBHuCIaWujDI31lJSzK0=;
        b=ACHCQS+nKJmzOzLJe38j5s7sjhuuvxl/19bTJ4rq7ytj+spGQcXAVe2QtoA2qyt/kv
         wEQBLv1rK+hNGIYjLKWdPL2vMT/ThNH3LjqN9UJOc2vNWpqPCIRtQ81RrtjG4KxgkZxM
         4e5Y+V+EghFr9gZCQOQFmQslr2LFMlFH4C/ATRoqVB1xvXOL0VJCEWX3oxUbEB3c+cKP
         6NNrKmHB3b/NwdN4pW1VlqYAopGK5vUVf1tih9JMrLhaS79BxIdHDA/+mPVTElXvjvOo
         8XNNhuR0lUtFMbksSc9ELyKemTuDRiZRnnVG7vbkKX1bnI8QhATW4nnZjR4Px9qUjViD
         Aqmw==
X-Gm-Message-State: AOUpUlEp4DT1lZXuSFJlFLW4f+jz1t/KgKVETSvXW+G2r4FngZg6F/3I
        7j9CxuLVF+aci7MZEPE4ATZB8y3GQhw=
X-Google-Smtp-Source: AAOMgpcI+pktUCt1lIE4sem49Vce+RBNtyhrSBlGh4l8oSSiZVWC5KLpuGoXzQ+wJ8WwvQISUqGaxg==
X-Received: by 2002:a6b:a082:: with SMTP id j124-v6mr14660845ioe.35.1532469076203;
        Tue, 24 Jul 2018 14:51:16 -0700 (PDT)
Received: from mail-it0-f54.google.com (mail-it0-f54.google.com. [209.85.214.54])
        by smtp.gmail.com with ESMTPSA id t64-v6sm1571937ita.13.2018.07.24.14.51.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 14:51:15 -0700 (PDT)
Received: by mail-it0-f54.google.com with SMTP id h23-v6so5893680ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 14:51:15 -0700 (PDT)
X-Received: by 2002:a02:8a59:: with SMTP id e25-v6mr17335696jal.82.1532469075269;
 Tue, 24 Jul 2018 14:51:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:52c2:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 14:51:14
 -0700 (PDT)
In-Reply-To: <AM3PR04MB33800EB3509E6715AC49DC294550@AM3PR04MB338.eurprd04.prod.outlook.com>
References: <20180724142131.28970-1-roy.pledge@nxp.com> <VI1PR0402MB3485147A99F219D5FA1B668B98550@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <AM3PR04MB33800EB3509E6715AC49DC294550@AM3PR04MB338.eurprd04.prod.outlook.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 24 Jul 2018 16:51:14 -0500
X-Gmail-Original-Message-ID: <CADRPPNQTPKdT2wWO5tyt-tRhdkMfWRExjUjmwDBwRZ8053jSng@mail.gmail.com>
Message-ID: <CADRPPNQTPKdT2wWO5tyt-tRhdkMfWRExjUjmwDBwRZ8053jSng@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] staging/fsl-mc/bus: Move DPIO from staging to drivers/soc/fsl
To:     Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
Cc:     Horia Geanta <horia.geanta@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 9:38 AM, Ioana Ciocoi Radulescu
<ruxandra.radulescu@nxp.com> wrote:
>> -----Original Message-----
>> From: Horia Geanta
>> Sent: Tuesday, July 24, 2018 5:35 PM
>> To: Roy Pledge <roy.pledge@nxp.com>; devel@driverdev.osuosl.org; linux-
>> arm-kernel@lists.infradead.org; gregkh@linuxfoundation.org; Leo Li
>> <leoyang.li@nxp.com>
>> Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>; Ioana Ciocoi Radulescu
>> <ruxandra.radulescu@nxp.com>; linux-kernel@vger.kernel.org;
>> arnd@arndb.de; catalin.marinas@arm.com; robin.murphy@arm.com
>> Subject: Re: [PATCH v3 0/4] staging/fsl-mc/bus: Move DPIO from staging to
>> drivers/soc/fsl
>>
>> On 7/24/2018 5:21 PM, Roy Pledge wrote:
>> > Move the NXP DPIO (Datapath I/O driver) from the staging/fsl-
>> mc/bus/dpio
>> > directory to the drivers/soc/fsl directory.
>> >
>> > The DPIO driver enables access to the Queue and Buffer Managemer
>> (QBMAN)
>> > hardware of NXP DPAA2 devices. This is a prerequiste for moving the
>> DPAA2
>> > Ethernet device driver from the staging directory.
>> >
>> For the series:
>> Reviewed-by: Horia Geantă <horia.geanta@nxp.com>
>
> Also:
> Reviewed-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>

Applied to soc/fsl tree.

Thanks,
Leo
