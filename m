Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-628284-1522188012-2-11657481254476616854
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES ensvda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522188011; b=V5DbO0pwLb2tElkV/tmDIr8pNoxHzNF1KedDQjw9xBBtacN
    Rjpjymo8rhwB7F32/CoKgkwfl3bVi1XCELGNgWa/nQ8rVL4KveY+vAM3UAqf0vUy
    irMtUqDtkkun1DYNWHtMCcK8hKm1M2OYW+2UhE+FNPLrCTYvg5dFdl7BaeRrlAt/
    M4PvWvWvmWNjcx1gs642qUapnJ5S4jVp7oUCGjm0flb2hs419B8DVinpiPkSJ1TQ
    jOETEUbzRuFoPnB1rd7z5RsQ3kK9gwE0Xv5XhJ8WB2M0UZ4khQirzo5ldugvDJ5N
    Z+7CN2tfzlzMKaqCZAv6kFMeZ/pTJ1T/jKYFZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:reply-to:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522188011; bh=K
    0aLo6Qu1kuJpdD/GsRsYLrIWHw7x3vKc5T6sDUJp10=; b=DnnlP6HAWKsqzey3r
    k5LU6nO8yRLzcr6JgrW7+vtmoGeekO7vc5xwtHycXUGO9xg3Jknx5VsoA3lXSvcp
    X+INSC80uWoQrnj0ykL8zkVFT4ODu4QoeDFWRdcupBVXSh/Vrvqx3995DoE8Oxao
    8mZudi+0jEEHU++j/LF309tlNuth3MbIqmY/mRpoE1jkDiA8luIjtaiVnDlfBIb+
    Z/+br4CYIEQ135Z11vgZGJdgY4Wfc60XzgcndfswHcwEe5m5NZTH9kbvxJFXrPNH
    jAlyiSZxjp6OA66e21nKwODEKUMtfh+XhgUKSt8LsB680CdgvpG5tuBsnvp3PT++
    Su0yw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDMukyvWyH6+M2gdY8FcHWdmr22t08KtTMus0ZaSKYRadIuF3mQJlonmdN9FjuDzMcbZ9Swg2PX1/rU4yDF7+wA164sFLufhj8ArX8Ujw78/c+I+rg+m
    hjc5yZPzT9kGJXsHKvmmXMmRczGucEDLxMyK/FUwzbTbnmZLxMkpjyH8dy6LhRw61cHZEp2EkcwQ5UUnEjVctiIaZfi6kDc7HOnZqqJWSMrDKjAD/D297Cn4
    LwpJyiEZLxQcXsxqEqPiNA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=wmH2h71lHiwA:10 a=kj9zAlcOel0A:10
    a=v2DPQv5-lfwA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=VOvU0uPMZk_4ZXywoR8A:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 vkuznets@redhat.com, jasowang@redhat.com, leann.ogasawara@canonical.com,
 marcelo.cerri@canonical.com, sthemmin@microsoft.com
Subject: [PATCH 0/4] Drivers: hv: vmbus: Miscellaneous fixes 
Date: Tue, 27 Mar 2018 14:58:59 -0700
Message-Id: <20180327215859.19624-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
X-CMAE-Envelope: MS4wfJeXe0kovy76tL5XvcqxRlBd5NOc9dVLlqBcWyHV8/zsgXmj2/bcrPHwigZFRjSXGuiv7bJxK5rRrQU9T1LCXI4ye3zFcf8HcMsxXHbyMfkYEBgAGq0y
 e8DgcbV7UrqpCklAg7fZxqIMp0jKSgrkwxv8XoqopLcbwPLAopCQYrOASorBzV8wRiNHkYxdUprX5Fhv6Q4bkJWmCbcjfNbUByX/Xo1VlmQvNX9EtSC6AeRv
 lK3/Dnw/0GZtAn9GE75mAv3JpdQvT3nsCphtooxbR61EhvZuk0tPqEFteBbQEmCikhdWm96iVWQtwDvjobfCX/F7Pgy2JO+MpaCNZFoersKiAk/+KzpTE55b
 4B6kanRRn3sF7mZ7fCVz2xa6J5hL97eVpq6MaQMG0EDOrb74B4BgXRGbUJMA7m/sZtPJdRZBugmy+oJb7B3o52+JDDukET5Ua31N99PXNzzx0wgVPjvYR/Fo
 87EhBqgFaCvwx8o+Kxow979DkfWtLOwLAICMd5KfbzgHrY3gvooujek66mC0+dVdFYecpDOdSkQoXSMjV7ijMpiEhIfH6iPuSsWXNA==
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
Reply-To: kys@microsoft.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "K. Y. Srinivasan" <kys@microsoft.com>

Some miscellaneous fixes and adjustments.

Dexuan Cui (2):
  Drivers: hv: vmbus: respect what we get from hv_get_synint_state()
  Drivers: hv: vmbus: do not mark HV_PCIE as perf_device

Stephen Hemminger (2):
  hv: add SPDX license to trace
  hv: add SPDX license id to Kconfig

 drivers/hv/Kconfig        | 2 ++
 drivers/hv/channel_mgmt.c | 2 +-
 drivers/hv/hv.c           | 1 -
 drivers/hv/hv_trace.c     | 2 ++
 drivers/hv/hv_trace.h     | 2 ++
 5 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
