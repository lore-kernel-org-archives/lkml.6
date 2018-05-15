Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2771586-1526395959-2-3068301237040109770
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526395959; b=Nnkdu9ctqrvkauUGa73xmD3JCFnG/GLuSSjGF0hnH0NGEiIV18
    TUHAaLC6gF5615RWdiPqGoJDpWiL4CZb8kKfPVuNDg6XqLcZ6BWO/SvGa62TnUUv
    Qg9RQdleV8ZThAKxIPNSsJ3C2v9EfiOQwltV+uXpCuih8UPsqLj5/ra+mVRiAAsv
    7VbHMLHmz3VgDQN/idNXIMLdmLmJmmf6O88BRK7A8o7cPJBWE6GbO7muZLD05QX9
    UsY29ypRdFYVB+xWNQBu2Xzta34weZPNZyPXwy1X0nSHEb6FiZNi5CdQqzo/8Mo9
    pDvtOuei2XoHYAe56S1XJFdbRpxjyizt1B0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526395959; bh=vZ625
    RYaV+saYbyrv4vd0z4FeuQyNHUVK/kZwYxo/84=; b=kEXQ3HpKA492fm0HgskRi
    bmpJhjZa3zQcQBV7VooW0ckX0TF99zuf6/XWSPQerEUBrgCTNTN3omNWG6dNeu6J
    2d/wwTxnRVeecdaHAWt9n7chd/CZBwcthYkDg/D+qd3X3Q75DPwTnIr7PkudWsl0
    brWRNQtAtkmaye73x09Es9Xs5VWjhZH2pZAB7XO4OABhbm6neNkaSxVgfLhwCcTt
    v95U56RwzFolBF0OqYPdpq/Mp+NiJF8fGQJCDU7mZ8Zhofnz/zqxJGFEn1h+mGjb
    0EJqoomtyPast061vmOmNApILcBHDi37oTvqvMB1Vz1g4Vm5AWZjJj41Gw8oMjXc
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=goodmis.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=goodmis.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMHDAzMCVPqlN1PzrYUduOIwaGjpcUDBz6WTd+jHxZ4fOTTngdX8jwf7HVOF5zFCDaWV1wbwWqDLjYZTruRm3UIHDcLfPhoovHSLPDtBqiOTrRIfqWA+
    0YIxYI3bKgRHXuuCf17o8bUBhhylgZf+hx6EUkCvyTNIDC+VDy+UFVxNiZoIm7p60vuPE5h5IEaYnopAw5o3JLdbR3wnJ7TTniwQx5+tYqBJJvcQQnUu6rke
    EXvltfYr/Q/jIM8UC0nnlw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=7d_E57ReAAAA:8
    a=meVymXHHAAAA:8 a=DDOyTI_5AAAA:8 a=K1_pGSZF4mqBJAM2iO4A:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=jhqOcbufqs7Y1TYCrUUU:22 a=2JgSa4NbpEOStq-L5dxp:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 15 May 2018 10:52:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v2 11/11] docs: fix broken references with multiple hints
Message-ID: <20180515105228.4ac2df94@gandalf.local.home>
In-Reply-To: <63a4f8a93f9115475bc184d0f37d076c9b9c75ff.1525870886.git.mchehab+samsung@kernel.org>
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
 <63a4f8a93f9115475bc184d0f37d076c9b9c75ff.1525870886.git.mchehab+samsung@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-fbdev@vger.kernel.org,
 linux-usb@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 David Airlie <airlied@linux.ie>, Linus Walleij <linus.walleij@linaro.org>,
 dri-devel@lists.freedesktop.org, Harry Wei <harryxiyou@gmail.com>,
 devel@driverdev.osuosl.org, Jonathan Corbet <corbet@lwn.net>,
 James Morris <jmorris@namei.org>, Ingo Molnar <mingo@redhat.com>,
 linux-input@vger.kernel.org, Roy Pledge <Roy.Pledge@nxp.com>,
 devicetree@vger.kernel.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Jiri Kosina <jikos@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>,
 linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@zh-kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed,  9 May 2018 10:18:54 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:


> diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
> index 7b6b1236ec2e..c292117b83a9 100644
> --- a/Documentation/trace/events.rst
> +++ b/Documentation/trace/events.rst
> @@ -8,7 +8,7 @@ Event Tracing
>  1. Introduction
>  ===============
>  
> -Tracepoints (see Documentation/trace/tracepoints.txt) can be used
> +Tracepoints (see Documentation/trace/tracepoints.rst) can be used
>  without creating custom kernel modules to register probe functions
>  using the event tracing infrastructure.
>  
> diff --git a/Documentation/trace/tracepoint-analysis.rst b/Documentation/trace/tracepoint-analysis.rst
> index b0c9c21f129d..716326b9f152 100644
> --- a/Documentation/trace/tracepoint-analysis.rst
> +++ b/Documentation/trace/tracepoint-analysis.rst
> @@ -6,7 +6,7 @@ Notes on Analysing Behaviour Using Events and Tracepoints
>  1. Introduction
>  ===============
>  
> -Tracepoints (see Documentation/trace/tracepoints.txt) can be used without
> +Tracepoints (see Documentation/trace/tracepoints.rst) can be used without
>  creating custom kernel modules to register probe functions using the event
>  tracing infrastructure.
>  

> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index c94f466d57ef..19a690b559ca 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -4,7 +4,7 @@
>  /*
>   * Kernel Tracepoint API.
>   *
> - * See Documentation/trace/tracepoints.txt.
> + * See Documentation/trace/tracepoints.rst.
>   *
>   * Copyright (C) 2008-2014 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   *

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
