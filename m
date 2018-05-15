Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526412759; cv=none;
        d=google.com; s=arc-20160816;
        b=RFbMjEDYahlNcyPYDFzXOD+DWKJuZWdhBpx8v3Zzl/8Xy/u+i97nM5StS6fkavaKhk
         NNQ3cHlCmrwtw/CozRl0udbnww5P0c7O/EmBNWtSl4i2Glstw0SC/56Cfj8N6S4sT97+
         0IUW9IIQKEUNH/pr2wom0xLek8TxkFqlq5UIqiJnDADFFMNzyYjRc15ZOLtUmJmsVV8p
         UnZ4DIdjEQvwLc5fwBLfpCv+oHHlNoTphnJw1rmC/3gZsBinNtHZRV8H4t3fhYR0w770
         rXx6PnOZxfrn9BZvotXMsxT6njgKUSXs1G6aKqjljRXSREEpY6Gw+wd9tZRalpTwsako
         kdqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=/sIGq869TDazuANExpZKq/BbjZ2VpUjjQPu6iuBBB3E=;
        b=MgHOwi9E972iP8uAQzJFvE2PeS686O31htsW8en3ST23ovsA+Nns9IP+V94qeit2Gx
         UcfxYp2FlDpgadJkPuPMpY+28ltABwIECSMId2eZu8ITiYT/hbF178Zvbnc+NM8PfTb9
         /h5cZdUAF2E27KrFye9k50SGVAppYFUFjz/U0bsp9yZge6TFVBli+Xw1Fai5NXkeS02a
         Zt/WDOiR7MvyMmp4gAMBcYGFHUqoIajuNL4eOEsxfV4WjWfWkk0KD/ZHpOPzOEo6PrER
         JbnAarFiozjBsQqxrpiVT1Olm1czeN8PRBfevOPwSb2Ek8GZFnrCVRUpG8RJXS357H0h
         bC5A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=H+1Nzbjl;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=H+1Nzbjl;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqvRte1ltxX0wLFwbWVsFXMRoLhaPqb6mZ0YYdCfp0qTA9y8inClRW9w3/wvZDPEOC3mRDn2dMlYHZ2zEbOvJw=
MIME-Version: 1.0
In-Reply-To: <78b08b68-ff57-8dd8-6eb1-00548f275eac@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com> <20180511235807.30834-3-jeremy.linton@arm.com>
 <78b08b68-ff57-8dd8-6eb1-00548f275eac@arm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 15 May 2018 22:32:37 +0300
Message-ID: <CAHp75VciOAMX1HWifZ+K9GiVicZRFrwHaGteJFVe1uFrh+qu0w@mail.gmail.com>
Subject: Re: [PATCH v9 02/12] drivers: base: cacheinfo: setup DT cache
 properties early
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>,
	linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org,
	Xiongfeng Wang <wangxiongfeng2@huawei.com>, vkilari@codeaurora.org,
	Al Stone <ahs3@redhat.com>, Dietmar.Eggemann@arm.com, Morten.Rasmussen@arm.com,
	Palmer Dabbelt <palmer@sifive.com>, Len Brown <lenb@kernel.org>, John Garry <john.garry@huawei.com>,
	austinwc@codeaurora.org, tnowicki@caviumnetworks.com, jhugo@codeaurora.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600214158032002659?=
X-GMAIL-MSGID: =?utf-8?q?1600559784772360119?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 8:15 PM, Jeremy Linton <jeremy.linton@arm.com> wrote:
> On 05/11/2018 06:57 PM, Jeremy Linton wrote:

>>   -     cache_size = of_get_property(this_leaf->of_node, propname, NULL);
>> +       cache_size = of_get_property(np, propname, NULL);
>>         if (cache_size)
>>                 this_leaf->size = of_read_number(cache_size, 1);

Can't you switch to of_read_property_uXX() variant here?

>> -               line_size = of_get_property(this_leaf->of_node, propname,
>> NULL);
>> +               line_size = of_get_property(np, propname, NULL);

Ditto.

>>   -     nr_sets = of_get_property(this_leaf->of_node, propname, NULL);
>> +       nr_sets = of_get_property(np, propname, NULL);
>>         if (nr_sets)
>>                 this_leaf->number_of_sets = of_read_number(nr_sets, 1);

Ditto.

-- 
With Best Regards,
Andy Shevchenko
