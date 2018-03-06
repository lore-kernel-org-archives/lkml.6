Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520333310; cv=none;
        d=google.com; s=arc-20160816;
        b=E1o1KjGSQAFFfRVwbJod+F7n/zstYOUURoT7q1fC7hBR2AxBzOqlNCNweTQwknTQ6O
         wwB/yUBICjxM1ZdXoyJFSvMmSGVw/kDFLFXcKTwfQ0WUhPthcSSDs8aOy8mShWI86+0c
         gFfWvIsa5JPfZO80vX0bjnDmnScq7G6rII7k8kA/qN2u9Ykjd6Nkl5KyqAIncd9i6V3w
         XqnkzoS1m0OnlaOsxc0lyMDRarlk5CxGOttg/38NpT16JG91Bu8tWIyHoqVr/0LfamNv
         yRHjb2+JU+OFKHXE26PCKAOkbiw5+1LH3dURZz1cKUsVNtnBXXXmM2cQ5AHgg1TTsB99
         9SbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=A+aierCuaWsV39/9qaiARy0HUQMPDSybaF8K0JVGmb4=;
        b=pDO+IwMOKKgPuvRoQjDTCe1Q6rX9V7P4ry31j2v+pqUBvNjZQySCvWPgCnY8j75yeW
         Bx5ge0sWMwkjujelLGuQOH8MrW99ENSWGZXfv7lV3CAsR7fyBzVDbzHywbIfL4lpCAoq
         /VjoZQehUOavlzrLNv1jekN1FZ0u1UFIlf2U+gFhnooXHJjWvdKa9EhiVn5AKM8WF1xI
         PuzasNC27m2PUjZdaNfNasB2ojSOd7o4zPNn4JqQ7j8DaGcYnlspuH3i98pmIn8vBrWy
         2H5GFYyB14jhnwmvrb5RUynKMY+D+Lt3XVqScrcFkdLUWJwT2gqjRGuXjJLsV2olpvJ6
         sokg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GKyTnfFF;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GKyTnfFF;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELt3QH/isKt4zROazZzNs15isM1KN3oW278pW3Cy6ELWK4yjuFiJjeERYNApfcNPcbuNuzKgmLwhIkCgZ9U42uY=
MIME-Version: 1.0
In-Reply-To: <20180305190824.847-8-logang@deltatee.com>
References: <20180305190824.847-1-logang@deltatee.com> <20180305190824.847-8-logang@deltatee.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 6 Mar 2018 12:48:29 +0200
Message-ID: <CAHp75Vc41MwtDr24-z3po2nx3Hr7_=tFUD0odcrbnVTP4SnJ1g@mail.gmail.com>
Subject: Re: [PATCH v11 7/7] ntb: ntb_hw_switchtec: Cleanup 64bit IO defines
 to use the common header
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>,
	linux-ntb@googlegroups.com, linux-crypto <linux-crypto@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
	Jon Mason <jdmason@kudzu.us>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594125898084128153?=
X-GMAIL-MSGID: =?utf-8?q?1594185021709306508?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 5, 2018 at 9:08 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> Clean up the ifdefs which conditionally defined the io{read|write}64
> functions in favour of the new common io-64-nonatomic-lo-hi header.

>  #include <linux/kthread.h>
>  #include <linux/interrupt.h>
>  #include <linux/ntb.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>

A nit, can we preserve alphabetical ordering?


-- 
With Best Regards,
Andy Shevchenko
