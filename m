Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52C6C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C9A206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fkklsq8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C9A206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbeKUEAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:00:03 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36492 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbeKUEAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:00:03 -0500
Received: by mail-lf1-f67.google.com with SMTP id a16so1931302lfg.3;
        Tue, 20 Nov 2018 09:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Qy+yv7yCvhWAuj3VlLr04ZmJwklJFZGR+jPGTDoQ04=;
        b=Fkklsq8TsS4qmMlpfKgRE0Oeu7p34ur/AzffTu2BwfKRooB8hqlpLmHvC/z8wAAM8O
         mW0OQWRvR7Uq5fouiRvLAVDYFd+nSM1PL1/2f0hR29ff4zsBlkV+A7aIHqUHNYUT/7cg
         hm+HC51u8RKDou3JTwYdQpQzHV3pTAYIaBR7nry6Oj5jRRlBrFWpRwOv4L+b2Zyibokv
         NHnvsYpi+7J5AMiM5ByW3dM9p1VcrwnLnmOF+SF00B1wqJ7ECJoGN8XDfNk5uWlK44WH
         6zodHQhDMoyP8+c4Wx7LOK3/RrTI6w+6qs8CjhTebM7yLDvS+jTxedVtwdAcQjv8A+un
         RM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Qy+yv7yCvhWAuj3VlLr04ZmJwklJFZGR+jPGTDoQ04=;
        b=Pl/a/ZAlYIZTZjTeJZsqbfWOMJd9T1iERlyvU8h4HVvN+WolOoffCwjRb5sHSPFUhO
         W9qDVqH7MrfnrG/Tn+lXztirqbZejXx2cVNGfjfPe8c4NwhXXz9gNHuhhn3boJ3+pkGT
         8tegAvwXeOXoPkDLZax9d0rfTQtglt9RX1POXTfd5zbOC//DLSD7KUCdQLv6ynZeN6zr
         7N2PHlajVPYEvJatdUoRUkGfEG7yjCfbk5JtR8jA1tU8tw4TjRdMiWqUw7C7vHs33JDH
         6C2VU59xwj2dEIqQsxlrcm66owLNXCOmF0qqCrz7fYpT7lvTxnZ6TboCi56h1M2PB5nB
         ewTg==
X-Gm-Message-State: AGRZ1gLBh9zng+HIFAdBHbyRoRbgyUgh5M1YUra3d22hT0E+ut6i0zN9
        IXLa8nEXJfcSMz30mQQUVaI=
X-Google-Smtp-Source: AJdET5em8FtO3DpW6xOpTdBH//6FHQzBBYCzJbmMZhZ5S/mdlQFjKF84FYLZnQqjDs7F3/R+G1YoGw==
X-Received: by 2002:a19:f115:: with SMTP id p21mr1607949lfh.20.1542734985479;
        Tue, 20 Nov 2018 09:29:45 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id m1sm6038497lfb.56.2018.11.20.09.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 09:29:44 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gP9qJ-0005M3-Nk; Tue, 20 Nov 2018 18:29:44 +0100
Date:   Tue, 20 Nov 2018 18:29:43 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V1 1/1] USB: serial: f81534: fix reading old/new IC config
Message-ID: <20181120172943.GJ19900@localhost>
References: <1542250724-11667-1-git-send-email-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542250724-11667-1-git-send-email-hpeter+linux_kernel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 10:58:44AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> The F81532/534 had a internal configuration space to save & control
> IC state with address F81534_CUSTOM_ADDRESS_START (0x2f00). Layout
> as following:
> 	+00h: to indicate the section is valid
> 	+01h~04h: UART Mode & port availability
> 	+05h~08h: Output pin control on IC power on
> 	+09h~12h: Output pin control on working <-- New added
> 
> Old driver will use +05~08h as default on working, but newer IC will
> configed with shutdown mode(7) in 05h~08h and working mode with RS232(1)
> in 09h~12h. It'll make mainstream driver not working.
> 
> This patch will make mainstream driver compatible older and newer IC.
> If using a old IC, the +05h~08h will be 00h~06h, we'll direct apply it.
> If using a new IC, the +05h~08h will be 07h or larger, we'll read +09h~12h
> to apply newer configuration.
> 
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>

Applied for -next. I guess you can ask Greg if he's willing to take this
into stable once 4.21-rc1 is out (as it is enabling support for a new
class of devices).

Thanks,
Johan
