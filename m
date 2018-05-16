Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AB8JxZpB6je7+p7ExePvv6k5H/G2I8lgghLMDuE1vKtavlfN6AoW/Ljdkci3mfZ1ymG7tT13Mc5v
ARC-Seal: i=1; a=rsa-sha256; t=1526468194; cv=none;
        d=google.com; s=arc-20160816;
        b=t8LDHyLAkQfv4QbnING+vMFqlBklQN/2xH+n+jLJJN/2p7IszNuZ+nrqp2KDp396E4
         Ihibrtd492BqkG5GVSJHBVLrDpY3baKwxqCoKNLezPjzq4Ra1pf5SYOijuxdTbjVv/33
         24TZaqTaKpbAFIJQ8mjCQuZE9X1ZQfP4vO6nutfTDrjl+ugkUmkm9G9Obqlwy/k3pIH0
         FJo0Q8OjHXsL9F3A8YOLv3hv6xWJsDSSjK1qCy8idUO1MImo6G+XjEtVLGzdyi6/C4ra
         3gHYuJcswKZ8bPlonK2BqOudbYR2/A2P59+4VqoCNd+spxxRn5kMPpKdUW00IfJLU66w
         uVvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=QVrRNlTSkgsq4MZwgMIAprBiiH0u08p3MEgViYdIbUU=;
        b=So46Rxo52XSfTIEYihkTXyi1nZKmRjjOpqtf1WX+PccynuPiWyf2x+ee8DDWXyUq4w
         gUayZLyYwYYl/5wHUxTN2WKuovjavOa98dX/Fic1hmcIp1AUL5YYCcjG3Imkm/irEHPc
         nvESO/f0+2I1lgBLvC0/O37b8tqVttUyfOMyFvfDy5WoUt8QNs06jX6eqampW/PDDFUU
         4QH63n3/QBA7CQ7wrYGW1EPvGulePEykYIPvuOutgAzSnvb0ur0S7kth/e4bZmyeeh4i
         xu+OtvCXXCnlLQ82E9Zh1c28/8c7vjjru2gIFY/njacJbGq77n+rnq+CvBSs6LkCTC8N
         jbag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Will Deacon <Will.Deacon@arm.com>, Catalin Marinas
 <Catalin.Marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Rutland <Mark.Rutland@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv@lists.infradead.org, Xiongfeng Wang <wangxiongfeng2@huawei.com>,
 vkilari@codeaurora.org, Al Stone <ahs3@redhat.com>,
 Dietmar.Eggemann@arm.com, Morten.Rasmussen@arm.com,
 Palmer Dabbelt <palmer@sifive.com>, Len Brown <lenb@kernel.org>,
 John Garry <john.garry@huawei.com>, austinwc@codeaurora.org,
 tnowicki@caviumnetworks.com, jhugo@codeaurora.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v9 02/12] drivers: base: cacheinfo: setup DT cache
 properties early
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Jeremy Linton <jeremy.linton@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180511235807.30834-3-jeremy.linton@arm.com>
 <78b08b68-ff57-8dd8-6eb1-00548f275eac@arm.com>
 <CAHp75VciOAMX1HWifZ+K9GiVicZRFrwHaGteJFVe1uFrh+qu0w@mail.gmail.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <a64ed431-0f60-2711-4138-eeefc7ba2d8b@arm.com>
Date: Wed, 16 May 2018 11:56:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VciOAMX1HWifZ+K9GiVicZRFrwHaGteJFVe1uFrh+qu0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600214158032002659?=
X-GMAIL-MSGID: =?utf-8?q?1600617913409788098?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Andy,

On 15/05/18 20:32, Andy Shevchenko wrote:
> On Tue, May 15, 2018 at 8:15 PM, Jeremy Linton <jeremy.linton@arm.com> wrote:
>> On 05/11/2018 06:57 PM, Jeremy Linton wrote:
> 
>>>   -     cache_size = of_get_property(this_leaf->of_node, propname, NULL);
>>> +       cache_size = of_get_property(np, propname, NULL);
>>>         if (cache_size)
>>>                 this_leaf->size = of_read_number(cache_size, 1);
> 
> Can't you switch to of_read_property_uXX() variant here?
> 

This patch is just changing the first argument to the calls. So if we
need to change, it has to be separate patch.

Now, we can use of_property_read_u64() but is there any particular
reason you mention that ? One reason I can see is that we can avoid
making explicit of_get_property call. Just wanted to the motive before I
can write the patch.

-- 
Regards,
Sudeep
