Return-Path: <jackstocker.93@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518717576; cv=none;
        d=google.com; s=arc-20160816;
        b=CUn/ATrxTHJJju2p+YYVt2l9Jzalir26dM+CaGlEM4qC653sMyQXpQLeX63zP0SE7u
         R10TASCKhUpBDJQco29UWp3B7UZ+LLsDzCYU7H0nQkZULQxhLsxhrEoAPvTKbqK9enxq
         V94/bjWtDodzgr1vK/GdsKaTCxzj5rY8sUaprittL6QeeskjVOYd/hza8YAsgKpEoqP9
         PVVLyuKWF1MMq2yoVvdMUpHPo3kR2XCycWpVJlFYb4+BzmlBfh3fBx3y+TBkD6T0XLAh
         7fwyFyzkQwoNdmltfW8lSAzSlTPlrI4ABohiWoUk/rius13Wn/6ijKLZEixU2RR+HxzD
         7SIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=H7AP/g0B9aTALDFZTu7TR+9DcnJ8qyEYu0Xkdi1OGcc=;
        b=KRI9LL2EF7ydlzFbihGaZBOOBJKS2Wkxc1+kll5uMhMiZsRDzRO4ZiA3kfsHHFAiYa
         F0F8mt0G1nj1ONiBBBqrsadlwvzE7c+0Lu0ElkawgxTdu9Zalb0PmMMBDcnXV8oPrPyO
         vUY1RF8zSh4Z3W+GUW6yQAXU6bWoIMtz8xzn/fLgGFQO/8JqoK6j3Iz6ycnbAQVrk2IB
         cDViqG+HXO7UCNZP7v6SeEBxX6Csq7GDzcr+25K5Ew7rJHVX+zWC8BHQ8g37eteEvLN6
         872iMBCi+l0tnkd0nnVZK5P2WoeoJXo9G84fr4/09s8prr3DlywZB27zltTWYxjxCw7g
         J9PQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bjTSopBT;
       spf=pass (google.com: domain of jackstocker.93@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jackstocker.93@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bjTSopBT;
       spf=pass (google.com: domain of jackstocker.93@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jackstocker.93@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x226t9cj1EXHhBQuzePOxGAOAJ/NUB6stsdYiTiaQmhXv16DMXRKa6Rn/GUlzQuaoGR+tSC1M3w==
Subject: Re: [PATCH v3] Add delay-init quirk for Corsair K70 RGB keyboards
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Seth Forshee <seth.forshee@canonical.com>,
 Dmitry Fleytman <dmitry@daynix.com>,
 Devin Heitmueller <dheitmueller@kernellabs.com>,
 Sandeep Singh <sandeep.singh@amd.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <AE53BCA5-F49A-41ED-B6F4-1B5FF8B4391F@canonical.com>
 <1517763059-9334-1-git-send-email-jackstocker.93@gmail.com>
 <20180215173500.GA11409@kroah.com>
From: Jack <jackstocker.93@gmail.com>
Message-ID: <5ffac152-c7e8-357f-9fee-c255d7947ecc@gmail.com>
Date: Thu, 15 Feb 2018 17:59:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215173500.GA11409@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591305042869034715?=
X-GMAIL-MSGID: =?utf-8?q?1592490800772088543?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 15/02/18 17:35, Greg Kroah-Hartman wrote:
> On Sun, Feb 04, 2018 at 04:50:58PM +0000, JackStocker wrote:
>> Following on from this patch: https://lkml.org/lkml/2017/11/3/516,
>> Corsair K70 RGB keyboards also require the DELAY_INIT quirk to
>> start correctly at boot.
>>
>> Device ids found here:
>> usb 3-3: New USB device found, idVendor=1b1c, idProduct=1b13
>> usb 3-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>> usb 3-3: Product: Corsair K70 RGB Gaming Keyboard
>>
>> Signed-off-by: JackStocker <jackstocker.93@gmail.com>
> I need a "real" name here please.
>
> thanks,
>
> greg k-h
As in 'Jack Stocker' is that correct?

Cheers,
Jack
