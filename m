Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C5CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED8620836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGKq8TLh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED8620836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935743AbeFRSFD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:05:03 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:40582 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935505AbeFRSE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:04:59 -0400
Received: by mail-yw0-f196.google.com with SMTP id p129-v6so5952778ywg.7;
        Mon, 18 Jun 2018 11:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l83y+8latgHcmjUkgXdqiHP+aMwxNlaOma9f6/lVFPk=;
        b=MGKq8TLhnrEZ2LMRDX9oGqkclQwlo+yWSwfCsMOPdMuyhelBfvlfADulybEEJ7o9i/
         jAtlPR6/dRUlk+EbV9NiHaTG7VwW7H5EpmJniDgXVDgm5jUHkQWCGYTQ1yJ3FgmLPMqW
         otyOT8imk0fFWRh3kSSUzp1ZWFaXlE+pjnPquHxuH8Z59qLxQ02ydXozy5Heke+wpHNd
         o2lDWkbhmG6pD54mC0yAAb7CWTHCj6NYduYY1Hn1LJyI/U2F1iR14YYVTMNI23dCmCHh
         xXaVCM+IQ3dXapQX3Ez+TtUQsm0hz6nvuv6FSeGRY7YqBzaZbTOWu0p/C9VhoRBHQbc+
         h7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=l83y+8latgHcmjUkgXdqiHP+aMwxNlaOma9f6/lVFPk=;
        b=qYeNNJ70qCOjObEy0R6T92WMnEd7Og7isyAyzOpgM3zZe0PeikdIWSW/7VWLgFsGB0
         BXh8vic1I8S+XZDMxitcTNOOQfV5PXzlRImyY5j9YJBDtTI+GuPD/nYQIWUtkRwjvhtF
         Xut0UI1ayFF/CIh8VZOq5uuVeGY8hONo/LwhPjFOoM/WYPQuyI2NxyLURE1x1MrMLX+s
         SrvFc/wr8XbhxwBIHTTu7ENsAaw3bsvnChbKQ2fXY/r3cnwUs+87DThWk3b2GkGztHim
         fgFhfIkA+sdyGCVZ6eelmomumZ1ibZdDA+UI0Ss38T4L+hWSXi79Upa+5DDYDo42pxbL
         zwuA==
X-Gm-Message-State: APt69E1SzdWpJ1PrM+qmH1Q3BcltajiH/SpdWmu1m9P0KbU0p0sjjPT/
        Bt5qbjaing6CvyXuQ713Wes=
X-Google-Smtp-Source: ADUXVKIjPmOnz3+DBkr9p7r7QRHRBCXreAbrETTQhBs09SQryquQSPDqxOziDWfx6cw5XehnxNjW1w==
X-Received: by 2002:a0d:e1d5:: with SMTP id k204-v6mr6278224ywe.365.1529345098775;
        Mon, 18 Jun 2018 11:04:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:b910])
        by smtp.gmail.com with ESMTPSA id n3-v6sm6270326ywd.78.2018.06.18.11.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 11:04:57 -0700 (PDT)
Date:   Mon, 18 Jun 2018 11:04:56 -0700
From:   Tejun Heo <tj@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH] libahci: Fix possible Spectre-v1 pmp indexing in
 ahci_led_store()
Message-ID: <20180618180456.GB1351649@devbig577.frc2.facebook.com>
References: <1528453593-225313-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528453593-225313-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 06:26:33PM +0800, John Garry wrote:
> Currently smatch warns of possible Spectre-V1 issue in ahci_led_store():
> drivers/ata/libahci.c:1150 ahci_led_store() warn: potential spectre issue 'pp->em_priv' (local cap)
> 
> Userspace controls @pmp from following callchain:
> em_message->store()
> ->ata_scsi_em_message_store()
> -->ap->ops->em_store()
> --->ahci_led_store()
> 
> After the mask+shift @pmp is effectively an 8b value, which is used to
> index into an array of length 8, so sanitize the array index.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

Applied to libata/for-4.18-fixes.

Thanks.

-- 
tejun
