Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D01C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC8C20818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ddk/uJQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC8C20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbeKJDlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:41:18 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37048 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbeKJDlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:41:17 -0500
Received: by mail-lj1-f196.google.com with SMTP id e5-v6so2344178lja.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 09:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n0jjdD3gVHEVQjOy2yYXIZuKztdvSoU+u9kYir6x/0Q=;
        b=Ddk/uJQ7Xhu0O+1fqNtvv1NS9304nLtjcxl4s44krX8qeSP+HrgieXrG0gyqBfzjJB
         niFhxeFzthF478QcxnzG6iRFTzeCjBiO3BxCSCv/7jhFW5c7SiGIgmJaamnjoq4XBinB
         4M4ZeCD7W0vJQqvTfqr+q2KsUSwEIJ39ImyDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n0jjdD3gVHEVQjOy2yYXIZuKztdvSoU+u9kYir6x/0Q=;
        b=ELrBSHX6/DY8Nb16d75GInnB/C8Hh1Xdqyfk1rZ8llMgrbaEs7NmB4t4FsTGe6c4ag
         CwQcUFo8rBFVgQ6tTWHRUd7K/Gc8KcvlfdJNnddhEyqpIWtWzdAHECCe3rOt6bbuDXFZ
         Kq0ExJsUsrioJHsT3AYtyRT4G6IG0oPpjlg3g8ibkXfX0HjdEZUeUIXGOvMc+Ll1GxCE
         v4Pbe1vfR+wUAhEUOoLhabirzgKhCG3CfcH+0C5Wshw5KLuG4i6CTzkVj/hJGxUKk+1u
         BCdnCXbRbnejFycEeTe7bNyEvrWQrTDzH0PITuswOOikO8QguDiuuqx4qoIIcAjk2fFD
         i1dw==
X-Gm-Message-State: AGRZ1gL2WGrmscKmMYvUAogG3MqcYXVexuMVAeOjjo6kVEijA3GyaL/u
        5V7tax7n77xBccJdstIxAQ0OZXI71P716Eke2ETG7mXR
X-Google-Smtp-Source: AJdET5eqkJGiZnlEVLeW83CrWAMn7QWj/eEX2dzOmD/6sTEe1vaRIcD+s/sClXyvGWbS1yuY6rLW7pt8Xptm1BfxFJs=
X-Received: by 2002:a2e:9c08:: with SMTP id s8-v6mr5344682lji.149.1541786376575;
 Fri, 09 Nov 2018 09:59:36 -0800 (PST)
MIME-Version: 1.0
References: <1541632132-1252-1-git-send-email-mathieu.poirier@linaro.org>
 <1541632132-1252-4-git-send-email-mathieu.poirier@linaro.org> <102c6181-189e-0ce4-02be-15c1a2744334@arm.com>
In-Reply-To: <102c6181-189e-0ce4-02be-15c1a2744334@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 9 Nov 2018 10:59:25 -0700
Message-ID: <CANLsYkxbzk3=uA0Tx6HNNoXGBnDUPAhgnWZM9Q7jqLSzBhDr-g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] coresight: etm3x: Deal with CLAIM tag before and
 after accessing HW
To:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2018 at 10:13, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi,
>
> On 07/11/2018 23:08, Mathieu Poirier wrote:
> > This patch moves access to the CLAIM tag so that no modification to the HW
> > happens before and after the CLAIM operation has been carried.
> >
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   drivers/hwtracing/coresight/coresight-etm3x.c | 16 ++++++++--------
> >   1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> > index fd5c4cca7db5..4f638d81a66a 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> > @@ -363,15 +363,16 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
> >
> >       CS_UNLOCK(drvdata->base);
> >
> > +     rc = coresight_claim_device_unlocked(drvdata->base);
> > +     if (rc)
> > +             goto done;
> > +
> >       /* Turn engine on */
> >       etm_clr_pwrdwn(drvdata);
> >       /* Apply power to trace registers */
> >       etm_set_pwrup(drvdata);
> >       /* Make sure all registers are accessible */
> >       etm_os_unlock(drvdata);
> > -     rc = coresight_claim_device_unlocked(drvdata->base);
> > -     if (rc)
> > -             goto done;
> >
> >       etm_set_prog(drvdata);
> >
> > @@ -422,12 +423,11 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
> >       etm_clr_prog(drvdata);
> >
> >   done:
> > -     if (rc)
> > -             etm_set_pwrdwn(drvdata);
> >       CS_LOCK(drvdata->base);
> >
> > -     dev_dbg(drvdata->dev, "cpu: %d enable smp call done: %d\n",
> > -             drvdata->cpu, rc);
> > +     if (!rc)
> > +             dev_dbg(drvdata->dev, "cpu: %d enable smp call done: %d\n",
> > +                     drvdata->cpu, rc);
>
> Isn't it good to report the failure case too ? Anyway it is dev_dbg and
> will be a useful info when we debug issues. Otherwise,

Simply removing the "if (!rc)" will do the trick.  Can I do the
modification and add your tag or you prefer to see another revision?

>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> >       return rc;
> >   }
> >
> > @@ -577,9 +577,9 @@ static void etm_disable_hw(void *info)
> >       for (i = 0; i < drvdata->nr_cntr; i++)
> >               config->cntr_val[i] = etm_readl(drvdata, ETMCNTVRn(i));
> >
> > +     etm_set_pwrdwn(drvdata);
> >       coresight_disclaim_device_unlocked(drvdata->base);
> >
> > -     etm_set_pwrdwn(drvdata);
> >       CS_LOCK(drvdata->base);
> >
> >       dev_dbg(drvdata->dev, "cpu: %d disable smp call done\n", drvdata->cpu);
> >
>
