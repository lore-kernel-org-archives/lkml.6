Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A900C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D15B204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHhjE86S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfBVSZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:25:13 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37844 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfBVSZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:25:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id s22so1476200pfh.4;
        Fri, 22 Feb 2019 10:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U/GbfWF0BIqpelcxOHEpWob7GaByLbfgmoKAHpzPzAw=;
        b=BHhjE86SP2DKz/1Mv4EAScHy7YXQO+9c3rRbZzE5ZWw4L+Ji0o9ENLtwmMq237pqWO
         RPo33kJxhjxRx6vZBeWk3FXtm3lqqr+NjHMtvnW+SGud0X2MFwwkEGya62FHIAp0iKXC
         hf/0e0ELIGq18AVktXZs+F9PbtakOWE86IYiMxB6LzR7iP/CNRHGnItbVHU2WjxUUILX
         OjSiN1DgSPSYQhHEqluLu3/GVnWOP14nfSuQL17a5JTtcY7ZnSYd1paRH8jfcl+WTUAo
         pP0OIGdb8kWi2nSX8oBVIQrxqyZXEPRm9whm/y4rvdNLFfly/Si+uxK0HxZgQbtBbk7s
         3guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U/GbfWF0BIqpelcxOHEpWob7GaByLbfgmoKAHpzPzAw=;
        b=p4LBOrXdQoggDViLA1G5d8QpzRkrr8OjYS5sqZkuQoelBHQgUgGIRIN1X2+G3q3KsM
         lmEm2LgMh3dkYS7tgAiYr/UIGJ5GA+I0PhwRp1PbvT0Jzzj3ZNJcHZVTcjs9yjsNBCUW
         jCi1aIiJhaYEM60TXEwMqaB9nWAjQ+E8JsYKWq1Id0mspuPFcdXQQ20+rajVnCQW0q1R
         ToYK8SMcE8uGgRJ+Wg0L8tdUZfqB+IcKoaohdNQChKtrbS/1MMl3SPjBtIrpJq1VimTw
         Zw6+IqobRCJ9q7opcU7YIvIfICpYfr349TuCTcFE1JAwC+tseYbKLThzUUY0IB21xygH
         b2Qw==
X-Gm-Message-State: AHQUAuaSHH0o2trZVP2d0qvJ7svk0CNKw1vVhwUNr6n3TM/5CcJNY8zK
        7lq9w18DX8TjUfbT2ziaQtQ=
X-Google-Smtp-Source: AHgI3IZJSQWPwCj7J/FIfbx4zrK70BuevmDgL2YEFFwV8EOUpVdn2YeWTT8PdvvosWeYKy3a9Jv8qw==
X-Received: by 2002:a63:d703:: with SMTP id d3mr5243263pgg.167.1550859911871;
        Fri, 22 Feb 2019 10:25:11 -0800 (PST)
Received: from [192.168.86.235] (c-73-241-150-70.hsd1.ca.comcast.net. [73.241.150.70])
        by smtp.gmail.com with ESMTPSA id 10sm4989521pfq.146.2019.02.22.10.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 10:25:10 -0800 (PST)
Subject: Re: [PATCH net] net: socket: set sock->sk to NULL after calling
 proto_ops::release()
To:     Eric Biggers <ebiggers@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Mao Wenan <maowenan@huawei.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20190221221356.173485-1-ebiggers@kernel.org>
 <e4d0f1e8-68ff-512e-ad69-480523ff300f@gmail.com>
 <20190222175743.GA163909@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <0de89a50-6d5c-1d7b-19f5-9a13465bcebd@gmail.com>
Date:   Fri, 22 Feb 2019 10:25:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190222175743.GA163909@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/22/2019 09:57 AM, Eric Biggers wrote:

> ->setattr() is called under inode_lock(), which __sock_release() also takes.  So
> the uses of sock->sk are serialized.  See commit 6d8c50dcb029 ("socket: close
> race condition between sock_close() and sockfs_setattr()").

Oh right, we added another inode_lock()/inode_unlock() for sock_close()


> 
> The issue now is that if ->setattr() happens *after* __sock_release() (which is
> possible if fchownat() gets the reference to the file's 'struct path', then the
> file is close()d by another thread, then fchownat() continues), it will see
> stale sock->sk because for many socket types it wasn't set to NULL earlier.
> 
> - Eric
> 
