Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3795744-1520965890-2-11284104908403491694
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520965889; b=obFuG4Q22SajBbr9DpNyvAUFc2S4IBrosqiNcoUPerI89La
    2g355QHqHNMaoVIGO1Gxz7LJDRa+vgialHhQuyXczyna+B1tMmIy1omygrzFNP8Q
    njWpFc8dIQLyfz/20EDUcXpbGABEP9sOidflr//YD0KqdttMz62ZeLJSfYrucEza
    gg6Ol96oAI7U/9iGkj18+vQwq2xh1M3dGUtVCeAoqUx4D2KI10yjqeIfZsRtFQVs
    uNB5ndJBpJosEs74Qg8zS7VredL7xWy2nBblxOdfEXx0DFD9JLXxBTOnkkpZtI+m
    kzZPT+F3luWuXhX8n87v2UWyxqP8e0fzu4FCqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520965889; bh=V
    +CU0AXKcyGf458ck/vt3ZGSX3BBsl17bXlRlTuv7MU=; b=KRAKFtn9FbfjQwu1B
    pmpRc5h8Fn/q2Lb1KMnULHVN+AUQ22sOSg1Dw/iQwZBeOowJoPeAki0xFKi/KICq
    a5nuBJnwWYD6UXDhWjQV61KqTR9WRKmnfOLlhL1RtkRhtuoetCNr9KNWtZh9vN/t
    kmfLPYuQYftlHIHemPPNf3owi7PMTD34seMP5kZKkFhW+eDRqWQLgkWcMIZaAaZM
    A4lif9xX+Px0FIRZjYOmE8LOJ4OUX5gs8lX1i5exIUdR40rl5uy1vQTrZNbsKrs9
    8nd7o2cxrK3xYhy9dz5nIV6TbdR6+11qniGCydD0TqYiLkBT+W/ntp2oipM+hLR6
    BHxRg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 13 Mar 2018 18:31:16 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v3 6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_msg()
Message-ID: <20180313183116.GD20373@e107981-ln.cambridge.arm.com>
References: <20180306182128.23281-1-decui@microsoft.com>
 <20180306182128.23281-7-decui@microsoft.com>
 <20180307123441.GD15139@e107981-ln.cambridge.arm.com>
 <KL1P15301MB0006B22926A4DC338BFEB78DBFD80@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <SG2P15301MB00158D30D602950F05F8B14ABFD20@SG2P15301MB0015.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SG2P15301MB00158D30D602950F05F8B14ABFD20@SG2P15301MB0015.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: "'olaf@aepfle.de'" <olaf@aepfle.de>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
 "'jasowang@redhat.com'" <jasowang@redhat.com>,
 "'driverdev-devel@linuxdriverproject.org'"
 <driverdev-devel@linuxdriverproject.org>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'stable@vger.kernel.org'" <stable@vger.kernel.org>,
 'Jack Morgenstein' <jackm@mellanox.com>,
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 "'apw@canonical.com'" <apw@canonical.com>,
 "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>,
 "'bhelgaas@google.com'" <bhelgaas@google.com>,
 "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
 Haiyang Zhang <haiyangz@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 06:23:39PM +0000, Dexuan Cui wrote:
> > From: Dexuan Cui
> > Sent: Wednesday, March 7, 2018 13:40
> > To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: bhelgaas@google.com; linux-pci@vger.kernel.org; KY Srinivasan
> > <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> > olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com; linux-
> > kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.org; Haiyang
> > Zhang <haiyangz@microsoft.com>; vkuznets@redhat.com;
> > marcelo.cerri@canonical.com; Michael Kelley (EOSG)
> > <Michael.H.Kelley@microsoft.com>; stable@vger.kernel.org; Jack
> > Morgenstein <jackm@mellanox.com>
> > Subject: RE: [PATCH v3 6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_msg()
> > 
> > > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Sent: Wednesday, March 7, 2018 04:35
> > > On Tue, Mar 06, 2018 at 06:21:56PM +0000, Dexuan Cui wrote:
> > > > 1. With the patch "x86/vector/msi: Switch to global reservation mode"
> > > > (4900be8360), the recent v4.15 and newer kernels always hang for 1-vCPU
> > > > Hyper-V VM with SR-IOV. This is because when we reach
> > > hv_compose_msi_msg()
> > > > by request_irq()  -> request_threaded_irq() -> __setup_irq()->irq_startup()
> > > >  -> __irq_startup() -> irq_domain_activate_irq() -> ... ->
> > > > msi_domain_activate() -> ... -> hv_compose_msi_msg(), local irq is
> > > > disabled in __setup_irq().
> > > >
> > > > Fix this by polling the channel.
> > > >
> > > > 2. If the host is ejecting the VF device before we reach
> > > > hv_compose_msi_msg(), in a UP VM, we can hang in
> > hv_compose_msi_msg()
> > > > forever, because at this time the host doesn't respond to the
> > > > CREATE_INTERRUPT request. This issue also happens to old kernels like
> > > > v4.14, v4.13, etc.
> > >
> > > If you are fixing a problem you should report what commit you are fixing
> > > with a Fixes: tag and add a CC: stable@vger.kernel.org to the commit log
> > > to send it to stable kernels to which it should be applied; mentioning
> > > kernel versions in the commit log is useless and should be omitted.
> > 
> > Hi Lorenzo,
> > Thanks for your comments!
> > This patch does have a "Cc: stable@vger.kernel.org" in the sign-off area. :-)
> > 
> > Here the patch is made to resolve 2 issues:
> > #1 is triggered by the x86 global reservation mode (4900be8360) patch.
> > 4900be8360 in itself is good. It's just that drivers/pci/host/pci-hyperv.c
> > should be fixed.
> > 
> > #2 is a longstanding issue since the first day the pci-hyperv driver was
> > accepted into the kernel.
> > 
> > So IMO actually we don't really need to add a Fixes: tag, which is usually
> > used to specify a specific commit that introduces a bug that is being fixed.
> > 
> > > Side note: you should not have stable@vger.kernel.org in the email
> > > addresses CC list you are sending the patches to (you mark patches for
> > > stable by adding an appropriate CC tag in the commit log).
> > 
> > Sorry, I didn't know this, but actually I didn't add stable@vger.kernel.org
> > manually. Instead I used "git send-email" to send this patchset, and it told
> > me "The Cc list above has been expanded by additional addresses found
> > in the patch commit message."
> > 
> > I didn't find a way to disable this behavior of "git send-email" by checking
> > its manual and googling it. This is strange.
> > 
> > > Here:
> > >
> > > git.kernel.org/.../Documentation/process/stable-kernel-rules.rst
> > >
> > > Last but not least, most of the patches in this series do not justify
> > > sending them to stable kernels at all so you should remove the
> > > corresponding tag from the patches.
> > 
> > I hope at least these 2 patches can go into the stable kernels:
> > [PATCH v3 3/6] PCI: hv: serialize the present/eject work items
> > [PATCH v3 6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_msg()
> > Especially the second one, which fixes a real hang issue for UP virtual
> > machines running v4.15 and newer.
> > And,  IMO the patches are small enough (<100 lines) , but definitely
> > the maintainers make the final call.
> > 
> > >
> > > Thanks,
> > > Lorenzo
> > >
> > > > Fix this by polling the channel for the PCI_EJECT message and
> > > > hpdev->state, and by checking the PCI vendor ID.
> > > >
> > > > Note: actually the above issues also happen to a SMP VM, if
> > > > "hbus->hdev->channel->target_cpu == smp_processor_id()" is true.
> > > >
> > > > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > > > Tested-by: Adrian Suhov <v-adsuho@microsoft.com>
> > > > Tested-by: Chris Valean <v-chvale@microsoft.com>
> > > > Cc: stable@vger.kernel.org
> > > > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > > > Cc: K. Y. Srinivasan <kys@microsoft.com>
> > > > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > > > Cc: Jack Morgenstein <jackm@mellanox.com>
> > > > ---
> > > >  drivers/pci/host/pci-hyperv.c | 58
> > 
> > 
> > Thanks,
> > -- Dexuan
> 
> Hi Lorenzo, Bjorn, and all,
> Do you need more ACKs? Currently Michael and Haiyang reviewed and ack'd 
> the patchset.
> 
> Should I send a v4 that just removes the "CC: stable@vger.kernel.org" tag
> for patches 1, 2, 4 and 5? I tend to avoid a v4 as I supppose it would be 
> easier if you just remove the tags if you belive it's necessary (IMHO all the
> 6 paches are not big and it would be great if we can have all of them in 
> the old stable kernels, but I respect your decision).
> 
> Please let me know if I missed something when addressing the comments,
>  and if I should send a v4.

I will have a look tomorrow, thank you.

Lorenzo
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
