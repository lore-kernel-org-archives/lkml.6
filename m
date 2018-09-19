Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE836ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A842A2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOqmNrly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A842A2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733002AbeISXBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:01:14 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:44454 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbeISXBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:01:14 -0400
Received: by mail-lf1-f52.google.com with SMTP id g24-v6so5819084lfb.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 10:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kjkzSeVbd9Q9AoA7oVEcp2Ze2wn+5aU/UqZKzoXCzTw=;
        b=jOqmNrly2Tx35EAU1Rij2SH+OOSfzhGTKYfG+fB/5WSwIT27FbKgQslFOFxTyC/SmF
         1cgDerBVFNpQ1w5p4yGFMzLxyKwJKKG+rlDGhzz9zO87hYq5EvGJ05tTFkTMuuJ6Yx5j
         8Zep0+t84oVe7zzytKtZdTgLi5/8dZrQYxY714VezP7KYbq71np5y3pBxieIBVFIDuQQ
         z22wa0gTAewdJbJ/lQMi757OMlPB3h554TxrMyATRogyWjSi70bYJr5Ji4U15O/vRfzt
         vObZEh/KxBQmDKgh07X53RkZxuI/2r4X03mtP4aJyiOrvANbQwcQXoxWd4aFb67NkSth
         b1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kjkzSeVbd9Q9AoA7oVEcp2Ze2wn+5aU/UqZKzoXCzTw=;
        b=mPvPPLdWeGaKmdolMV+5lc1/a8wGoh1jXVkxWg8WL1zMhfMbFw4fbdS1Hihp63KJJw
         GskTeKpgRLUBM42C1eOBs1jPL0suPP1Vf/huUjuG+7e+Pm2UVSz0BV5821JhI3L9FeMc
         mYcb99xsMc+2pcSXqO7yVmu8T2G9b7EA1bT+iQ+nnFgvLI+WkbKCyE10OXP+0yPKf5BL
         ykx4DiZx5O9OnxUmvzUBVEEP/ha7SGeJM4zObo1CCLHZC26e0nLQFmVD6ub3uxDHTVqw
         U0nhb0HLH1EJC3xy1kqdnJPbP8H+LyUFkN8BNQNcWn+jXATEIXbRsYWgoREyohIUbYKM
         YHmQ==
X-Gm-Message-State: APzg51B6Q9dRrTnPMdZKHvFFF7lcoUAHjHek1E2oZ2G5bKloz8uMBWuY
        Mcu1khvlAIoLeN8SVQFSrnuSj/NWp834YR9Ar3pkxw==
X-Google-Smtp-Source: ANB0VdasdgeKntZaUjCU7kyeXI0/3FaaIpF3LNtqV/+k60/atCfE9GBYlA71L1E87daarF//pshtiaTFcwrmtncMBWE=
X-Received: by 2002:a19:518a:: with SMTP id g10-v6mr6795245lfl.63.1537377738340;
 Wed, 19 Sep 2018 10:22:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:278e:0:0:0:0:0 with HTTP; Wed, 19 Sep 2018 10:22:17
 -0700 (PDT)
In-Reply-To: <77f81bcb07d6a9193992f87dbd040658@redchan.it>
References: <6b4a0cf6fa672938b8ab98acd1dea0a1@redchan.it> <BBFE2346-72C7-47D3-910A-DD720C7637DC@charter.net>
 <24cf6d6095c740903f16b56e22dd137c@redchan.it> <996c99ea4146a247730d87df14dfca1a@redchan.it>
 <E1g2TJn-0006lD-Lm@fencepost.gnu.org> <0bd7fb92f5b2d5f18e67fdc9b3f6e603@redchan.it>
 <77f81bcb07d6a9193992f87dbd040658@redchan.it>
From:   "\\0xDynamite" <dreamingforward@gmail.com>
Date:   Wed, 19 Sep 2018 12:22:17 -0500
Message-ID: <CAMjeLr-qVubez4wJ0AVrjVv2hEk6HjCpA30U=Of0hJEWmwqKyA@mail.gmail.com>
Subject: Re: Re: Fwd: Re: [DNG] GPL version 2 is a bare license. Recind.
 (Regarding (future) linux Code of Conduct Bannings).
To:     observerofaffairs@redchan.it
Cc:     linux-kernel@vger.kernel.org, dng@lists.dyne.org,
        debian-user@lists.debian.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 2018-09-19 03:38, Richard Stallman wrote:
>> [[[ To any NSA and FBI agents reading my email: please consider    ]]]
>> [[[ whether defending the US Constitution against all enemies,     ]]]
>> [[[ foreign or domestic, requires you to follow Snowden's example. ]]]
>>
>>   > One is rescission of the license they granted regarding their code,
>> and
>>   > then a lawsuit under copyright if/when the rescission is ignored.
>>   > The others are breach of contract, libel, false light, etc.
>>
>> If "rescission" is really a possibility, it would cause greast trouble
>> for the free software community.  We would need to take steps to make
>> sure it cannot happen.
>>
>> However, that goes against everything I have been told by others.

This is where copyright differs from IP.  With copyright, you have the
right to derived works if they don't violate Fair Use -- but that
could essentially be violating the GPL.

The only way to protect the code and spirit of the GPL at that point,
is to accept the legal concept of Intellectual Property.

The question then, is, is source code released under the GPL
considered "published work"?

Mark Janssen, JD
