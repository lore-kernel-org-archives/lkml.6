Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246D3C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADEE20897
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OLnOT3tM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RUV9IzQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CADEE20897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbeG0Kps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:45:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44398 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbeG0Kpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:45:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 45AA860B62; Fri, 27 Jul 2018 09:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532683487;
        bh=QQm0Sxt7J4/C+8THbVVe0mohDZ/MYUlxkI0d45td/iM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=OLnOT3tMPT7AJYmseIlb88tZRCqh3nwH/l7NVE0UQc/ykr41AjnFTfQQqYUbOvlws
         JF6SBbqQYSet0nGfSzxqVpmL5xvQfNUOIBNNjYl+VsfWHsa/axUlNc2s4My0l8eemB
         KRHrRBc272UjXz6EYa1LiaB36A4OREJ4jSrUVusg=
Received: from x230.qca.qualcomm.com (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CAB8860594;
        Fri, 27 Jul 2018 09:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532683486;
        bh=QQm0Sxt7J4/C+8THbVVe0mohDZ/MYUlxkI0d45td/iM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=RUV9IzQLcdbxz5SDBwDTd8jVNxEUxFnpobV7ibvnPMVCjwMfsgrQeGLoa0MBj1iv3
         olGWZIEC93xz1LOno6iz64r4kp5/f40OOsvCcbq2YdWB93QeDv+lhc99v48BORsARS
         jUgywx+DKoEYXR3aqXdOT9wYXsMlzH9wpqoSpGxc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CAB8860594
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <simon@thekelleys.org.uk>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <davem@davemloft.net>, <rdunlap@infradead.org>
Subject: Re: [PATCH 03/10] atmel: hide unused procfs helpers
References: <20180713064658.10340-1-yuehaibing@huawei.com>
        <ded55181-e1b0-99e9-ac68-2d93fb6168c0@huawei.com>
Date:   Fri, 27 Jul 2018 12:24:40 +0300
In-Reply-To: <ded55181-e1b0-99e9-ac68-2d93fb6168c0@huawei.com>
        (yuehaibing@huawei.com's message of "Fri, 13 Jul 2018 17:31:37 +0800")
Message-ID: <87va91vxnr.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(fixing top posting)

YueHaibing <yuehaibing@huawei.com> writes:

> On 2018/7/13 14:46, YueHaibing wrote:
>> When CONFIG_PROC_FS isn't set, gcc warning this:
>>=20
>> drivers/net/wireless/atmel/atmel.c:1402:12: warning: =E2=80=98atmel_proc=
_show=E2=80=99 defined but not used [-Wunused-function]
>>  static int atmel_proc_show(struct seq_file *m, void *v)
>>             ^
>> fix this by adding #ifdef around it.
>>=20
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>
> pls ignore this,my bad.

Why should I drop this? Does the patch have something wrong which I'm
missing?

I'm asking because I prefer this over Randy's version:

https://patchwork.kernel.org/patch/10512913/

--=20
Kalle Valo
