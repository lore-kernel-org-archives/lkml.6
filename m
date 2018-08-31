Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E049C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0B220652
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0piOU+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0B220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeIABfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:35:18 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41871 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbeIABfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:35:17 -0400
Received: by mail-lf1-f65.google.com with SMTP id l26-v6so11028269lfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 14:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2LrPf3BZ7KKHee4dCYRYlvWOsklSuU7dFkrTWs159hs=;
        b=b0piOU+hJ7w/d+bjzHH38huzAZwgiudJbMPk0eTkggUcfNtHmCk1/CddqqAqKB7/Yb
         0Dz8zRjDoW/caT9dkH8oQWumuW0T0915bNHyRSDAPc8tIQ3wAU10Yn7w2mH0ANA+H6lS
         LbxoMQSh4aSSH8FE/EkTR47ak9WYtv2JSOawxX071dHczT+xr5TtNlR/ew4O74C9CmLX
         eea0t68C+jLfGqL55rmKAmYPIq/eZ3Um1s8H/Sp2GV4WALVlgXPD/8RlgxgUw7/hMfEm
         mFTp8rNFuGpO5DjTAm9QneMzccocWytkYRGU8r01+yScsAdsUOG0QXvzwIZpEnO+qcow
         jSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2LrPf3BZ7KKHee4dCYRYlvWOsklSuU7dFkrTWs159hs=;
        b=R0FZLk7Rn7SyQQNPhPtE6AAMlwjNOZDlFWxlIYbyZtkQeRrwjABqVsFk1peb/x1foe
         8lB69ZJtSWFNMDs4eF+4iequ5Vp6REF5vvSEhT+Ja9c5IUOBmRLAuFRwypK1yH4l+Jdk
         nWj2aigvcuacrrQr4+1KUpN01Warj7hGXjagQ5rC3JQ4n6PaFyN/s3MuP6c+rH16GqEf
         P+UcrWFo8ktNgdNTc8k9nvDcg/mJUshOKOsjQebr/ofXjVxcKllWEtiAT/CPaVOxsufI
         vEHHWrsWJ3kbNMk769mcGN0g/xnLZUlRmJzIJXgr8wPBQFrYHICv2jNQFWWbedZ37xl0
         FI0Q==
X-Gm-Message-State: APzg51CShvOclgwcULmvZZaLko8olIj2hMJgUTl+qS4QWKS76drCtnXv
        4981YZnYHYRCg+cAcR79v9k=
X-Google-Smtp-Source: ANB0VdbcPIaUBWsSTR8AknF0l+QSXcdnqu8qJ96KALNfK8ftyBngn2C324DnBKKr7wsGDRrjeYv7Bg==
X-Received: by 2002:a19:870b:: with SMTP id j11-v6mr12396927lfd.4.1535750756345;
        Fri, 31 Aug 2018 14:25:56 -0700 (PDT)
Received: from [192.168.10.160] (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id 17-v6sm1969973ljs.32.2018.08.31.14.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 14:25:55 -0700 (PDT)
Subject: Re: [PATCH 05/23] selftest: vm: add unlikely() to BUG_ON()
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Igor Stoppa <igor.stoppa@huawei.com>, Shuah Khan <shuah@kernel.org>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
 <20180830223429.30051-6-igor.stoppa@huawei.com>
 <1535669872.23560.73.camel@arista.com> <1535670261.23560.77.camel@arista.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <9813280a-4599-9ace-320a-f4ec5998e0a1@gmail.com>
Date:   Sat, 1 Sep 2018 00:25:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535670261.23560.77.camel@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 31/08/18 02:04, Dmitry Safonov wrote:

> Probably, the one from "tools/include/linux/compiler.h" can be used in
> tools directory.

Thank you for the advice. It seems to work now.

--
igor
