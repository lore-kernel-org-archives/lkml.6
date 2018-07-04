Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B80C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E5720899
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="AVBFzxsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E5720899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932580AbeGDNiA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:38:00 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:44743 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932362AbeGDNhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:37:42 -0400
Received: by mail-oi0-f43.google.com with SMTP id s198-v6so10755989oih.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 06:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cP/rS1HfNxjViNQ5k3DbArgwr3Rsj84xeX56MDi1LVQ=;
        b=AVBFzxsgI/TSY40hg4jGKeB5GzRlSY9cTwMSv4BMW+hKJggpq8tXjoGOyMc+D69g3k
         lR4WJir8hY4g25NmqR6YUZiuYWkaXitStKtMKuDiKzSRO5Finea3H/47DSTs1yzmoudO
         xNjlqKXyvVQiwcEbt9GDoIbzt4H3zNt+vaB0Wx2XUbPmCB41Zk3Kq/PjveYsRSayzkNP
         8l+D6ssdvbp8fN/j9Ijnp0LZfOzB4q7JaFaWJkCmbwvMEQoEfyDn7SSPvQ19phhnJNQr
         L4rDN2yd/zWMI9T6QgQSz+AOoSPT3CLFr5EVht87pYUv/JQU2f7GSu3sLmpy4LbKbtEG
         t0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cP/rS1HfNxjViNQ5k3DbArgwr3Rsj84xeX56MDi1LVQ=;
        b=d8DIP/jKx+RQSakzsskGmGTt3Qa23ueVrRA4DX6gK+tko6ty53Gat93L6lFWp/jMME
         Z/0uMdSatJ9WyZ+jYi9OklTbKTWh89EC6ecGzZU1XV0KL07ehzHYv+C0SXMtUWnky5Yd
         6LSyr1tRWxILjHUPqwQasmhoCVipdeEn8Z6qcGkLqSbU10vZ7RkxrTzBmg6Bp1DRZm3O
         /uy3WWbKIEtzhXC5MK3qiOQSAonoBBXyDy10Za1ZoO3pfY8yarODWxsYHYVDjEzGFrI5
         DQXRX0mINxHHwYEE3S1pwPw76dR42wtX162XhXAEy9QuUpsI6CifPL/sm/qm2Tynr1uu
         3KRg==
X-Gm-Message-State: APt69E1kAGKNqq6BDeChKQMBvhG6R9VXwxwTaoM6HpDEmFSOuKms8yHU
        Hoegz+2pmqHAUIQoyb3BkhrePG1sPtOzVcSEMoieZA==
X-Google-Smtp-Source: AAOMgpeMmRf+ZXVkC17co1NkMm6uEHle7FlIUhtO5yRJgg53rN00o4KKHhmmFWRJI1GC98QobnwCKAWFMT+f4z/xvyY=
X-Received: by 2002:aca:afcc:: with SMTP id y195-v6mr2391815oie.322.1530711461676;
 Wed, 04 Jul 2018 06:37:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3e18:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 06:37:41 -0700 (PDT)
In-Reply-To: <20180704130448.pta7t5joj5qrxlpq@mwanda>
References: <CAPpJ_ed1oFQW_xmBtetP-ztoL7Z14T6akOSgKJ_8jxogdf3FWg@mail.gmail.com>
 <20180704130448.pta7t5joj5qrxlpq@mwanda>
From:   Daniel Drake <drake@endlessm.com>
Date:   Wed, 4 Jul 2018 08:37:41 -0500
Message-ID: <CAD8Lp45wgsqxx+qYvAWCuRuAMEChK-aPeFNdN1LE28qeoEWu4A@mail.gmail.com>
Subject: Re: [BUG] staging: r8822be: RTL8822be can't find any wireless AP
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jian-Hong Pan <jian-hong@endlessm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        devel@driverdev.osuosl.org, Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Colin Ian King <colin.king@canonical.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 8:04 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> I really prefer to see the whole dmesg instead of an edited ... in the
> middle.

Full log:
https://gist.github.com/dsd/20c05f0c6d66ee2ef9bfbb17f93f18ba

> I agree that it feels like the default aspm setting should be 2 (use
> what the chip says).  Although I don't know the device well enough to
> say if that will break anyone's system.  Perhaps someone who knows
> better will be able to respond.

Looking at the code for _rtl_pci_update_default_setting(), the meaning
of value 2 actually seems to be "enable ASPM on Intel platforms, and
disable on others".

But I suspect that code is not working right, because the system we
are using here is Intel-based and so my expectation would be that
value 2 leaves ASPM on and we would continue seeing the issue.
However, Jian-Hong reports it as working.

There are also some other reports that this driver doesn't work until
aspm is disabled:
https://bugzilla.redhat.com/show_bug.cgi?id=1464731#c21
https://ubuntuforums.org/showthread.php?t=2364383&page=4&p=13748721#post13748721
https://bugzilla.kernel.org/show_bug.cgi?id=199651

Daniel
