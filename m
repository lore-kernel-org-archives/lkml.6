Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4AE52C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D77208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQYgUR4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D77208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936006AbeFNLHG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:07:06 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42713 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754883AbeFNLHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:07:02 -0400
Received: by mail-qk0-f193.google.com with SMTP id j80-v6so3320971qke.9;
        Thu, 14 Jun 2018 04:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8YrXiZ9NeAqcXtzxLxNiPD5sfs0KYAscJhISSD8mtJY=;
        b=sQYgUR4XAS6NzLkTCoHgxJOe7cQanWs598/b1porcQ2werv4nHpAJRQGG1JrVfzhxG
         NRg3/2e5Vp0t327q3o5Xl5qEPKPs9pvn0iU0SJ4fAr6I4Q4ef8JgFtuRWI2Znz/1qMD0
         Nvlq6ascotdBLl8204pDBb/vj5EuTopvV5+6TtoI3wQ2+YTWBMPn2kSTFvMj9MJ/UCVz
         8BuFWXW3to/dzK9pff9ISGDP/LO+5bsK8w4svaUDzrYrEVHVTS+dxUsptqhlIJCk5/RX
         8IGbJ1j0ss/hNdeERV8k0DC9fnr9fg1JhjoNZlleGg4Tja3Q8Zk7T/LC7xT4kS1Nl/WB
         irSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8YrXiZ9NeAqcXtzxLxNiPD5sfs0KYAscJhISSD8mtJY=;
        b=VDurv3lREZtA6O1khhBOrRJSuZ0fnlG2kQviEtOHEkhSZgK7TMxP2TyiBwYt/eUZlC
         +QLICsEJpbx4VW/kNAgZf7aQAWlk2RFl5+7jmVdRvDtUCIR0ARTMTH0K3hFdZQhGyRZH
         QbzH807x64wS5J7VtBXRLimOBpdWuRG0PH0osgclc0/vPyFsTQhhvz3OjXsewWQtVAaD
         uLzjMCZmhiaK5WMtdNPqMg3nWLSHLg+ZcHWrZrCXDMDa39W52kWh1/LWAKIvsWVj8AlM
         y5IIImd8i4YnJ8L9g0jxqePJUCw+d7tRK+kLUHRZTVT6pwhOeHJfY18SAGPtvE1lvZaI
         FImQ==
X-Gm-Message-State: APt69E39EH5X2inZYg/M3UeSkMb0Hg6+MRMlELrnYGMbkvilrfoSly1H
        bcfrng0lt0/zjcO3JKPdJ+7q7CO2hr3xOmsu1LgBpupk
X-Google-Smtp-Source: ADUXVKJlcmbqwGrEjbITNo0woS3qncozlsOSfmWmhVAW5Iw8xgct37B0+ztVo/sjmKO+iVMY+JjEd6ylifVAspgK9ns=
X-Received: by 2002:ae9:dd05:: with SMTP id r5-v6mr1406588qkf.214.1528974421571;
 Thu, 14 Jun 2018 04:07:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:22b2:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 04:06:21
 -0700 (PDT)
In-Reply-To: <d6851756-ae3b-09ec-f487-1eeece6bd4c6@iogearbox.net>
References: <20180612110510.11731-1-anders.roxell@linaro.org> <d6851756-ae3b-09ec-f487-1eeece6bd4c6@iogearbox.net>
From:   William Tu <u9012063@gmail.com>
Date:   Thu, 14 Jun 2018 04:06:21 -0700
Message-ID: <CALDO+SY3qNYAOSiYC3645C7YY9LSx7ggg0GjY76m4TbBfF_t3A@mail.gmail.com>
Subject: Re: [PATCH] selftests: bpf: config: add config fragments
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 5:08 PM, Daniel Borkmann <daniel@iogearbox.net> wrote:
> On 06/12/2018 01:05 PM, Anders Roxell wrote:
>> Tests test_tunnel.sh fails due to config fragments ins't enabled.
>>
>> Fixes: 933a741e3b82 ("selftests/bpf: bpf tunnel test.")
>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>> ---
>>
>> All tests passes except ip6gretap that still fails. I'm unsure why.
>> Ideas?

Hi Anders,

ip6erspan is based on ip6gretap, does ip6erspan pass?

Regards,
William
