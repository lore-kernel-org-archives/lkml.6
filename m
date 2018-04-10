Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2579355-1523326259-2-6779895845558667259
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523326259; b=ZliCYuMJ30/WhC7yzAXJFJMYlZpjO/HyAAe6MFsJIJTOPbaREQ
    H2ewKYLtAmBgOZyar5MMoXZY3ZMZZX+o59LDthYWXWLaDp/Ob7rrjDfwooZZqGFI
    JdhCreg64cyPVC3jcB6RxTE+ZsykU/3giS35VZgHcxMsuhpzGKsRZae0cO6ITcaj
    VNwOGrzcI/ZeYM1Cg1hTMFH0EZ3iVUA3WBjh90o3LnkCWUiSb1XWYDH57O6MT0iP
    9iev5lXlXiljbY7lQ0g5ZHf57kc/j0ZqKcMEIxuwUdH6WHHlQOdRp+imzvghdtbF
    vQwcQ44RmgCiob3grGWf7UdNTJykdk2nmtYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523326259; bh=32KAK
    dB0xuoaw4Rx8hF4aygwEZM6GkSx2pKz8B/YNIg=; b=ZSrx/j9vPauOlsYRCj4f1
    s2E36IYxEv0oltbOdCEMEjN0UOM/5cf20wxBesIt8rjjFbsT+i3oNMn0GDItjZ0Q
    iHnixFJ1z4bELPn0MS9bZgZgyCkS4N7vPDp1j9yzh1p8gX6KPhXwG1h1TIVGNojX
    lkK/EFtCXdi/9icicHtwDc14w09ttiGjrxEJ8ijn01GY8aneTN0Pty22lHGAPWW4
    eMVZDSQWiYOskVPtFNEoRLqSKg8gkIH0XXH6TvsonmAb842Z51iY/xTFZ8pTRoQ0
    qi7GD+XPnAIW6+Vr3SayER2Ppm26gePInSUGdmNPeFgfskfQqSHpPGtIxtS/x4Ya
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCcPwnBp8OSHy7xbq4eMDAvMR/gT6+LmBpxgmChsJmIfDDnuNcq7QwmVvABx7C2r4bLw1B353Al970CvAql9VJsGRIwWYdON5m8H/GPNBhHPSsd8CM/8
    bmmSvtK0cjsVw+CS1jrBrrAH+6PMTeGIbWpi1LVmq5jnzuPe5CLytSSO1Zwv6YU+ZzSR+K5RRqvh76TmxHbRAajcRI06W9OKpzl0k3R4i8dc94UOO3I8V1gq
    w95PSVwtuJHgRQ35iGIi0Q==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=20KFwNOVAAAA:8 a=DDOyTI_5AAAA:8
    a=4VFYWwbRFt5eAjreYpkA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 10 Apr 2018 10:10:43 +0800
From: Baoquan He <bhe@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 1/3] resource: Use list_head to link resource sibling
Message-ID: <20180410021043.GC25724@localhost.localdomain>
References: <20180408024724.16812-1-bhe@redhat.com>
 <20180408024724.16812-2-bhe@redhat.com>
 <20180409090853.GJ19345@localhost.localdomain>
 <CAPcyv4huU32+oMeoF8-HmmctafZ_uOZN-v85O5M8Ka8pBXP+Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4huU32+oMeoF8-HmmctafZ_uOZN-v85O5M8Ka8pBXP+Lg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
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
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
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

On 04/09/18 at 08:38am, Dan Williams wrote:
> On Mon, Apr 9, 2018 at 2:08 AM, Baoquan He <bhe@redhat.com> wrote:
> > The struct resource uses singly linked list to link siblings. It's not
> > easy to do reverse iteration on sibling list. So replace it with list_head.
> >
> > And code refactoring makes codes in kernel/resource.c more readable than
> > pointer operation.
> >
> > Besides, type of member variables of struct resource, sibling and child, are
> > changed from 'struct resource *' to 'struct list_head'. Kernel size will
> > increase because of those statically defined struct resource instances.
> >
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> [..]
> > diff --git a/kernel/resource.c b/kernel/resource.c
> > index e270b5048988..473c624606f9 100644
> > --- a/kernel/resource.c
> > +++ b/kernel/resource.c
> > @@ -31,6 +31,8 @@ struct resource ioport_resource = {
> >         .start  = 0,
> >         .end    = IO_SPACE_LIMIT,
> >         .flags  = IORESOURCE_IO,
> > +       .sibling = LIST_HEAD_INIT(ioport_resource.sibling),
> > +       .child  = LIST_HEAD_INIT(ioport_resource.child),
> >  };
> >  EXPORT_SYMBOL(ioport_resource);
> >
> > @@ -39,6 +41,8 @@ struct resource iomem_resource = {
> >         .start  = 0,
> >         .end    = -1,
> >         .flags  = IORESOURCE_MEM,
> > +       .sibling = LIST_HEAD_INIT(iomem_resource.sibling),
> > +       .child  = LIST_HEAD_INIT(iomem_resource.child),
> >  };
> >  EXPORT_SYMBOL(iomem_resource);
> >
> > @@ -57,20 +61,32 @@ static DEFINE_RWLOCK(resource_lock);
> >   * by boot mem after the system is up. So for reusing the resource entry
> >   * we need to remember the resource.
> >   */
> > -static struct resource *bootmem_resource_free;
> > +static struct list_head bootmem_resource_free = LIST_HEAD_INIT(bootmem_resource_free);
> >  static DEFINE_SPINLOCK(bootmem_resource_lock);
> >
> > +struct resource *sibling(struct resource *res)
> > +{
> > +       if (res->parent && !list_is_last(&res->sibling, &res->parent->child))
> > +               return list_next_entry(res, sibling);
> > +       return NULL;
> > +}
> > +
> > +struct resource *first_child(struct list_head *head)
> > +{
> > +       return list_first_entry_or_null(head, struct resource, sibling);
> > +}
> > +
> 
> These names are too generic for new global symbols. A "resource_"
> prefix is warranted.

Thanks, sounds reasonable, will change them as resource_sibling() and
resource_first_child(). Or res_sibling()/res_1st_child()?

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
