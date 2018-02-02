Return-Path: <srivatsa@csail.mit.edu>
X-Google-Smtp-Source: AH8x2266A8Q+sNMyJilC4vR4dUFCLeIv7+pRsXnmHD9umC14P3XHXFlUNno1JvplnKraIgrVqFrc
ARC-Seal: i=1; a=rsa-sha256; t=1517531114; cv=none;
        d=google.com; s=arc-20160816;
        b=DabhL69yGXoqmtIFTOzydmWs/YM+8ihm8K8aUoRxDpQ2KLABpb51Q8NVQvfoUet5RD
         UVBzYMI0sOxphm69ICL8anhjq9hP6n9DfK/XgVocPBkZlj1nht6tTmTG90Lq5uDJI2WT
         nphL8xVQX60ESZnD3uvIvfFuRokdJznP7iTtTzL/BB2UxZWAZRjVbDfSV9MzxKHYSWP+
         Y1K7E3NbKQzljlfwc8pYRRzttFCZ3V2CncWrVIgTxTMByfk6qtg23ZF9TW+PsNpS5MD1
         N2BEldbitlyCoVVauLIb/EjgBNjMe8BJucSe/yj+IIcb1q0jQroiNnA7K+/GqNnkG7k3
         ST2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=g2VwYe5unpeLtIR7yshDVzOUtwylWXdSJW9qXF832fg=;
        b=yxu/Xy7ZbveqUVOc9Wua3Od5VssXXev6Pi9gHDMp9xxtp1jpgre7GqDpHArfl0Ci8P
         nRZccmFRk4m8PtDcLayiq3/HhSilD5HQQJo1sVB0J2L0cu0Zn28Ic4eAKuby+kDW1JFL
         LcHTzWmFefLjkThYWmhwrFFXN0aaM90APklYipYCu2IoPrsgUiRgJgObuHQ4IWvf+0Y5
         yH/Lf7FVpPeYdi48gRToqVLvqhp75X3ISJQ2y58uCMdP6MepErnIZl8Z1RVMOCnrjtDs
         bEXhZ8ekuVkMN0qcf+kiPTp5uhuP7ZOqA0QKc4UA0KySA3+pkMjnlLqJvH5LrrY0L7tw
         rzHw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of srivatsa@csail.mit.edu designates 128.30.2.210 as permitted sender) smtp.mailfrom=srivatsa@csail.mit.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=csail.mit.edu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of srivatsa@csail.mit.edu designates 128.30.2.210 as permitted sender) smtp.mailfrom=srivatsa@csail.mit.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=csail.mit.edu
Subject: Re: Change in register_blkdev() behavior
To: Greg KH <gregkh@linuxfoundation.org>
Cc: logang@deltatee.com, axboe@kernel.dk, jlayton@poochiereds.net,
 bfields@fieldses.org, linux-kernel@vger.kernel.org
References: <a01cedbc-ca1a-3e3d-cf2c-3e995c63f793@csail.mit.edu>
 <20180131142403.GB9233@kroah.com>
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Message-ID: <2c9a88ae-89e5-e89e-ade3-3eebd2a26a85@csail.mit.edu>
Date: Thu, 1 Feb 2018 16:25:08 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180131142403.GB9233@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591067494565207085?=
X-GMAIL-MSGID: =?utf-8?q?1591246706351518750?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 1/31/18 6:24 AM, Greg KH wrote:
> On Tue, Jan 30, 2018 at 04:56:32PM -0800, Srivatsa S. Bhat wrote:
>>
>> Hi,
>>
>> Before commit 133d55cdb2f "block: order /proc/devices by major number",
>> if register_blkdev() was called with major = [1..UINT_MAX], it used to
>> succeed (provided the requested major number was actually free).
> 
> How was LTP calling register_blkdev() with such crazy numbers?
> 

Haha :-) No idea!

> Anyway, I agree with Logan, this sounds like something to be resolved in
> LTP, as allowing block devices with numbers greater than the number we
> really allow seems like an odd requirement :)
> 

Agreed! And thanks for confirming!

Regards,
Srivatsa
