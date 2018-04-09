Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1388873-1523289931-2-17670727387093366965
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='ISO-8859-15', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523289930; b=XM4467jCW/Fz5oMdifsHY2OvYR0tOJSGZmSrnFDojzb6VkKXrJ
    S32IlypmU+uBoQemYUJlox1fzqlFqme6p6sgzHKwWJTep5JGt4xJbfapmdZPJpf0
    zUi60AZ0PDZK4J2gVszFKIYlm6T0RmQ7FhrPSmWmwNSj9BqTwgv9Tv1V7kl5cdex
    JPHs62XuLhY0cRRE+Ev2xyrqBDb7aRM6Wpaj7SjOwXd5q1NjcxbaS0ifDajsNnXr
    GY5eN+9zEgCo9WpCP9qLcnxNHnkdnUTnqUsoZkgTDPfMUAXX2lbBh0tnSdHbObwN
    SvP0lj23XnrgR9MhroUSV92+98nDKQy7SqNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523289930; bh=mO3/T
    YEC/qn5pblKgqmMzfRRlKgeICSc+eYmsx/tRuA=; b=n+TgVhhpY9+rlZ5n7mBle
    KWOxlMJt4bzbcQke23uPKqXDUYefpSq3VIMUNo/EMDWe8WR79AKbi/zlxPUaPb2L
    iYOT1wYQSZ3+89nmoAS9GkLt0oW2WLbCZotMQe60+iLRYtxV/K2Jebh2ZxMa5lXq
    Q4cVWCIKkayUzuo0ow/ZBAUcGevZAniLjnCyRoDHx8TIllHnRTnd4J/gBIyUP6Nm
    LkmfXe5gLqYlrcEP/DoEZgHzIgSAzqOE5/1r6voY0pK69WHi9e+bF98+IBCqwCTh
    BcBt2+mR5IgFmrocOOoPN1Asj9PGkXxxJ/C1UrM6cOgMjI1ZAXvGL6Zj8cKu7kMB
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=TRgzcmb8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=k5lm05Hw;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=TRgzcmb8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=k5lm05Hw;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNXWz7ABOha07NV+K67lgxFn+Rf4J8k36FQG7LTKpQoZr9rQhDUK6lTGqkJCubIV7YauMZ4RIlqRr9nVCDYQ8GT4KtS1UXEdRTegjF7fEpI0NSovjMMp
    a/qLr9uM5YoREc1QJIkX25IgB7haJXBqwoBVlVp49o7yf8L2mf1NZ93/S0pVL0cgUSKg+tFvRCRbBQJgAwblaEoVEuC08UeiZf1L+z6Sqmf5BXbz/MmM7arG
    VVM/tkfqlKOskDYFcaMHAA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=20KFwNOVAAAA:8 a=DDOyTI_5AAAA:8
    a=dqc-o_JxzUUwGzWqvPEA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+CjyhRcXgFdGR2Q42Nw/QwKcr8IW35ocUFHtpIK2/i336XOJ3ySwO4EPns1SaSjyxsW4O4Aw==
Date: Mon, 9 Apr 2018 12:05:20 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/3] resource: Use list_head to link resource
 sibling
In-Reply-To: <CAL_Jsq+xxa9ep2LK3H6YWhwrZtc-T73Y84ry6Hs-JJ3XEXoGsw@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1804091133330.28462@knanqh.ubzr>
References: <20180408024724.16812-1-bhe@redhat.com>
 <20180408024724.16812-2-bhe@redhat.com>
 <20180409090853.GJ19345@localhost.localdomain>
 <CAL_Jsq+xxa9ep2LK3H6YWhwrZtc-T73Y84ry6Hs-JJ3XEXoGsw@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Brijesh Singh <brijesh.singh@amd.com>, devicetree@vger.kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Wei Yang <richard.weiyang@gmail.com>, Keith Busch <keith.busch@intel.com>,
 Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
 Frank Rowand <frowand.list@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baoquan He <bhe@redhat.com>,
 linux-nvdimm@lists.01.org, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 linux-input@vger.kernel.org, Borislav Petkov <bp@suse.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 =?ISO-8859-15?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jonathan Derrick <jonathan.derrick@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 devel@linuxdriverproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 9 Apr 2018, Rob Herring wrote:

> +Nico who has been working on tinification of the kernel.
> 
> On Mon, Apr 9, 2018 at 4:08 AM, Baoquan He <bhe@redhat.com> wrote:
> > The struct resource uses singly linked list to link siblings. It's not
> > easy to do reverse iteration on sibling list. So replace it with list_head.
> 
> Why is reverse iteration needed?
> 
> > And code refactoring makes codes in kernel/resource.c more readable than
> > pointer operation.
> 
> resource_for_each_* helpers could solve that without the size increase.
> 
> > Besides, type of member variables of struct resource, sibling and child, are
> > changed from 'struct resource *' to 'struct list_head'. Kernel size will
> > increase because of those statically defined struct resource instances.
> 
> The DT struct device_node also has the same tree structure with
> parent, child, sibling pointers and converting to list_head had been
> on the todo list for a while. ACPI also has some tree walking
> functions (drivers/acpi/acpica/pstree.c). Perhaps there should be a
> common tree struct and helpers defined either on top of list_head or a
> new struct if that saves some size.
> 
> >
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> > v2->v3:
> >   Make sibling() and first_child() global so that they can be called
> >   out of kernel/resource.c to simplify code.
> 
> These should probably be inline functions. Or exported if not.
> 
> >
> >   Fix several code bugs found by kbuild test robot.
> >
> >   Got report from lkp that kernel size increased. It's on purpose since
> >   the type change of sibling and child inside struct resource{}. For
> >   each struct resource variable, it will cost another 16 bytes on x86 64.
> 
> The size increase should be mentioned in the commit log. More
> generally, the size increase is 2 pointers.

Tiny kernels have much fewer resources anyway, and usually run on 
platforms with 32-bit pointers, so this probably won't matter much in 
the end.

This is if reverse iteration is actually needed as you say though.
Unless I'm mistaken, resource iteration doesn't happen that often, and 
not in critical paths either.

Making the code clearer while keeping the same structure size could be 
considered with the help of llist.h instead.


Nicolas
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
