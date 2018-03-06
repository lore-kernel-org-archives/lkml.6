Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELv0lo2Zwc6Ujr2Jn3SecB0vO9uejSNbhe2g8H2406HyyVqoRKpAJTqWrEwEtLhIPVeABgu1
ARC-Seal: i=1; a=rsa-sha256; t=1520354641; cv=none;
        d=google.com; s=arc-20160816;
        b=jmuTuwTIkamSD4GOBPnk+UoxY/ZEWdzl50hfpHlcUJLEQzCXFVLiVqDNLlmGg8Orf0
         lM+OJelAXvSbia+eUbO6kGT5IFZ+bNHyZncAOluX6FO1mbJDIe16bGtajgs8mMYT5mdZ
         UAitO9maazVYbe9buWx1TUBkPWNQoX4/pnQvK9/TwrFitrTBnNU8D3UWb1KR9Im4UPmL
         4vCQTakiQHbvEGcHj2vUc6ZZgs+UQWk7zCKS3OjcwCIUw8hGeGKnIoS/CaI3SHxsnWEF
         S2MdgST/WhrWlubURYlHkTCPbP2E/JRriqJe3v16/zUi8W460b1JdxwEmxBRmkmHSej0
         16hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=4g2tgemF6Fy+C5t+Q4GrRBzWfpfHkMuxeQD/Df4lMPk=;
        b=eURqTdNHp3SCUoIeftjA6nU5mGIlDXvdZAWbKWXVi5ZQH+74v4c8KoGPXQM9FqDGUX
         B2xbD6/K0Z9FlaNtpEGebub6DDIcKLKjEPJIFeNHfv3uE2wpJrG63R+pi819/On6ULOr
         rLL2+2Sd/7yMjPvj5N3+DGXfhuUpj6ZLuAz0ry313iIDRPRFzu6B7AW37fiuAocaqc/E
         Eo8aF6aizd+MxY0I3p+ELdYn7GyKgdkK2kE7ZEK4YISOsFc+qICcSrO1vlWtb/H1/EAt
         mi+csviIseZKmhmuGves0o5gyjT3LC0UUe2H6r4jw9c5GYq7HNTurAHjhQsm1r4BbjZj
         B3qA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: linux-acpi@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
 linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
 hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com,
 catalin.marinas@arm.com, gregkh@linuxfoundation.org, mark.rutland@arm.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com,
 dietmar.eggemann@arm.com, morten.rasmussen@arm.com, palmer@sifive.com,
 lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org,
 tnowicki@caviumnetworks.com
Subject: Re: [PATCH v7 02/13] drivers: base: cacheinfo: setup DT cache
 properties early
To: Jeremy Linton <jeremy.linton@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-3-jeremy.linton@arm.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <67bdb642-292c-598a-496f-9d186c8a6705@arm.com>
Date: Tue, 6 Mar 2018 16:43:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228220619.6992-3-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684143739692917?=
X-GMAIL-MSGID: =?utf-8?q?1594207388655209917?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 28/02/18 22:06, Jeremy Linton wrote:
> The original intent in cacheinfo was that an architecture
> specific populate_cache_leaves() would probe the hardware
> and then cache_shared_cpu_map_setup() and
> cache_override_properties() would provide firmware help to
> extend/expand upon what was probed. Arm64 was really
> the only architecture that was working this way, and
> with the removal of most of the hardware probing logic it
> became clear that it was possible to simplify the logic a bit.
> 
> This patch combines the walk of the DT nodes with the
> code updating the cache size/line_size and nr_sets.
> cache_override_properties() (which was DT specific) is
> then removed. The result is that cacheinfo.of_node is
> no longer used as a temporary place to hold DT references
> for future calls that update cache properties. That change
> helps to clarify its one remaining use (matching
> cacheinfo nodes that represent shared caches) which
> will be used by the ACPI/PPTT code in the following patches.
> 

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
