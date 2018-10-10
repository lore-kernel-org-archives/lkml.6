Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7EDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89C22086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gILtjNDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89C22086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeJJXsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:48:07 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35839 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJJXsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:48:07 -0400
Received: by mail-io1-f65.google.com with SMTP id w11-v6so4338699iob.2;
        Wed, 10 Oct 2018 09:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=W/SCJ2DRfdbnmeO/vyY7pKE5M9KfojecjS9OEkmSLts=;
        b=gILtjNDw4zhOcYwxYNJrV2pQVSPMOipAZc/DiAvLHxFRKhfJ/atDIkQD4dTX2wI8mb
         PtfYYcwBc1R1UJBkcNnmWdeZFlfU4yEuNy9cTW7v4bxbG50y5nWqtR3aLDFS1FOGDbV8
         MX9OfwzApo3umYbh+g3GNBrtvuL2gnxPdshXc/ixZXjLJoUBwabk+kv8xCFaNrCX9pBg
         ZITblEemr168Evw4FncvBrteuLhQcItsRW/n0SRwdbVkuNe5NVqBLpo+MET/NG3rq/4l
         89tTw69jC4obGwm84gy6YsW6B3Ca8CwClnlithEMO9paLZUr65Ez70kzheVnOy8XhSwU
         eeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=W/SCJ2DRfdbnmeO/vyY7pKE5M9KfojecjS9OEkmSLts=;
        b=DVx1I5AhEbHEHl6dZCuxx2rEX2GPovJ3K5/s+FBVJb4N5sL3yxaTsRPYLpL0u2x3XX
         8ya+ZRiD+jECPCELfPv0FTeADSgeY3xgJ3UXcv4k6VYx6GuLzwwP4yDmgntA+BUVA1h8
         gV57/oAodZF6KcnZVGegBdkS9PBsAO4WNtCofMftmikBvWgH2OZjQyc7Ljdcb0rNVFUh
         RJwITOMbwWAG55L876ieCNHW4dpEYVZ7k8gZCon/jCSbCJptG2jfJ1uLF1UdYorl3uJ1
         fxV+jB+cXqCW1D+hfE790hwqM2yJNtSMdGY9lktYF664e5jJKr5i+Dl6pQVLOhdfx/u+
         LOeQ==
X-Gm-Message-State: ABuFfoghDNh9rcx6Tf8TOoHtRsn/ttnH/DxrD6aEW0/HNzU6iqJrZ9mQ
        EU5XKaCJGxFcLt93Mvy2Z5R2qQ+s
X-Google-Smtp-Source: ACcGV61DrxKYoMs4cBAoXzG0Ladgouy3Am3jowbZYfYQpA9eMUu6cu052OhQHVRMHRHLp4SWeFgvtw==
X-Received: by 2002:a6b:900a:: with SMTP id s10-v6mr21427356iod.231.1539188712327;
        Wed, 10 Oct 2018 09:25:12 -0700 (PDT)
Received: from nexus5x-flo.lan (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id b26-v6sm7443089iod.38.2018.10.10.09.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 09:25:10 -0700 (PDT)
Date:   Wed, 10 Oct 2018 09:25:01 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20181010144631.GE3368@kwain>
References: <20181001095714.26024-1-antoine.tenart@bootlin.com> <25a88126-2397-a1fb-0c0d-06504bb348ca@gmail.com> <20181002065937.GB3368@kwain> <20181002124323.GC9155@lunn.ch> <20181010144631.GE3368@kwain>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next] net: mscc: allow extracting the FCS into the skb
To:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
CC:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, quentin.schulz@bootlin.com,
        allan.nielsen@microchip.com
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <28179B83-2C71-47FA-9D9C-49237E4A07AE@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On October 10, 2018 7:46:31 AM PDT, Antoine Tenart <antoine=2Etenart@bootl=
in=2Ecom> wrote:
>Hi all,
>
>On Tue, Oct 02, 2018 at 02:43:23PM +0200, Andrew Lunn wrote:
>> > The question could be "do we need len +=3D ETH_FCS_LEN" to account
>for the
>> > FCS when NETIF_F_RXFCS is used", but I looked at other drivers and
>it
>> > seemed to me the FCS is not accounted in the stats=2E Should it be?
>>=20
>> There does not appear to be a good answer to that=2E I submitted a
>patch
>> to a driver i'm using to not count it, so that the stats counters we
>> consistent with another driver=2E The patch was rejected=2E
>>=20
>> I think the best you can do is flip a coin, and then document it
>using
>> a comment about if it is/is not included=2E
>
>I'll leave it as-is then :)
>
>@Dave, Florian: it seems to me no modification was requested after
>discussing those changes=2E Where do we stand regarding the patch?

Silence means agreement, thanks for your explanation, no more questions or=
 concerns on my side=2E
--=20
Florian
