Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5601C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F91D2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHv2OB6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F91D2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeIGMU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:20:59 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:43830 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbeIGMU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:20:59 -0400
Received: by mail-pl1-f178.google.com with SMTP id h3-v6so2849524plh.10;
        Fri, 07 Sep 2018 00:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rU9CaFweO+TjJN/F9DgOtrpkoCOIzVqMwCHiJwtoxjM=;
        b=nHv2OB6Y3qchfqOX4OJBEZ5JB/nDft2wMqL/8+MaQgnCrgfPyOZks43POptI0ETG80
         jNdlZv3k4j92wJQLB75DQLTEQqUwCgPJc63LJjmieZNzzuNU6Ybol5GHMoRTb1vTflXF
         5nP2pB+qB9gt4M2IYSXnRnWIH+UaP2U/EV8WeTCYpwL8B1Hqe49Ppn9UScOjQIkUENmk
         xLsMNdx0zRB3skG1Q0ESxu/Uo5fY8nCsWy0sQxvHKJ9oGZi8GBsuEFWQoxP19+gSxf4v
         WOzOvC00rV1zIa+KDn7o9izkPJ3BT+/oBoDiCulNIop5RHgLG+fHeVsXe9osHtoqaspi
         4T8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rU9CaFweO+TjJN/F9DgOtrpkoCOIzVqMwCHiJwtoxjM=;
        b=W+I9Ckhn2JZHRfWzkQqBou0GGerOxdwySkzflyUbcSg1/dbKya8T/S0b4eb/hM05TX
         WKFamenU8dOeho58yI6/C2C4sArtZOhaZmWHTEsLYMplUaXn9dpqnonScV180Q23mItH
         F/eClEsMuUJ4CiWVLm356PAYF/zhh6qLCNVC8sfnb7qtI0W/a0xOFJhg6jGbEUELnIqM
         DzLuuzKF2mr6Vz3fzwXWsle+ewNCLYDG053rHYEFl3OzM4EYhfgNK3sgqOiaDL7kJKH6
         W0Ie+mexN4rnsIx5Fp0QOGwH6vZxplkhFqUdXdc1KeJGjaOIhY2SYTF5ZjX/OlpNCegx
         VtbA==
X-Gm-Message-State: APzg51CzlcpuBz1Og3NHomeZ6Js4y0K2YXJ4QZtYk8GjCq2ShJDdEHFE
        evtmhFeeJKQWMt3C8abI2F4=
X-Google-Smtp-Source: ANB0VdZW3eqxEgltsysnE1JOtzKANvWqRrGztHthqR1YPh7buNxKvX6SImcLiEH1hJlpUqbtL5cvnQ==
X-Received: by 2002:a17:902:bd4a:: with SMTP id b10-v6mr6670052plx.209.1536306079720;
        Fri, 07 Sep 2018 00:41:19 -0700 (PDT)
Received: from [192.168.1.54] (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id r25-v6sm8690078pgm.59.2018.09.07.00.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 00:41:19 -0700 (PDT)
Subject: Re: [PATCH V2 1/4] USB: serial: f81232: clear overrun flag
To:     Johan Hovold <johan@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        hpeter+linux_kernel@gmail.com, Oliver Neukum <oneukum@suse.com>
References: <1535593634-22004-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1535593634-22004-2-git-send-email-hpeter+linux_kernel@gmail.com>
 <20180905143933.GC1089@localhost>
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Message-ID: <648af074-4082-17e6-270a-7d61ba702576@gmail.com>
Date:   Fri, 7 Sep 2018 15:41:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180905143933.GC1089@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Johan Hovold 於 2018/9/5 下午 10:39 寫道:
> Looks like you ignored Oliver's comment that you needed to take care of
> any pending lsr work both and close and suspend.
> 

I'll add the cancel operation when suspend() with next version.

Thanks
-- 
With Best Regards,
Peter Hong
