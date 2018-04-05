Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3549775-1522955375-2-8499523705723929716
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522955375; b=fycT79cnklfH5jw95LYwn6bzjfH1lyVEOUNFk2oSrN5r6U67ep
    T5UXwa8FdzeqaNJ9M40S5oxs270igtL7o2W5R58QRUWXHQM6bRNceV8FDt/lLnFP
    ZZqgWzPi3SV35mxxv5ersWRDulPCryeX/hFW9LDbPQV+zr5o9N2mb2JZsYtjvo5g
    WnasfMBdSeiJh9J+F9vW9QCymVRa99zp5UDgLGOqavoAJ48il4OAWDW3GnFmLJUy
    BpFHCvnD4KtxvNtJwCo8bhgD/9XU9E6iryaWD9OWQX7eg2JNOAvDkvhwr7lL6NWl
    Hs8Cm+E8E93fDaOtHm5LFq7xBWTqEp/f6ouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522955375; bh=V56sT
    tFGXAHtCnw5yXnZhizCQRyJZp5+UVBdiZwLQcM=; b=TTLta4/pkyhFXQJfgV3xE
    vEPBH/2l/cERB5jQBoCHq2cwGhKsSeSWK0a6d5p+KKcTgSsF5QB94uMUzLDuKQgE
    v9lmSyzRh8dkjPtjlWbOxCBl0SWdCHOEfiU4B6kfFpGCjYkxgGH48BfcyEi48h1k
    6/lKC/CP4Qz5q0zExZtDv8VF2oa/y669i0FWj6Hbp4t+NUsx2t8CIsDQwZqTw5cd
    idfbuAP0kaFVxfTAiuWL1kX3cCqCMKuPH188J9A9PNFlKt0XanuqqQznC6QvClJj
    K1uvwTGD14B9gxc1ICuz2Xax3pJtbGZ7dQcGGLzoTw3ssiWWWBtN9ZNNvuS1i/gN
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDWXx4ksfyplvgVAq5aBu9v6QwhVt2LSVf5baBQowSDaoM3nxP4wu2djfzx9XifK2BnnvdYUsJRodnlv7mBEyqUeNQ5KBqMfZMHmvDtBko+wkHvd/mRX
    FLIeS8kN48qRVNhzAu83syAMXn57TWb/jPWXsrItDgTM63MUcPDOSIwuzy3xWLJNgl/CHes3pvjYTpwvbR/tcX3STwvCN5kLQkerUVxmgzLeXGWXX2y4D09e
    lUTiBqpgyMpm3WglY63r6A==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=D19gQVrFAAAA:8 a=DDOyTI_5AAAA:8
    a=LGEF6Tp_7qsDkkUUalUA:9 a=CjuIK1q_8ugA:10 a=W4TVW4IDbPiebHqcZpNg:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Mohammed Gamal <mgamal@redhat.com>
To: netdev@vger.kernel.org,
	sthemmin@microsoft.com
Subject: [PATCH 0/4] hv_netvsc: Fix shutdown issues on older Windows hosts
Date: Thu,  5 Apr 2018 21:09:17 +0200
Message-Id: <1522955361-14704-1-git-send-email-mgamal@redhat.com>
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
Cc: otubo@redhat.com, Mohammed Gamal <mgamal@redhat.com>,
 haiyangz@microsoft.com, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, vkuznets@redhat.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Guests running on WS2012 hosts would not shutdown when changing network
interface setting (e.g. Number of channels, MTU ... etc). 

This patch series addresses these shutdown issues we enecountered with WS2012
hosts. It's essentialy a rework of the series sent in 
https://lkml.org/lkml/2018/1/23/111 on top of latest upstream

Fixes: 0ef58b0a05c1 ("hv_netvsc: change GPAD teardown order on older versions")

Mohammed Gamal (4):
  hv_netvsc: Use Windows version instead of NVSP version on GPAD
    teardown
  hv_netvsc: Split netvsc_revoke_buf() and netvsc_teardown_gpadl()
  hv_netvsc: Ensure correct teardown message sequence order
  hv_netvsc: Pass net_device parameter to revoke and teardown functions

 drivers/net/hyperv/netvsc.c | 60 +++++++++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 16 deletions(-)

-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
