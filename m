Return-Path: <sjg@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524856346; cv=none;
        d=google.com; s=arc-20160816;
        b=pznbv3fZU5QpKWGryylVGulC9IhpGl3vdhm5TXZ5bO2Co8bTjRDoDvDhjlARkWe7rC
         cJJKKaRmsqQ8P8eluW0sudkpwTrT+38AvV0krAVm7eowS0J8zlDgQn42ecpViC4LjPFp
         U/7JCmLH7gyDiIDqQavDR3gWhyHQYsb2Wjx4zXlFAI3e2yGLtM4x9F5q+FiUHP4Xw6tE
         ln6rJmD+ssyZGy/mBGv74BoqB3m7AQj1k/Tz0V3wWQsDwz0SLLYFh/zq8D1u6cr+Qpt/
         bDcRrjMPDBB1BnPliUyCZp8QvG7XiZqczG1xlkOxO2Gv1YPbbCfRAfK2fj202NfR/1YV
         7FVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=3KKPl7BbRwA777odQ3V8buA/A9G6YK8AWUvXw4qhEC4=;
        b=N8mY/tVjRnenUNTbbp3VmJFA16E690/YhlFkMkaRr068EipsYvAr0nl0gxpLCMf2/2
         sZ3rWecpDT2rMf1GWoRZse9nCl7gBpwil5omgCTGO2VpS3nQ/UmIMvE7ykv/i/hcxiFv
         4UCpSqXZqgBYHYwWjkA0v+L/ZdIEhH0GGh2a71JJlrbBzHfLPYR0n+N9Ss1Hv2AZKYXx
         p6ZwhB9ZueLKOYmFuSk12Q7nXdrdy6Tu8GBQoZ5TY1R7KWyNQ7tkTy4KN2lnl76FiAzl
         KDg9KhLhIQxm1USs2meJT8gJcj7rddEQsJaXT50h46+ScjotRPeQczaVJl5He2mWcqWL
         r65Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=K4716R/P;
       dkim=pass header.i=@chromium.org header.s=google header.b=fx87zSBc;
       spf=pass (google.com: domain of sjg@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=sjg@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=K4716R/P;
       dkim=pass header.i=@chromium.org header.s=google header.b=fx87zSBc;
       spf=pass (google.com: domain of sjg@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=sjg@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AB8JxZqU+6BBX+f2yp3ntef0XCn0mYR18k4pLQKlSIPpw7/6EGye9It4J7SHipj48Yh38Cb23skRu1KTjfN0UAoggVI=
MIME-Version: 1.0
Sender: sjg@google.com
In-Reply-To: <20180427095817.74bf5378@endymion>
References: <20180424211111.140374-1-sjg@chromium.org> <20180427095817.74bf5378@endymion>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 27 Apr 2018 13:12:05 -0600
X-Google-Sender-Auth: sP2GlEs6pRRe9wspDXBwteAItz0
Message-ID: <CAPnjgZ0y9GhA12dvM8aW_AY30LzbdgYDc4JJ0aXWudAUU8kz7g@mail.gmail.com>
Subject: Re: [PATCH] firmware: dmi: Add access to the SKU ID string
To: Jean Delvare <jdelvare@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, C Shapiro <shapiroc@chromium.org>,
	Aaron Durbin <adurbin@chromium.org>, Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Philippe Ombredanne <pombredanne@nexb.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alex Hung <alex.hung@canonical.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	sayli karnik <karniksayli1995@gmail.com>, Vinod Koul <vinod.koul@intel.com>,
	Sagar Dharia <sdharia@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598663453447525196?=
X-GMAIL-MSGID: =?utf-8?q?1598927769002411650?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jean,

On 27 April 2018 at 01:58, Jean Delvare <jdelvare@suse.de> wrote:
> Hi Simon,
>
> On Tue, 24 Apr 2018 15:11:11 -0600, Simon Glass wrote:
>> This is used in some systems from user space for determining the identity
>> of the device.
>>
>> Expose this as a file so that that user-space tools don't need to read
>> from /sys/firmware/dmi/tables/DMI
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> ---
>>
>>  drivers/firmware/dmi-id.c       | 2 ++
>>  drivers/firmware/dmi_scan.c     | 1 +
>>  include/linux/mod_devicetable.h | 1 +
>>  3 files changed, 4 insertions(+)
>> (...)
>
> Looks good to me. Applied, thanks. For consistency I have moved product
> SKU before product family in all files, same order as in the DMI entry
> itself.

Sounds good, thanks.

- Simon
