Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526680209; cv=none;
        d=google.com; s=arc-20160816;
        b=trPrnMTf1NfJUYg0kuEWKBdYrnY1T0Ghpp9y2YGIRORDwezTOjZgZJFqvIgiMF+suJ
         nzzS4Gp8f0/VpC6AHxq+rlc962c/H9xVCiIC7ItoIA/t+RkKswQn7Sy9T0m9bm7RIyOg
         G8i4nvTJPbM6ApEhjhKXbt3eYyX4FqzWP3IuXA+9vQDcvZy11YgKH1g93Kqik4C+FZWN
         FaO3EA9gNbde5Ap4QcqqzAusI+M/uZRZP7JN/vX/RIuOOowew9TIqGg+wB9e6jdFlH7Y
         HiJJDv2AYZ2fWjiGkc2RTILh/wC9iId46S5wzSLBHt9WjFqJIcrSYu67hHvMDxFN5NK5
         1WBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=LfII10dLb2cZTLNPZhGKZrKhgeibac5vXM0NapjNoEI=;
        b=gWYetqRL59wKInmsXYs13uow+AQq/U75AgSqWdBA0TnbaKR6mdjTiyByU5nhTGJ81D
         OKDkc+KXigUPpkGhORNLVrZZkdE5r35jrOZX/pAXjTr6vCQpheoUxObBdlBJaaa6IYgy
         rFdMlFWziISUw3k98k80XX+LyHLTW8Aj2GFTEc1Ks+uzv0ZQPstkxBSa+HLSu/K6w8IF
         P0MoOTqHJJNEau/3EXT5dWdERPcd70UGzAyoo1DvfAD48gCE/QzvVcZAX9QYZDXCyZJG
         qcSY6gsm83KssK0oMVRqP0mYnQsJcf1cxOPjG/ZhErHnpwPG+2uc2eke4bh1tsGexRNS
         eWLw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=llxDS5eF;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=llxDS5eF;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZoJvIZ6Z2JoFktAabVQa47rtbf+jomsE5uIbqk/DIpAvyGwLiEv7aDekGyT9KSb4aJkyw6j1WvQ5d06A1DLFxQ=
MIME-Version: 1.0
In-Reply-To: <20180517154701.GA20281@e107155-lin>
References: <20180511235807.30834-1-jeremy.linton@arm.com> <20180511235807.30834-3-jeremy.linton@arm.com>
 <78b08b68-ff57-8dd8-6eb1-00548f275eac@arm.com> <CAHp75VciOAMX1HWifZ+K9GiVicZRFrwHaGteJFVe1uFrh+qu0w@mail.gmail.com>
 <a64ed431-0f60-2711-4138-eeefc7ba2d8b@arm.com> <20180517154701.GA20281@e107155-lin>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 19 May 2018 00:50:08 +0300
Message-ID: <CAHp75VfEYcPdECmDDOd8CLBBXGpcwSUGQRr0x8VTb1-7j51_0Q@mail.gmail.com>
Subject: Re: [PATCH v9 02/12] drivers: base: cacheinfo: setup DT cache
 properties early
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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
X-GMAIL-MSGID: =?utf-8?q?1600840227692504171?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 17, 2018 at 6:47 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

> Is below patch does what you were looking for ?

Somewhat.
See below for some minors.

> of_property_read_u64 searches for a property in a device node and read
> a 64-bit value from it. Instead of using of_get_property to get the
> property and then read 64-bit value using of_read_number, we can make
> use of of_property_read_u64.

Suggested-by?

> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>


> -       cache_size = of_get_property(np, propname, NULL);
> -       if (cache_size)
> -               this_leaf->size = of_read_number(cache_size, 1);
> +       if (!of_property_read_u64(np, propname, &cache_size))
> +               this_leaf->size = cache_size;

I suppose it's something like this

ret = of_property_...(..., &this_leaf->VAR);
if (ret)
 warning / set default / etc

>                 propname = cache_type_info[ct_idx].line_size_props[i];
> -               line_size = of_get_property(np, propname, NULL);
> -               if (line_size)
> +               line_size = of_property_read_u64(np, propname, &line_size);
> +               if (line_size) {

ret = ...
if (ret) {

> +                       this_leaf->coherency_line_size = line_size;
>                         break;
> +               }

> +       if (!of_property_read_u64(np, propname, &nr_sets))
> +               this_leaf->number_of_sets = nr_sets;

As in first case.

-- 
With Best Regards,
Andy Shevchenko
