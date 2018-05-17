Return-Path: <catalin.marinas@arm.com>
X-Google-Smtp-Source: AB8JxZpMgFOOJ6lmdbz8OiCBqSF8R/RzyUGoOa0GNDFLElcOQADibppW7DtckDHWav10sbBhqL9z
ARC-Seal: i=1; a=rsa-sha256; t=1526576731; cv=none;
        d=google.com; s=arc-20160816;
        b=iqlN7iFDUcPzL5Aw7RUVHiH4YsFwhzM5l0Zq8c6bTnz5SHsA5ylfBzb2qmeFDN1cdV
         fluouGjzLj1J495cG7TLfGFbslHdPy5aDTNnA7T6dyhx9M3gz8/688s/l5O3s7lbxDcg
         hLNlSjsabjAPJT4jyOBaW26TST7mtsOn8usYlkKRFi6nAXVOsyfPuw5nU2l+RtOTsIRF
         ffhP8IO1fVuaQHMKL5IXUCw/6MCNGBRVry8/CMORnJpOhohtaqEMrb0tzYian4tdLQSv
         A7v/gZfVO6AypK4DJ2xe2p1HusdoTd41HmB7wIeDLUcKuwoBX54lzX5gVy6Git/NAXRy
         QptQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=VEFzYgWuikLdZQw3kbc3BsOjhVjfCnSBcZwgo0k5cvA=;
        b=K71zDOOJl4FnhHernEp9UktpZPNQ84BadGopUPtcaPs2SUK7unqoXJIwX9s9LAGJsR
         +OU0TJ0hq9PZb8bkzOW8V1Kt5uuqCd72EEsy7Yl+/muA+v8XGVWnBTd8iCl/ewHKemoE
         GbHYBygD6Jk9vKgP3X5Srh7GVS3pdN4X+Xb2ZOQkAdzMtNqQC5IOo8C0MKGA6LEUDcRZ
         UQ02p1+bBu0064LZNPWmh6IHBndFuYNNS8KjMc+z/Sb8PBNvNUoce+j8DvwtYNHFBilW
         GPQFH5WPdo2fsNQROoyyVaRXOZYNVy7YBaB7A0hLi4SB9O4DTesbTFPsonH+UaeRdOm7
         SpLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of catalin.marinas@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=catalin.marinas@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of catalin.marinas@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=catalin.marinas@arm.com
Date: Thu, 17 May 2018 18:05:24 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, Mark.Rutland@arm.com,
	austinwc@codeaurora.org, tnowicki@caviumnetworks.com,
	palmer@sifive.com, Will.Deacon@arm.com,
	linux-riscv@lists.infradead.org, Morten.Rasmussen@arm.com,
	vkilari@codeaurora.org, Lorenzo.Pieralisi@arm.com,
	jhugo@codeaurora.org, ahs3@redhat.com, lenb@kernel.org,
	john.garry@huawei.com, wangxiongfeng2@huawei.com,
	Dietmar.Eggemann@arm.com, linux-arm-kernel@lists.infradead.org,
	ard.biesheuvel@linaro.org, gregkh@linuxfoundation.org,
	rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
	hanjun.guo@linaro.org, Sudeep.Holla@arm.com
Subject: Re: [PATCH v9 00/12] Support PPTT for ARM64
Message-ID: <20180517170523.h7tuvbzdfluuidcz@armageddon.cambridge.arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511235807.30834-1-jeremy.linton@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600214146814792437?=
X-GMAIL-MSGID: =?utf-8?q?1600731722755136325?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 06:57:55PM -0500, Jeremy Linton wrote:
> Jeremy Linton (12):
>   drivers: base: cacheinfo: move cache_setup_of_node()
>   drivers: base: cacheinfo: setup DT cache properties early
>   cacheinfo: rename of_node to fw_token
>   arm64/acpi: Create arch specific cpu to acpi id helper
>   ACPI/PPTT: Add Processor Properties Topology Table parsing
>   ACPI: Enable PPTT support on ARM64
>   drivers: base cacheinfo: Add support for ACPI based firmware tables
>   arm64: Add support for ACPI based firmware tables
>   arm64: topology: rename cluster_id
>   arm64: topology: enable ACPI/PPTT based CPU topology
>   ACPI: Add PPTT to injectable table list
>   arm64: topology: divorce MC scheduling domain from core_siblings

Queued for 4.18 (without Sudeep's latest property_read_u64 cacheinfo
patch - http://lkml.kernel.org/r/20180517154701.GA20281@e107155-lin; I
can add it separately).

Thanks.

-- 
Catalin
