Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBE7C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 04:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C982088E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 04:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DANzvjtP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C982088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754632AbeFPEYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 00:24:04 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33339 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbeFPEYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 00:24:03 -0400
Received: by mail-qt0-f194.google.com with SMTP id l10-v6so10960600qtj.0;
        Fri, 15 Jun 2018 21:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FCRM1ddD4Uq7GeOXc0lJuKcI/CaIekCdZG6CJ8aRqUw=;
        b=DANzvjtP4z12KJa8e3nJwfl/3rpmH58/Fcf1FXZ6KXuKC8fgPApitO2uK36tOJPCnC
         YNm2Yxh0TJtDX9amdR30xhvAGGipUY/WDcwYqGTp2Af4eUbJ2Ct/vREPItM3VMP8yaxX
         0Qt6tOv7YQA4PZcVyzeFlUcHaNc7lHoPZCo21NMqMjYECWn9NOAkG2spg04tRlKh8M4d
         Qxtv2ghTPjdJ26J6z7b/ZXUBFG7k/v82+DQAcjvwgCC86GvVAPtA5Vgjusej6R5BOrKu
         Bf/YGPn/Hh3z40LNzs5z/KGasrI9HkEft3UyuEFUcEswEjdKSngPvatvrFsjLpWLLIZ3
         WWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FCRM1ddD4Uq7GeOXc0lJuKcI/CaIekCdZG6CJ8aRqUw=;
        b=q1aw6NTJo/7kamzQXeTzP16NLfJBTLV4phhpexqBV3bO4w6DTu7Kw7Et+AYfcVUsak
         q7xe0iRJcDtQTdOIx3lkwXOkoFaFbWS4F1LgCKi+VpusnWn77CmInNZwOcQtCji4m8IK
         559QxbUz1cMpcN3TdX3v5eiYur/olUyCtZuJkMeyGY5aTISY0oVPfi8fhrwXtxkLlhR5
         sxV4Qqz2E/lSZ1YEi3zJQ6wfIRiksXUD4mBrVjS0mAHTH3SaL4WrP4WvCF7Uq80xhAq+
         Voz41Iw8PFmTjz39ebJNTXwMkJazUBMM2oTEUV8PMe9v3YzlW1DGFBpvxkKhBnBNVm+s
         Lw9g==
X-Gm-Message-State: APt69E06hJaMGQ+tEfbMD6eo4s5qb/AkNswMsqjT+uvJ0oEnwPe3a8jC
        ivOCoh8idlGIqA8uzAPOgIhhZFbZCKIGf2HzjKs=
X-Google-Smtp-Source: ADUXVKJ6Y69GguyXcoDgRC8bPO/KLfzxntwbUDeCdr85sFURTiGmom/zy2CMKRDZRTtuxppOaT1CF0AF71mZPqdAKjY=
X-Received: by 2002:ac8:2372:: with SMTP id b47-v6mr3970789qtb.358.1529123042470;
 Fri, 15 Jun 2018 21:24:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:27a1:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 21:24:01
 -0700 (PDT)
In-Reply-To: <20180615110820.GB14855@kroah.com>
References: <1986308.HpuS17FQ0J@os-virtualbox> <20180615110820.GB14855@kroah.com>
From:   =?UTF-8?B?6rmA7ZiE7J28?= <thtlwlsmsgkfla@gmail.com>
Date:   Sat, 16 Jun 2018 13:24:01 +0900
Message-ID: <CAO7xFUZJm_Jk90=TVx8j5t2-_owb=Q3Rw=WcsfQo7ZU_UjbKLw@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging: rtl8192e: remove brace for single statement
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, Kees Cook <keescook@chromium.org>,
        johannes.berg@intel.com, Malcolm Priestley <tvboxspy@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linyu.Yuan@alcatel-sbell.com.cn,
        Colin King <colin.king@canonical.com>, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks greg.
Let me check and send again
regards
Hyunil Kim

On Fri, Jun 15, 2018 at 8:08 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Sat, Jun 09, 2018 at 03:05:56PM +0900, thtlwlsmsgkfla@gmail.com wrote:
>> * fix checkpatch.pl warning:
>>   WARNING: braces { are not necessary for single statement blocks
>>
>> Signed-off-by: Hyunil Kim <thtlwlsmsgkfla@gmail.com>
>
> This does not match your "From:" line in your email headers :(
>
