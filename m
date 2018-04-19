Return-Path: <john.garry@huawei.com>
X-Google-Smtp-Source: AIpwx4/TFG5m15JmVlUwsUP9wvnDsPPXi7Pv+mWK0kSGm+xCXEI50Ayo5gFKOzR5LsJZu9mktlg8
ARC-Seal: i=1; a=rsa-sha256; t=1524143341; cv=none;
        d=google.com; s=arc-20160816;
        b=LOgJs2jkk5b4hLcZ3U8l6UhXTvTgwEYryWKBMsoqwYiB7nEt2ZJXogRzpIILR/DO9z
         dmYDyLGcBlJmfXFW+t22Rd0jjEH1G2u7Cm1jsLXwsdZQaX2cJJbfhf6WIWhPSfRv2gT+
         YxAjODOuVcCaxn1qgNS0jlbluWLV6Dw58lt+KUI48XTDsv+O/zv811/1RacOqwipRB6D
         gCETLyagQZavF1Z38biyvEJhV7LjgD1sRRVWUjnIWE1RvmJiQASAJKUi+zFSPxRXvhyU
         qCb6628SkS8rN/EScSvErPACOn3EZCftYLNmMjlJlRlTYeHyshzEFJ1NV8hBz24hDQtE
         ikUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=kUYJwfeyELdlvqGjcPepWBcNfpiut09y0fqfNKK1AwU=;
        b=pEnDRGvIv8Cux8w2w30u7snIWe+qQR7iQzA/RjcBY546xL9qXm24YCXg7Mc9mAkS+q
         eIfhvVdB920BMV1hlRGNcUTK6sFfYbASX1M3dEug2UcJmDHpMyXQtAxmSitYBMyM/nu2
         BHsJ1i9DC04gkIWZMAf7t/6zseagHAU1TNCy+Uf8QB7/rfWdlqsxFXHBra5ICq/ldAAH
         kb3ALG0gA1xfNC0rrEPLOlDWX5/JBk5X0LjZiBchDlstRb6k2wtDaWgHGIL9smVTOsH3
         jYeTeEPVxx14SKg8kcRpzBLB2WwkTckCyAANfNGsY3DTNIXCuEJDDvvFjfimmgmkPZKU
         stOw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Subject: Re: [PATCH] HISI LPC: Add Kconfig MFD_CORE dependency
To: Arnd Bergmann <arnd@arndb.de>
References: <1524138946-136701-1-git-send-email-john.garry@huawei.com>
 <CAK8P3a1nen_EoyZ63p_EfSu51wUAbLigzbrv3K4byS2gUo9CjQ@mail.gmail.com>
CC: "xuwei (O)" <xuwei5@huawei.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Simon Horman <horms+renesas@verge.net.au>, gregkh
	<gregkh@linuxfoundation.org>, Paul Gortmaker <paul.gortmaker@windriver.com>,
	Robin Murphy <robin.murphy@arm.com>, Sebastien Bourdelin
	<sebastien.bourdelin@savoirfairelinux.com>, <bogdan.purcareata@nxp.com>,
	"Tony Lindgren" <tony@atomide.com>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>, Bjorn Helgaas
	<helgaas@kernel.org>, Olof Johansson <olof@lixom.net>, Kevin Hilman
	<khilman@kernel.org>, <tanxiaojun@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <026e9f13-7201-57a5-a4b3-8c48a89bf134@huawei.com>
Date: Thu, 19 Apr 2018 14:08:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1nen_EoyZ63p_EfSu51wUAbLigzbrv3K4byS2gUo9CjQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598175575431248949?=
X-GMAIL-MSGID: =?utf-8?q?1598180128856063330?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 19/04/2018 13:00, Arnd Bergmann wrote:
> On Thu, Apr 19, 2018 at 1:55 PM, John Garry <john.garry@huawei.com> wrote:
>> For ACPI support of the HiSilicon LPC driver we depend
>> on MFD_CORE config.
>>
>> Currently the HiSi LPC Kconfig entry does not define this
>> dependency, so add it.
>>
>> Fixes: e0aa1563f894 ("HISI LPC: Add ACPI support")
>> Reported-and-tested-by: Tan Xiaojun <tanxiaojun@huawei.com>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>
> Can you explain the specific dependency? Normally MFD_CORE gets
> selected by an MFD driver but not other drivers.
>

For each device on the LPC bus we create an MFD.

The reason we do this is that we need to set the resources of the 
derived MFD, as we should not modify the original ACPI device created in 
ACPI scan. Details are in the log for e0aa1563f894.

Shall I update commit message updated with this info? Or were you just 
interested in the motivation for using MFD?

Thanks,
John

>        Arnd
>
> .
>
