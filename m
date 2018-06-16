Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900C4C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 14:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D8820862
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 14:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xQ5QinsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D8820862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754199AbeFPOqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 10:46:42 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:33973 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754037AbeFPOql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 10:46:41 -0400
Received: by mail-io0-f175.google.com with SMTP id e15-v6so13238829iog.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jun 2018 07:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aMU/UBrrcZe+TttFzB2VZ7jhkYUoI1L21LcGWiyX0Dg=;
        b=xQ5QinsZ2o2BXevwPL3InkteRYpN37JwI2cTGwf0mTBsbyvgIJbql5psbAPAobYrf0
         doYH3p1V51VdWtnM/SxpuKOpI1RAhEOYKxPddB+SjGSSt/6clsyPxLA0rDNYicUaQkdB
         cy/a661+SsiAFeFgp3cmNzfQ37XZ5Fd0eayJ6/QzduY6gzDgD0ZPv2MgqtRCdYDvQ+vq
         GpJu3iyaEscu/kvr4/SEpkm5vfgPGJ98/QxAGstCCwqpbI53LfRXAmyQyHN9JKYHLOTt
         0PdCP7JYrXT6pojiWCxTTvPdRhPMat1/S2tmKj0rXZ1+cARpKdRL/CTJhMcxVNXqUCA7
         ZQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aMU/UBrrcZe+TttFzB2VZ7jhkYUoI1L21LcGWiyX0Dg=;
        b=CwxTxiMIMe/jrB9E4TjFoW9kxYPs9HkVrplKNnJSMIJBUB3ScyAmEkLQaDHzkHW8H1
         JKaAe1RRUz9Dxeg4v/ML+Kj9JkRxlu8mL4nt3qmWk4QzLYAvOwJU/Mt5oKQ790W+6yhm
         iawtbi+8Q4mR7gtUfDJVya8z7zcOkK6gXu0ncTQAjXVS97KHmHiu/vebYsc6JMj+ycQd
         Q3Q3ZB4og4s3l3bOuBs2CzWdewSUuMaKD7nUb4ZR8VopjxsBgdYGM9SYB8iP2oc5KyrZ
         N2BZNxDHO9aDcwXlcYlAK6rG4DO2wr24PoNPUA44GpjB/5Z1QVB2ykWfY+/YToHqm04s
         JKhw==
X-Gm-Message-State: APt69E0oIGTn8J24mVsMptR291r4Uv6Ibh4yxGWJBbUQW9V1THhwnyFS
        Ofelrs5rFmRt/1o1J1rKkvBWMY1DOU0=
X-Google-Smtp-Source: ADUXVKLzI99iSivg6hBbJItWBgVLIzE+39P2MLC1HTSVsDqmOuxwoFL2RjkDC7uWNhxbJC43uFzerw==
X-Received: by 2002:a6b:ea09:: with SMTP id m9-v6mr5142607ioc.121.1529160400309;
        Sat, 16 Jun 2018 07:46:40 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id m76-v6sm4607572ioi.68.2018.06.16.07.46.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Jun 2018 07:46:38 -0700 (PDT)
Subject: Re: list_add double add in blk_mq_check_expired()
To:     Borislav Petkov <bp@alien8.de>, linux-block@vger.kernel.org
Cc:     lkml <linux-kernel@vger.kernel.org>
References: <20180616103605.GA28657@zn.tnic>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <78f4ff73-3b5a-1e1b-2996-b2b16437247c@kernel.dk>
Date:   Sat, 16 Jun 2018 08:46:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180616103605.GA28657@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/18 4:36 AM, Borislav Petkov wrote:
> Hi,
> 
> just triggered the below in a qemu guest, kernel is Linus' master from
> yesterday + tip/master. It doesn't fire reliably so it could be some
> transient thing of the merge window:

Should be fixed in my for-linus branch, it'll go out today.

-- 
Jens Axboe

