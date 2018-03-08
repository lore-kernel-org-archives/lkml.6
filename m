Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1971043-1520514767-2-10176870514467028034
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520514766; b=upiFYMD4SduYI8Bc4MGI4IT7ggWDU8yHO1pPJIEB3eLfaRO
    RuiO4ZKYZ/BZnWe82m78f4v4w8E3ERSceVsML5FrOxOxERAyntZdV31ef/05SzMC
    Ic4ZyIHPQYopS9F2NY6EmUrc18HoS76SQOHkhMneLLsdkdtOs358gkY53Gy2R1Ii
    cw/hnssKSi5z8i5f9qIHrG+LP44XLfbTxv+u0J6YMxi52cTAI7iInArFfnaV++An
    hV1MNGEShPf2mPHFp5Sbsf9m/aA98ubYMQny2M6aizJmWeBXH4ARxZwG2eYt4xjg
    ahXCnsewNUT5z443JVqU4A8m29/VJsbwlkdrVVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520514766; bh=Rz5eZxqvswlNpTMgV1mrpQ0qSL
    iDQU02WjW1cfE5wuE=; b=WvEROIlmOhzsUqEfApaFv1W36WoXpyUmHOvsoo2bMp
    UOKX26LhmD8kwT+7DDBuSJKeFm5xy2tsnQPivEnjkvE7qVdZdCh1Pdw2v48Ri/Zj
    kir5smkFbriscS8u/GmnZ0dC9JKE4zFodfp0vvAmHDZGy6tg57cA4m0fxdX/2Mo4
    CnLwnEv6VjV4RfAJeBwpganx9zo8b14WvBr5qS6OpMuphg01cOQ5XuaAsVnood9p
    NQ9BbscmGxfEKPPzHFDMdrRGR919t9CrQ8hT661NNYIJzzoXSJBzWdsaKQ2Pw4hJ
    cXYB0HR1u5QHDmq25TVYq2B0PbjhnF0sKGLC4LRB1t5A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935811AbeCHNMQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 08:12:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:45990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935769AbeCHNMP (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 08:12:15 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2762133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jeyu@kernel.org
Date: Thu, 8 Mar 2018 14:12:10 +0100
From: Jessica Yu <jeyu@kernel.org>
To: Leon Yu <chianglungyu@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH resend] module: propagate error in modules_open()
Message-ID: <20180308131208.qlrfmla2x3gwt3mp@redbean>
References: <20180306151624.24196-1-chianglungyu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180306151624.24196-1-chianglungyu@gmail.com>
X-OS: Linux redbean 4.15.0-next-20180207 x86_64
User-Agent: NeoMutt/20171215
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

+++ Leon Yu [06/03/18 23:16 +0800]:
>otherwise kernel can oops later in seq_release() due to dereferencing null
>file->private_data which is only set if seq_open() succeeds.
>
>BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
>IP: seq_release+0xc/0x30
>Call Trace:
> close_pdeo+0x37/0xd0
> proc_reg_release+0x5d/0x60
> __fput+0x9d/0x1d0
> ____fput+0x9/0x10
> task_work_run+0x75/0x90
> do_exit+0x252/0xa00
> do_group_exit+0x36/0xb0
> SyS_exit_group+0xf/0x10
>
>Fixes: 516fb7f2e73d ("/proc/module: use the same logic as /proc/kallsyms for address exposure")
>Cc: Jessica Yu <jeyu@kernel.org>
>Cc: Linus Torvalds <torvalds@linux-foundation.org>
>Cc: stable@vger.kernel.org # 4.15+
>Signed-off-by: Leon Yu <chianglungyu@gmail.com>

Ah yeah, the error code was dropped in that commit. 

Applied, thanks for the fix.

Jessica

>---
> kernel/module.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index ad2d420024f6..e42764acedb4 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -4228,7 +4228,7 @@ static int modules_open(struct inode *inode, struct file *file)
> 		m->private = kallsyms_show_value() ? NULL : (void *)8ul;
> 	}
>
>-	return 0;
>+	return err;
> }
>
> static const struct file_operations proc_modules_operations = {
>--
>2.16.2
