Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA3FC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77AC2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77AC2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeIEK0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 06:26:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35342 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbeIEK0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 06:26:01 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so6389419wmc.0;
        Tue, 04 Sep 2018 22:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AMgbBa6UlbSPoYWx8CWPWLAm3ycxSclGGmxfjZo9fGQ=;
        b=gxnqfnOyd9FyswiZTV/5o/Kmz+3H6qWPedUgkniiKAgF/pfWWzrwy9l4NackRlMpJa
         PcG0hdrDHySEBH6+DoYXf+Ps5YWM1gkbkrTVZ4V9xEmDCEFgLpE4P5q42FLDN9+DwNm6
         n2YzkO6ENwi2qo9pVf4oJJC7h1/eBWkIOfa4m1ypLINGf2pdWgt/aa95kYgnl+8tJrpF
         hKILWaZZqsqdNte/6/WMWlD3ZV9DKxnGkrQKJo73KGMDAuqTSHtuwE/2mEXYlyUX0Ze2
         isbSSQURFzt9iRCMiHbZwprPTa7479Qms6akxDy7lU8/X17UiR8N4MKGoSaJTIChPWgm
         SZsQ==
X-Gm-Message-State: APzg51BVgqwNMch0INe/pTYt1ze0qUBdwcY4bTGWSNIdMQ3xg6XpmNyo
        Mtcs6a2TPNqJjltih4QBckHqtls4Azg=
X-Google-Smtp-Source: ANB0VdZYoOUBpkq//HF0IfIoMfsptM2VwGDLH4pTW7AYgmHZED0Jq2isYxlAMgqax4QMRgKFgB4Jkg==
X-Received: by 2002:a1c:dac9:: with SMTP id r192-v6mr9937057wmg.141.1536127047254;
        Tue, 04 Sep 2018 22:57:27 -0700 (PDT)
Received: from ?IPv6:2a01:4240:2e27:ad85:aaaa::70f? ([2a01:4240:2e27:ad85:aaaa::70f])
        by smtp.gmail.com with ESMTPSA id q3-v6sm1520399wma.45.2018.09.04.22.57.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 22:57:26 -0700 (PDT)
Subject: Re: [PATCH 01/25] tty: Change return type to void
To:     Jaejoong Kim <climbbb.kim@gmail.com>,
        sergei.shtylyov@cogentembedded.com
Cc:     devel@driverdev.osuosl.org, Greg KH <gregkh@linuxfoundation.org>,
        linux-um@lists.infradead.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-bluetooth@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-serial@vger.kernel.org,
        USB list <linux-usb@vger.kernel.org>, netdev@vger.kernel.org,
        sparclinux@vger.kernel.org
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
 <1536029091-4426-2-git-send-email-climbbb.kim@gmail.com>
 <3b5cce6a-b4c3-edf9-51c8-0a16f156e128@cogentembedded.com>
 <CAL6iAaKzDPe7CMGR8VOBZRsJqZuNB1=zek_YVvwcKnjimbox2g@mail.gmail.com>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d3d5df26-4678-2539-e579-1c48bc726163@suse.cz>
Date:   Wed, 5 Sep 2018 07:57:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL6iAaKzDPe7CMGR8VOBZRsJqZuNB1=zek_YVvwcKnjimbox2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2018, 03:08 AM, Jaejoong Kim wrote:
>     > @@ -688,7 +688,7 @@ extern int tty_port_close_start(struct
>     tty_port *port,
>     >   extern void tty_port_close_end(struct tty_port *port, struct
>     tty_struct *tty);
>     >   extern void tty_port_close(struct tty_port *port,
>     >                               struct tty_struct *tty, struct file
>     *filp);
>     > -extern int tty_port_install(struct tty_port *port, struct
>     tty_driver *driver,
>     > +extern void tty_port_install(struct tty_port *port, struct
>     tty_driver *driver,
>     >                               struct tty_struct *tty);
> 
>         You need to update all the callers in the same patch -- the
>     kernel must
>     remain buildable after each patch but you seem to have spread that
>     update
>     among a lot of patches..
> 
> 
> OK. I will make several patches as one patch.

You don't have to. Just reorder the patches as suggested by Sam. (First,
make everybody ignore the return value, then change these return types
to void.)

BTW you can mention in this commit log, that this change is possible
after a3123fd0a4a5. That commit made tty_standard_install to always
return 0.

thanks,
-- 
js
suse labs
