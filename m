Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-311249-1525674782-2-13447509503409560980
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525674782; b=IaCAHJmw8GGHHd/xzHrkzR/n1anhxWAkDc57ig/gjYlimi6LS8
    9ALNkwJ14ALZV+xGikukC24cY0ZuVCP9ouhTETVKYWhW8z4UvS+75aKhS4Z1sR9m
    YaCx1UENMOmQSMQ1rt9lLmnESz0KnwOwuE+CPXCEuIxevOQiaq+ypYb7nPNycWPY
    AO4jqkX2GBbzl1zBuYx/S72BC5ozODAvdvTZR9mLlv6nVpfyL+/vFvBSZDy81K9/
    Yz3g4QADl1Df23/z9O5v4Uf9/hfggDQFbr1h+pA3y+5N/wEGXtS0oEWQ70FqoQr2
    ZxainQZ2pR9zOLGVI9IBuVR3mf/IxY4SCGfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525674782; bh=ccD8E
    7hYnud8/CNH56OnyquvVixP82OkstKhLbPdSAM=; b=MOF7Yvh4wXwIumSVSWTgf
    UPThbrhfpxCCHOGxag7ZtyjXY3bnBGVbKN9i+wI0HoLdzoVkDlG77Fr3RzUFyq7q
    dkiPT01yg2taT5w9s1uk+qsiJrpu19e2IvtgwFqqD47YTUulHJvjgP/yEuUHCy5E
    cHu07CQ04rE539eRygVjIDxw5iL50dxMRl0gtEsjgZOYufSga2M5i74Atm5SoqH5
    aqYxxGFT9KCd1GbqLN8Uxq7m+eUr3h3X/bgs3Qgis0e9CF7yO24/oXiDrSP5MJ2u
    YIOYrL47Cj82PlpauP1t3cZDZQN+gP+bc/ImaYZrP6xifJS70Mwn0PMVBmrPPAGM
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=redhat.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=redhat.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFi5U2e05qm7Z5LA8cB4ywIW42WdKJCLW0pfABCk2eQwRtP2lTkfHQ0s3Lq3Vt8Tt0LiswQRfMdIz8Pdw7SV1CzTJla+GpyoUQN5QeJ//SVm0/BOl7Pb
    WHOF0ptVaUs2G/mFKUg2ypJdbjo+HguV011KOUrB4lLOuBPvrYpbJLUwYzzJpIBcX+hDFP/pvrmzevd/mr+IjZhLrpXo3ys61hQB4ykelA1grDpFVVjgu0GF
    61iHtGhkrC04jN/DaaQ3GQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
    a=D19gQVrFAAAA:8 a=DDOyTI_5AAAA:8 a=dLq7eA-5A1Ghy2zlNLMA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=W4TVW4IDbPiebHqcZpNg:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 robh+dt@kernel.org, dan.j.williams@intel.com, nicolas.pitre@linaro.org,
 josh@joshtriplett.org, fengguang.wu@intel.com, bp@suse.de
Subject: [PATCH v4 0/3] resource: Use list_head to link sibling resource
Date: Mon,  7 May 2018 14:32:21 +0800
Message-Id: <20180507063224.24229-1-bhe@redhat.com>
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
Cc: brijesh.singh@amd.com, devicetree@vger.kernel.org, airlied@linux.ie,
 linux-pci@vger.kernel.org, richard.weiyang@gmail.com, keith.busch@intel.com,
 jcmvbkbc@gmail.com, baiyaowei@cmss.chinamobile.com, frowand.list@gmail.com,
 lorenzo.pieralisi@arm.com, sthemmin@microsoft.com, Baoquan He <bhe@redhat.com>,
 linux-nvdimm@lists.01.org, patrik.r.jakobsson@gmail.com,
 linux-input@vger.kernel.org, gustavo@padovan.org, dyoung@redhat.com,
 vgoyal@redhat.com, thomas.lendacky@amd.com, haiyangz@microsoft.com,
 maarten.lankhorst@linux.intel.com, jglisse@redhat.com, seanpaul@chromium.org,
 bhelgaas@google.com, tglx@linutronix.de, yinghai@kernel.org,
 jonathan.derrick@intel.com, chris@zankel.net, monstr@monstr.eu,
 linux-parisc@vger.kernel.org, gregkh@linuxfoundation.org,
 dmitry.torokhov@gmail.com, kexec@lists.infradead.org, ebiederm@xmission.com,
 devel@linuxdriverproject.org, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patchset is doing:
1) Replace struct resource's sibling list from singly linked list to
list_head. Clearing out those pointer operation within singly linked
list for better code readability.
2) Based on list_head replacement, add a new function
walk_system_ram_res_rev() which can does reversed iteration on
iomem_resource's siblings.
3) Change kexec_file loading to search system RAM top down for kernel
loadin, using walk_system_ram_res_rev().

Note:
This patchset passed testing on my kvm guest, x86_64 arch with network
enabling. The thing we need pay attetion to is that a root resource's
child member need be initialized specifically with LIST_HEAD_INIT() if
statically defined or INIT_LIST_HEAD() for dynamically definition. Here
Just like we do for iomem_resource/ioport_resource, or the change in
get_pci_domain_busn_res().


Links of the old posting(Boris pointed out that we should use
https://lkml.kernel.org/r/Message-ID, while it can't be opened from
my side, so paste all of them here.):
v3:
https://lkml.kernel.org/r/20180419001848.3041-1-bhe@redhat.com
https://lkml.org/lkml/2018/4/18/767

v2:
https://lkml.kernel.org/r/20180408024724.16812-1-bhe@redhat.com
https://lkml.org/lkml/2018/4/7/169

v1:
https://lkml.kernel.org/r/20180322033722.9279-1-bhe@redhat.com
https://lkml.org/lkml/2018/3/21/952

Changelog:
v3->v4:
  Fix several bugs test robot reported. Rewrite cover letter and patch
  log according to reviewer's comment.

v2->v3:
  Rename resource functions first_child() and sibling() to
  resource_first_chils() and resource_sibling(). Dan suggested this.

  Move resource_first_chils() and resource_sibling() to linux/ioport.h
  and make them as inline function. Rob suggested this. Accordingly add
  linux/list.h including in linux/ioport.h, please help review if this
  bring efficiency degradation or code redundancy.

  The change on struct resource {} bring two pointers of size increase,
  mention this in git log to make it more specifically, Rob suggested
  this.

v1->v2:
  Use list_head instead to link resource siblings. This is suggested by
  Andrew.

  Rewrite walk_system_ram_res_rev() after list_head is taken to link
  resouce siblings.

Baoquan He (3):
  resource: Use list_head to link sibling resource
  resource: add walk_system_ram_res_rev()
  kexec_file: Load kernel at top of system RAM if required

 arch/microblaze/pci/pci-common.c            |  31 ++--
 arch/sparc/kernel/ioport.c                  |   2 +-
 arch/xtensa/include/asm/pci-bridge.h        |   4 +-
 drivers/eisa/eisa-bus.c                     |   2 +
 drivers/gpu/drm/drm_memory.c                |   3 +-
 drivers/gpu/drm/gma500/gtt.c                |   5 +-
 drivers/hv/vmbus_drv.c                      |  52 +++----
 drivers/input/joystick/iforce/iforce-main.c |   4 +-
 drivers/nvdimm/e820.c                       |   2 +-
 drivers/nvdimm/namespace_devs.c             |   6 +-
 drivers/nvdimm/nd.h                         |   5 +-
 drivers/of/address.c                        |   4 +-
 drivers/parisc/lba_pci.c                    |   4 +-
 drivers/pci/host/vmd.c                      |   8 +-
 drivers/pci/probe.c                         |   2 +
 drivers/pci/setup-bus.c                     |   2 +-
 include/linux/ioport.h                      |  20 ++-
 kernel/kexec_file.c                         |   2 +
 kernel/resource.c                           | 221 ++++++++++++++++------------
 19 files changed, 215 insertions(+), 164 deletions(-)

-- 
2.13.6

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
