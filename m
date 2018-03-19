Return-Path: <kai.heng.feng@canonical.com>
X-Google-Smtp-Source: AG47ELvjR/n6BjH064I+N5YLiaNNi+O9SKxUKa1AQ0ctNxaja1WyeCcRqq2ZKRY4je67wy9G2I/f
ARC-Seal: i=1; a=rsa-sha256; t=1521475040; cv=none;
        d=google.com; s=arc-20160816;
        b=tQke6N3b7NM0PPJZhK++N4SusKM/CZDwr65GRG7D1Mc04IvpsmZMpziD8Lt/BwUDrW
         a73T346hY+PutU8Zaz3ncniaVUh6KbLS4pEgTiimYx9oX+Pr/Y0KAIoB+ZkQhFGB+lUS
         OJ/eT3OxBkwvbnGBKqLL5RfKLfuCg0DK+x7JhuO5qMEtNQbM0zilZI9l9ipqKFItWw77
         GyW79ZqbmXSin0LzYiwVpJS3WHQWOcITtiDjPGzwMM2uwrWtWXfP1+I2uVAqTe8depEN
         zX96z7E7gPr2zOgiVvEX0Tj213pjI1md2+6BokM89OV6livvVbbYdyp69QpOD41ynPhE
         XrDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:arc-authentication-results;
        bh=8PISD+0p+iuJzu7Z1Bs9zhcP6ZXYtlyW5+tl/L82y5I=;
        b=p6lX/PH8+iF17dbHSUMU+QN6kzYFgllVivYbW7fW21Bm0swCxl/kn4n6Ra5rijbzGo
         /rHo+1G3f8GCyGpJpMnl4Pj6jnp3L16Lm1YU4h/cLL9bFhAYfT+JFyRavLC3QGAUeNRV
         irwksxg3q46HWnJBqxXMeiGl4FPWsQ6i46CZ6sYkX5U4mfkl4qUztYtl7gvI8U6rPSft
         MzgNdWKO13qqDExocf08vY+ZpVNOJydojaWpgMIDA6QEiCoAll1FwIw3n4cqOqkKSxR0
         wvPALW9gQ+HjrNwdcUGaU8FURibFEDKFGLoXZYD35MM82/m1mlEKP+5syrupErq+3abd
         HmfA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of kai.heng.feng@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=kai.heng.feng@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of kai.heng.feng@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=kai.heng.feng@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Content-Type: text/plain;
	charset=us-ascii;
	delsp=yes;
	format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v6] usb: core: Add "quirks" parameter for usbcore
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <3823E1D9-FAC0-4816-AF04-5B944C5A6504@canonical.com>
Date: Mon, 19 Mar 2018 23:57:13 +0800
Cc: Greg KH <gregkh@linuxfoundation.org>,
 fengguang.wu@intel.com,
 oneukum@suse.com,
 linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <3A4EA370-68E2-45D0-A452-39075944D551@canonical.com>
References: <20180313072619.29717-1-kai.heng.feng@canonical.com>
 <20180313113654.GA3304@bombadil.infradead.org>
 <3823E1D9-FAC0-4816-AF04-5B944C5A6504@canonical.com>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594806487347934858?=
X-GMAIL-MSGID: =?utf-8?q?1595382212061481129?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Kai Heng Feng <kai.heng.feng@canonical.com> wrote:

> Matthew Wilcox <willy@infradead.org> wrote:
>
>> On Tue, Mar 13, 2018 at 03:26:19PM +0800, Kai-Heng Feng wrote:
>>> +	usbcore.quirks=
>>> +			[USB] A list of quirks entries to supplement or
>>> +			override the built-in usb core quirk list.  List
>>> +			entries are separated by commas.  Each entry has
>>> +			the form VID:PID:Flags where VID and PID are Vendor
>>> +			and Product ID values (4-digit hex numbers) and
>>> +			Flags is a set of characters, each corresponding
>>> +			to a common usb core quirk flag as follows:
>>
>> This doesn't really tell me that the specified quirks will be XORed with
>> the built-in quirks.  Maybe something like ...
>>
>> 			[USB] A list of quirk entries to augment the
>> 			built-in usb core quirk list.  List entries are
>> 			separated by commas.  Each entry has the form
>> 			VendorID:ProductID:Flags.  The IDs are 4-digit hex
>> 			numbers and Flags is a set of letters.  Each letter
>> 			will change the built-in quirk; setting it if it is
>> 			clear and clearing it if it is set.  The letters
>> 			have the following meanings:
>
> Thanks, will update the description to specify the XOR behavior.
>
>>> +		/* Each entry consists of VID:PID:flags */
>>> +		field = strsep(&p, ":");
>>> +		if (!field)
>>> +			break;
>>> +
>>> +		if (kstrtou16(field, 16, &vid))
>>> +			break;
>>> +
>>> +		field = strsep(&p, ":");
>>> +		if (!field)
>>> +			break;
>>> +
>>> +		if (kstrtou16(field, 16, &pid))
>>> +			break;
>>
>> Is there a reason to not use sscanf here like hid-quirks.c does?
>
> Actually I use sscanf in previous patch version. Using kstrto* isn't  
> needed anymore, I'll use sscanf in next version.

Okay, I remember why I don't use sscanf, mainly because the quirk_param in  
hid-quirks.c is charp instead of char, so using sscanf is trivia for it.

We use plain char* here because of module_param_cb(), so I guess using  
sscanf doesn't make much sense here. strsep() isn't the most elegant  
solution but it does its job well.

I'll update the description and send a new patch.

Kai-Heng

>
> Kai-Heng
