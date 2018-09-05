Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21BEC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CCA2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CCA2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeIEMIy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:08:54 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:56315 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeIEMIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:08:54 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id BFA7F3A2B55;
        Wed,  5 Sep 2018 09:39:58 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Rogier Wolff <R.E.Wolff@bitwizard.nl>
Cc:     Jeff Layton <jlayton@redhat.com>,
        =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: POSIX violation by writeback error
Date:   Wed, 05 Sep 2018 09:39:58 +0200
Message-ID: <3805399.0d8HT3LL4o@merkaba>
In-Reply-To: <20180905070847.GC24519@BitWizard.nl>
References: <CAJDTihz-rFb2SGaxZsQnXGnee_2qW_ynhPe=tZ4yzQBSV_KQ1g@mail.gmail.com> <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com> <20180905070847.GC24519@BitWizard.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff - 05.09.18, 09:08:
> So when a mail queuer puts mail the mailq files and the mail processor
> can get them out of there intact, nobody is going to notice.  (I know
> mail queuers should call fsync and report errors when that fails, but
> there are bound to be applications where calling fsync is not
> appropriate (*))

AFAIK at least Postfix MDA only reports mail as being accepted over SMTP 
once fsync() on the mail file completed successfully. And I´d expect 
every sensible MDA to do this. I don´t know how Dovecot MDA which I 
currently use for sieve support does this tough.

-- 
Martin


