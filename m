Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31729C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93E520657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJzteBay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93E520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbeKABM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:12:29 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41310 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbeKABM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:12:29 -0400
Received: by mail-qk1-f194.google.com with SMTP id 189so9006683qkj.8;
        Wed, 31 Oct 2018 09:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rcc85HV4lq9ZltHXPPNYabPReLZqnZxCSj3Gfxkokxw=;
        b=mJzteBayTcI1RDxCZ4dcsDLctJ5UTEz9L74obkpX8gVzeG3Rdp326l7QrGx5xXPzw+
         6qokNF8kDvBuyrRW68kjf/fqP/PzRcqAIGP0HzYErIgu0Tc2W+TROcvdEmrOTPMXy/JN
         qHCv/XoXQ1TKamW53DCA8bpxTMb03tEbxGDCcDYVLlUoY+eVZaNe+U/7L7lPzWI1itwN
         /EuJOmUXQlAVlf+fTyvccmz5m2SuJI8aEodtWNwI5CArbtkFic+mHwMQDpwO4D1EV5pQ
         vkt6r3RT3BsNYGyQgwa1TMxzM1eRREX/nmuLOqhXYTATogSsl9X8PraSP3zhDyXSCCw3
         mrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rcc85HV4lq9ZltHXPPNYabPReLZqnZxCSj3Gfxkokxw=;
        b=LIle6ckI3wJsZJllYSAD7JmhsvQMuRuzpax/qJzjfXWb60yivORnOX64U7Txyw+bQV
         p2P/V/rRPq67ZelKcUY6S/57zu+gQT8g9ow/pLPzedUaapLgpeDNoJoulVQAvmZiB5H8
         p1Z7oeal9BcKwBzueEOxgknxfuYCkkqrrjMfGX7JDnqBNFdcsh2z8ihRwBOggsJ4/6zZ
         ux9qXmMEHYF4pzOn+C9GPUUBw8DFHRkEIkr9OUi7zTIPag9j4jtlvcUQg7YMQMD/3s3d
         MlZw0vNMwskMBd7G8CxfrskEbFZNUlLtxHlk2JcQhe08eSVRWwex/BJJoTuNkO/Lt/Z7
         eKzQ==
X-Gm-Message-State: AGRZ1gJNMYuHJGHG6AxYBTnMWqqPmVkM0+LqtbNzliEyG6yYpn5IWHhf
        ZIKy6mhqHBRNKdsz3TAYAGUpqJrhUWmG7DNIE6Y=
X-Google-Smtp-Source: AJdET5dEwxjwwyIsWzkBLrIwYCYmytZGuQKK8cWQbF611dQL8Rb4IDIlsyBre3S/m2wUcJCMcOP3UOQ7cfrgabME89I=
X-Received: by 2002:a0c:e202:: with SMTP id q2mr3175798qvl.180.1541002428939;
 Wed, 31 Oct 2018 09:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <e2da896b99bd0c0ba39f214ee7fb2231994554df.camel@gmail.com>
In-Reply-To: <e2da896b99bd0c0ba39f214ee7fb2231994554df.camel@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 31 Oct 2018 18:13:37 +0200
Message-ID: <CAHp75VeyHmBfKftjSp67et7nxq80Kh=os7qrRVoQY+zMY0HcNA@mail.gmail.com>
Subject: Re: [PATCH] x86: add support for Huawei WMI hotkeys.
To:     ayman.bagabas@gmail.com
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 5:57 PM <ayman.bagabas@gmail.com> wrote:
>
>
>

Thank you for your patch!

It would be much better if you can send it using traditional tools,
i.e. `git send-email ...`.

-- 
With Best Regards,
Andy Shevchenko
