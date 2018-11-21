Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C5AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24056214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24056214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732973AbeKVEqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:46:10 -0500
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:50524 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731134AbeKVEqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:46:10 -0500
Received: from [127.0.0.1] (helo=cs.cmu.edu)
        by hurricane.elijah.cs.cmu.edu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <jaharkes@cs.cmu.edu>)
        id 1gPWxX-0003ur-4j; Wed, 21 Nov 2018 13:10:43 -0500
Date:   Wed, 21 Nov 2018 13:10:42 -0500
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: Re: [PATCH v2] codafs: Fix build using bare-metal toolchain
Message-ID: <20181121181042.4gzuniz2vzjikpwc@cs.cmu.edu>
Mail-Followup-To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>
References: <20181030202713.26203-1-semen.protsenko@linaro.org>
 <CAKaJLVu0h5woVtN5=Mh38ajACBZZQ3JHfRhkjNrwMwYXHEG-NQ@mail.gmail.com>
 <CAHp75Vd-ydncUWQtc8ziLpCMJRFCvjV=ueKB0wRgn7W-pnV09Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd-ydncUWQtc8ziLpCMJRFCvjV=ueKB0wRgn7W-pnV09Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 06:41:13PM +0200, Andy Shevchenko wrote:
> I'm not sure how you managed to miss people in this list (perhaps by
> default you have suppress all Cc in your Git configuration), but I
> guess we may gently ask Christoph to apply this in case Jan will not
> appear.

You have got to give me a little more than 10 minutes to respond before
assuming that I would not appear... I don't think I've ignored any
previous emails on this subject and the only issues has been some people
not receiving my responses for unknown reasons (agressive spam filter?).

I have no problem with this patch, have it sitting with some other
non-urgent patches and in case it doesn't appear upstream it should
piggyback with whatever I have to send.

I still don't know why the bare-metal toolchain couldn't just add a
-D__linux__.  I understand that this define is expected to be always
present while compiling kernel headers so that there is no good reason
to even bother testing for it, which is why I have no issue with the
patch. But it seems it would make your life a lot easier if you had it
defined.

Jan

