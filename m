Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D2415C5CFF1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792562086D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HBaRgc54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792562086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935073AbeFMBME (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:12:04 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:33950 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754202AbeFMBMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:12:02 -0400
Received: by mail-io0-f172.google.com with SMTP id e15-v6so1657299iog.1;
        Tue, 12 Jun 2018 18:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gYdQyGXKUoDhLkAytoQbsoib6dcyw2JH1le1LnvNqCU=;
        b=HBaRgc54balIWQ+OaLqYrLJWHJcQeipwpvIa5sWul5SaX0JNGZTVn08a3pXgL+/rue
         OFU+ywvkRMERsX5iyX36z0+F4Lm809iuD+/hSmLIHUtAayUNqxJnHsGsC06zV/bJCeGh
         9r2bzA4VGA7zAWUn3BdU0oI54S3wfyS/lOYSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gYdQyGXKUoDhLkAytoQbsoib6dcyw2JH1le1LnvNqCU=;
        b=gjcZ9M9WSbmCQ+xtzLYQe36iAjE43oRhwb+TrL5vzk6s+WilzeJpwkx8Iuj/YB7x8N
         aj7gHKiBipslqQ5Jqb8pHW9Yc/HWddW+6tN5CABBjekEmShb60eW++bL5ts9KyhhNeiy
         5t0ZUyxB9BAV14J6WlS0+omkXsPbcn3ug7y1vPG2wWO1RnA1TtFvih4CtVdd9fH1H7Av
         1cdcLaRrgZ81jlOTpwsJCBVmu3NC+Yujz7QtTFHyeDKjG5Ixv/J7dbljHBIap7T544GY
         yg9xS+0DeaT66AQVhzYv8G698zKg5i/bxqLuueKbi8bHyuDqTGD68ehK2SgiChNYEJPZ
         RLuA==
X-Gm-Message-State: APt69E0ZDuQ6sl1R+uh9Qm8mQujT5FxAAr6eNpQRHdAOTeer5SXQctYO
        kbKMUlZMrh0pV54m0iwz+FR4RA5cZmK+O1Ga9uU=
X-Google-Smtp-Source: ADUXVKLF6IPWeopwCJ09HuZV8dqlSgGUW00OIq+r61sFiMAeVj94rHu/tSz3mME8Q1DRpFB1p30YJZluGUzR8uIhWvs=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr2905359ion.259.1528852321768;
 Tue, 12 Jun 2018 18:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <e5c90488937d14e9df81752a024be9d1e73ed398.camel@hammerspace.com>
 <CA+55aFxYMg+F9Jdi_25X-Qtt=7imqjQhLnjEyQXOQ6+eJvy83A@mail.gmail.com>
 <CA+55aFw+2+xCRAaMo8qgvZ7qNgRMo6D=WkwP7APQndG-y5b3dw@mail.gmail.com>
 <CA+55aFz3jmGST_cOB+qH6qZTFa5HJcw2JoeWxJEZdWgeO4=vNQ@mail.gmail.com> <20180613010427.GD3593@linux.vnet.ibm.com>
In-Reply-To: <20180613010427.GD3593@linux.vnet.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Jun 2018 18:11:50 -0700
Message-ID: <CA+55aFyWS-MC44k=LnGWr-Kq4_DRkJmub00Fj-tVrGxCL-PxGA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull NFS client changes for 4.18
To:     Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc:     trondmy@hammerspace.com, NeilBrown <neilb@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 6:02 PM Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>
> We did review this one, and Neil did make requested changes to the comment
> header and documentation.

Oh, I checked the commit for "acked-by" from you and didn't see any,
so I was assuming this was just Neil and Trond on their own..

            Linus
