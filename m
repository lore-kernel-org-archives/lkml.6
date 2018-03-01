Return-Path: <axboe@kernel.dk>
ARC-Seal: i=1; a=rsa-sha256; t=1519918415; cv=none;
        d=google.com; s=arc-20160816;
        b=KGFQKyyhoHPvb8i0KCoDCLIjQ/EcdQyIF3aMBhyIHqSRNCIbGcdOFZRGBoCI81JOEl
         wcONTM5uIZ0PL6NTGPjK5vD4Wiw4OiLRoAtmxDLjJ8/hmP1oDd3UmWk5fsChs0x5t395
         QY0bqfKNZYsjk3ojB+PW9fArGQQTnIkqFfQbmWilaLjfOL73cWHoT7Zy7dGQ3dtO7g2F
         EhjmDW7qE28VCmABdrqmVxZnhHg6xnVhSQx44IAlCZzqkumsgDBKADmRkDIBVPbuoY4X
         yJUgWvsOh9zLRX6zSnRun5CqkeDrecUOeFurRdLFcSXF4XW4Y4SjXohe4+4NhsnbWjgC
         GHLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=RX4KdPkw/1x7h1iLe/JJHaRHJOdHy0sFelxWxjXr78c=;
        b=Au9JpwRycf9BM01HCjPBdZ5KuPZht2E/ukD5ceFS966/zRt6wBR8AF7n7HnuG/p0MT
         BFUrLBYzOJO0rbqLtk8h5Pnsq4Dese84qk5aM/FVq31v9z9Srjok4WeBOMDN71EZjqT6
         JxIxryDPYz/0cDQfu7A9ibOtpkL3MnTD5RQSvdA2mX4tTnAMSOsO21vfsfCEnc5ItkNh
         UkNrSylULrfv1qoqymyAQek97u31sd5E0119TQJsxr96R1NcZeGm4Srr49dRrWnwHzXG
         Ow56whcFJ4OCrIYRIGabQGDBACoar3EqQNiEM4x3khMks5Jes2hWid+rCo8UTVbygpo1
         /Zwg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel-dk.20150623.gappssmtp.com header.s=20150623 header.b=y6woSZAt;
       spf=pass (google.com: domain of axboe@kernel.dk designates 209.85.220.41 as permitted sender) smtp.mailfrom=axboe@kernel.dk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel-dk.20150623.gappssmtp.com header.s=20150623 header.b=y6woSZAt;
       spf=pass (google.com: domain of axboe@kernel.dk designates 209.85.220.41 as permitted sender) smtp.mailfrom=axboe@kernel.dk
X-Google-Smtp-Source: AG47ELsrDT+bNXiy9MK/LX4GZXrRfl4c3KMMXuR/Zwmyds23P51XxISQvxM6QXbsOta8yqpdouMgXA==
Subject: Re: [PATCH 1/2] misc: rtsx: rename SG_END macro
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Lee Jones <lee.jones@linaro.org>, Rui Feng <rui_feng@realsil.com.cn>,
 Steven Feng <steven_feng@realsil.com.cn>, linux-kernel@vger.kernel.org
References: <20180301105641.1650792-1-arnd@arndb.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a353140d-5411-285e-b4e1-7ba7b5281db5@kernel.dk>
Date: Thu, 1 Mar 2018 08:33:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20180301105641.1650792-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593732560989886053?=
X-GMAIL-MSGID: =?utf-8?q?1593749971856938900?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/1/18 3:31 AM, Arnd Bergmann wrote:
> A change to the generic scatterlist code caused a conflict with
> the rtsx card reader driver:
> 
> In file included from drivers/misc/cardreader/rtsx_pcr.c:32:
> include/linux/rtsx_pci.h:40: error: "SG_END" redefined [-Werror]
> 
> This changes one instance of the driver to prefix SG_END and
> related constants.

Thanks Arnd, applied 1-2.

-- 
Jens Axboe
