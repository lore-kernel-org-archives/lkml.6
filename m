Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-89514-1519694094-2-14146380947892455707
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, RCVD_IN_SORBS_WEB 1.5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='gbk'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519694094; b=Mj5Pdcq81id0jVvrGyaiXx4znvnYTkvTTPfI4ULJJwtg7wx
    qgxq4iOR8gbdXrwPraPgiWicQcqds+671ET/tP4bkOTvgyBeheo2aFwiLu2mzirm
    ENxNJg45E3Q6CR+CT1o692202T324gF4IjR/ChUSDNukDsFSe9QNqQMRbFhxkQtw
    fgQHaAIXagz/PTeIfVxv10eEea7P8WYPfNkOmaJ+j0K/r3EViDM2hbbUWsIpek6e
    hnrTcGzr0rUlAtDkzksON0087dEKbFbwToSKB0Xd7uYmsdr2uLxhuLuOfXOTYAHZ
    9nUToVWETpj/pBy6gtwcvnYQtK/dR1Jc9jowI2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=cc:subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519694094; bh=9rf1etHn+fQjEvha65G8LDDPlRpRSM/6qOStiUe+xow=; b=B
    BW2Fn8AbETdQW635VMpq25dn0VaPpaBv8YeDuD/WPEAM4ai88wGRTlAZaSFrbta0
    C4i7wyglMsFzo7YWRgAvytrWdnjLhF3Iyb763+kf4m9C9iGrckZTRDur0kjb40xz
    Ey6lzKZMC9pUXqdh0ZX7tmv3+Co+hsEiTDWST6JvU9ggVFwibEYo0i/sSVdVNu1d
    GlRt0RBLkwGOEcMzrD4KTxkpJe91IL6M1zlNXAFE8vWHE0cqiVzBl/xB0qFC2jg0
    EDYFAPvs8dOzQE5+dY41vzGwvMepNbdd46eLhseh3r4Gz7M9v1VcGV85Ec2w8uTS
    cLpvy8HRk5Cm8VVQLKnVw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rock-chips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rock-chips.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rock-chips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rock-chips.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeB0BOv (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 20:14:51 -0500
Received: from lucky1.263xmail.com ([211.157.147.130]:41694 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeB0BOu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 20:14:50 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: vineet.gupta1@synopsys.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <9ceb694a5a29c582a22539b72e91f653>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc: shawn.lin@rock-chips.com,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        stable@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 1/2 v3] mmc: dw_mmc: Fix the DTO timeout overflow
 calculation for 32-bit systems
To: Evgeniy Didin <Evgeniy.Didin@synopsys.com>,
        linux-mmc@vger.kernel.org
References: <20180226143413.44134-1-Evgeniy.Didin@synopsys.com>
 <20180226143413.44134-2-Evgeniy.Didin@synopsys.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <d955cc19-1398-3c05-4742-32664480d07d@rock-chips.com>
Date: Tue, 27 Feb 2018 09:14:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226143413.44134-2-Evgeniy.Didin@synopsys.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> Tested-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
> Fixes: ARC STAR 9001306872 HSDK, sdio: board crashes when copying big files
> 
> Signed-off-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
> 
> CC: Alexey Brodkin <abrodkin@synopsys.com>
> CC: Eugeniy Paltsev <paltsev@synopsys.com>
> CC: Douglas Anderson <dianders@chromium.org>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: linux-kernel@vger.kernel.org
> CC: linux-snps-arc@lists.infradead.org
> Cc: <stable@vger.kernel.org> #  9d9491a7da2a mmc: dw_mmc: Fix the DTO timeout calculation

As I said, the correct tag may be:

Reported-by: Vineet Gupta <Vineet.Gupta1@synopsys.com> # ARC STAR 
9001306872 HSDK, sdio: board crashes when copying big files
Tested-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Fixes: 9d9491a7da2a ("mmc: dw_mmc: Fix the DTO timeout calculation")
Cc: <stable@vger.kernel.org>
Signed-off-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
...
...


> ---
> Nothing changed since v2.
>   drivers/mmc/host/dw_mmc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 

> -	drto_ms = DIV_ROUND_UP(MSEC_PER_SEC * drto_clks * drto_div,
> +
> +	drto_ms = DIV_ROUND_UP((u64)MSEC_PER_SEC * drto_clks * drto_div,
>   			       host->bus_hz);
>   

Hmm?

#define DIV_ROUND_DOWN_ULL(ll, d) \
	({ unsigned long long _tmp = (ll); do_div(_tmp, d); _tmp; })

#define DIV_ROUND_UP_ULL(ll, d)		DIV_ROUND_DOWN_ULL((ll) + (d) - 1, (d))


It uses intermediate unsigned long long _tmp for your "multiply", namely
MSEC_PER_SEC * drto_clks * drto_div, which could solves the problem.
So I don't see why DIV_ROUND_UP_ULL can't work for you?


>   	/* add a bit spare time */
> 
