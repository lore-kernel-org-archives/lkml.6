Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADE5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B825726D96
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="bqm5O+0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B825726D96
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeFZQGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:06:35 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:33114 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbeFZQGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:06:33 -0400
Received: by mail-ot0-f193.google.com with SMTP id h6-v6so19649352otj.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 09:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qSQcr03qsieCwbx9tQviqcvej0FpnzCPgyWDfnbPD4o=;
        b=bqm5O+0PCVjk2+lRAvYqOwzUsdVcZmo+n/eq20/QigNHdLLTBXBjxtTuMO1wtiCHXT
         Dj9plcIHv9n2fkRP0QAOBiCYKp4j207nuCi6qjOYJ51K4Hn+X1Gaj5EHfUBpsUesNcV8
         spmtUFp3GOdK+WbtLGayjciUvxvTtBwKZEFvKaUUVhq5yNFPR6A88IaRyd50YXMRpLlo
         t/Dpdxgbu1oVc12v8Rj2zRADDX5mUHM9ovp6+uB69HK/QS7O9IiuodIG2w4xy+4Hhlxb
         H1ndyVbfUPjSTgoxSvjC4lGDrTrAk9Rvrfs4W5Mkmr1pHCezRHwu6UPsen9Vrtc5FfPX
         tA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qSQcr03qsieCwbx9tQviqcvej0FpnzCPgyWDfnbPD4o=;
        b=JbO1x5HgEsSDUin3P5+FzQl39bhXn6rv4DAbdAS2woHFsJH0uY68Yzt0BIrS0x8c/s
         KgNUAf7489kl0I82NjurIWzh1m9LqmRfigGsDOdlfq9Llk334ZFatSe9ouGYUh6A/W7k
         pRLWcuLpmdXYjqQaCpqEn9mkj7TnQB+4Hq8i8V+RTZKdIuxYjVC+ZwdQwsdIXHZ7hMUa
         xaCArUFcbAG6jhEOLNmd+cCCrF9jbVa1mJDW/mLb+cQ6XiWT2mvADJIf7wEhyqIdOQFt
         B1CXDzmBfH6s1hsjBfMi2maSZ0c2Ogm8FcuD5vHH2Fwmihh3huqpwVg7YEMqgbYxCjLY
         GoLA==
X-Gm-Message-State: APt69E03UcNIqRewyDJ3IycnLqJmjIGE6qM8ofpY75CN2Eea66X2Ds8N
        vVXmRXd/etq0jnlAC3Gw3vppTc+OBZmmyXBsC7LWQw==
X-Google-Smtp-Source: AAOMgpdLKQR+NQPmL86Sd1f+gLolPF2BrgIBaSixeoTtmR40SGbM7lrCccNDNcLV2HdoOmTR3FLqZY1grQNm/WleSts=
X-Received: by 2002:a9d:3072:: with SMTP id w47-v6mr1281652otd.387.1530029192884;
 Tue, 26 Jun 2018 09:06:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:38c2:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 09:06:32
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1806261217140.2204@nanos.tec.linutronix.de>
References: <20180626121853.0b4ce17c@canb.auug.org.au> <alpine.DEB.2.21.1806261217140.2204@nanos.tec.linutronix.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 26 Jun 2018 09:06:32 -0700
Message-ID: <CAPcyv4hdpkFGHZ4sv7Od-ezMXg8JZg+-E=CEsmN1tea+z75hkg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the nvdimm tree with the tip tree
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 3:21 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 26 Jun 2018, Stephen Rothwell wrote:
>> Today's linux-next merge of the nvdimm tree got a conflict in:
>>
>>   arch/x86/kernel/cpu/mcheck/mce.c
>>
>> between commit:
>>
>>   d3d6923cd1ae ("x86/mce: Carve out the crashing_cpu check")
>>
>> from the tip tree and commit:
>>
>>   f6785eac562b ("x86/memory_failure: Introduce {set,clear}_mce_nospec()")
>>
>> from the nvdimm tree.
>
> Dan, we have rules how to deal with that stuff and there is no excuse for
> you to collect random patches and apply them as you see fit. Stop this
> please.
>

Yes, it was stale from the merge window when I was getting late 0day
and -next testing coverage. I held them back from the merge window
precisely due to lack of acks and review comments. My mistake was not
immediately pulling them down from my -next branch when it was clear
that I needed to circle back and try again for 4.19.

> MCE/RAS patches have a well established and working route and if something
> in your tree really depends on this, which I'm not seeing at all, then
> there are well documented and established procedures to do that.

Sorry, again I had no intention of bypassing x86 and the offending
patches have been pulled from my -next branch.

I need them for teaching memory_failure() how to handle DAX and
persistent memory. The primary challenge DAX and PMEM pose to the
existing error handling flow is that the errors can be repaired and
that the same poison pages can be accessed safely through the
device-driver with memcpy_mcsafe().
