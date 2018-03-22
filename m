Return-Path: <logang@deltatee.com>
X-Google-Smtp-Source: AG47ELtHQrHGvYKFa4uHwyAA2Fr5NUmzeJV4gkgv+9HCIKOEQQG0gj9EKOZo8IAvrVDt3UjDLwiI
ARC-Seal: i=1; a=rsa-sha256; t=1521739732; cv=none;
        d=google.com; s=arc-20160816;
        b=jYwIRHq7zRY/O+sG8IZ4K+4QZvB/leKhe+f0gFQFhJE9yD+a96YSgB4jRPnMGAkO67
         q7lAtCLRQfRRJvMxtj9sTzK8sHi0PZ93FLdSwUpw/z/FOEbc8m/SF1ZZwFlW/wfy13xv
         kpiVJksX0uCuWfrCcKkbyIpUHB9aRD0EZrsw/9OgGUD+UX3WkLRaSeBaL/rrxQovyEAt
         5XF4KTbZCa5LYD0e5MvMrugpvyF/syuiKULt19kDPx0Eth5CtVIahvjW+nSC1u+tzi0q
         UxJmA8q00oHQuf+ro95uLkXxmB9ryqC8VUILi+M7J3iWMbpsGDzkUrVNFMdpdeq92cKw
         hzVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:message-id:from:references:cc:to
         :arc-authentication-results;
        bh=toAissXb2V1UrlMGrRO4zd+Tn5Pql5nH72u9CEZRMqw=;
        b=FUqNDDFDctJsGGA4zKLrB5U5mVl+xJZkKaDwo2bvo75d4c8fwR5vB5jRznlovOGqX5
         5Wf34FhUoYvfsLUJfLkUBbWcCMugrrFK2kBO12lFuCYmIOcpb6elPSZ8au9o5VO4KD4s
         dEcqL2/2peACxH1//YQoa5ksrUyqvbSjr4OqRT6zW5alCxgJ9Sr/PG64eJLPkqFC0BMJ
         TCWfjDtHt6TmZNx8uGmhse7wU/QO1FzcGj+i6RXcoAXMJGwjkPazDzmAd0otf4ChBgL8
         UuS05efcC7+rtUTXzkxGzrt7U4nKb7VumVdl3G+nOui4v/8TTMXcWMjob7DxUgBvHHrV
         jMvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of logang@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=logang@deltatee.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of logang@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=logang@deltatee.com
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>
References: <20180322171703.4300-1-logang@deltatee.com>
 <20180322171703.4300-3-logang@deltatee.com>
 <20180322172747.4rjped3gojfuhuh2@ltop.local>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e183ca6b-8148-1210-8f00-3415fbad7e77@deltatee.com>
Date: Thu, 22 Mar 2018 11:28:44 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322172747.4rjped3gojfuhuh2@ltop.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: kstewart@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de, horia.geanta@nxp.com, andy.shevchenko@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org, linux-crypto@vger.kernel.org, linux-ntb@googlegroups.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, luc.vanoostenryck@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v14 02/10] iomap: Add big endian sparse annotations to
 mmio_{read|write}XXbe()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595659036992994205?=
X-GMAIL-MSGID: =?utf-8?q?1595659761347761340?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/22/2018 11:27 AM, Luc Van Oostenryck wrote:
> On Thu, Mar 22, 2018 at 11:16:55AM -0600, Logan Gunthorpe wrote:
>> Sparse produces a few warnings of the form:
>>
>> lib/iomap.c:84:9: warning: cast to restricted __be16
>>
>> (The kbuild robot has recently started running such checks)
> 
> Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> 

Thanks Luc!

Logan
