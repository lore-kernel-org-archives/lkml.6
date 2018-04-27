Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AB8JxZp1lHA2Pv1fDcFU4C19LnCugCBZQOpJsHawgQP1h3feWGtm7XhTCZEUegunqVhnrlwN35Sd
ARC-Seal: i=1; a=rsa-sha256; t=1524834504; cv=none;
        d=google.com; s=arc-20160816;
        b=r5ZmEb4C1YBOLLFaqIQtKWJodIzFeUC8e6vhnKZORCyJJwUL8Y7T/eroklXyZLXjOQ
         vu9gGp0oU0IlyUmbkmNI0qCE2I3sJZ0b4gNxtY+vj686xXp/mGqiCl6dtrW0XWLh4PFg
         Z4K4Xvs/67SmKTQ5NS/Of3hQCQjnY4n2zj4IMuRjdKjBGtfUGTsAqRsi4VEhbdsbVymi
         Bcn5rED+qlKyJS3y0gk3eZZh1z/HdN/oFsjJzBYnlOPYwEZYTeYvY+HcKWSgSPykCMqK
         8+zCnMWSwnJXfwWlib0QbsWm+JtUCwcWAeT0wtPt+GPQRJCzSMksYGhlb8hgPBVbFqUX
         fWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=6GywujpK0ygida3h+fooLjal6P4GXk1GW0g6RyM/RPM=;
        b=SD4IvNSnRii3VVkzrBO523zjGHTIEZYIuyFsB4LmNTD+QPJ8RNPH5N+56Z/8Yut1RO
         f6Jc0iORt8Weg349ey5/k7JqDymVDlMqmgWGZ0k2TwN9T7xOFAL8I2Wnu37qiVgexURx
         iMDBTdD0a7BhBXhFLifVkvaolpLdMknRP5SWw9iu7MTQRdqI3ST+SHu4tb90rLzR2//v
         ISTOqITZwykDe86KwlVUNJGFTBDLqYGkye3t/k/grlp7aAHTrAVZz9biCEUF0lEGZad2
         wf33L9/fyniOPbtr45YlW3rFJ+MZmJHy+ZvXn50ogyoDX4zqhjqps2AMqKAdhQTxEcIt
         7X1g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 linux-arm-kernel@lists.infradead.org, Lorenzo.Pieralisi@arm.com,
 hanjun.guo@linaro.org, rjw@rjwysocki.net, Will.Deacon@arm.com,
 Catalin.Marinas@arm.com, gregkh@linuxfoundation.org, Mark.Rutland@arm.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com,
 Dietmar.Eggemann@arm.com, Morten.Rasmussen@arm.com, palmer@sifive.com,
 lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org,
 tnowicki@caviumnetworks.com, jhugo@qti.qualcomm.com, timur@qti.qualcomm.com,
 ard.biesheuvel@linaro.org
Subject: Re: [PATCH v8 04/13] arm64/acpi: Create arch specific cpu to acpi id
 helper
To: Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-5-jeremy.linton@arm.com>
 <16324b54-42d4-d9bc-6d57-de52431dc209@arm.com>
 <ee956bd3-37d7-b9ac-af55-dc297397476d@arm.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <a00dd78c-6e94-26a2-1515-c677a032e6ce@arm.com>
Date: Fri, 27 Apr 2018 14:08:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ee956bd3-37d7-b9ac-af55-dc297397476d@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766316038693524?=
X-GMAIL-MSGID: =?utf-8?q?1598904864607146892?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 26/04/18 19:33, Jeremy Linton wrote:
> Hi,
> 
> On 04/26/2018 05:27 AM, Sudeep Holla wrote:
>>
>>
>> On 26/04/18 00:31, Jeremy Linton wrote:
>>> Its helpful to be able to lookup the acpi_processor_id associated
>>> with a logical cpu. Provide an arm64 helper to do this.
>>>
>>
>> As I pointed out in the earlier version, this patch is not required.
>> The acpi_id stored in the acpi_processor can be used for this.
>> Won't the below change make it work ? I can't think of any reason why it
>> shouldn't.
> 
> So, I only noticed your previous email last night on the mail archive,
> as I was applying your review/ack tags and couldn't find a response for
> this patch, seem the spam/etc filters need some further tweaking!
>

Ah that's bad.

> At that point, I was pretty sure the suggestion wasn't going to work out
> of the box as a lot of this code is running fairly early in the boot
> process. I spent a bit of time and plugged the change in to verify that
> assertion, and yes the per_cpu processor/acpi bits aren't setup early
> enough to be used by much of this code. It is being called from
> init_cpu_topology()/smp_prepare_cpus() which precedes
> do_basic_setup/do_initcalls() which is what runs the acpi_init()
> sequence which ends up eventually allocating the required data
> structures. So without restructuring the core boot sequence, this seems
> like a reasonable solution.
> 

OK makes sense. I completely ignored topology related patches as I
haven't looked at them yet and assumed cacheinfo is the only user. Sorry
for that.

-- 
Regards,
Sudeep
