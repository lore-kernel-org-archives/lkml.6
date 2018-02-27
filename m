Return-Path: <k.opasiak@samsung.com>
X-Google-Smtp-Source: AH8x226rF8WzU5tpeaZ7nMHlfsTlJP16/mfpfgGEDMs+9cTnIUfCADPDTwUCzPLfgDe8SATgimbW
ARC-Seal: i=1; a=rsa-sha256; t=1519737893; cv=none;
        d=google.com; s=arc-20160816;
        b=GisSpL0daQTmwnHN+BbXTjC+AAwNcueXPtNqvR1Xjy37ifurR7fYgOK3PDDQKIc0WJ
         /Hm7nrvhzgzWz5n7u6EkbJY/nWGxko2tHR0QouHtE2gv7LlIw9qCLzbKF4ZHHOOArxiR
         VvuVOdqq2bFabfv4l7HHv1WwNN6fV6G909tLUgI/YdS0NVKd8bTTwI42yYenxHkkSPkk
         aotjMwWm/xVjT9NxGDbxfe8f/gJuG6D90JhSRIT4KVhOO1Jb26NcbCk7Q2IdpVKCOqMD
         uAv2ZpFQD/QbKYl8KB7K2Tzc54pyPjLa1hx/IC3Vl0ICqxjl7tvWjf1erUozY43UVXSZ
         xV7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:cms-type:content-transfer-encoding:content-language
         :in-reply-to:mime-version:user-agent:date:message-id:from:cc:to
         :subject:dkim-signature:dkim-filter:arc-authentication-results;
        bh=j8lLkVc0UU6ussw+O5qxJa14Dwr75pMKZ/pvvIaNAl4=;
        b=CUk3d+uPL2HsKwZdDnBkYsHi8oTSkPP1SUv1DQpNb6D3RzaoZwxVphYvGR2hocxkSA
         hknf6a9A60y7QcMIvjMrcoBEPGVsVjItHsIR6mgWm+K89mcSvk4GikX2BDPwkTTmEcM+
         SLrFLoMeqUBMAXAcXS73bU2ICL6VKF5jiaceSogHMA9nHM1EWi14/bGDkRbTcl01NLxZ
         qJDAx8bai9WGJW26UfzDJh9muKipfkdwg8mDN34JHGixU5U+4J4/y1ZmnOIbAjgcbws/
         Npa4APT+EXbkKmJz/Lf5w6yOP+C36pPtcldxdX/JspDAykh43sy4qPycrCMuqd4Q52bB
         r1RA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=kIeugxwR;
       spf=pass (google.com: domain of k.opasiak@samsung.com designates 203.254.224.33 as permitted sender) smtp.mailfrom=k.opasiak@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=kIeugxwR;
       spf=pass (google.com: domain of k.opasiak@samsung.com designates 203.254.224.33 as permitted sender) smtp.mailfrom=k.opasiak@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180227132450epoutp036681ab0f53ba4bbc99f5610902093baf~XMY9UqKz90151101511epoutp03x
X-AuditID: b6c32a45-403ff70000001023-ed-5a955c2102ca
Subject: Re: [PATCH] usbip: vudc: fix null pointer dereference on udc->lock
To: shuah@kernel.org, Colin King <colin.king@canonical.com>, Greg
	Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Shuah
	Khan <shuahkh@osg.samsung.com>
From: Krzysztof Opasiak <k.opasiak@samsung.com>
Message-id: <b021604f-06e0-e595-23c5-cf40e7a02268@samsung.com>
Date: Tue, 27 Feb 2018 14:24:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <0e3059a0-1310-5d08-4623-f1cf34c52fc0@kernel.org>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7bCmha5izNQogwev9Sx+r+5ls2hevJ7N
	YustaYvLu+awWSxa1spsMeXlOnaLqV8+sDiwe8xq6GXz2LSqk81j/9w17B5b+u+ye3zeJBfA
	GsVlk5Kak1mWWqRvl8CVMfPKX8aCN7wV8zt6WBoYJ3J3MXJySAiYSJzuWsDUxcjFISSwg1Hi
	99kPzBDOd0aJ20v/scNUTVxxnAXEFhLYzSjRNT8Uoug+o8Sf+cfZQBLCAt4SxyctYgFJiAh0
	Mko0XZoBlmAWyJT43T2PtYuRg4NNQF9i3i5RkDCvgJ1Ef9cXJhCbRUBVYsLbL2DlogIREgun
	PmWEqBGU+DH5HthiTqD6FVfnMEKMtJJ49q+VFcIWl2huvckCYctLbF7zlhni6BNsEkfuJkHY
	LhIz5s9hhbCFJV4d3wL1mLTEs1UbGUFulhBYxygx+cJ+VggH6Mt9fY+gJllL/Fk1EeoZPomO
	w3/ZQZ6REOCV6GgTgijxkLjdsR5qgaPEyouNrJAQOsoocfpUA9sERrlZSB6aheSJWUiemIXk
	iQWMLKsYxVILinPTU4uNCgz1ihNzi0vz0vWS83M3MYKTipbrDsYZ53wOMQpwMCrx8B50nBIl
	xJpYVlyZe4hRgoNZSYR35eLJUUK8KYmVValF+fFFpTmpxYcYpTlYlMR52wJcooQE0hNLUrNT
	UwtSi2CyTBycUg2M6pl7W65lzHRWMTE/uqJxi7fZfz/R+meuE/ZGqkpusbvNM+WGTQXzuXrx
	x8cFA7h35R57nvVFYY3wxbbp5T/+8Bspq0vO66o88uy9hRJnMGfz15NBiawrnrx2W158IFFM
	Y426Tqn+hdui3XlqzjL7DB7tEN0Q9OHGPxe/8pulV+LKtPsPnV+vxFKckWioxVxUnAgAIMpx
	aiYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsVy+t9jAV2FmKlRBlPXWVv8Xt3LZtG8eD2b
	xdZb0haXd81hs1i0rJXZYsrLdewWU798YHFg95jV0MvmsWlVJ5vH/rlr2D229N9l9/i8SS6A
	NYrLJiU1J7MstUjfLoErY+aVv4wFb3gr5nf0sDQwTuTuYuTkkBAwkZi44jhLFyMXh5DATkaJ
	7sUXoZyHjBJXL85mAqkSFvCWOD5pEVhCRKCTUeLUxIlsIAlmgUyJbZdbGCE6jjJKfN/Wyt7F
	yMHBJqAvMW+XKEgNr4CdRH/XF7BBLAKqEhPefgHrFRWIkOhcOZ8FokZQ4sfke2A2J1D9iqtz
	GCHmm0l8eXmYFcIWl2huvckCYctLbF7zlnkCo8AsJO2zkLTMQtIyC0nLAkaWVYySqQXFuem5
	xUYFRnmp5XrFibnFpXnpesn5uZsYgXGw7bBW/w7Gx0viDzEKcDAq8fDOkJsSJcSaWFZcmXuI
	UYKDWUmEd+XiyVFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEefnzj0UKCaQnlqRmp6YWpBbBZJk4
	OKUaGJlf35jnsSr4tzvzl4+ZPU46He16//53WJa79DbJPdsmdyShNFRsclLls3dZG+fx7n3I
	ee9nOV+X/X5pPQa1TRY1ifV8upsmHftiGDBZy8rsS5PVmfy8Dh3xvQf3rdusUlBdt0ju6sbj
	ZjHLkpdps2wvLjr8adXEqV7F9wuTij58W6pyYfXzNCWW4oxEQy3mouJEAF20h4l/AgAA
X-CMS-MailID: 20180227132449epcas2p1a6d5d8261d23cd5509ec6b0f2bcfdc82
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180226164058epcas2p2bb0094cc06b3161a0d0b2a9cc6ce282f
X-RootMTR: 20180226164058epcas2p2bb0094cc06b3161a0d0b2a9cc6ce282f
References: <20180222173917.10841-1-colin.king@canonical.com>
	<CGME20180226164058epcas2p2bb0094cc06b3161a0d0b2a9cc6ce282f@epcas2p2.samsung.com>
	<0e3059a0-1310-5d08-4623-f1cf34c52fc0@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593123702701163352?=
X-GMAIL-MSGID: =?utf-8?q?1593560681293684386?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 02/26/2018 05:40 PM, Shuah Khan wrote:
> On 02/22/2018 10:39 AM, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Currently the driver attempts to spin lock on udc->lock before a NULL
>> pointer check is performed on udc, hence there is a potential null
>> pointer dereference on udc->lock.  Fix this by moving the null check
>> on udc before the lock occurs.
>>
>> Fixes: ea6873a45a22 ("usbip: vudc: Add SysFS infrastructure for VUDC")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>   drivers/usb/usbip/vudc_sysfs.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/usbip/vudc_sysfs.c b/drivers/usb/usbip/vudc_sysfs.c
>> index d86f72bbbb91..6dcd3ff655c3 100644
>> --- a/drivers/usb/usbip/vudc_sysfs.c
>> +++ b/drivers/usb/usbip/vudc_sysfs.c
>> @@ -105,10 +105,14 @@ static ssize_t usbip_sockfd_store(struct device *dev, struct device_attribute *a
>>   	if (rv != 0)
>>   		return -EINVAL;
>>   
>> +	if (!udc) {
>> +		dev_err(dev, "no device");
>> +		return -ENODEV;
>> +	}
>>   	spin_lock_irqsave(&udc->lock, flags);
>>   	/* Don't export what we don't have */
>> -	if (!udc || !udc->driver || !udc->pullup) {
>> -		dev_err(dev, "no device or gadget not bound");
>> +	if (!udc->driver || !udc->pullup) {
>> +		dev_err(dev, "gadget not bound");
>>   		ret = -ENODEV;
>>   		goto unlock;
>>   	}
>>
> 
> Thanks for the patch. Looks good to me.
> 
> Acked-by: Shuah Khan <shuahkh@osg.samsung.com>

Reviewed-by: Krzysztof Opasiak <k.opasiak@samsung.com>

but you could fix also a similar bug one one function above 
(dev_desc_read()) ;)

Best regards,
-- 
Krzysztof Opasiak
Samsung R&D Institute Poland
Samsung Electronics
