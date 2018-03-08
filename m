Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2157884-1520521299-2-18226739857562650599
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  FREEMAIL_REPLYTO_END_DIGIT 0.25, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520521298; b=CLNls6z37p0N9HlXqQORjxFqihpcVVLcFR2VN7C9UqKbv40
    t5hbv7vR1LFYDul0XE4flUzF8to+oi2mE4uDo7GHhT8+245iFY2DQxcAdChg98Ez
    4/UROfXlAt4HuRcJqTMneOuY8CorKtm4gDF83rIk0GqmUwLbHXXbvxhE9ABVI1Vq
    3GlLEyaeMHgEmThvoSBCPWxa2hJC63UKuPwC3eZwmfKX3AMrA673HvyPaUhul0aO
    7cQyyZCtuIVCWUM2qJI9yq7krvRPm90Od7YrZbGUFrI4VIk22mSO6nLXPrC+JPXq
    DvS/Q4yCSngXZw8vveQ37tTZjWCEnpn/ybul/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:reply-to:to:cc
    :date:in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520521298; bh=3g17Ex0JfXZQHlin12dIuIEMAVVc4fZuX/and/TS874=; b=a
    AWjmoU4mPhXMhSMqZVGjEafZmov/3hKkwoht+PvWOAddMFHny+NeCk2PliRxSWGL
    kIpO1tHuOxcz0NM+OxVSXzzkdT2NRFwBvsnYNlplPLZg+4QKehTnlPlD5mSoixGa
    Cm1UwQ07nruR96ILoxyoNk+T+B5J3rUyT8qIsLfNdaP9p3gDeYQ/rPYmaBA4ZOcN
    JACOpMVFZY/aeAI1ezEUhtTB70IjI2Ep5ROq5KUQs0nB3Fgf3d4zkhWvkPAZT/IG
    yF6fPzG5eE8vw2IhdqDAqVkKB16eu0r1m0c4xCdFnkTJkD1FsQ3qT0rvoCz4mRxz
    dkkGaNLUT3Dyuh78PdYdQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756000AbeCHPBX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 10:01:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:18914 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755468AbeCHPBV (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 10:01:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,441,1515484800";
   d="scan'208";a="26310555"
Message-ID: <1520521275.20980.41.camel@gmail.com>
Subject: Re: [PATCH] ubi: Reject MLC NAND
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: Richard Weinberger <richard@nod.at>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mtd@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Mark Vasut <marek.vasut@gmail.com>,
        Boris BREZILLON <boris.brezillon@free-electrons.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>, tharvey@gateworks.com,
        stable <stable@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 08 Mar 2018 17:01:15 +0200
In-Reply-To: <3797589.z8fAhu5iDP@blindfold>
References: <20180303104554.5958-1-richard@nod.at>
         <CACRpkdYOqt4xTqGmbSwd_R84NRD8GA9TsHEk_hJ68hhxwbsL_Q@mail.gmail.com>
         <3797589.z8fAhu5iDP@blindfold>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-03-08 at 15:43 +0100, Richard Weinberger wrote:
> As stated by David Woodhouse, it was a huge mistake by UBI to not
> reject MLC 
> NAND from the very beginning.

Correction: when we were developing UBI/UBIFS and upstreamed them, MLC
was widely used yet we did not really know about it. So there was
nothing to reject yet.

The mistake is that we did not add the reject timely. When people
started reporting MLC issues we were answering that UBI/UBIFS stack
needs more work to make MLC safe to use, and we hoped someone would do
the work.

Artem.
