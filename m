Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1765435-1522767418-2-6660537339384481248
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522767418; b=rRAsH/1n+GmFAVd2GSVUZjvRdq1bHX1ME81ySFVND5RFSkEr3A
    3LCy/1L0mS8wSXtCXnnifig0XBJt8XJ0gdu4vjj96hEA/kW2LvYSpF44wEHMuqQx
    sPa0iJ2OL6Wqadb1Upaj47taP5VoSgO8hbIr2pxGDjErKl0vNHVBAzMj0EXuueuE
    xglFPWQnN/n6d8sVIzO9CJ6DDMmrkoM56n/zrWI3H/CzvcJyNf12ZbarODldF4v0
    o4ez+bP7s0fZ+VRoM+kE2//3vJazWXROdCNWTHFhkOFd4eltwmR9Yvdd7hrqt3xW
    4uKYPrR6wIoiWb+gusDhnUYJJ+C8qWTXUMAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522767418; bh=sa1CLM1QOJbkA9eKSLCaIT9buTUaOp
    VjGKHCZ6nF3S8=; b=aMTjA2LV+RKy+1Xm1RHtTzrIj3pPDe4djucCO9lnp9MZjI
    OeBAbYNycekJUYBecGFkPSbwKQMBo1B/MkdEsrs3HGdWoGUbTT/XAOzdvEGG5TT6
    i4+8ySsL52RwFWYNdfX7huFotPY+K2uPQbVgdwzMiD0DO3Dwm8hPVe++iHeVTens
    zpubZFKwXAAEKHnNHNXhmPj7AZ+oPVdBPxvb2jCzR49uCGJisW6X14Fuq9tH6Cv7
    OkcH96Leol1wedgOnxiGfnGj0QWxEzK/2aCmbSyhmDsY0VaBr+IHqyeKBgpzgQpu
    f+O39/RB9WEW/J1fNxxzdiGcizmMQoau5uSkncJA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=free-electrons.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=free-electrons.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=free-electrons.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=free-electrons.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA7jHXcQ4aL/ZnNVLm2gND0NWUtYMZ5iJ0U7hPA334gNiqSOKE6AbFSWCTtnwq8ydJ5DAjlrUvntptJXa8GniR1TdJpDGXNeL5ARi5v1gxVTqCGV4PyC
    fRIT4NHpgpacz7KmF54zQTLM2XcVWBhF7a/h5oU3WA3InLcHlKDc0cTNg5fHNJI6QmuampFU7sPQIMdrXf/bCxp+9nncMisrQH8tgpOdL2DTinYtMTBgFVcP
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=uP1ucDPQAAAA:8 a=Byx-y9mGAAAA:8 a=3Suf5XRKAAAA:8 a=6ohNodAXAAAA:8
    a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=Pms26XNpMU6socnADCgA:9
    a=CjuIK1q_8ugA:10 a=9a9ggB8z3XFZH39hjkD6:22 a=VcBebDW0u3KdNpfvOfbI:22
    a=0gLUg1G2xj6MhZ7RLP3J:22 a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22
    a=d3PnA9EDa4IxuAV0gXij:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbeDCO4z (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 10:56:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50576 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751095AbeDCO4y (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 3 Apr 2018 10:56:54 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on mail.bootlin.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT,
        URIBL_BLOCKED shortcircuit=ham autolearn=disabled version=3.4.0
Date: Tue, 3 Apr 2018 16:56:42 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: linux-kernel@vger.kernel.org, a.zummo@towertech.it,
        Pan Bian <bianpan2016@163.com>,
        Guy Shapiro <guy.shapiro@mobi-wize.com>,
        Stefan Agner <stefan@agner.ch>,
        Frank Li <Frank.Li@freescale.com>,
        Shawn Guo <shawn.guo@linaro.org>, linux-rtc@vger.kernel.org,
        "# v3 . 16+" <stable@vger.kernel.org>
Subject: Re: [RESEND] [PATCH] rtc: snvs: Fix usage of snvs_rtc_enable
Message-ID: <20180403145642.GA6444@piout.net>
References: <1522264445-2398-1-git-send-email-pure.logic@nexus-software.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522264445-2398-1-git-send-email-pure.logic@nexus-software.ie>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 28/03/2018 20:14:05+0100, Bryan O'Donoghue wrote:
> commit 179a502f8c46 ("rtc: snvs: add Freescale rtc-snvs driver") introduces
> the SNVS RTC driver with a function snvs_rtc_enable().
> 
> snvs_rtc_enable() can return an error on the enable path however this
> driver does not currently trap that failure on the probe() path and
> consequently if enabling the RTC fails we encounter a later error spinning
> forever in rtc_write_sync_lp().
> 
> [   36.093481] [<c010d630>] (__irq_svc) from [<c0c2e9ec>] (_raw_spin_unlock_irqrestore+0x34/0x44)
> [   36.102122] [<c0c2e9ec>] (_raw_spin_unlock_irqrestore) from [<c072e32c>] (regmap_read+0x4c/0x5c)
> [   36.110938] [<c072e32c>] (regmap_read) from [<c085d0f4>] (rtc_write_sync_lp+0x6c/0x98)
> [   36.118881] [<c085d0f4>] (rtc_write_sync_lp) from [<c085d160>] (snvs_rtc_alarm_irq_enable+0x40/0x4c)
> [   36.128041] [<c085d160>] (snvs_rtc_alarm_irq_enable) from [<c08567b4>] (rtc_timer_do_work+0xd8/0x1a8)
> [   36.137291] [<c08567b4>] (rtc_timer_do_work) from [<c01441b8>] (process_one_work+0x28c/0x76c)
> [   36.145840] [<c01441b8>] (process_one_work) from [<c01446cc>] (worker_thread+0x34/0x58c)
> [   36.153961] [<c01446cc>] (worker_thread) from [<c014aee4>] (kthread+0x138/0x150)
> [   36.161388] [<c014aee4>] (kthread) from [<c0107e14>] (ret_from_fork+0x14/0x20)
> [   36.168635] rcu_sched kthread starved for 2602 jiffies! g496 c495 f0x2 RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=0
> [   36.178564] rcu_sched       R  running task        0     8      2 0x00000000
> [   36.185664] [<c0c288b0>] (__schedule) from [<c0c29134>] (schedule+0x3c/0xa0)
> [   36.192739] [<c0c29134>] (schedule) from [<c0c2db80>] (schedule_timeout+0x78/0x4e0)
> [   36.200422] [<c0c2db80>] (schedule_timeout) from [<c01a7ab0>] (rcu_gp_kthread+0x648/0x1864)
> [   36.208800] [<c01a7ab0>] (rcu_gp_kthread) from [<c014aee4>] (kthread+0x138/0x150)
> [   36.216309] [<c014aee4>] (kthread) from [<c0107e14>] (ret_from_fork+0x14/0x20)
> 
> This patch fixes by parsing the result of rtc_write_sync_lp() and
> propagating both in the probe and elsewhere. If the RTC doesn't start we
> don't proceed loading the driver and don't get into this loop mess later
> on.
> 
> Fixes: 179a502f8c46 ("rtc: snvs: add Freescale rtc-snvs driver")
> 
> Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
> Cc: a.zummo@towertech.it
> Cc: alexandre.belloni@free-electrons.com
> Cc: Pan Bian <bianpan2016@163.com>
> Cc: Guy Shapiro <guy.shapiro@mobi-wize.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Frank Li <Frank.Li@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: linux-rtc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: <stable@vger.kernel.org> # v3.16+
> ---
>  drivers/rtc/rtc-snvs.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
