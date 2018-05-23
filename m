Return-Path: <mr.nuke.me@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1527085572; cv=none;
        d=google.com; s=arc-20160816;
        b=wimhX5VfB1UtOp0iPRg06jo8mmfwRVT7qpxuQxbpyoChCMQr2eaYPQDt23eTPowGhz
         YM+xrGemFyv7x8YC8ljaEI5EncxTmKuYcWNqEsbCTB8L7zeJo3ZH/en8YnAlW2bkjjN/
         Qe6o6qPvZ54u6VUJgxFuAT0zE5evYMrDf9eiNg55EEKl3AEo/H2xwz+S4GUzv3bsRQhL
         FDPxNlJIl3lgs1NV8zuy6TOvRxtVEO29eBqRdX2ir+NKEdlt/uzU2zdvx0dsyeUcrzlX
         F8t3VOozxB5Czgm4jlxiXAOu5+Y/VkUQVlIjZEhxdwrkdCDQDeqzPnIP/0S2E/+7r0ct
         +zSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=42OJcamRyf2Zrvk6FHK0+d1xP/sqTR+lpdUePJOdscA=;
        b=zUjzNOr6OCPpelZis1c7F66/oX/n+2kXzXjtZzyPPzDF9biGMpVnCCITu/xfm4Kn3u
         qfUE++y3w2DCxmGV/SxP03QQMuL+kyB/jQn86NN/fcEEGakcuQE5ArBRZ+DxfNRTRHNU
         Swk7qra8qV69oTj2NCO/ZpliW/OZcg2nU/uF1bJ/ElWEN0tb/jTZGhD2Ol2JrkSSdc8v
         f+3PH6eInElnntXXBnPTmsgtgcHWfpgIajNs36Vzc7qSGaA0nwGKcEGFLZ6mo8JxC48m
         bD+NC0JdlKCmBRgZaLkj5q/XmqoCGn9JukYCm8X9N+R2weZETIw3aqMd5CJ8qRtuuyrn
         J6xg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lSh+pzCX;
       spf=pass (google.com: domain of mr.nuke.me@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mr.nuke.me@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lSh+pzCX;
       spf=pass (google.com: domain of mr.nuke.me@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mr.nuke.me@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZoyn0CbQk8FHtVtK7c/FG05hHBEkZAOwh8Sf8jsf37Zt6g4q1bujBT+Vz0YILk2YSBqMe8yuQ==
Subject: Re: [PATCH 1/5] PCI/AER: Define and allocate aer_stats structure for
 AER capable devices
To: Jes Sorensen <jsorensen@fb.com>, Rajat Jain <rajatja@google.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Frederick Lawler <fred@fredlawl.com>, Oza Pawandeep <poza@codeaurora.org>,
 Keith Busch <keith.busch@intel.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Thomas Tai <thomas.tai@oracle.com>,
 "Steven Rostedt (VMware)" <rostedt@goodmis.org>, linux-pci@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kyle McMartin <jkkm@fb.com>
Cc: rajatxjain@gmail.com
References: <20180522222805.80314-1-rajatja@google.com>
 <20180522222805.80314-2-rajatja@google.com>
 <62fae8eb-aaed-65b2-19ad-7c57b3a9bfdc@fb.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <53789ac0-b571-5d6a-5925-7e83925b5b31@gmail.com>
Date: Wed, 23 May 2018 09:26:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <62fae8eb-aaed-65b2-19ad-7c57b3a9bfdc@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601205015185558067?=
X-GMAIL-MSGID: =?utf-8?q?1601265281234023824?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/23/2018 09:20 AM, Jes Sorensen wrote:
> On 05/22/2018 06:28 PM, Rajat Jain wrote:
>> new file mode 100644
>> index 000000000000..b9f251992209
>> --- /dev/null
>> +++ b/drivers/pci/pcie/aer/aerdrv_stats.c
>> @@ -0,0 +1,64 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> Fix the formatting please - that gross // gibberish doesn't belong there.

Deep breath in. Deep breath out.

git grep SPDX

Although I don't like it, this format is already too common.

Cheers,
Alex
