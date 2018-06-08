Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /RnvLpgmGlvfegAAmS7hNA
	; Fri, 08 Jun 2018 06:47:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A20CE6089E; Fri,  8 Jun 2018 06:47:52 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaLx0jPl"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2D94960275;
	Fri,  8 Jun 2018 06:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2D94960275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeFHGrt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 02:47:49 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:34641 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbeFHGrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 02:47:48 -0400
Received: by mail-wr0-f174.google.com with SMTP id a12-v6so12176897wro.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 23:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GfzD4UBHfgCRVlUhSSUnSNg9YLFp5OdKg1iqwF7tmfw=;
        b=EaLx0jPlA/BhgG5yPK41UfwGannFV1pdQWXqqlufrck8Y1yxDu1X+MNLwAoSLVO3Mb
         Ku5pMJiaA5xYsUFLr0wNhrc3vWeu2vdpyBSrHVER9HxxWrA1bZ88eWAQz6C83pyeQPPN
         MnzLU9jS3EqUgLEUU30/FkWr6pxZJz2Lh9Vtdu3ay+BD84A9hXelm4XZGnKDCZ5iCjXo
         FjdgbCKkEOwJA9z4pXnMGNJ+06O1KfMIo3fxj21Q8OxpAg0CKlHOQsKCDiaRMlf6ub/+
         5e/KGaEMMUWtL/QRSVP3IlAmUIF/EhSD3igK5FG+89WATHRWS0pvCRyt3re28z/kvi+B
         kC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=GfzD4UBHfgCRVlUhSSUnSNg9YLFp5OdKg1iqwF7tmfw=;
        b=U+XvfZofkk0lCEvtnrRlF6r9aWdISF9RfCBS1hESt8FuH0wTZfJ+OH8xAoxWKteoI1
         nyXZiCE2d9Tc3M98IZiyHthsifmSDdvSmGmfzcIwK4S/HMZp4n+sAw0UYrESdLtp19QZ
         hSd0vkPAR2wgwAdtSS2RQHhJEUdfQMST3x0a41qqLu12WKtunYBIZy7coR7p+HzLY4Sy
         LW3P+AD4UeW7uPB1q/jUE/qwT4wR/VkIVjGVx6rF9ifChSDdK5BhA9raoFEPPQMQfh2I
         lmHkpfAmnwVceuYDrwnZmtuqgu5Co94VwSc/Y/qVX12BGVL3lBhd8Cf3F7ShPErmyufk
         g4lQ==
X-Gm-Message-State: APt69E0yT8lknkxL+o5W7eQizr3RG2rmYyeeVhf0D/UQVNAYGtXhU8Ns
        Jgc5cXXhcPVJ2QxKhom/GrY=
X-Google-Smtp-Source: ADUXVKLguXIxsxcv5ix+jN22Gj1zouRnlSSqjt+RNRLoVW+TIk5yDQBv3kV9tV1MofHBSA/L3ghPtQ==
X-Received: by 2002:adf:c00b:: with SMTP id z11-v6mr3728078wre.268.1528440467331;
        Thu, 07 Jun 2018 23:47:47 -0700 (PDT)
Received: from ?IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740? ([2a02:908:1257:4460:1ab8:55c1:a639:6740])
        by smtp.gmail.com with ESMTPSA id 12-v6sm985520wmn.27.2018.06.07.23.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 23:47:46 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: Kernel and ADM hardware roulette ( was AMD graphics performance
 regression in 4.15 and later )
To: Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
        Jean-Marc Valin <jmvalin@mozilla.com>,
        Gabriel C <nix.or.die@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, Joerg Roedel <jroedel@suse.de>,
        alexander.deucher@amd.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
References: <CAEJqkgiNVDzboDK1vsn9rYP0G=Q_mGDrkx1VVB8TUkm35Rs9fA@mail.gmail.com>
 <516cddbe-73c2-01f3-a552-0d9fd75ce63a@amd.com>
 <8f7d00f9-992f-cc07-6bd0-b1b47c5d2ccf@amd.com>
 <ae904954-18f7-180a-ce69-7e7618bd398f@daenzer.net>
 <CAEJqkgjErpxG44CZXn2BzvPES7Ptf24ae6748dAcYdg2n5HuZw@mail.gmail.com>
 <267c42ce-91e2-4843-3815-904ac74b2f44@amd.com>
 <CAEJqkggsjnod79HFvYQHRFEsFaN-bb27P8Xf79_9DmxhLKs_Og@mail.gmail.com>
 <CAEJqkghgkDeZheZsFC3rJ3W5Z-5DYdqA0U+zas0voDp7kSdORg@mail.gmail.com>
 <f3ae499f-c78f-4d65-ddfe-b74468b0fd81@amd.com>
 <20180608060144.GA24107@lst.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <cf512303-6bae-cd7d-d8ea-29f5462c1eb4@gmail.com>
Date: Fri, 8 Jun 2018 08:47:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608060144.GA24107@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Am 08.06.2018 um 08:01 schrieb Christoph Hellwig:
> On Thu, Jun 07, 2018 at 07:20:37PM +0200, Christian König wrote:
>> Hi Christopher,
> I don't see a Christopher on the Cc list..

Sorry, auto-uncorrection. I indeed meant you :)

Christian.
