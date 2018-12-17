Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31CEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7BF205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545082939;
	bh=nJuuDAdMNpOMQw8CTueZPgBLAH+b+m++4SJxoNj6Z6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O8iaXgVZMEVsOqNiZQvstMccjSoAdn9mUhd72nkFQKYhXsOqFiDCPluqiMrfGU/Ob
	 huCIFSrxYYC8s26mj1JMBk4PV7pOJFRwLUZlzXuej2W3IgOQTfKfK6uaqTp9PuYvgt
	 65m6HwbuaRB0Py9Iw8fZtdNC+XL4Lo3WrT6a/f20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbeLQVmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:42:18 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44397 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeLQVmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:42:17 -0500
Received: by mail-ot1-f66.google.com with SMTP id f18so13628373otl.11;
        Mon, 17 Dec 2018 13:42:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CiTFZ2Emf7NHYxEvHLVl8BgfwakG1WBOfabXdeusr+U=;
        b=bcqcimKJKqvP2EeedLG1gfX1ObMtwgpZLMuzHpqP5laIlr5d8iKKskdCmAvMeclIlh
         8c+dACGKSYwo99U3Wj2oAcBWDn7Z6kUXmjididLPQpf0+pqRotkfV/HVCrbcAGCu4def
         YPPoMh8IUwlMIr9/3tTOmLa6Zkn7yRGsuLDyuFnTqgdcdxf3F2m3pkwXmBfR/hWZ4jaG
         qm8iQ58bd19DgL8jUw6ujI6s61HNwAdJN0N2mgVAkyiGnSxG17HN/lx8FhOzSN0jHUia
         njyPa0+/8abDGWAyUFK2NMikrE41RRXM/Hq0i2Vz2XTx6VUqcbaYROk2KBKl4ecjjkA/
         zpCA==
X-Gm-Message-State: AA+aEWYmbIzCzwzin5bXGu+lCMBFsj9fs2oMqsfGXJHJOETKqYEPRbfW
        9S3/0oSd8wDxTjTnggM/JA==
X-Google-Smtp-Source: AFSGD/X7ztxjWFevohjYgr+rWSVuw97i3L5hS4nXX8JlQjSvuvJuu0fVnkVQvqRukf6+P1TeQ5pOLw==
X-Received: by 2002:a9d:22a:: with SMTP id 39mr11146334otb.354.1545082936723;
        Mon, 17 Dec 2018 13:42:16 -0800 (PST)
Received: from localhost (cpe-70-114-214-127.austin.res.rr.com. [70.114.214.127])
        by smtp.gmail.com with ESMTPSA id m2sm7492400otp.34.2018.12.17.13.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 13:42:16 -0800 (PST)
Date:   Mon, 17 Dec 2018 15:42:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "martink@posteo.de" <martink@posteo.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "preid@electromag.com.au" <preid@electromag.com.au>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V5 1/2] dt-bindings: iio: accel: mma8452: add power
 supplies  property
Message-ID: <20181217214215.GA16536@bogus>
References: <1545023805-31250-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545023805-31250-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 05:22:49 +0000, Anson Huang wrote:
> The accelerometer's power supplies could be controllable on some
> platforms, add property "vdd/vddio" power supply to let device tree
> to pass phandles to the regulators to driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/iio/accel/mma8452.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
