Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37445C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 02:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D559C2156E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 02:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWpmxmQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D559C2156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeI0IeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 04:34:25 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:39687 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeI0IeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 04:34:25 -0400
Received: by mail-pg1-f175.google.com with SMTP id 85-v6so712205pge.6;
        Wed, 26 Sep 2018 19:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A90Lp2W6H1+QKdsi/tGZOMLHo6szgWaNW4589vJxLIU=;
        b=hWpmxmQqMq//uMr1RRZQxPLg13DaJvapc2iL6jBFg+FZsF1MYDtiXiKRA993sE77fz
         BX9k7v9lAum8LM3OytcNSj9/AvcngWEXW9hNjzm7qtt3oSZ7cjIdtgS2FRfE2MeRU25E
         TmgiT/B6b/a2YbpeBQl2Mf/zJrLTcQl7TTSwF6b6wotPNSS+Fu3B9AaFcy80UPK2Kvy7
         RzmSBx15y0l5lyTaMhNbScWWfdliPGvlvMBZX5hEX2EVF2CCoNKOp/pQQcfqMe/hIu3I
         3pIWHdf65rUbMVhCBeqRXIPkMzPawKi+dDRrDw6yglMM2+nYsqHrmQhDKuh8BCfbiFGm
         bzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A90Lp2W6H1+QKdsi/tGZOMLHo6szgWaNW4589vJxLIU=;
        b=qQlC+rJ5HCz+WmZJNqiKPgq9BwjLY2PPRa5P0ELweP5XhKYB2mqW1aaRO6Ib7hDWhO
         XlSi72K/8J2YqoR0dzgPhOy6b8vY1ew8vpFsqujatk9OYJKt8NSfYKd1EPFg2rlzDSqx
         KbRLFPn/8QgBw9ZfefkkvMfCunc0JIykYWaRluqMEK4IbjSvBYxiY+BCYaGHwUMo6FSe
         UIaDAUWP5LMEH1mJOYRjIqtoeuTZ82u+q3TOewtZndyk87lB5kJAzvEVCHgJLOH7aYn2
         dRPLmNTSJ/66oSLrgyx0HWTSPPDfEjHvp2pA0STX11mcFOB8iyw+OoSJa+h8cUdX92ds
         dnDg==
X-Gm-Message-State: ABuFfojOY/k9QOq3BZnbDABFj5zhAE9Tpq35HM21qqkh/kmYjnDm6s+l
        rJc5Opgcr5OhIQuebgtycdc=
X-Google-Smtp-Source: ACcGV606d2p3BewOLi5iJqWKh7rYxkas3Cgn6BPfd2hazvev7WDUEE7+EirUHOD9P4gD/Er0kIPs/w==
X-Received: by 2002:a17:902:6909:: with SMTP id j9-v6mr8512247plk.196.1538014710485;
        Wed, 26 Sep 2018 19:18:30 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id 1-v6sm604434pfm.145.2018.09.26.19.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 19:18:29 -0700 (PDT)
Subject: Re: nfs+tcp boot failures on linuxnext-20180924 from switch
 tcp_clock_ns to CLOCK_TAI
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>
References: <30e76d01dd08c2d9127072ad28c5a99afc5daabf.camel@nxp.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <2185d09d-90e1-81ef-7c7f-346eeb951bf4@gmail.com>
Date:   Wed, 26 Sep 2018 19:18:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <30e76d01dd08c2d9127072ad28c5a99afc5daabf.camel@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/26/2018 06:15 PM, Leonard Crestez wrote:
> Hello,
>  
> It seems that after commit 72b0094f9182 ("tcp: switch tcp_clock_ns() to
> CLOCK_TAI base") some systems that use nfs over tcp fail to boot. The
> last line printed in the log is from systemd:
>  
> [    7.232579] systemd[1]: System time before build time, advancing clock.
>  
> Superficially it looks like very large clock discontinuities now break
> TCP. Maybe boottime could avoid such issues?
>  
> I didn't find similar reports anywhere else. The machines I’m seeing
> this are all 32bit arm imx (this shouldn’t matter) and it seems their
> RTC isn’t properly setup so they boot with realtime set to unix zero,
> then a ~50 years jump happens when systemd starts up. This is the
> likely trigger for this issue.
>  

Thanks for the report.

It is annoying, because SCM_TXTIME and net/sched/sch_etf.c are using CLOCK_TAI,
so it means that if we convert TCP (and net/sched/sch_fq.c) back to ktime_get_ns(),
we will have to differentiate in skbs the clock base.

This has been discussed in the past (When ETF was merged in 4.19) and we chose
to use a common clock base.

