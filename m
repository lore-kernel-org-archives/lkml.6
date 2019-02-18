Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530EDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2292221901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tpbvR+xO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391311AbfBROVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:21:18 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34550 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390450AbfBROVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:21:16 -0500
Received: by mail-wr1-f67.google.com with SMTP id f14so18633677wrg.1;
        Mon, 18 Feb 2019 06:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KvO5W3n5/ix1CMmiWjgbJ0NECWDFUH/XXGsLppnW1oY=;
        b=tpbvR+xO6XHRggzsVbMWxTQzmjkqMIm0+173Cq3m1HoGjoivA+KUGM1YGP8OzSYqR1
         LoCKjU5ox4mo8MxA5OQNAFyWb5Ax9DhBgM6pxMbp2Q6fL9xSglDqVJPEjTW/esJXJ7gx
         qwXY6ILMcxXoysKo0u3cJzl5REjkD/G0H3O2au9CpPVVKZ59tzOuztp/C4bvhZBfUfKj
         0sP7E+EkemaMFTx+2HNSBikI2bKdvFaThwWJKY9N4lg2Dd2XJOocS1SAuadzcuUGYJq+
         cJj4emV6AadZTMX7JdXHBrE+nen8y8N98FBk0w+K4sswzHowAPKSSFcbcdE/sLGdev0b
         3FZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KvO5W3n5/ix1CMmiWjgbJ0NECWDFUH/XXGsLppnW1oY=;
        b=OreSw0bxhVAjFv/X0YEYnaZ7G8X+e7y5CTOmmw2kcnloskL13kfAtCcR8Cmyryzu7E
         azamjSrgsiOBSLn0NzPmTdfms4+U742Rva4+JuWuf94IKrvymUxjtu1E86culInekuYH
         obbz9whuuPv5OBLZRdmBRiEGthTfbH5tcxa/icptRcwT5Kh0DbzGVhHVaShWNDTMUz60
         rxk1Lyib5KlbXcaFQj6mR27PD1+3zjiwEIE/fE4dESRTshL9JYuku3yEi3LPxjDXs6NZ
         vYl2u5Pw3C5Pw88KqKOjBar59gHKNlVmJVAb1O5/FVXz+FAGI1D2Q2dKUoDxTzl0oO/9
         8NNg==
X-Gm-Message-State: AHQUAubWQAx0bVsxkIFiL5swsBCkBw+eIs8ySUvgyEVfNELm/8W2FIIR
        i4xCktWSOpxh5Wzm7/IIOEJ4O0ln
X-Google-Smtp-Source: AHgI3Ib6bq5EU2s8BKMEOgC9CtZO870HLkUgbhjmy0myAp8Hedad+jhueml+j7iMz/t7+cNkttH9bQ==
X-Received: by 2002:a5d:6288:: with SMTP id k8mr18060533wru.173.1550499674481;
        Mon, 18 Feb 2019 06:21:14 -0800 (PST)
Received: from casa ([89.128.102.109])
        by smtp.gmail.com with ESMTPSA id j3sm12542217wmb.39.2019.02.18.06.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 06:21:13 -0800 (PST)
Date:   Mon, 18 Feb 2019 15:21:10 +0100
From:   Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, rodrigorivascosta@gmail.com,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Martin Kepplinger <martink@posteo.de>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)" 
        <linux-input@vger.kernel.org>
Subject: Re: [PATCH] Input: uinput - Allow uinput_request to be interrupted
Message-ID: <20190218142110.GA23087@casa>
References: <20190218004305.339758-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218004305.339758-1-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 09:42:52PM -0300, Marcos Paulo de Souza wrote:
> -	if (!wait_for_completion_timeout(&request->done, 30 * HZ)) {
> +	if (!wait_for_completion_interruptible_timeout(&request->done,
> +							30 * HZ)) {
>  		retval = -ETIMEDOUT;
>  		goto out;
>  	}

Now this function can succeed or fail because of ETIMEDOUT or an
interrupt. I think you should return -EINTR or maybe -ESYSRESTART if
interrupted.

