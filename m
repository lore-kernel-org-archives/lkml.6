Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B7BECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F02E2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmm7PMvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F02E2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732677AbeIXSjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:39:36 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:40239 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbeIXSjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:39:36 -0400
Received: by mail-lj1-f171.google.com with SMTP id r83-v6so39322ljr.7;
        Mon, 24 Sep 2018 05:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ounyAlZG9kLozcvtnoKN4U5I/ChqzwDJGCowBl2XLxc=;
        b=hmm7PMvDyGUT/i2rryhwDN9Qieu8jqz4S6pEVrv7Ho5J/jI5RH42QN+5990xwVbHm0
         6qNSR1vjOoDGN0CQGDpsWm07359I6l72GBs6vT+QDkJInxN0dMTYLduFeJBf+wZxKhm6
         mEBjiamg5sX3MUQ7K63GG8o0JOI9G7UCYgOwtcAYqAba9HcoVxRb7zmUzRx68hZYRfpt
         NCM+s8Kmpznpgluv6gPezZveaGUrlB5khJHK7SlTBesVRGYQaDZ2bR9Y1qLCtWxcsjNV
         XJvZs7+UZ1RIm3jWOnB7Qc7ZbFIxDzn1w97dmcRFGiXpc7raezDIQhHa+kvtbJpIziby
         X6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ounyAlZG9kLozcvtnoKN4U5I/ChqzwDJGCowBl2XLxc=;
        b=ljmd4Wt8Co/0YUgx+JtFVtA2w/mgmCNbsUBSSlVMvHrbM4CfNm8EY36jRu0C/+aCHI
         1+lxjlXTVB1Ow33BBjoJ+AEasB8wzJwcjdqGgJjNSYqOAfkX7RDXpg0pFO5UJUw8+niB
         qqP6R1FQ91pppZwoTMydK2/JvD7766Snrq4BCM3ULO7EU/Er0Qrj1haJJYp0yxyMetSU
         OlTKimDDXCcZcWA5Fut6Vac53QlgDpSkBx894jugSL9u0hQBMvts/+0/JPqNo2862p9y
         kwb3jxc4Kb0H3602rJW3ZlMVaW1nnoOqY8fBoZYQNfGfcA1QSySgZD04oxXqDk829kie
         u35A==
X-Gm-Message-State: ABuFfohnb6Sc6/qjAMNFYvWFHpXyqnI3S685dnA4Uk66OFsFf6BVHzSv
        L6mzv0NnwWwpRuJJleAopXk=
X-Google-Smtp-Source: ANB0VdZX/XKOZWGQy/AQTafFoTwu+kt/tux7ndNvHWYtxrhmb5eS9P7QXHvOvKVAelScN3bZ62TaMQ==
X-Received: by 2002:a2e:3313:: with SMTP id d19-v6mr10184401ljc.25.1537792657588;
        Mon, 24 Sep 2018 05:37:37 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id u13-v6sm2620856lfb.78.2018.09.24.05.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 05:37:36 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g4Q7M-0001ca-44; Mon, 24 Sep 2018 14:37:36 +0200
Date:   Mon, 24 Sep 2018 14:37:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [PATCH v5] USB: serial: ftdi_sio: implement GPIO support for
 FT-X devices
Message-ID: <20180924123736.GJ5101@localhost>
References: <20180924084756.GD5101@localhost>
 <20180923160330.2184-1-pados@pados.hu>
 <48c673281bec5fbb4b8b84ed884c000a@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48c673281bec5fbb4b8b84ed884c000a@pados.hu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 11:52:38AM +0000, Karoly Pados wrote:
> Oops, I sent v4 again, so it had no changes at all. Can't I just
> resend v5 instead of calling it v6?

No, you should label it v6 so that it can be told apart from the
incorrect v5.

Thanks,
Johan
