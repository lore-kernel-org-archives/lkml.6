Return-Path: <jdelvare@suse.de>
X-Google-Smtp-Source: AB8JxZpZKTUuDZ6kDC7c6rn+fTh+vDK2I5Rjn2jaTYBP3IIeYCc6eR39KimzQxi3kVEVZvfeCTub
ARC-Seal: i=1; a=rsa-sha256; t=1524815902; cv=none;
        d=google.com; s=arc-20160816;
        b=hBTN8awtRQdrN9bt8n+asQK6AQlL5Q7jGoWaF8qa8bRdAwvI3L0ODNCD3JzOtS08cU
         kYEM4MgPamYfrOXkH3OKxRbtABlsaiy2+ekr3FOOsJ1OiBjrar4x2mMxpK9EbUVsQwm9
         2WaXYdiqVMQsxRCQQGpbrwpojHDQ8rw2UMubmM9agpFijtxEvQ90rv8CNV2d6R0Q82E1
         4JeUMbAFxfpHoY/FtNmGgqqWaNqe/IPbaQGYFiuQcQ2PXjpy+V217BzPXLL0T2LEGfrf
         7yjr0KKTkzeZY5K6QDmQILp5GWWJpriYIIKlaW7VnpWF6F0qiU6m4I37arp7QI9qlAiU
         XbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=/YCq4c2zpJKiwd8P6UexM1mCW0RkDh70v6aawXZGBnM=;
        b=SSZtiavCVtlrkk/gXpJH2senSYPOKeOx0yoFjJRvYVSiH13j0qWAc1stiRfeRJV8NA
         hO+xoNq4GciFaPY2xtoDTe5UyR2zfnJwWbzpB2d6RU8ik2y7Z7rCjcyuWUgYKhiVSb+V
         BrnD6zmjkb4bNWwCd39/FUJbhnXRz1JPMdonciYQwTB8W+uFdrNKwMlWuF77dMg/YPxG
         cJm5UvuB8q25KOdElS1do1mg645p26ogF/Tdg4PM44a2iNfjPa2cbTz49V90b0SQeYSu
         KQCb0051f4nYpii1HSK3b1casIQBiOqo90+XRz0FRAWc1WT/BNfCL4hOz5JM66OpCPwG
         3YcA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jdelvare@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jdelvare@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jdelvare@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jdelvare@suse.de
Date: Fri, 27 Apr 2018 09:58:17 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Simon Glass <sjg@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, C Shapiro <shapiroc@chromium.org>,
 Aaron Durbin <adurbin@chromium.org>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Philippe Ombredanne <pombredanne@nexb.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Alex Hung <alex.hung@canonical.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, sayli karnik <karniksayli1995@gmail.com>,
 Vinod Koul <vinod.koul@intel.com>, Sagar Dharia <sdharia@codeaurora.org>
Subject: Re: [PATCH] firmware: dmi: Add access to the SKU ID string
Message-ID: <20180427095817.74bf5378@endymion>
In-Reply-To: <20180424211111.140374-1-sjg@chromium.org>
References: <20180424211111.140374-1-sjg@chromium.org>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598663453447525196?=
X-GMAIL-MSGID: =?utf-8?q?1598885359108144820?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Simon,

On Tue, 24 Apr 2018 15:11:11 -0600, Simon Glass wrote:
> This is used in some systems from user space for determining the identity
> of the device.
> 
> Expose this as a file so that that user-space tools don't need to read
> from /sys/firmware/dmi/tables/DMI
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  drivers/firmware/dmi-id.c       | 2 ++
>  drivers/firmware/dmi_scan.c     | 1 +
>  include/linux/mod_devicetable.h | 1 +
>  3 files changed, 4 insertions(+)
> (...)

Looks good to me. Applied, thanks. For consistency I have moved product
SKU before product family in all files, same order as in the DMI entry
itself.

-- 
Jean Delvare
SUSE L3 Support
