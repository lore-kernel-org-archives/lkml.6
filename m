Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA66C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0395E20899
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Uj0FYGYq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dWWdKpqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0395E20899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbeG0Kqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:46:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44622 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbeG0Kqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:46:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2550B60B19; Fri, 27 Jul 2018 09:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532683534;
        bh=v1T1fp4ppjWc8fXpDEV41CgkVlc779vJadUDLHWurHg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Uj0FYGYqHvcIpEMJ+F5XkvQ/lNocmIKXCPC7TRE+tNhdU+YPynvu9BPBdeWNoNdY1
         tqL+6hnpQMKI/oqJ+WKssKfFf0dMjsAEvSMUp7llrlP64+0wQYa0KZQjwOr9C+sJnt
         oQ3ou9mkOsHU6+CVFHgI8FsX6YMhBzFmIw0LOHqk=
Received: from x230.qca.qualcomm.com (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7DCAB60594;
        Fri, 27 Jul 2018 09:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532683533;
        bh=v1T1fp4ppjWc8fXpDEV41CgkVlc779vJadUDLHWurHg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dWWdKpqemhNNavPrVXW0AJiv2u+XJCB14Hf4V1Ndexyi8nuyiN7AFcEVj8tjlCpTY
         rfGEpms/ffDhRIgfP7InytfldAYLooFtC0IpXcbvKCT+450GDBo+ftjFMSYpUjjnzE
         NPGtLGPYXUsRsg6+Ay23ETLMfNoOgN73PMd4yEZE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7DCAB60594
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     YueHaibing <yuehaibing@huawei.com>, j@w1.fi,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, davem@davemloft.net,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] hostap: hide unused procfs helpers
References: <20180713070317.6724-1-yuehaibing@huawei.com>
        <5B485441.1080305@broadcom.com>
Date:   Fri, 27 Jul 2018 12:25:29 +0300
In-Reply-To: <5B485441.1080305@broadcom.com> (Arend van Spriel's message of
        "Fri, 13 Jul 2018 09:26:57 +0200")
Message-ID: <87r2jpvxme.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

> + Randy
>
> On 7/13/2018 9:03 AM, YueHaibing wrote:
>> When CONFIG_PROC_FS isn't set, gcc warning this:
>>
>> drivers/net/wireless/intersil/hostap/hostap_hw.c:2901:12: warning: =E2=
=80=98prism2_registers_proc_show=E2=80=99 defined but not used [-Wunused-fu=
nction]
>>   static int prism2_registers_proc_show(struct seq_file *m, void *v)
>>
>> drivers/net/wireless/intersil/hostap/hostap_proc.c:16:12: warning: =E2=
=80=98prism2_debug_proc_show=E2=80=99 defined but not used [-Wunused-functi=
on]
>>   static int prism2_debug_proc_show(struct seq_file *m, void *v)
>>              ^
>> drivers/net/wireless/intersil/hostap/hostap_proc.c:49:12: warning: =E2=
=80=98prism2_stats_proc_show=E2=80=99 defined but not used [-Wunused-functi=
on]
>>   static int prism2_stats_proc_show(struct seq_file *m, void *v)
>>              ^
>> drivers/net/wireless/intersil/hostap/hostap_proc.c:177:12: warning: =E2=
=80=98prism2_crypt_proc_show=E2=80=99 defined but not used [-Wunused-functi=
on]
>>   static int prism2_crypt_proc_show(struct seq_file *m, void *v)
>>              ^
>>
>> fix this by adding #ifdef around them.
>> hfa384x_read_reg is only used by prism2_registers_proc_show,so move it
>> into #ifdef.
>
> There was already a fix for this posted by Randy Dunlap taking a
> different approach, ie. use __maybe_unused classifier. To be honest I
> prefer the ifdef approach as it is more explicit and does not feel
> like a cheat.

I also prefer the ifdef approach more so I'm planning to take this
patch.

--=20
Kalle Valo
