Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F3CC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B68F2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=profitbricks-com.20150623.gappssmtp.com header.i=@profitbricks-com.20150623.gappssmtp.com header.b="cstYeP4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B68F2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=profitbricks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbeJSAUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:20:36 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:37657 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbeJSAUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:20:35 -0400
Received: by mail-wr1-f43.google.com with SMTP id q1-v6so1451669wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 09:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profitbricks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sCFUxhrLMKtQdrl6dmmN+WO9oRf03HSY4CKqba+0ZKo=;
        b=cstYeP4+sF1I8z5ymg/XYJ2WyADVR6KYMIhO8CPHdDvWMteYDd2WFoFkXhL7tauPMC
         pUHUhBJa3H9MsEK26YT3+LA0DalqQyxxy4LJ87GuPYwB2XXCWlac7zAUlGHsa5MieKbF
         ckhza681/kB0CmRUt5K/AHLEquhwsBDkjoFunSPJSDkbOeJdlVVDpeEe2xViDAwx4lNB
         eTDIR+osnmE7oD1VmuPjYoHUWrWtsmPHsCvhKyE3Ns7+MOICrEiY1d5DjNNwi1BfHw1O
         ur2QATIKAx6p2YXW5nXWfvHOY1ayLqoAp7QcgeJHRAp1NJ8DTHXnUzhzommp81YtF0Va
         93kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sCFUxhrLMKtQdrl6dmmN+WO9oRf03HSY4CKqba+0ZKo=;
        b=Ky7dYVUUCPmPFVY44MQ1vsoQyFK8hHURmieT5YBhsbWhbSJUvOCuxxZ8cxq71NpMDK
         TWODLea4nbs6L4wc9a3ct6mbftznjWYcda9so7I5fYjMX7su29Q5HihH/7szt3VI1vH2
         pKEvIHMqkn9a3RnLjfU3EN8EdzS0eYLS2nGPiEUiXTyzIYMOYTvq7MV29Qp1esO8hm0F
         JaKcmBhIC0oKE0Ood6SvaHeR6vyOF4duUCZHyB8is3sPkZwOJK2xS3DVdG0IVyteQ/dS
         iBIyqINcEh/R6xGlkLSTtoQIYuz0ASTAha26csECpsdejS2kd0wOcEbH/dFzAkGrr2AD
         djNQ==
X-Gm-Message-State: ABuFfoin4I1sy9Jo0r1PrwzS3Qx1+BrGMRZF8a8jNfbyhQ5HQkkBUpja
        mAFzmArH0f+g5LhIh/0oQObWrTJhoui90BG13Yo+Sc6ielr2cA==
X-Google-Smtp-Source: ACcGV62RyRl63yrKsUaqWBXqaR1s+T5naN8W80Gyg1YzGGNEiNUwgKe1D/gzg6ROaME97fS1hrMPo8eKM9j52JiVY9I=
X-Received: by 2002:adf:e94b:: with SMTP id m11-v6mr30154048wrn.126.1539879532372;
 Thu, 18 Oct 2018 09:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <5bc8af85.1c69fb81.3eebc.a22b@mx.google.com>
In-Reply-To: <5bc8af85.1c69fb81.3eebc.a22b@mx.google.com>
From:   Jinpu Wang <jinpu.wang@profitbricks.com>
Date:   Thu, 18 Oct 2018 18:18:40 +0200
Message-ID: <CAMGffE=sKUZS=soSgT_ki9JQ7bVdCdVyrzQ8W+m5F4FSPEopFQ@mail.gmail.com>
Subject: Re: [PATCH] scsi/mvsas/mv_sas.c: Use dma_pool_zalloc
To:     sabyasachi.linux@gmail.com
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        John Garry <john.garry@huawei.com>, jrdr.linux@gmail.com,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 6:06 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Replaced dma_pool_alloc + memset with dma_pool_zalloc
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Reviewed-by: Jack Wang <jinpu.wang@profitbricks.com>
Thanks!
> ---
>  drivers/scsi/mvsas/mv_sas.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)



--=20
Jack Wang
Linux Kernel Developer

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Tel:       +49 30 577 008  042
Fax:      +49 30 577 008 299
Email:    jinpu.wang@profitbricks.com
URL:      https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Gesch=C3=A4ftsf=C3=BChrer: Achim Weiss, Matthias Steinberg, Christoph Steff=
ens
