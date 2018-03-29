Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3703489-1522289908-2-1687420320436390767
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522289907; b=GR8nr5Wk7cYFjM3CwBYluIU2AELtxwd+BYsVJraXSZUHUL+
    gFbOFAA50K8ttyRFpxXGDOSM1iTjbUc9D9bRIC8DTseUnPrQW1E7zTTZK7WZKeB0
    XYpSTrp6mrkLRb++iRvNqTp48rHmb/o7QyzxdFDbcBKmuh5WZ/3UVhOjMLzrs2UX
    IZnX7yxV/fMGhyociPzxLEMk6KqnFF0THJEHHSrjxQ7phlQ2Gas1cIRUdYKZ5Vs8
    TghmYLK0YTOPbHyJWTH2LLuIi0p61ZWzR6jnZkhBtKK8Jziiw8z4wWCKEHQCSH9Q
    puNYBAbOhzXvQPdi82NVs3l3CosRb82dI8RDabA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522289907; bh=Ojf6fDcqOf5OMnQr6opUCQ1chu
    VTU+CHdX/iA155GR4=; b=m2Q3A5W8v91x23OR54IyxPTtIZw9lzCEooDcTZ1wnY
    v0udc4NbRou/SX9d/b2I4Ch0sYWkhXvDMBREvjrdFA8XLXU4mq19+wFInmw3uojQ
    ycbz/DgHBB3UdpKztIT74vp7eynv/xgDAXSAz2F1KfkkfEyfrmbCpennb1VDDehh
    XxdO3oN4ihMDGM84esHBAepmanViI9Y4m4lOoj2SsWfayl7+RRTLO116mHfukovR
    kJNUmuVoAIn0LXxZoBhFgFSVcksexzEYpA4TGbn6mZP7S9GvZmOpKacowoXLVDmY
    P795O2nSu2KvCeguy2UOw4L4Pmv7LTrNWYQU92SWQjCQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=K9MME2+v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Jyg/dwuH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=K9MME2+v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Jyg/dwuH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFT3X5qN81i4Qxn73bMQc0l+Za7yD9N9wgseu7EsvBiTiUYtzaAraOPfN3At354QAdu0pcNAKBZe2R8UmxRftQODB+v4NRMwxmMbXVM2mBfH2OhQFW8W
    vIsd1YE9XdEXHkKiwg4W2EUZE7oLec+DHoTgzHAfSM6DmkwipM25Bb5mk9M7TPbZTGlyq3+iwEXZnwTurTHtuhMXJNsr7xPYaNl5X4AMEgiBNmwPT2t94Ilg
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=uP1ucDPQAAAA:8 a=Byx-y9mGAAAA:8 a=3Suf5XRKAAAA:8 a=6ohNodAXAAAA:8
    a=KKAkSRfTAAAA:8 a=Pms26XNpMU6socnADCgA:9 a=CjuIK1q_8ugA:10
    a=9a9ggB8z3XFZH39hjkD6:22 a=VcBebDW0u3KdNpfvOfbI:22 a=0gLUg1G2xj6MhZ7RLP3J:22
    a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750946AbeC2CSY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 22:18:24 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33776 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeC2CSX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 22:18:23 -0400
X-Google-Smtp-Source: AIpwx483qtcTh8EZRuGrovj2vDPjFeAtRaM3XwZx1BWIG+7v/3jWJTV1OCvNjVaR52AP3XH99CLtlg==
Date: Thu, 29 Mar 2018 10:18:06 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: alexandre.belloni@free-electrons.com, linux-kernel@vger.kernel.org,
        a.zummo@towertech.it, Pan Bian <bianpan2016@163.com>,
        Guy Shapiro <guy.shapiro@mobi-wize.com>,
        Stefan Agner <stefan@agner.ch>,
        Frank Li <Frank.Li@freescale.com>, linux-rtc@vger.kernel.org,
        "# v3 . 16+" <stable@vger.kernel.org>
Subject: Re: [RESEND] [PATCH] rtc: snvs: Fix usage of snvs_rtc_enable
Message-ID: <20180329021803.GI27302@dragon>
References: <1522264445-2398-1-git-send-email-pure.logic@nexus-software.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522264445-2398-1-git-send-email-pure.logic@nexus-software.ie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 08:14:05PM +0100, Bryan O'Donoghue wrote:
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

Acked-by: Shawn Guo <shawn.guo@linaro.org>
