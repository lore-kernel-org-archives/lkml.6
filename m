Return-Path: <shuahkh@osg.samsung.com>
X-Google-Smtp-Source: AIpwx4/Y9rYA9rzIT8O3/jSfRwZAPDCK8Lx+CnNVbkn8n7CyEA8vWPJ0xKE9unZicQ8hnqflIwcr
ARC-Seal: i=1; a=rsa-sha256; t=1522763706; cv=none;
        d=google.com; s=arc-20160816;
        b=th/wdw2uVGZbIorXhRl4wRJCzpRe0wZrt5UPZxf7rZgQyTAaZk0XMbKJ0xRUUtxF/W
         fDCUlkugGTkYaZabBKaeaPxpUVUEnnHQYx787Ra7lvW4xRmaAbvaAQiNEGjQB/TaCt/N
         84GXWDJiF6WDNx5R4Siq3yDwrmwrzBsC6GDoT9tt7awOGBwWC7Ch/lAJI2g2D1g3/LcA
         2aV3SWOJEFB4exav8Wj5CyeCcs2BsBnaQJiqRON/lawPTq6mXaVHo5FJGpFf3ZvWpYdp
         cbE4wu6WTst+AfotyHfUCsvdFQ1w0rgM9Eg35CYOl415hsQp3ZMVy8e0AzU+ONqT9o6Z
         JVXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:autocrypt:openpgp:from:references:cc:to
         :subject:arc-authentication-results;
        bh=LuaxF0k79SmmxaAux1jMWQ9quEdsKptiDlrfScfRCpY=;
        b=yMa432Vly/gOBQqBCr/h99amRIXuJuwFHuuZfToO9M2VqOjX9RnAF0njC6B/b3moQt
         dZ113sZyHSOBKbIeBNy18j/id6l85eaowJ2JkACaBY0R2L7yb3zGbxoUKURycMj3Gs1P
         oLNFdVu7tbwhihpexRfkKuxgmixIcQ5YYL1y/jDqDyLaHZG4Lhzrev3OGks3pSshvWxV
         +ufsSny0PkqZwSeP9ZX7xC2ta+/BKhfn4Nrdtcpqqnh7bKsm8SUkoRO92CmUX2QZ7Xqq
         7MdKUvqlOT1lA3inS15TSui62ygQL+j4xmou1oqNCP9i005RTgLvozNzgjP49QPbA84C
         k6FA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Subject: Re: [PATCH] usbip: vhci_hcd: Fix usb device and sockfd leaks
To: Greg KH <gregkh@linuxfoundation.org>
Cc: valentina.manea.m@gmail.com, shuah@kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180402205232.21659-1-shuahkh@osg.samsung.com>
 <20180402205232.21659-2-shuahkh@osg.samsung.com>
 <20180403065642.GB1093@kroah.com>
From: Shuah Khan <shuahkh@osg.samsung.com>
Openpgp: preference=signencrypt
Autocrypt: addr=shuahkh@osg.samsung.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2cbcf722-4430-e531-709f-25c0882fce17@osg.samsung.com>
Date: Tue, 3 Apr 2018 07:54:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180403065642.GB1093@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596669167321916876?=
X-GMAIL-MSGID: =?utf-8?q?1596733475987163672?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/03/2018 12:56 AM, Greg KH wrote:
> On Mon, Apr 02, 2018 at 02:52:32PM -0600, Shuah Khan wrote:
>> vhci_hcd fails to do reset to put usb device and sockfd in the
>> module remove/stop paths. Fix the leak.
>>
>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> 
> Should this be marked for the stable kernels?
> 

Yes please mark this for stables. I forgot to do that.

thanks,
-- Shuah
