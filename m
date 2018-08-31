Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CB8C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CEDC20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gokIJCdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CEDC20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeIAAoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:44:21 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42474 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeIAAoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:44:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id f1-v6so11075162ljc.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 13:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I0/fCvUyhd3rSmsOjctetkXT+qUy3U1bl2VDeQzPk0w=;
        b=gokIJCddIwRY535NZhtrAPSeFsbbsCWCnHX8ZjQKek0bhkkW36H4vK/Q3juSU5oocD
         MYdEgfOv9boDuMiCUzdkwiQ975/p8E1QEu7IDP1KtGLu7vVDzjlNC+ZH48SDT3/fNoVC
         y4BPnzCsl/IPdUdMC2tCSSpSMws2LklOqLpxMAnjKIX+JTfPp2+jFdUkvBcSgmn3uzk2
         +YQr7l/fC8HMrOSMnUxyCZcAl7dJc0OQ4zFNlJzWgz0CkmDY+u5LxdZOSDlb5OiYBGfR
         6Y8rj7Bnf/E4zJYA4PUJUKEMBX4F3mCvlv6yhaDVf00lS71rV7XjGiok4o3AMlKX0mkT
         70QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I0/fCvUyhd3rSmsOjctetkXT+qUy3U1bl2VDeQzPk0w=;
        b=azFRWJjKAKsP/NLQTaweHNvo3sfebuUItc84tjIogVMA29kuEyOVMZ+Kud5AzoKiIt
         KryIBreAj9Y7uJFkfvu/kqNfILw/NMM4Uwe/rnFcZiG1yeiMppmopCNeu1vfKBSYlfMI
         AtPb/zap4He7ex5SJ1kw2SeYLltFe7eJ4hSxdv4vxsoccXDbR+W5IgEcffktX1n3nYm+
         RvzFOZ9CMMk8F4zBY8M2xC82idPPWVlJtlzF0mdAD/82Kb/P3GMRcnxjfjyLGtOJ8FNZ
         8qdrBS1azebdWxolTXrUYeG8mpDEZPtCnIo4rgIP+dGONbn/JhVbNyCZ0Xp+DPXZ/Qi6
         8CEw==
X-Gm-Message-State: APzg51DGQBTmo7BUP5UnzMaAIQm5+D6DDIDBVqReRvh58PgAsFSXRBUj
        DvCerkYRZMO7IguTx6Lls2I=
X-Google-Smtp-Source: ANB0Vdag6behh0akY8lyQFtl2kY2s9r6EX1f+nQMtN1ili6rFQLkBcZ+xBfDow9wKBH57doQPMZyAg==
X-Received: by 2002:a2e:658a:: with SMTP id e10-v6mr10253204ljf.99.1535747710254;
        Fri, 31 Aug 2018 13:35:10 -0700 (PDT)
Received: from [192.168.10.160] (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id b80-v6sm2071070lfe.83.2018.08.31.13.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 13:35:09 -0700 (PDT)
Subject: Re: [PATCH 00/23] Make use of unlikely() more consistently.
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        igor.stoppa@huawei.com, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Alasdair Kergon <agk@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Jeffery <andrew@aj.id.au>,
        Archit Taneja <architt@codeaurora.org>, asolokha@kb.kras.ru,
        bvanassche@acm.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        chien.tin.tung@intel.com, chunkeey@googlemail.com,
        Christoph Lameter <cl@linux.com>,
        David Airlie <airlied@linux.ie>,
        David Daney <ddaney@caviumnetworks.com>,
        Dennis Zhou <dennisszhou@gmail.com>, dima@arista.com,
        Doug Ledford <dledford@redhat.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Daode Huang <huangdaode@hisilicon.com>,
        Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        James Hogan <jhogan@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, ejt@redhat.com,
        Kalle Valo <kvalo@codeaurora.org>,
        Kees Cook <keescook@chromium.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Madalin-Cristian Bucur <madalin.bucur@nxp.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Michael S. Tsirkin" <mst@redhat.com>, michal.kazior@tieto.com,
        Mike Snitzer <snitzer@redhat.com>,
        Paul Burton <paul.burton@mips.com>,
        Paul Mackerras <paulus@samba.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Clark <robdclark@gmail.com>, rolandd@cisco.com,
        Salil Mehta <salil.mehta@huawei.com>,
        Shuah Khan <shuah@kernel.org>,
        srivatsa.bhat@linux.vnet.ibm.com, sviau@codeaurora.org,
        Tejun Heo <tj@kernel.org>, yisen.zhuang@huawei.com,
        zijun_hu@htc.com
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
 <CAK8P3a2JasKXtXYoV7KsSZt4TwkffsBjrf=LK1HZJx0KFKCcow@mail.gmail.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <46369585-4d67-5235-d57d-a5162cc85e56@gmail.com>
Date:   Fri, 31 Aug 2018 23:35:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2JasKXtXYoV7KsSZt4TwkffsBjrf=LK1HZJx0KFKCcow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/18 17:09, Arnd Bergmann wrote:

[...]

>> #define assert(condition)
>> ...
>>          if (unlikely(!(condition)))
>>                  error_action()
>> ...
> 
> There is a potential that this introduces false-postive -Wmaybe-uninitialized
> warnings when CONFIG_PROFILE_ANNOTATED_BRANCHES is
> set, since that turns unlikely() into a complex operation that in turn
> confuses the compiler so it no longer keeps track of which variables
> are initialized or not.
> 
> It's possible that none of your patches do that, but one needs to be aware
> of the problem, and possibly revert some of your patches if it does cause
> warning regressions in drivers that don't actually benefit from the
> micro-optimization.

I see.
But if such case might arise, it might be possible, instead of reverting 
these patches, to locally - and conditionally - turn unlikely() into an 
identity macro.

For example:

#ifdef CONFIG_PROFILE_ANNOTATOED_BRANCHES
#define unlikely(x) (x)
#endif

Without giving up the hint for the case of normal compilation.

--
igor
