Return-Path: <kai.heng.feng@canonical.com>
X-Google-Smtp-Source: AH8x226yzQ4SNK+d5WFNZ7Cmo9gfa/lmWeW26IGreSlSaub4t1ZUcHrfz7Of4iXkXRzC6MDFduOh
ARC-Seal: i=1; a=rsa-sha256; t=1517762344; cv=none;
        d=google.com; s=arc-20160816;
        b=kN1hnTtwUHU/7zAEMuUrNsItdUFeQ8GBn4fwg0qhyy/+kAMzuV+rpveMXcXKKgvBt8
         xcFf/kttQkegnlkNPOOECp99TSCryMmJED2/pFbcJGxIWxcwxMtRuxACWqSliFyN9ZNK
         Q4j9UPbkSUBPPmQA3StI0Ms4qsLS3TuX+ZleIihRmgMjwBanGPpoi/ZjXTaK/bpcQ92X
         7Z4bKqf7L1S9YNo9TTQTzHKHn3LK3x1vyBKc0Fc1/CfhB/2fGs0oR5ix6uyQDhiOFfy/
         QCIHNZNm6cRQkGkrKT1he0XQhFK9ljszRbv6aE3T0YzgWUm9LhJC8ZYONaOToXYNZTwn
         Wqyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:arc-authentication-results;
        bh=SthLfjZyKxuiVNvPEf8Hfn+4+YEgqqFZVYs+KRwyojM=;
        b=wC7u7chLhV24S9BgOFPt+dP/ST/aLokRAh/SMaVBRLY1Qz6s1pTsSIqkTbhNwhjYs5
         WyTLvw5gDESV71jxqhIW71cUECWv4oLx7L5sxpRVjIld3s7MB6AyKjMdSn8uC7u+bITW
         pQ1M1wx8kQ5ayOn63lBVhIyhqBrQS15KDM1tD0f2Q3vx7LZ/nvOAacIEpS4aq7aCgplx
         vhxjJo0o5+xOchpFDXUSKTsaIGx/RH/XYVJpFzB8AYZkUQdq+1tVX0bdeHVPh96nwu4p
         LaCoKU+qP1jeSpn2P1xY8zt0bL7AAE4dTaUnXHlvdcR5lhFRoPWIE+ReSqDXL+wfqRQh
         BKuw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of kai.heng.feng@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=kai.heng.feng@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of kai.heng.feng@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=kai.heng.feng@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v2] Add delay-init quirk for Corsair K70 RGB keyboards
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <1517761102-6849-1-git-send-email-jackstocker.93@gmail.com>
Date: Mon, 5 Feb 2018 00:38:56 +0800
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Seth Forshee <seth.forshee@canonical.com>,
 Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
 Sandeep Singh <sandeep.singh@amd.com>,
 Devin Heitmueller <dheitmueller@kernellabs.com>,
 Dmitry Fleytman <dmitry@daynix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <AE53BCA5-F49A-41ED-B6F4-1B5FF8B4391F@canonical.com>
References: <14038CE4-3754-426C-AC53-0AFE58D095A3@canonical.com>
 <1517761102-6849-1-git-send-email-jackstocker.93@gmail.com>
To: JackStocker <jackstocker.93@gmail.com>
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591305042869034715?=
X-GMAIL-MSGID: =?utf-8?q?1591489168324731620?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> On 5 Feb 2018, at 12:18 AM, JackStocker <jackstocker.93@gmail.com> wrote:
> 
> Do you mean like this?

Yes, with proper commit message.

> 
> Signed-off-by: JackStocker <jackstocker.93@gmail.com>
> ---
> drivers/usb/core/quirks.c | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index a6aaf2f..0405d68 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -218,6 +218,9 @@ static const struct usb_device_id usb_quirk_list[] = {
> 	{ USB_DEVICE(0x1a0a, 0x0200), .driver_info =
> 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
> 
> +	/* Corsair K70 RGB */
> +	{ USB_DEVICE(0x1b1c, 0x1b13), .driver_info = USB_QUIRK_DELAY_INIT },
> +
> 	/* Corsair Strafe RGB */
> 	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT },
> 
> -- 
> 2.7.4
> 
