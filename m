Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A866ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6283720857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H79b7Wbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6283720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeKICGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:06:36 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:41539 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeKICGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:06:36 -0500
Received: by mail-wr1-f46.google.com with SMTP id v18-v6so2618566wrt.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 08:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xB/ElbUHkAFs/cQJoyyNbRADnlbrAHjeqwhrLLdWKV4=;
        b=H79b7Wbjmlq/yPBSzROJak0Gmcc1fOWh+yqvQrBp+P6zXonFHNHGJqL1drYd5J5rsj
         kbbWGoaFqPY7pWy5EEOPpzzZKkoud11M9fI9e/DDr9FEHfpkc5PQsKlfiW4y1UBoq6wU
         ie2zjQ19TUcfExLj48Gw1Wdx3kBiLjr85mbpqsJP+y6AFd6H7INaamPZmEnfPGiIi+1I
         GxBa+0V+CBfLxYd6L1Nmme8+N6UWbWphurxFqFivR6YiLr+9CTa2w7m/Xju1zw8ykChZ
         XoHjE6U0HyQZo3IskO/dRdOns2yKf2F6tl9MF4YaC5Cw/Cm2tqVocePehg5zoRLlPPKG
         sqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xB/ElbUHkAFs/cQJoyyNbRADnlbrAHjeqwhrLLdWKV4=;
        b=OcQo428+Fn0a3dKsU6Zg+VXTt1/FDAdER07HBdsj65/7vZYIcKbfIFmGsBVVtBvCqq
         ML5S+ec2WCXB/7WCmmrbZjHFbtJJIJIyCC6GdBdWCZWQwz9wcgnw+mlClFXXtKNKaBhu
         PPp02UExbD86pyVgZUdVZwffgYGco5Inxw1zahpTBedF0XQDUMCac0+E/7OdFtFlucmy
         L75Src/SaIQNU8cGNWu6rUShfIKq8CTYkV6Nc+THGH7NLTawLoXBnixMXpAzhcqSRs9j
         03uVPQcEhIbRMuTYTB/fk0XFGJq+GG7xvDjx74CFQc4kCK+ua/iA0ETRfPqkIDiH8uzF
         IuYw==
X-Gm-Message-State: AGRZ1gIAF8CkZ8LLEzASdcVVNBqdF1fga6at0pD5j9EH5KEhiE6wreHQ
        sxjtTZoluSsUlQ8rwa55O0BPpo0IaFpbIiqV5OY=
X-Google-Smtp-Source: AJdET5evzjTZHskXz67G0xSzkmwXY+D4daKVEKjjHCpTVgVonDDiiWjVSzEKFF5rtuyHuW1/QBykd82aJEBRunq4i0Q=
X-Received: by 2002:adf:84a4:: with SMTP id 33-v6mr4795010wrg.191.1541694616950;
 Thu, 08 Nov 2018 08:30:16 -0800 (PST)
MIME-Version: 1.0
References: <CAPhKKr_XFzGcBBuQ51w7HjZd_Kq3nTOB6uAFG2vP5JH+Vx_eng@mail.gmail.com>
 <70eba492-0b3d-1fe1-f17c-88964254124a@collabora.com>
In-Reply-To: <70eba492-0b3d-1fe1-f17c-88964254124a@collabora.com>
From:   Dhaval Giani <dhaval.giani@gmail.com>
Date:   Thu, 8 Nov 2018 08:30:05 -0800
Message-ID: <CAPhKKr-ntHmEiFwpvtnY890MUyTLH-6YuEPiN2-zGJQ-GY-V_A@mail.gmail.com>
Subject: Re: [Announce] LPC 2018: Testing and Fuzzing Microconference
To:     gustavo.padovan@collabora.com
Cc:     Sasha Levin <alexander.levin@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        Alice Ferrazzi <alice.ferrazzi@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Carpenter,Dan" <dan.carpenter@oracle.com>, willy@infradead.org,
        knut.omang@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 10:05 AM Gustavo Padovan
<gustavo.padovan@collabora.com> wrote:
>
> Hi Dhaval,
>
> On 9/19/18 7:13 PM, Dhaval Giani wrote:
> > Hi folks,
> >
> > Sasha and I are pleased to announce the Testing and Fuzzing track at
> > LPC [ 1 ]. We are planning to continue the discussions from last
> > year's microconference [2]. Many discussions from the Automated
> > Testing Summit [3] will also continue, and a final agenda will come up
> > only soon after that.
> >
> > Suggested Topics
> >
> > - Syzbot/syzkaller
> > - ATS
> > - Distro/stable testing
> > - kernelci
> > - kernelci auto bisection
>
> Having 2 kernelci talks don't make too much sense, I discussed with
> Kevin and we thing it would be a good idea to merge them together. Could
> you do that?
>

OK, we can make that happen. 45 minutes for the 2 combined topics?

> Thanks,
>
> Gustavo
>
>
> Gustavo Padovan
> Collabora Ltd
>
