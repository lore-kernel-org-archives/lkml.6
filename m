Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1093326-1523010138-2-8954813783639616079
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523010137; b=ohinH3AYcaVawH396jGVUy/Ab7+9brQ7fC6wHs/3/1dhNmZ7mp
    j4OotpknuA9AQbZTl3hn00L7XWFTMulqmlsQPEiuBMY82FppE6HLfp5f3YrtA2iG
    9u5fgxjzG5l9AIAaV9sT59NAWrq5h4Ghzy+Q98/VimVPc255N02XX+2o4Mg9QL1M
    VdSqr2iUpmp9BQV9Iq7v1OwxbbtwTZw6/hTXwDwcKz3Mllfx3zOve7ZG3YU1UCTp
    v4lRhmptUH7AIepl86Urgj7RZXpYsIdJGGxenz5pSiMHwSA0bfM96PbYPEWAA3tw
    kllPkYS4aX3q264QBQdUCX3iEgL6LESIUfbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523010137; bh=gp2mf
    s6SgEjGqwIdqvorIsxoF4MhPDI1dhxnaQ9bqq4=; b=Py806/CPrTfL7Cfj/caqE
    M2KCabfzlZavjus09TtQ0eGfeoTLIyTYnj/90wzqWz4aqg+lw/6KomgpWPZkdi0z
    VwHn26wh3rR2ZPMH5aQw/7DU4BHWTqcmcJrjvRrU2GGp4Atg/RR11lr3FW6sn+UX
    DZkWQ9RIrzyE0zUBYeVnmfWxyUFWySwCtNyQmjkT1gIulBwvCrmBkZPXeIt+jPrf
    DxU1Hs6131cGgk33Eoz9TyoyNNy9xN5cDUtPfdFa1Ii+WGnK2AvPka/GABp8kqn/
    gJyZqwwLhU7fPvh13ZOyz68YK/xkru2eGP3sZmctCZWDMvRXFWqnP7rK8U+l6tz3
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=GAiRDpfM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=vJhxCRBp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QmSmqy7v;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=GAiRDpfM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=vJhxCRBp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QmSmqy7v;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNPY+8bgoyQRV9bXGP12LRl4YlFjDuck9y5Fu44B6xLmwESC8I+znY0gcwoSgAMlCJQSUSglFrIuv+CPRzntRS4zVrEWxmlwWmajlsDBeV2rcOnCLnZz
    N5noIXvlVlybtgBgAAKiGyT8c1+ewmhhTHZJ3jXidgHEtuIkdYpxpIp/N2G2OxWmT+oSMb/ljWDIZcuqKu5iw8LAv1D5rzUP3JPwGapKMZqjGFoLb+7LRPfe
    VCqMPN03qQI0nIPzuWFkig==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=orOaanDUxKhfy2RhKzgA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+J+VZUVJ3estNbutzpOpnkP05hpkf+5OPTU9u5lUjkMmzBgJmxK+kJG7svAjaIBUXlLRJsllHkp4P9e95ISY0=
MIME-Version: 1.0
In-Reply-To: <20180406100953.GA12400@stallman>
References: <20180406100953.GA12400@stallman>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 6 Apr 2018 15:52:06 +0530
X-Google-Sender-Auth: juuTseMoSiK9wFmgXq24TwniJqU
Message-ID: <CAOh2x==TphhhoPVSFdFmFCQr4Ag_+tMzOOW3yp-e++SQcrWggA@mail.gmail.com>
Subject: Re: [PATCH v2] staging: greybus: Fix warning to limit chars per line
To: Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: driver-dev <devel@driverdev.osuosl.org>,
 Vaibhav Agarwal <vaibhav.sr@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Johan Hovold <johan@kernel.org>, Mark Greer <mgreer@animalcreek.com>,
 greybus-dev@lists.linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 6, 2018 at 3:39 PM, Gaurav Dhingra
<gauravdhingra.gxyd@gmail.com> wrote:

Why did you remove the commit log? You had the right one in v1.

> Signed-off-by: Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>
> ---
> Changes in v2:
>     - use correct format for multiline comment
> ---
>  drivers/staging/greybus/audio_codec.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/greybus/audio_codec.h b/drivers/staging/greybus/audio_codec.h
> index a1d5440..4efd8b3 100644
> --- a/drivers/staging/greybus/audio_codec.h
> +++ b/drivers/staging/greybus/audio_codec.h
> @@ -23,7 +23,10 @@ enum {
>         NUM_CODEC_DAIS,
>  };
>
> -/* device_type should be same as defined in audio.h (Android media layer) */
> +/*
> + * device_type should be same as defined in audio.h
> + * (Android media layer)
> + */
>  enum {
>         GBAUDIO_DEVICE_NONE                     = 0x0,
>         /* reserved bits */

This looks ok.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
