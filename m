Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3551978-1526433054-2-12062429048072682300
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526433054; b=GiEa+TwRsnk4B+c059Alsik7PZogVC8T0co6PJFM3B32ZlYl1S
    5UEEtmB0mKxhLbV/mzKULnIlzZpmLjGO4pp6b95D0AuZEkf0OnKZtSy2IMhezWMr
    JhJVu+dlPE0WyOmEomGncUqk0QLVw5W4v1Fhe1IC6X1A156Q6SoBQxld6AKjFakC
    hXWV6xgkz48BWzi6Hk2dMKwSEq4vvtrPyOCVrMobRH7/FhH/UUw8XHtCALbSCQ/N
    iukXj1edpqiP4T6iCZmSbWwl90If6CegzwH17m73nnwAQvqrU4X4oj29QWeJ3iV7
    0JWkM4f7dnAzr8n9jNDwRW3Hcz7GBXlAv+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526433054;
    bh=/qEfQQd4U5ODW899aJJuVAonQHDKXVwXG5CrYBMuq+Q=; b=DSMQAYz03mi1
    srX9WZ22JlWoRJDX8EARh1NZxNI8tWNSFxO+0lzYJRXncjec0kfA/NHm65TLh5Fy
    yPZ9o0A6SOQBDbxvpAYz45qgMA04fWpB2P9heUMmrp/7ikade1bgo1Xh8Y7jHs3A
    r070XBdTa2KG5pysBb+CVyDg9xry0p8HTllyJpyN1jaIRkED/M47IzCD2IGkeUSM
    SLeMmD3IZ2jyorTCnMbwFnHuUUPGGDz29jRVr9/KQIOqsBYvsLCeTFDOeCBK8j2b
    oedZLwfY3OAD4fJaXokJcajPTs8QwjwxjG12F+Qb4jmBCR/dc3Om3VCQYenuA1vt
    4BAHCwEiGg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=codethink.co.uk header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=codethink.co.uk header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPCONzSov+5Gr6ejsM45D/GsyVyEECz/B3UFUrXJmtNPPjztMIbwAT8P4BUbQF23E9GIsjLvwYLao5MT3Wo5HU9f3Ro4o/E+whdcXIIX+4Azav2uJ03b
    ighRZxB/zzsxVgH3rm0rTfJsuZrSud3X5/ANBiCqGQunvpgE8gXVX7cdnVfH9FpnFM3B7zu/8jW4N4OISdqW7CC4xwd1tnrnQxjA10HTieQd59OYbeZCQNi9
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=Byx-y9mGAAAA:8 a=USiETDfwkM-mFnYQSa4A:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbeEPBKv (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 21:10:51 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:59470 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbeEPBKv (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 May 2018 21:10:51 -0400
Message-ID: <1526433042.9159.103.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 125/190] [media] cx25840: fix unchecked return values
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Pan Bian <bianpan2016@163.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: stable@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date: Wed, 16 May 2018 02:10:42 +0100
In-Reply-To: <20180411183559.391845365@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
         <20180411183559.391845365@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-04-11 at 20:36 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Pan Bian <bianpan2016@163.com>
> 
> 
> [ Upstream commit 35378ce143071c2a6bad4b59a000e9b9f8f6ea67 ]
> 
> In functions cx25840_initialize(), cx231xx_initialize(), and
> cx23885_initialize(), the return value of create_singlethread_workqueue()
> is used without validation. This may result in NULL dereference and cause
> kernel crash. This patch fixes it.
[...]
> --- a/drivers/media/i2c/cx25840/cx25840-core.c
> +++ b/drivers/media/i2c/cx25840/cx25840-core.c
> @@ -420,11 +420,13 @@ static void cx25840_initialize(struct i2
>  	INIT_WORK(&state->fw_work, cx25840_work_handler);
>  	init_waitqueue_head(&state->fw_wait);
>  	q = create_singlethread_workqueue("cx25840_fw");
> -	prepare_to_wait(&state->fw_wait, &wait, TASK_UNINTERRUPTIBLE);
> -	queue_work(q, &state->fw_work);
> -	schedule();
> -	finish_wait(&state->fw_wait, &wait);
> -	destroy_workqueue(q);
> +	if (q) {
> +		prepare_to_wait(&state->fw_wait, &wait, TASK_UNINTERRUPTIBLE);
> +		queue_work(q, &state->fw_work);
> +		schedule();
> +		finish_wait(&state->fw_wait, &wait);
> +		destroy_workqueue(q);
> +	}
[...]

Why is the error "handled" by skipping part of the initialisation
process?  Shouldn't we abort and return an error?

Why even create a private workqueue, when we don't do anything that
wouldn't work with one of the global workqueues?

Why even use a workqueue, if we immediately block waiting for the work
to finish?  This makes no sense to me.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
