Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-311249-1525674832-8-580403766123501307
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525674832; b=iTJOfAqcT4H6Ry2T9XU4fdjI7kKaXrEdf8EkQFlquRCi3jc6P3
    ng5FwtcKn3gl43EsLG+jyPRjxR+STU4D9WesZrw00lK8CZdMsXodv+jcaHup5Xey
    SVznIZUGjyUbUyLVUpH3ONllPjRA8JNG4OwwwPhZnAEQ66wp0Lr3VHu/OaV2O9Wk
    PIaV7aNQdmIWC1kHdyUA08uRxyJ/GhRlR7PyPfyNUcpw1gLWTMIc7sPbYpU6gm7N
    0Pop8JnuM72ChsinIftGIftUIuSoB7DuPuiakHfx+LpMEYotw7EWzjHmX+xe8aDD
    1TFzhMykDvCOAws+1E3gK3Q0sKc8wbT6mp1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525674832; bh=KFi3G
    8bFI5wz56xDR7iCemxSkpOwTLTe1f5JMPF2WDk=; b=cpj4osm5NIdPpAS0APCe1
    no+mhcGwtZxIkUOhYlLKxoxocqNSPCcCOqq1FRGadSgIASjXOnWJjLeqd5inNPnH
    pbctpLkVNsiBZ3a4e89cBnQE+idw/qyk59FCZmJuU057M/2B35mT3VCfP8IJNJ3l
    wlTcyq8RcU3yEEE6IahTyFh7JYtu0173QS/PmglYryQ4u4PkZ4kjhMjSF5bmrL+V
    wCiCdQvy8GOmRHgnPtTOEHdN7Z6UuqE/rQYtgUbiJhiwHiAiMfCUJ20ezrscFKGN
    AKNsr2SfmK/e4uVvfyJh0phD31gKnksvJ4naIPPSjByrHluWW5OtdL3arng0PkaK
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=redhat.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=redhat.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLzW6Suy+Guus40hYAL7Ed9yejWYP5P/RrXi/0Kakn+VvcIfy3hTuGVT+kXSWmUZcIA0Vq9aTG3V5MTEMK1vtTosyu2viWblkDdEqIQVS8CMEcW80CKt
    Kij+rr9wp+gMv6KLsTf+l7LFUQ47eSfiY6ILwsEVA6y2TJvijndiG9UFQvOQmReeJGTOCHOh63h9q1G3qjceS+k7XPeE5VWdwUCnyX6qEERx/QEEfTdv3glA
    iSBSXbd1SQOkfAkBSSNGIw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=20KFwNOVAAAA:8 a=PtDNVHqPAAAA:8
    a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=GyvjMoo1nnRyjdH4L1YA:9 a=CjuIK1q_8ugA:10 a=BpimnaHY1jUKGyF_4-AF:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 robh+dt@kernel.org, dan.j.williams@intel.com, nicolas.pitre@linaro.org,
 josh@joshtriplett.org, fengguang.wu@intel.com, bp@suse.de
Subject: [PATCH v4 3/3] kexec_file: Load kernel at top of system RAM if
 required
Date: Mon,  7 May 2018 14:32:24 +0800
Message-Id: <20180507063224.24229-4-bhe@redhat.com>
In-Reply-To: <20180507063224.24229-1-bhe@redhat.com>
References: <20180507063224.24229-1-bhe@redhat.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For kexec_file loading, if kexec_buf.top_down is 'true', the memory which
is used to load kernel/initrd/purgatory is supposed to be allocated from
top to down. This is what we have been doing all along in the old kexec
loading interface and the kexec loading is still default setting in some
distributions. However, the current kexec_file loading interface doesn't
do likt this. The function arch_kexec_walk_mem() it calls ignores checking
kexec_buf.top_down, but calls walk_system_ram_res() directly to go through
all resources of System RAM from bottom to up, to try to find memory region
which can contain the specific kexec buffer, then call locate_mem_hole_callback()
to allocate memory in that found memory region from top to down. This brings
confusion especially when KASLR is widely supported , users have to make clear
why kexec/kdump kernel loading position is different between these two
interfaces in order to exclude unnecessary noises. Hence these two interfaces
need be unified on behaviour.

Here add checking if kexec_buf.top_down is 'true' in arch_kexec_walk_mem(),
if yes, call the newly added walk_system_ram_res_rev() to find memory region
from top to down to load kernel.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: kexec@lists.infradead.org
---
 kernel/kexec_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 75d8e7cf040e..7a66d9d5a534 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -518,6 +518,8 @@ int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
 					   IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
 					   crashk_res.start, crashk_res.end,
 					   kbuf, func);
+	else if (kbuf->top_down)
+		return walk_system_ram_res_rev(0, ULONG_MAX, kbuf, func);
 	else
 		return walk_system_ram_res(0, ULONG_MAX, kbuf, func);
 }
-- 
2.13.6

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
