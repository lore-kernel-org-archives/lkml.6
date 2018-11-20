Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C836C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C013220831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9MrbDGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C013220831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbeKUCjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:39:11 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38395 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeKUCjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:39:11 -0500
Received: by mail-io1-f66.google.com with SMTP id l14so1612728ioj.5;
        Tue, 20 Nov 2018 08:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=miSa+ronOx0kLNtgv2mh6jz8jVUsiKydWcd127BjKVY=;
        b=f9MrbDGEMssJ9AjnVyF8bvg/g5Q38tjtH25D9xYkzxlX/3Cc5N/fRyXRx02gSfjlbH
         9PXfL5C3uFK3AJAf9Lq5p14WytiADbRo0fdAgb2t2z0980Yv62kFTMlnCYUqZ9v2+Pg3
         1lFbJO250M0XeAk2apzz+/F7HNUNNh7Mcmx9/WVped3dN1ZJwODAgg5u73wPZnjV4wGb
         k15YAHH+3bDJnv3njIP7wCSzbOZmawQuoJJRVpKSfgVFSMjoJvqcDrBI0enc7HFb5IzN
         8ocE5qKWOBciH8dC393rFDx9wbyh5C4tKqbp8JlfvjfJrkMfG5whPPGnXarGv0ObqlbL
         QDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=miSa+ronOx0kLNtgv2mh6jz8jVUsiKydWcd127BjKVY=;
        b=C/Q73yQDx7wDNLk0n4Uy6b/dXg34zJj7CMkhaXLN86IXB0dwkCP/5uUdR02EJsgNiU
         /8iDdpZpvchEBolrPtlsHwfLr6JFLyYtCNkXGD9vkqdFJg/bAcptfnSbjDlBvcW233hl
         pP2kReY/EAAQIRIE2HAOyyqoqIpWA0hF6PIGPWnpfKnpN+DDE2hWmVS0ZcbPc3oUnLJD
         Fyv4aCiWaUfJpXzLHumVKe2RqO6XtQGWsDu45yxK37k+AEdUqiPRiK52mQPZ1nSlaPn8
         sFRq+DQRh7YcKAQW9Tbr7wUlO/MdscL2djNy6PYuCJ9SDbncQMKg8NZxNVhzTK2JwMpN
         MJtQ==
X-Gm-Message-State: AA+aEWbHGEkre8lA+ghrEzFUe1AN0tEOQj+E5E8ekjDHKh6RBWF1s8bq
        ebW4tSl8vCiKMgja3ZiYJfm1bZbGAgxPgfH4UPk=
X-Google-Smtp-Source: AFSGD/Xwfdhp/0XiYScZKV6Jpb5g7yV2hz6ilntBP4ozqpW1lVKF8KZug6CZRNB5aH7IqrNCKVMKG4MfI8/R2ic3h/8=
X-Received: by 2002:a6b:bf44:: with SMTP id p65-v6mr1864916iof.225.1542730159233;
 Tue, 20 Nov 2018 08:09:19 -0800 (PST)
MIME-Version: 1.0
References: <20181120154617.20903-1-tiny.windzz@gmail.com> <CAJZ5v0hWSCDbDUV1_iQBf-4Y=QgnBTrAqQqcCyOpv9r7yCjGiQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hWSCDbDUV1_iQBf-4Y=QgnBTrAqQqcCyOpv9r7yCjGiQ@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Wed, 21 Nov 2018 00:08:58 +0800
Message-ID: <CAEExFWv289bsEc-2OXcVkhnHv_UsOU1YnKt6Mv-nFqM_QN+PVg@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: big.LITTLE: add of_node_put()
To:     rafael@kernel.org
Cc:     lorenzo.pieralisi@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 12:06 AM Rafael J. Wysocki <rafael@kernel.org> wrot=
e:
>
> On Tue, Nov 20, 2018 at 4:46 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
> >
> > The of_node_put() is missing.So we call the of_node_put() to release
> > the refcount.
>
> I would say "of_find_node_by_path() acquires a reference to the node
> returned by it and that reference needs to be dropped by its caller.
> bl_idle_init() doesn't do that, so fix it."
>
> Thanks,
> Rafael
Hi Rafael=EF=BC=9A

You are right, I will change it right away.

Yours=EF=BC=8C
    Yangtao
