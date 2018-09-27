Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A52DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3DC21546
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="ryxGDavM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3DC21546
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeI0QKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:10:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34455 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbeI0QKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:10:21 -0400
Received: by mail-lf1-f68.google.com with SMTP id y10-v6so1663450lfj.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 02:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=myg17J5/prpunPv5neNvf7cN+7gblD+xZfj9RmZmqXE=;
        b=ryxGDavMgkwnggR20Xq8EpNbhgTzILqTYrQcOf0UfPKSTrc2dpWU7R9yz+aD/Ni4hh
         XC2I65xYGtmuPaP67QS726f+anMGKfEx8QocnsQsl7mUckkp45A1v8+xFMR6cLKT3hdp
         m1Fwx4hVBSEfe7gFb3iIehYrTNDIy7kYdFeMPpWY87CtD2Cpd/v9fHxT1STqEChkMHhp
         nja4eje8oP4qFeRZLoaLwEGDIlMbLslZsL234k/jOJh5I5j3Cmk7Ix9bmDln0VXnmLmb
         Govz8Kg6HklngadispSR/La7ajsyeDkh0bHTgtA2QgOXb7Yb5CUdvZ2sF0kuH+yYFPjz
         aA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=myg17J5/prpunPv5neNvf7cN+7gblD+xZfj9RmZmqXE=;
        b=sIrNBW5EB6d6hh3ve4hBsV0u4HbEl+bC/EeqBqyDMzM4/F0Xted0Y5wckzS3rATnJE
         1c8tZtBPnXaUaQtZd1GsvrlLgBob7pMXOjLS2npiLd2twvjVCj3kneZHNPCE1sVS1Kfv
         sUd6/WDxoS3wPWsmJ4n4WM0y8Rq87V6RixV6b0gI8axhh6DRrIl3F4OZlhVnGenzpZWc
         Qykb0nTVspfeWlsPp7tjn4CnFphrIBFO0BAU9KODIFQNsNpTBcLXgbiuiCwB8y7eSLLq
         CM3XXaZKVlJy91JcxtPQQrGtplSBRm9tXxJT34svNdpB6yPJNLb6g7gjuyxbo6L5OKYW
         5Tyg==
X-Gm-Message-State: ABuFfojzkkqZ7Llc6Qw2iUhg6sMjlOkBxIMNjttjK+CnEKOY9qyAXUuP
        K+u5zjjQYDOGOr4QERDxZinAtc82iAI=
X-Google-Smtp-Source: ACcGV60Ol+cUSDfkVsgSwQCFi4ICzUgQus4WI0NYQS+8YS8ndxMUv6WbxmrRPNpuzOaLUCi9ckMZwg==
X-Received: by 2002:a19:3855:: with SMTP id d21-v6mr7198481lfj.148.1538041971657;
        Thu, 27 Sep 2018 02:52:51 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.84.252])
        by smtp.gmail.com with ESMTPSA id v10-v6sm322996ljg.12.2018.09.27.02.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 02:52:50 -0700 (PDT)
Subject: Re: [PATCH net] vhost-vsock: fix use after free
To:     Jason Wang <jasowang@redhat.com>, stefanha@redhat.com,
        mst@redhat.com
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180927084301.573-1-jasowang@redhat.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <a413a8b4-302d-7fbc-092d-95e8aa421c4c@cogentembedded.com>
Date:   Thu, 27 Sep 2018 12:52:50 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927084301.573-1-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 9/27/2018 11:43 AM, Jason Wang wrote:

    Just a couple of typos...

> The access of vsock is not protected by vhost_vsock_lock. This may
> lead use after free since vhost_vsock_dev_release() may free the

   Lead to use.

> pointer at the same time.
> 
> Fix this by holding the lock during the acess.

    Access.

> Reported-by: syzbot+e3e074963495f92a89ed@syzkaller.appspotmail.com
> Fixes: 16320f363ae1 ("vhost-vsock: add pkt cancel capability")
> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
[...]

MBR, Sergei
