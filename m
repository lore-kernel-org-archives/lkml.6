Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELvP9jdIKxDWTSD/ix7TvHKEi4CCNI4Q+r7Quo59X+UboxDdWgw9Nd4SpHYFqeLMK+zRmE3Y
ARC-Seal: i=1; a=rsa-sha256; t=1520356434; cv=none;
        d=google.com; s=arc-20160816;
        b=tXAW6zcNJ+QaT2dZBm7MXqR97XuNWEK4O8tX9NlP8TO61fIYQX//6FiaqcVpkId9pv
         IzNKC+IehsE1I3PMIvUyMoAewH5iBA3jE/JyUVdNySu4lHofDVnoDCi5q8gQ9uuph2Nw
         DtRnrduTu6nOeJ+wXz/En8Lgf53o7i6y7DgJHxhXLth7cqdFgs3xUrpAvGHzOG6HtgA7
         3lhlrfrhxY1P0Eh8L7roGq8qylYXGGS9u989kyzD0U2LLelvF/da+cGGRb2jHVKXZfMw
         HGGgnk69ZE5uydp2s9jCIySgk6Ap//p+B6ota5mC7+Be3wbCyH8mqJtgvI0URzMnxOsj
         SrPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=jwmT5ZO+KzBY1d3MDbjPhRKks8G+1aKPRdz8rXi8Z94=;
        b=tOvdmF+hpl+ECvVqPBVYbFI8hapjyzsm1XwYFyld05Ipo+S3M9YWs8K397sdpzRkhb
         nxNmJhddx09qQZMZRFntmD4TmJpMsAdAFVlFdFBcwHvG2y5t1t2HMv5YvsCGlUcwKxUy
         voHLOAXpNjelCcnvxTYm1y2+uAnkrY0RYKuhUvxOMzo6hOEig9CKhsb2nDTiLWKOK2MS
         HH3yNuDSJEN7dxpNSLjXBNKKG2jxx56wzD3RQVC9zBLcoSSAqkJ94sJrpHccZbadB7XK
         IiT3sqYJiJ7Rl2uu9kN+2KFqe4aKuS1Z8NegaPr5Mkp9hfBWgjrPXqV0RG6U0ppOCgND
         oQmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
 hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com,
 catalin.marinas@arm.com, gregkh@linuxfoundation.org, mark.rutland@arm.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com,
 dietmar.eggemann@arm.com, morten.rasmussen@arm.com, palmer@sifive.com,
 lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org,
 tnowicki@caviumnetworks.com
Subject: Re: [PATCH v7 04/13] arm64/acpi: Create arch specific cpu to acpi id
 helper
To: Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-5-jeremy.linton@arm.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <6763fdb6-92ac-c9cd-0cbc-e641e785b2d9@arm.com>
Date: Tue, 6 Mar 2018 17:13:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228220619.6992-5-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684147211561477?=
X-GMAIL-MSGID: =?utf-8?q?1594209269103604007?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 28/02/18 22:06, Jeremy Linton wrote:
> Its helpful to be able to lookup the acpi_processor_id associated
> with a logical cpu. Provide an arm64 helper to do this.
> 

This patch on it's own is good, but it's quite generic and made to look
at it again. Sorry for missing this earlier.

Can we use "per_cpu(processors, cpu)->acpi_id" at call sites instead ?
Or you can make that a generic helper using above expression ?

-- 
Regards,
Sudeep
