Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBF7C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1722086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOlpRvw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1722086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933708AbeFRL0X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:26:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33934 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932585AbeFRL0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:26:21 -0400
Received: by mail-wm0-f67.google.com with SMTP id l15-v6so14591998wmc.1;
        Mon, 18 Jun 2018 04:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=y8+Dfg5uoUuePZcclvO2hG8Z0haRSACJE6K1CTeDvWI=;
        b=QOlpRvw/NZbY6ZgGw6UDhHkgjblwE3gCNGxoNUZGORE1g5wJL4oMQtlO/U5AZgIorG
         H4UZfhINeAv4L/dZYl7jY6tlbexhDxDPKF0YFCEpQVVCNLpn/EPZy6zMB5CySSJUEoVS
         kDYxBurNGqMtkImz+MdW9L/5YKvmJjit4XFUNOOgLE7ynq9PWAWAJWYkE2phJRdrMhog
         RxJFge0Yas9kPDZGLA1TgAMP3wlLdv87wqY3rAtE+vKbJTtCV17TltoEivs9U5HHSGU/
         PxMkpjpu6wff0NwcShV4GAexzqtJYDlXBjacmgaY4zmzOKLyNVnP1cuQIOKrliMZSY9J
         er9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=y8+Dfg5uoUuePZcclvO2hG8Z0haRSACJE6K1CTeDvWI=;
        b=Pnr7kb/EFyt3t3/Wkcz4sy4KyHb1QgwuKWUXYt+1KYUfC+x1bqXQTPiqpcRb4moSbo
         SRozHqM+pQh0tjV/5RCOVMXndRvcu2fYE5y4/DhxLMfS2ZEbZ6t5l1gNE8znwoxwzPoX
         Wy8VfzXBUw8LG9i8r/1Wviv0EmMI8QnUdxnxydxMly3mo7/YM1KIzeQOLfLM5cv3/s9M
         xDxdGY/7wD9SUhrdIyag4f30y8kQXEG3hfwEXT64H4I9YSVOFPmLokwVzLfYCbOTJGRO
         iwwyFeehZbrbOuL9+Ux5SD58qqFVw01DTiR2oJ2hIl2ou/cIBCqntNrOkRhQ8IS5o8Bg
         Xweg==
X-Gm-Message-State: APt69E1tN1zZ7zlxokkSIW0233LLrf0kSfcrqK/qcQYEkCWqucsiJ0kg
        NrcdH0XtNLrFP9KTK9nWypM=
X-Google-Smtp-Source: ADUXVKLaPbkImOWnA0ZG/lSetKvdFhIFrHXUaJkob6kg6UQ2EH5O/wH48wUt1TVxmmyQlhgrYB6LLA==
X-Received: by 2002:a1c:b954:: with SMTP id j81-v6mr7952559wmf.89.1529321179983;
        Mon, 18 Jun 2018 04:26:19 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id a17-v6sm13342182wrr.81.2018.06.18.04.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 04:26:19 -0700 (PDT)
Date:   Mon, 18 Jun 2018 13:26:18 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ThinkPad T480s & LED_MUTE, LED_MICMUTE
Message-ID: <20180618112618.hcwiacfzzu4swwd2@pali>
References: <20180608111057.4wxpg7m7nm7suf6n@pali>
 <s5hk1r01acc.wl-tiwai@suse.de>
 <20180615190959.pqipwnm6a3tf3lxc@pali>
 <s5hmuvvtdmi.wl-tiwai@suse.de>
 <20180616154309.ualrx2py6ndr5xgz@pali>
 <s5hh8m2u3cp.wl-tiwai@suse.de>
 <20180618102806.vwm4rhvxhn6hi43z@pali>
 <s5ha7rsz8i8.wl-tiwai@suse.de>
 <20180618112121.cl76a3oozsbbbqnb@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180618112121.cl76a3oozsbbbqnb@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 June 2018 13:21:21 Pali Rohár wrote:
> Now I see that in Debian backports is some 4.16.12 kernel version. I can
> try this one (and later compile one from Linus tree).

Tested, this version is working fine and leds works as expected. And now
also snd_hda_codec_realtek is loaded.

-- 
Pali Rohár
pali.rohar@gmail.com
