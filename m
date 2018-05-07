Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-311249-1525674818-2-10220287146768187522
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525674817; b=buq0xMyoeBgEDJWBu+CflU5ic5aO7MaEP/haQilEKF6EUZQGx7
    J/IQ+EK0pnQOEm0+XajeiSWR6zJP8SS8Saxmqq/zZG6TjvZ+cTanc/dFIYR2o527
    ylQZgfRWm6MgkGKyKFw+mKeTbuLUd5gPzjUwshsW3q1+uDdMblrBALV7uj/TQgQz
    AbUgZBiBj/WuRgMrM75RZOVXys+2mSwLpSWKjBcTQ31atjXMsEGP7XH7OFt/qovW
    Qv/NOn9P/d6xrocFtmGt+aLjaggHNjb+jB/0G3QW4KulwCLb0L4F/RAUd9t/sB1X
    nQDTdoJRrMc5U34WPVDoOadRx/a0E+Hagotg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525674817; bh=QmpuY
    RJ95XiZ/PMSz2vy0WYDcM7JO1snydALrKarNtI=; b=NVOy98ViWxVIPcUxepoXg
    e6NfcCO8rlt8Rk4DNar4iyWZ27T1KiDqm6D9EHdH4ay7KXPwo3X3R/zONES1Icn0
    kcMJy5ti98Ayj/DeOwEBZ1LchOtWwbK7j0TB/343ez7ubxJS3ENxABzH6Xpn0COk
    AWUKkPSI6kcW/jFyMSrSKRJtllToMG/nPBiDjgWjh5HxZvb7LpHEfP8R+seocdsL
    pme2pKn/No7po0w2PWpZ3Zqs6YsoZ7lw2F02Ye4BGGZQzfcgBM1VaTr/8eHgqrrX
    UtZsaqL+FyUAapqV/z0fIK5kj+Uy6IBOexCXYnTZx7Ku8nLJ3koNdwyeVHnwKfEy
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfK7mHxjywZ1vSkaEwM74z8rhUg6pRU92RmC+XgFKD55IdNEyuYuCstvC0HBdBh6aZBCucFON89fLpenfy4kSMhZdpvdr1rOu71um7MxStAhkcxa2FvJ0
    5ujINyOu+PPJDAU+5KcTPwRNVktbzU2NpboDG2JPx4FF/03lgaHKZiTJBvS6W31nCDE91BCP12vGTV62DcyS4QKkFxbmL2PnIFpPCs6E2ARDaMt5fRfBUoTU
    vMvgM3pt4rDIAzRD0y0img==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=20KFwNOVAAAA:8 a=Z4Rwk6OoAAAA:8
    a=zd2uoN0lAAAA:8 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=lq52kGoOkO8qgVZK7kcA:9
    a=QEXdDO2ut3YA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 robh+dt@kernel.org, dan.j.williams@intel.com, nicolas.pitre@linaro.org,
 josh@joshtriplett.org, fengguang.wu@intel.com, bp@suse.de
Subject: [PATCH v4 2/3] resource: add walk_system_ram_res_rev()
Date: Mon,  7 May 2018 14:32:23 +0800
Message-Id: <20180507063224.24229-3-bhe@redhat.com>
In-Reply-To: <20180507063224.24229-1-bhe@redhat.com>
References: <20180507063224.24229-1-bhe@redhat.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

VGhpcyBmdW5jdGlvbiwgYmVpbmcgYSB2YXJpYW50IG9mIHdhbGtfc3lzdGVtX3JhbV9yZXMoKSBp
bnRyb2R1Y2VkIGluCmNvbW1pdCA4Yzg2ZTcwYWNlYWQgKCJyZXNvdXJjZTogcHJvdmlkZSBuZXcg
ZnVuY3Rpb25zIHRvIHdhbGsgdGhyb3VnaApyZXNvdXJjZXMiKSwgd2Fsa3MgdGhyb3VnaCBhIGxp
c3Qgb2YgYWxsIHRoZSByZXNvdXJjZXMgb2YgU3lzdGVtIFJBTQppbiByZXZlcnNlZCBvcmRlciwg
aS5lLiwgZnJvbSBoaWdoZXIgdG8gbG93ZXIuCgpJdCB3aWxsIGJlIHVzZWQgaW4ga2V4ZWNfZmls
ZSBjb2RlLgoKU2lnbmVkLW9mZi1ieTogQmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+CkNjOiBB
bmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPgpDYzogVGhvbWFzIEdsZWl4
bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+CkNjOiBCcmlqZXNoIFNpbmdoIDxicmlqZXNoLnNpbmdo
QGFtZC5jb20+CkNjOiAiSsOpcsO0bWUgR2xpc3NlIiA8amdsaXNzZUByZWRoYXQuY29tPgpDYzog
Qm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPgpDYzogVG9tIExlbmRhY2t5IDx0aG9tYXMubGVu
ZGFja3lAYW1kLmNvbT4KQ2M6IFdlaSBZYW5nIDxyaWNoYXJkLndlaXlhbmdAZ21haWwuY29tPgot
LS0KIGluY2x1ZGUvbGludXgvaW9wb3J0LmggfCAgMyArKysKIGtlcm5lbC9yZXNvdXJjZS5jICAg
ICAgfCA0MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVz
IGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lv
cG9ydC5oIGIvaW5jbHVkZS9saW51eC9pb3BvcnQuaAppbmRleCAyMjVkMTNkMzUwMGEuLjVmMmNm
YjQ2MGExNCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9pb3BvcnQuaAorKysgYi9pbmNsdWRl
L2xpbnV4L2lvcG9ydC5oCkBAIC0yNzgsNiArMjc4LDkgQEAgZXh0ZXJuIGludAogd2Fsa19zeXN0
ZW1fcmFtX3Jlcyh1NjQgc3RhcnQsIHU2NCBlbmQsIHZvaWQgKmFyZywKIAkJICAgIGludCAoKmZ1
bmMpKHN0cnVjdCByZXNvdXJjZSAqLCB2b2lkICopKTsKIGV4dGVybiBpbnQKK3dhbGtfc3lzdGVt
X3JhbV9yZXNfcmV2KHU2NCBzdGFydCwgdTY0IGVuZCwgdm9pZCAqYXJnLAorCQkJaW50ICgqZnVu
Yykoc3RydWN0IHJlc291cmNlICosIHZvaWQgKikpOworZXh0ZXJuIGludAogd2Fsa19pb21lbV9y
ZXNfZGVzYyh1bnNpZ25lZCBsb25nIGRlc2MsIHVuc2lnbmVkIGxvbmcgZmxhZ3MsIHU2NCBzdGFy
dCwgdTY0IGVuZCwKIAkJICAgIHZvaWQgKmFyZywgaW50ICgqZnVuYykoc3RydWN0IHJlc291cmNl
ICosIHZvaWQgKikpOwogCmRpZmYgLS1naXQgYS9rZXJuZWwvcmVzb3VyY2UuYyBiL2tlcm5lbC9y
ZXNvdXJjZS5jCmluZGV4IDRmNTYwOTkxYzEzMC4uNmM1MTliMDZlM2Q2IDEwMDY0NAotLS0gYS9r
ZXJuZWwvcmVzb3VyY2UuYworKysgYi9rZXJuZWwvcmVzb3VyY2UuYwpAQCAtMjMsNiArMjMsOCBA
QAogI2luY2x1ZGUgPGxpbnV4L3Bmbi5oPgogI2luY2x1ZGUgPGxpbnV4L21tLmg+CiAjaW5jbHVk
ZSA8bGludXgvcmVzb3VyY2VfZXh0Lmg+CisjaW5jbHVkZSA8bGludXgvc3RyaW5nLmg+CisjaW5j
bHVkZSA8bGludXgvdm1hbGxvYy5oPgogI2luY2x1ZGUgPGFzbS9pby5oPgogCiAKQEAgLTQ3NSw2
ICs0NzcsNDQgQEAgaW50IHdhbGtfc3lzdGVtX3JhbV9yZXModTY0IHN0YXJ0LCB1NjQgZW5kLCB2
b2lkICphcmcsCiB9CiAKIC8qCisgKiBUaGlzIGZ1bmN0aW9uLCBiZWluZyBhIHZhcmlhbnQgb2Yg
d2Fsa19zeXN0ZW1fcmFtX3JlcygpLCBjYWxscyB0aGUgQGZ1bmMKKyAqIGNhbGxiYWNrIGFnYWlu
c3QgYWxsIG1lbW9yeSByYW5nZXMgb2YgdHlwZSBTeXN0ZW0gUkFNIHdoaWNoIGFyZSBtYXJrZWQg
YXMKKyAqIElPUkVTT1VSQ0VfU1lTVEVNX1JBTSBhbmQgSU9SRVNPVUNFX0JVU1kgaW4gcmV2ZXJz
ZWQgb3JkZXIsIGkuZS4sIGZyb20KKyAqIGhpZ2hlciB0byBsb3dlci4KKyAqLworaW50IHdhbGtf
c3lzdGVtX3JhbV9yZXNfcmV2KHU2NCBzdGFydCwgdTY0IGVuZCwgdm9pZCAqYXJnLAorCQkJCWlu
dCAoKmZ1bmMpKHN0cnVjdCByZXNvdXJjZSAqLCB2b2lkICopKQoreworCXVuc2lnbmVkIGxvbmcg
ZmxhZ3M7CisJc3RydWN0IHJlc291cmNlICpyZXM7CisJaW50IHJldCA9IC0xOworCisJZmxhZ3Mg
PSBJT1JFU09VUkNFX1NZU1RFTV9SQU0gfCBJT1JFU09VUkNFX0JVU1k7CisKKwlyZWFkX2xvY2so
JnJlc291cmNlX2xvY2spOworCWxpc3RfZm9yX2VhY2hfZW50cnlfcmV2ZXJzZShyZXMsICZpb21l
bV9yZXNvdXJjZS5jaGlsZCwgc2libGluZykgeworCQlpZiAoc3RhcnQgPj0gZW5kKQorCQkJYnJl
YWs7CisJCWlmICgocmVzLT5mbGFncyAmIGZsYWdzKSAhPSBmbGFncykKKwkJCWNvbnRpbnVlOwor
CQlpZiAocmVzLT5kZXNjICE9IElPUkVTX0RFU0NfTk9ORSkKKwkJCWNvbnRpbnVlOworCQlpZiAo
cmVzLT5lbmQgPCBzdGFydCkKKwkJCWJyZWFrOworCisJCWlmICgocmVzLT5lbmQgPj0gc3RhcnQp
ICYmIChyZXMtPnN0YXJ0IDwgZW5kKSkgeworCQkJcmV0ID0gKCpmdW5jKShyZXMsIGFyZyk7CisJ
CQlpZiAocmV0KQorCQkJCWJyZWFrOworCQl9CisJCWVuZCA9IHJlcy0+c3RhcnQgLSAxOworCisJ
fQorCXJlYWRfdW5sb2NrKCZyZXNvdXJjZV9sb2NrKTsKKwlyZXR1cm4gcmV0OworfQorCisvKgog
ICogVGhpcyBmdW5jdGlvbiBjYWxscyB0aGUgQGZ1bmMgY2FsbGJhY2sgYWdhaW5zdCBhbGwgbWVt
b3J5IHJhbmdlcywgd2hpY2gKICAqIGFyZSByYW5nZXMgbWFya2VkIGFzIElPUkVTT1VSQ0VfTUVN
IGFuZCBJT1JFU09VQ0VfQlVTWS4KICAqLwotLSAKMi4xMy42CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkZXZlbCBtYWlsaW5nIGxpc3QKZGV2ZWxAbGlu
dXhkcml2ZXJwcm9qZWN0Lm9yZwpodHRwOi8vZHJpdmVyZGV2LmxpbnV4ZHJpdmVycHJvamVjdC5v
cmcvbWFpbG1hbi9saXN0aW5mby9kcml2ZXJkZXYtZGV2ZWwK
