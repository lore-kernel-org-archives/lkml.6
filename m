Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34808C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED4220836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CyBRNFWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED4220836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753541AbeFTLL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 07:11:29 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37527 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbeFTLL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 07:11:27 -0400
Received: by mail-lf0-f68.google.com with SMTP id g21-v6so4347376lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 04:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BjopVPYRVnCOz1AqVkcQdUVup+FiV6ghR1aHlEhyOTY=;
        b=CyBRNFWPmzJzQxFP7YtMTGXvlkHFcvsFLJhG8cwPRVsbo62LYy5Nd+IpKRHl7BDi0r
         hAfxTwLUwzNQKlRj6WdgGNOKf+pmgd1DRTpFG5Uy7LApRPUHZBbFfqsvN3yz5oJvKJmz
         eqeRSfPsyy8Y66yfPdbUaRsZRSDKiYV3Ltsgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BjopVPYRVnCOz1AqVkcQdUVup+FiV6ghR1aHlEhyOTY=;
        b=DzCbQ3tCyzkUZcPFdLhpwhPvUrcPN4+ChWKur1GzMuxpvN/3O9sFPXNSs028PEUPF3
         J2swGkjX43CchVPVWu1YFnTHN8mW6ALAr10rOzPTIbTbyAPw/18P4iSyGasvQUUhgzl9
         m22kMDS6TxluVjWVUDC4mG2FVx6Iw1QJo2BAiD3Or2yRxdCbDevIp+DCrbAgjQ+D1yW8
         ulcK0Fcn2wAB1IpeisTrtBvmLBQ76+LEr+9W/juGAoPNEXy9UliUzkXbl+ZAl0oqIQ+7
         YnRBXRU32tMwhumHu+Q/DJtcab1e6A6CigyQkBfDU/vuwu7bwnyXlzx88prIV0FGRKiQ
         HLsQ==
X-Gm-Message-State: APt69E1ITKZFbbhDq52EbqRmp76vvKOCoqkbORRPWo6qtfcQbXpJMKpR
        u/l+MsANBgEU1pXqVCGjLERf7MwLrWmutMNJPO/hxg==
X-Google-Smtp-Source: ADUXVKJJBNYEiVUKgYoHaBKyC3xwTdGWt/dkp2/pCVTtjGnJB5fnUHZa3cp5XS3z2JVOLt67A5EkzX8ayc4S6LjIe8s=
X-Received: by 2002:a19:51db:: with SMTP id g88-v6mr13380933lfl.78.1529493085979;
 Wed, 20 Jun 2018 04:11:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:ee14:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 04:11:24
 -0700 (PDT)
In-Reply-To: <20180620072138.yrz76kmms3oviv7i@linux-d8ym>
References: <CA+G9fYsRgGsmi-tE8dU=pfSDDLg3bUuii_0KUPZ71jFLNre-5g@mail.gmail.com>
 <20180620072138.yrz76kmms3oviv7i@linux-d8ym>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 20 Jun 2018 16:41:24 +0530
Message-ID: <CA+G9fYtoML7G7f_sXB6hQJJAQOG94TsBXujmQgHxy-rKABaTtA@mail.gmail.com>
Subject: Re: LTP CVE cve-2017-17053 test failed on x86_64 device
To:     mmoese@suse.de
Cc:     dave.hansen@linux.intel.com, ltp@lists.linux.it,
        open list <linux-kernel@vger.kernel.org>,
        Jan Stancek <jstancek@redhat.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Rafael Tinoco <rafael.tinoco@linaro.org>, ebiggers@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 June 2018 at 12:51, Michael Moese <mmoese@suse.de> wrote:
> Hi,
>
> On Wed, Jun 20, 2018 at 12:14:22PM +0530, Naresh Kamboju wrote:
>> Test FAIL case output,
>> tst_test.c:1015: INFO: Timeout per run is 0h 15m 00s
>> tst_taint.c:88: BROK: Kernel is already tainted: 512
> The kernel is already tainted. In this case, the test refuses to run,
> because it could not tell if the test is pass or fail.
>
> Could you please check if you could run the test directly after a
> reboot?

This single test ran immediately after the boot and bug reproduced.

tst_taint.c:88: BROK: Kernel is already tainted: 512
https://lkft.validation.linaro.org/scheduler/job/293222#L1204

Test command for 10 iterations and it failed for all 10 iterations.
+ ./runltp -s cve-2017-17053 -I 10

NOTE:
We still see kernel warning while booting the x86_64 machine.
DEBUG_LOCKS_WARN_ON(sem->owner !=3D ((struct task_struct *)(1UL << 0)))

- Naresh

>
> Regards,
> Michael
> --
> SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton=
, HRB 21284 (AG N=C3=BCrnberg)
