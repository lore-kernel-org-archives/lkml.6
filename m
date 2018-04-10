Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2640437-1523327660-5-11061113616599697021
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523327660; b=q/6AaMKlpPDwIgu8iIeDUQcLgEH/npgr/xVIOzqbkb7rGgSiJM
    EA6Y/UNQRbI2KpTgyeIwlaNagAiUObagPSpCA7c6nOCLktygNh2SSlCGrfyY37+P
    rgr5gd3RfVBBt7NKyWdQ/OnGW7glz/QTqJ4ltyPO3IkVfl4x5aiL68W1iiNyDafV
    1l5BdApvqjq7JT5nViPjBC+ymyBGEDg7O4POMGboxxy//+FYRCfubqRCVh3/9bSD
    W+RvymtM85EGIpLFDhQJpm3FEIOfidXlQZegbMpswY9NCPkXIR8sjpds1JUJrPSm
    CMCZXu2ugsSrij/l7MjmDdxicEdSSgZV8a3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523327660; bh=4nIHi
    5WTHFqV6C8CvpOyzqGTY2QsvrYPQfQBVKfgGN8=; b=SqnDepGxqKDBCc0bKb3VB
    xp+DmbGgFQ0+6f6SRKSSp/M2t6TPEJRmg6TQ76FO6hQwZBd/5UdOq9nBB63g+4EB
    6TOQ34S3yV41+T4jmjyYKBuIIYUNp54m4qF+fAWVo10SwuSGr3wm/c7ZZJnlpN4e
    vzb/1TQI4jp6OGcL9XaNA2ZKw4aZhpTaBXJ5c9Jb+TcB3hmCuCtQmNxm/WrT33Bq
    XhmVxi8zGUsYTdPebj8MmQ6FYNEYfHqx7VLkPm0nom3xyRDq3m9yAJMlly5Dc6V0
    lFlI+bJFlYdxaaqDAJwcsUsdzAtbg52pk4ZAwvzLfbP700qcTFa9hb46GvvQorwl
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=RPgpmh0R x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hW+zPdL+;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=RPgpmh0R x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hW+zPdL+;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPQaGsEM7Xg6KmAQc07KeLlPn1d12GBgTxgVnBzKP942gM+OivCQ/qoRxu/nAcb+3U3BKp/Ni3UGwxFjIP6QdqsD0qMuv0m43t5ZNuxXXkR3/C8DbebQ
    mAMzkQATjYw50ndFWtgOHUHxKoaA2gWl4OP8Xd+ujN8gi/lxmI5UlEq90bzAh8vZhxfp9CJ9DUpISXyJcmBNQpI1b7PyLLd/gnM9kPb2OXg9zw1vN0GLiVqU
    5r7aDEUPMZhq/akirccVBw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=20KFwNOVAAAA:8 a=DDOyTI_5AAAA:8
    a=-dFLKyz5dZBoEVE3x8kA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx480X+MYH/nH+008y04GCx7Z2KrLVHew303Mayc9u51z5/8VGLnsvNYtejXbKcy49F8WMBQOZZJprx2cXB9d/70=
MIME-Version: 1.0
In-Reply-To: <20180410021043.GC25724@localhost.localdomain>
References: <20180408024724.16812-1-bhe@redhat.com>
 <20180408024724.16812-2-bhe@redhat.com>
 <20180409090853.GJ19345@localhost.localdomain>
 <CAPcyv4huU32+oMeoF8-HmmctafZ_uOZN-v85O5M8Ka8pBXP+Lg@mail.gmail.com>
 <20180410021043.GC25724@localhost.localdomain>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 9 Apr 2018 19:34:09 -0700
Message-ID: <CAPcyv4gLrfq87FWP2f9n8YbP-XZ-uxuoc0nZu3LEW_bDxEAH_w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] resource: Use list_head to link resource sibling
To: Baoquan He <bhe@redhat.com>
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
Cc: Brijesh Singh <brijesh.singh@amd.com>,
 Device Tree <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>,
 Keith Busch <keith.busch@intel.com>,
 Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
 Frank Rowand <frowand.list@gmail.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, linux-input@vger.kernel.org,
 Borislav Petkov <bp@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Jonathan Derrick <jonathan.derrick@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 devel@linuxdriverproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 9, 2018 at 7:10 PM, Baoquan He <bhe@redhat.com> wrote:
> On 04/09/18 at 08:38am, Dan Williams wrote:
>> On Mon, Apr 9, 2018 at 2:08 AM, Baoquan He <bhe@redhat.com> wrote:
>> > The struct resource uses singly linked list to link siblings. It's not
>> > easy to do reverse iteration on sibling list. So replace it with list_head.
>> >
>> > And code refactoring makes codes in kernel/resource.c more readable than
>> > pointer operation.
>> >
>> > Besides, type of member variables of struct resource, sibling and child, are
>> > changed from 'struct resource *' to 'struct list_head'. Kernel size will
>> > increase because of those statically defined struct resource instances.
>> >
>> > Signed-off-by: Baoquan He <bhe@redhat.com>
>> > ---
>> [..]
>> > diff --git a/kernel/resource.c b/kernel/resource.c
>> > index e270b5048988..473c624606f9 100644
>> > --- a/kernel/resource.c
>> > +++ b/kernel/resource.c
>> > @@ -31,6 +31,8 @@ struct resource ioport_resource = {
>> >         .start  = 0,
>> >         .end    = IO_SPACE_LIMIT,
>> >         .flags  = IORESOURCE_IO,
>> > +       .sibling = LIST_HEAD_INIT(ioport_resource.sibling),
>> > +       .child  = LIST_HEAD_INIT(ioport_resource.child),
>> >  };
>> >  EXPORT_SYMBOL(ioport_resource);
>> >
>> > @@ -39,6 +41,8 @@ struct resource iomem_resource = {
>> >         .start  = 0,
>> >         .end    = -1,
>> >         .flags  = IORESOURCE_MEM,
>> > +       .sibling = LIST_HEAD_INIT(iomem_resource.sibling),
>> > +       .child  = LIST_HEAD_INIT(iomem_resource.child),
>> >  };
>> >  EXPORT_SYMBOL(iomem_resource);
>> >
>> > @@ -57,20 +61,32 @@ static DEFINE_RWLOCK(resource_lock);
>> >   * by boot mem after the system is up. So for reusing the resource entry
>> >   * we need to remember the resource.
>> >   */
>> > -static struct resource *bootmem_resource_free;
>> > +static struct list_head bootmem_resource_free = LIST_HEAD_INIT(bootmem_resource_free);
>> >  static DEFINE_SPINLOCK(bootmem_resource_lock);
>> >
>> > +struct resource *sibling(struct resource *res)
>> > +{
>> > +       if (res->parent && !list_is_last(&res->sibling, &res->parent->child))
>> > +               return list_next_entry(res, sibling);
>> > +       return NULL;
>> > +}
>> > +
>> > +struct resource *first_child(struct list_head *head)
>> > +{
>> > +       return list_first_entry_or_null(head, struct resource, sibling);
>> > +}
>> > +
>>
>> These names are too generic for new global symbols. A "resource_"
>> prefix is warranted.
>
> Thanks, sounds reasonable, will change them as resource_sibling() and
> resource_first_child(). Or res_sibling()/res_1st_child()?
>

resource_sibling() and resource_first_child()
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
