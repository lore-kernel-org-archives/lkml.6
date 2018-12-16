Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB127C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDAF62084D
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbeLPX60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 18:58:26 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:53101 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730719AbeLPX6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 18:58:25 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gYgIZ-0006n2-0l; Sun, 16 Dec 2018 23:58:15 +0000
Message-ID: <1545004693.19315.66.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 00/88] 4.4.168-stable review
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Date:   Sun, 16 Dec 2018 23:58:13 +0000
In-Reply-To: <c5862b36-beae-4810-fb33-4b646e96378b@roeck-us.net>
References: <20181214115702.151309521@linuxfoundation.org>
         <dfd49bfd-359a-7f5e-8332-5e6ad6da21cd@roeck-us.net>
         <20181215080729.GG10074@kroah.com>
         <c5862b36-beae-4810-fb33-4b646e96378b@roeck-us.net>
Organization: Codethink Ltd.
Content-Type: multipart/mixed; boundary="=-kROQblllK2+fsoWRxmgC"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kROQblllK2+fsoWRxmgC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Sat, 2018-12-15 at 07:45 -0800, Guenter Roeck wrote:
> On 12/15/18 12:07 AM, Greg Kroah-Hartman wrote:
> > On Fri, Dec 14, 2018 at 06:10:29PM -0800, Guenter Roeck wrote:
> > > On 12/14/18 3:59 AM, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 4.4.168 release.
> > > > There are 88 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Sun Dec 16 11:56:41 UTC 2018.
> > > > Anything received after that time might be too late.
> > > 
> > > Build results:
> > > 	total: 170 pass: 145 fail: 25
> > > Failed builds:
> > > 	arm:allnoconfig
> > > 	arm:tinyconfig
> > > 	arm:efm32_defconfig
> > > 	blackfin:defconfig
> > > 	blackfin:BF561-EZKIT-SMP_defconfig
> > > 	c6x:dsk6455_defconfig
> > > 	c6x:evmc6457_defconfig
> > > 	c6x:evmc6678_defconfig
> > > 	h8300:allnoconfig
> > > 	h8300:tinyconfig
> > > 	h8300:edosk2674_defconfig
> > > 	h8300:h8300h-sim_defconfig
> > > 	h8300:h8s-sim_defconfig
> > > 	m68k:allnoconfig
> > > 	m68k:tinyconfig
> > > 	m68k:m5272c3_defconfig
> > > 	m68k:m5307c3_defconfig
> > > 	m68k:m5249evb_defconfig
> > > 	m68k:m5407c3_defconfig
> > > 	microblaze:nommu_defconfig
> > > 	microblaze:allnoconfig
> > > 	microblaze:tinyconfig
> > > 	sh:defconfig
> > > 	sh:allnoconfig
> > > 	sh:tinyconfig
> > > Qemu test results:
> > > 	total: 288 pass: 288 fail: 0
> > > 
> > > mm/nommu.c: In function '__get_user_pages_unlocked':
> > > mm/nommu.c:211:49: error: 'write' undeclared (first use in this function)
> > > mm/nommu.c:211:56: error: 'force' undeclared (first use in this function)
> > > mm/nommu.c:212:9: warning: passing argument 7 of 'get_user_pages' from incompatible pointer type [enabled by default]
> > > mm/nommu.c:185:6: note: expected 'struct vm_area_struct **' but argument is of type 'struct page **'
> > > mm/nommu.c:212:9: error: too many arguments to function 'get_user_pages'
> > > mm/nommu.c:185:6: note: declared here
> > > 
> > > Details are available at https://kerneltests.org/builders/.
> > 
> > Ugh, I'll dig through this later on today, we must be missing something
> > with those backports that Ben did...
> > 
> 
> 69ce144e5c3a ("mm: replace get_user_pages() write/force parameters
> with gup_flags") seems to have missed converting a call of
> get_user_pages().

Right.  This was changed earlier upstream in commit cde70140fed8
"mm/gup: Overload get_user_pages() functions", but I don't think it
makes sense to apply all of that.  I'm attaching a minimal patch
(tested with an arm allnoconfig build) which should ideally be inserted
before mm-replace-get_user_pages-write-force-parameters-with-
gup_flags.patch.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
--=-kROQblllK2+fsoWRxmgC
Content-Disposition: attachment;
	filename*0=0001-mm-nommu.c-Switch-__get_user_pages_unlocked-to-use-_.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-mm-nommu.c-Switch-__get_user_pages_unlocked-to-use-_.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSAwZDBhZmU5MzNmNjBmNTczNmM5ODRlOTE3MTIxNGFhMzRiMTg3NjRjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCZW4gSHV0Y2hpbmdzIDxiZW4uaHV0Y2hpbmdzQGNvZGV0aGlu
ay5jby51az4KRGF0ZTogU3VuLCAxNiBEZWMgMjAxOCAyMzo1MDowOCArMDAwMApTdWJqZWN0OiBb
UEFUQ0hdIG1tL25vbW11LmM6IFN3aXRjaCBfX2dldF91c2VyX3BhZ2VzX3VubG9ja2VkKCkgdG8g
dXNlCiBfX2dldF91c2VyX3BhZ2VzKCkKCkV4dHJhY3RlZCBmcm9tIGNvbW1pdCBjZGU3MDE0MGZl
ZDggIm1tL2d1cDogT3ZlcmxvYWQgZ2V0X3VzZXJfcGFnZXMoKQpmdW5jdGlvbnMiLiAgVGhpcyBp
cyBuZWVkZWQgYmVmb3JlIHBpY2tpbmcgY29tbWl0IDc2OGFlMzA5YTk2MQoibW06IHJlcGxhY2Ug
Z2V0X3VzZXJfcGFnZXMoKSB3cml0ZS9mb3JjZSBwYXJhbWV0ZXJzIHdpdGggZ3VwX2ZsYWdzIi4K
ClNpZ25lZC1vZmYtYnk6IEJlbiBIdXRjaGluZ3MgPGJlbi5odXRjaGluZ3NAY29kZXRoaW5rLmNv
LnVrPgotLS0KIG1tL25vbW11LmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbW0vbm9tbXUuYyBiL21tL25vbW11
LmMKaW5kZXggZmExNTYwYzIxOGQ1Li4yMzYwNTQ2ZGIwNjUgMTAwNjQ0Ci0tLSBhL21tL25vbW11
LmMKKysrIGIvbW0vbm9tbXUuYwpAQCAtMjA4LDggKzIwOCw4IEBAIGxvbmcgX19nZXRfdXNlcl9w
YWdlc191bmxvY2tlZChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzaywgc3RydWN0IG1tX3N0cnVjdCAq
bW0sCiB7CiAJbG9uZyByZXQ7CiAJZG93bl9yZWFkKCZtbS0+bW1hcF9zZW0pOwotCXJldCA9IGdl
dF91c2VyX3BhZ2VzKHRzaywgbW0sIHN0YXJ0LCBucl9wYWdlcywgd3JpdGUsIGZvcmNlLAotCQkJ
ICAgICBwYWdlcywgTlVMTCk7CisJcmV0ID0gX19nZXRfdXNlcl9wYWdlcyh0c2ssIG1tLCBzdGFy
dCwgbnJfcGFnZXMsIGd1cF9mbGFncywgcGFnZXMsCisJCQkgICAgICAgTlVMTCwgTlVMTCk7CiAJ
dXBfcmVhZCgmbW0tPm1tYXBfc2VtKTsKIAlyZXR1cm4gcmV0OwogfQo=


--=-kROQblllK2+fsoWRxmgC--

