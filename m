Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466CBC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020C72086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zNhboszU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020C72086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbeIKVJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:09:46 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:54677 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbeIKVJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:09:46 -0400
Received: by mail-it0-f53.google.com with SMTP id f14-v6so2242651ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 09:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jaXivJsbzz2/ySp9Pn2vm8UYo2jihQfrKBFbnzPQaBA=;
        b=zNhboszUxSeoFyAh1K6YirRmvDbqA2uUZHG0rxq07a9X0rU2vaoKgugrRx+1Mi874J
         6fRz7Frd5ZwqDBj/9Q5S8pk3CKukeLQNI/3h/IKR1nWhbseBgl/mx4ZHlS4OFktso5tZ
         hgSpojJTn2uBWcX4hz+ISJklaTC53gpvuEvqaOFh0uuIVS54QXOvH0x3TuxXquoQJgEK
         iGXweBq31oT06xORYrlyZtXneNkrq4DIxxjnrXLJTDcfxGk64pwsI9TGpVJQr5AQ4+NO
         j+AXWfR6OYafqZ2/022nO3ynNlITMMFIR7arkFiqreO9u5LCVKZ99EVz0M+yhOJWY6pV
         v55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jaXivJsbzz2/ySp9Pn2vm8UYo2jihQfrKBFbnzPQaBA=;
        b=quSk6cNNKIgkqR1vEpikKIzTZRXccrPS1ltECd1KdfmT0lvJ201+mQ81T/BaI7fIJo
         28yGhNIpkTvgqkXNrs3KYjaysVEDV78XLLJx71Ffp1UbkW0KVmY42AlFQZMSHbeKYEwj
         4JJbOMSgOij99jIf0FjpDwYudzdSTuorVxeKzCQrkXI9xVdaXeOCEM3hLM/NX5aIbAjK
         QUFCq7hYS+3W0DSCI5tPvmTPtOCxZINezG1KjAZ+Ci8w5nX0PJckr+AZh8Iijx8V3JlF
         pwB3BqpS+sPgM321q7hLJYo79NEtYjWqb2HvyABnQey0D2iUNBOEc+UQGATrp14MjSUC
         GQvA==
X-Gm-Message-State: APzg51DblGvqTWPw/Jh8DtTPctJA75AR0P9MhzhMC6I4k6bEVBu6EUm5
        VAUwtiaE6INO5Lu5WJBJUQn6DFFXGm0=
X-Google-Smtp-Source: ANB0Vda8RmND8GwhG+uvPelsiJ9T0whmnOA2gP0U2vmr/nwOvLPpU68dvmoUe4uAWqmpfQ/tb+NNRw==
X-Received: by 2002:a24:c984:: with SMTP id h126-v6mr2120273itg.33.1536682186761;
        Tue, 11 Sep 2018 09:09:46 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.22.static.utbb.net. [107.191.0.22])
        by smtp.gmail.com with ESMTPSA id 14-v6sm530676ity.8.2018.09.11.09.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 09:09:45 -0700 (PDT)
Subject: Re: [REGRESSION] bfq probe failed on 4.19-rc3
To:     Takashi Iwai <tiwai@suse.de>,
        Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <s5ha7ooxbps.wl-tiwai@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8b5a7dc9-2dc1-16ee-4b05-a72eb6680c77@kernel.dk>
Date:   Tue, 11 Sep 2018 10:09:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <s5ha7ooxbps.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/18 10:03 AM, Takashi Iwai wrote:
> Hi,
> 
> I noticed that bfq doesn't appear in the I/O scheduler list on
> 4.19-rc3.  It seems that blkcg_policy_register() at the beginning of
> bfq_init() returns -ENOSPC, hence the probe aborts silently.
> 
> Is this already addressed?

Haven't heard about this one before. What kernel did you last use that
worked?

-- 
Jens Axboe

