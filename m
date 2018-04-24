Return-Path: <wulf@rock-chips.com>
X-Google-Smtp-Source: AIpwx4+e1PKIG4Ql/Wai0cCUD1xJNkeU8EZ5k6ZlwXgvqgyXMta/vU7AgiKLUwZICtT9GjRayGY6
ARC-Seal: i=1; a=rsa-sha256; t=1524560706; cv=none;
        d=google.com; s=arc-20160816;
        b=yl+STX8FCJZKXYSIdX3ISA3z9MB5SQNhb3VZjaEggVNwtVA/lSwqzD8UFhkWSvboym
         MJMc0s6VSHZ5mHPQbQEG4aCRVXl6kVSt++H/oVvr+r/ZweOgXO3+PksKi3LRaUzVTOHZ
         mRSPRs6LBl8GL4isB4y/H3zzzd6RbdsOM4LVuTVrVnO08+IoEiPq8jIoeQ3w0GzgnNsB
         WhjWe13mYqwXvsxitaSTEepeF5TRteq7DxdsOSzYXOTBlOpyRJ/T+ZGqfhfAmkdIGpTf
         vyx5bLYzj/WrARHrSIcSTQ2pGHwkzpgDPv7MxaQy0DIgndCQWsEghwrR+xn2XSfyqytE
         c6NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=WOrRXWZ676CiX40zInt3Uz79Gq1C51QoK84mAD9+D4U=;
        b=zLWvqWHbgQSA2oP+NHhWTy/F3tVMLIQNxZVuq/PRVuXDRSq5WK4pwm/duAUKJ15Zlv
         C2KDSWPesO7XNO/iYzQZfhcEaxNkgVD08EthxI6jYms5itJKg0vg8AOsuurvZqbQ4Cbh
         spDtzZfoEMnsPzXSzYDjtua1TuFQynmd1VlEm7EqMunSJBm+DRh0Chdh+nMwRDdYSTEm
         LBcCGnT8/CKKqL1KF+scVXfAN1A9AGaZSEBTzNgPnG3BLi/hdimCa4qoTdquox1KjJy3
         CN0iLFd2g/MS4zexU16+Jmp1LkWSyrPAsllwALafANc5emZQ94GisBxNHRYezbLBEPDh
         BQRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of wulf@rock-chips.com designates 211.150.80.16 as permitted sender) smtp.mailfrom=wulf@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of wulf@rock-chips.com designates 211.150.80.16 as permitted sender) smtp.mailfrom=wulf@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: wulf@rock-chips.com
X-FST-TO: stantsui@aopen.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: wulf@rock-chips.com
X-UNIQUE-TAG: <b4185c6d3a08ba31bf462f0e95f9ff46>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH 2/2] usb: dwc2: fix isoc split in transfer with no data
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 William Wu <william.wu@rock-chips.com>, hminas@synopsys.com,
 felipe.balbi@linux.intel.com, gregkh@linuxfoundation.org
Cc: heiko@sntech.de, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-rockchip@lists.infradead.org, frank.wang@rock-chips.com,
 huangtao@rock-chips.com, dianders@google.com, daniel.meng@rock-chips.com,
 John.Youn@synopsys.com, wzz@rock-chips.com, zsq@rock-chips.com,
 Allen.Hsu@quantatw.com, StanTsui@AOPEN.com
References: <1524537824-22010-1-git-send-email-william.wu@rock-chips.com>
 <1524537824-22010-3-git-send-email-william.wu@rock-chips.com>
 <799e2eea-be83-b3c1-3ee7-7a66b1759379@cogentembedded.com>
From: wlf <wulf@rock-chips.com>
Message-ID: <4daa0026-f5b5-a82f-08b1-20196968dcfb@rock-chips.com>
Date: Tue, 24 Apr 2018 17:04:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <799e2eea-be83-b3c1-3ee7-7a66b1759379@cogentembedded.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598593891532629314?=
X-GMAIL-MSGID: =?utf-8?q?1598617767681479176?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Dear Sergei,


在 2018年04月24日 16:27, Sergei Shtylyov 写道:
> Hello!
>
> On 4/24/2018 5:43 AM, William Wu wrote:
>
>> If isoc split in transfer with no data (the length of DATA0
>> packet is 0), we can't simply return immediately. Because the
>> DATA0 can be the first transaction or the second transaction for
>> the isoc split in transaction. If the DATA0 packet with on data
>                                                           ^^ no?
Thank you for correcting me. I will fix it in next patch version.
>
>> is in the first transaction, we can return immediately. But if
>> the the DATA0 packet with on data is in the second transaction
>
>   One "the" too many. And that "on data" again... :-)
Ah, sorry to make such a simple mistake. I will fix these in next patch 
version.
>
>> of isoc split in transaction sequence, we need to increase the
>> qtd->isoc_frame_index and giveback urb to device driver if needed,
>> otherwise, the MDATA packet will be lost.
>>
>> A typical test case is that connect the dwc2 controller with an
>> usb hs Hub (GL852G-12), and plug an usb fs audio device (Plantronics
>> headset) into the downstream port of Hub. Then use the usb mic
>> to record, we can find noise when playback.
>>
>> In the case, the isoc split in transaction sequence like this:
>>
>> - SSPLIT IN transaction
>> - CSPLIT IN transaction
>>    - MDATA packet (176 bytes)
>> - CSPLIT IN transaction
>>    - DATA0 packet (0 byte)
>>
>> This patch use both the length of DATA0 and qtd->isoc_split_offset
>> to check if the DATA0 is in the second transaction.
>>
>> Signed-off-by: William Wu <william.wu@rock-chips.com>
> [...]
>
> MBR, Sergei
Best regards,
     wulf
>
>
>
