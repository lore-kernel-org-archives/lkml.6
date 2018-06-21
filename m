Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAABC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E935421C66
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ghN8Sm4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E935421C66
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933433AbeFUUvM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:51:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37270 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933385AbeFUUvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:51:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id r125-v6so8468526wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 13:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nUtZDsp1C+7/cA8GwNwGu00uy8s6wYq8L/NTyithdkA=;
        b=ghN8Sm4rqeTEO3d1QJE+Kstzr6GcRJd3HVI2wVf5XAmlsTfVYtlkJ2BYcIrMpdTBz4
         MpgnmDpjZ6IhUbMUL0yfbXLGxls2Gut3V1iX+RhVILDjjyDFR63S6QL2IHNdnbPm/IDV
         asrE/gq6iR88G32TeTjVxggk9T+2fkoMWgHPoWp5r74eIgadgR810NgsyYBqYW1vz8ky
         6lAm2i3uQN5ZYXHmFkaYvRq7FIUHHs21JawUDDZPRkfBfBo3Ri1WFvU8VGhSh7b5AcLg
         LD23g8wU0RoYBnzhSCSjbxhZPay2/aGK8n2ptoA5W9ifEoq4TgNpt/9g9f+rlF658T8O
         InbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nUtZDsp1C+7/cA8GwNwGu00uy8s6wYq8L/NTyithdkA=;
        b=I4+Tgoc8RxGW4pXX+nX3Ex/dlGJ4nYjctkRZA5TKCTSQkXXXr3mM2cBJidbs/HnZRz
         eSMWfWe4Gw03fY3hsh3ebZw6/4XLVm2iolEr1adWHtnNoRX+PWWc3ITWARUKOLKaHcBe
         zMy6Nz2rNegclH9NGiZHtsbKGmccjk9ZF5p/4XDYvHGSIWKUN7dc+iQXgDhm5n8QSRxm
         9YPjO6H2GEiwbdt6xl+LG0ZWClmLhAlw4t8yTKGl24WwKn3/v4Y4+yFwrMf2kE5JVEYe
         OPNid15KKHsbgsjtGsZtUDwMWHdErr7LSpw0k4sgrfn+VsiwE8pPNjBpnSIBLgl0viIK
         aj+g==
X-Gm-Message-State: APt69E2K6WsJGlM2wWkDGyB1qSQjkQF2CNh6N4GQOR23s2CONc7ULLmy
        td+wpMEF0Odp1ld5OKm8vo3Gww==
X-Google-Smtp-Source: ADUXVKIyWyPn6qn74ar3SDN9VcxoVjnVdhoRXFPuLsi1BH4Q8ohHrAEM8lOqWBCWxHU23Q2FNyQUYQ==
X-Received: by 2002:a1c:eb08:: with SMTP id j8-v6mr6995895wmh.160.1529614269126;
        Thu, 21 Jun 2018 13:51:09 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id a8-v6sm7782648wrc.18.2018.06.21.13.51.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 13:51:08 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fW6Xo-0006xk-TV; Thu, 21 Jun 2018 14:51:04 -0600
Date:   Thu, 21 Jun 2018 14:51:04 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] tpm: Implement tpm_chip_find() and tpm_chip_put()
 for other subsystems
Message-ID: <20180621205104.GA19151@ziepe.ca>
References: <20180620204236.1572523-1-stefanb@linux.vnet.ibm.com>
 <20180620204236.1572523-2-stefanb@linux.vnet.ibm.com>
 <20180621171518.GI11859@linux.intel.com>
 <95b2970f-b71b-4cfc-c188-7ae7e8cb94c5@linux.vnet.ibm.com>
 <20180621175601.GC19270@ziepe.ca>
 <743f606f-b3eb-6917-33bb-5b080f76fe3f@linux.vnet.ibm.com>
 <20180621190620.GE19270@ziepe.ca>
 <9fd8786e-f223-0b06-ce31-78c828348e83@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fd8786e-f223-0b06-ce31-78c828348e83@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 04:14:46PM -0400, Stefan Berger wrote:
> On 06/21/2018 03:06 PM, Jason Gunthorpe wrote:
> >On Thu, Jun 21, 2018 at 02:19:44PM -0400, Stefan Berger wrote:
> >>On 06/21/2018 01:56 PM, Jason Gunthorpe wrote:
> >>>On Thu, Jun 21, 2018 at 01:45:03PM -0400, Stefan Berger wrote:
> >>>>On 06/21/2018 01:15 PM, Jarkko Sakkinen wrote:
> >>>>>On Wed, Jun 20, 2018 at 04:42:33PM -0400, Stefan Berger wrote:
> >>>>>>Implement tpm_chip_find() for other subsystems to find a TPM chip and
> >>>>>>get a reference to that chip. Once done with using the chip, the reference
> >>>>>>is released using tpm_chip_put().
> >>>>>>
> >>>>>>Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >>>>>You should sort this out in a way that we don't end up with duplicate
> >>>>>functions.
> >>>>Do you want me to create a function *like* tpm_chip_find_get() that takes an
> >>>>additional parameter whether to get the ops semaphore and have that function
> >>>>called by the existing tpm_chip_find_get() and the new tpm_chip_find(). The
> >>>>latter would then not get the ops semphore. I didn't want to do this since
> >>>>one time the function returns with a lock held and the other time not.
> >>>Another option, and I haven't looked, is to revise the callers of
> >>>tpm_chip_find_get to not require it to hold the ops semaphore for
> >>>them.
> >>We have tpm_chip_unregister calling tpm_del_char_device to set the ops to
> >>NULL once a chip is unregistered. All existing callers, if they pass in a
> >>tpm_chip != NULL, currently fail if the ops are NULL. (If they pass in
> >>tpm_chip = NULL, they shouldn't find a chip once ops are null and it has
> >>been removed from the IDR). I wouldn't change that since IMA will call in
> >>with a tpm_chip != NULL and we want to protect the ops. All existing code
> >>within the tpm subsystem does seem to call tpm_chip_find_get() with a NULL
> >>pointer, though. Also trusted keys seems to pass in a NULL pointer every
> >>time.
> >>
> >>>Either by giving them an API to do it, or revising the TPM entry
> >>>points to do it.
> >>>
> >>>I didn't look, but how did the ops semaphore get grabbed in your
> >>>revised patches? They do grab it, right?
> >>The revised patches do not touch the existing code much but will call
> >>tpm_chip_find_get() and get that semaphore every time before the ops are
> >>used. IMA is the only caller of tpm_chip_find() that now gets an additional
> >>reference to the tpm_chip and these APIs get called like this from IMA:
> >>
> >>ima init: chip = tpm_chip_find()
> >>
> >>ima::tpm: tpm_chip_find_get(chip) ... tpm_put_ops(chip)
> >>
> >>ima::tpm: tpm_chip_find_get(chip) ... tpm_put_ops(chip)
> >>
> >>[repeat]
> >>
> >>ima shutdown: tpm_chip_put(chip)
> >Maybe just change tpm_chip_find_get() into tpm_get_ops(chip) and
> >convert all callers?
> 
> And then re-introduce tpm_chip_find_get() for IMA to call ?

You could keep it as 'tpm_chip_find', that seems like a fine name to
me

Jason
