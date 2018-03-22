Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3449376-1521745361-2-12658448163033743801
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521745359; b=jKOVRSh9MwDFxGenLNA0WH6iMWoqLLTu8pg2bj0kTXNV+YZ
    7xTGPF1Z7dLAW+LaUogC4CoA/yr6SxPvatAr+dzqGtJozCE+29I4amLd0zS9GA0S
    uuD3/+s/+GTYBfe17Uw0HdedWZEUjLXkXyeTb+zmoa1AtiTZuRHnDmGcKWsY/Ef8
    uob+1wtmFf1/ig/U7qG7+Q+qRWdkIJzaZ9dIT7yYPpfU5Mbqtt0EIS6k8i8TCx1q
    5HpFGkU0kAf00zCkbtWpiIobiAz2woU2J8sllvBSxjIILVnBe2/3hG6BWNoCIZL3
    odVpsVJWsuPVniBVFW9ojbcm3E09ENDVpUNBFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:reply-to:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521745359; bh=P
    JYMDQ+kvO/8UNZJmIJ6wgYGiRdagMsnuBuoBT0+upA=; b=jePGQpEHKT81hxc1Z
    Ae/7g6mQPZ+EeBMRORjCgTsaw8Jn0DSLwE3Cetx7zxRU1qivzAO2K4/OqzgSSDz4
    m9iIsvDk6ysEH6KEHmuAPA35VclwgYefRSSvuQsTbuuKVTnkFufV2wFCCYJGXsSU
    16VZEObbP9LRJcVG7pENWB17SoWng9jjn9aT8BcnjHNlwIK33F1cL8Qmtb5qS3u2
    EGcMNlJDdt1RhmA76kfs7TVu3WnI8gwr1SDaK2H2XFPm1iNJTTMevUx+yY6GzOJn
    uVAOfRgLpdDVomkfjkBDGJ0z2wj9orA4tbLCfOmxKYR+PIEkJ9qPfUr9N3J4LEnH
    fluYw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: Haiyang Zhang <haiyangz@linuxonhyperv.com>
To: davem@davemloft.net,
	netdev@vger.kernel.org
Subject: [PATCH net-next,0/2] hv_netvsc: Fix/improve RX path error handling
Date: Thu, 22 Mar 2018 12:01:12 -0700
Message-Id: <20180322190114.25596-1-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
X-CMAE-Envelope: MS4wfECRHunTMOghbmsaSE0PXQQbPMUkFMbA8nFRctntofYTitMuzQZlSlnai1FinctEnZI0ObyGMLU09KQCJGzAn7PSkyPBHL0hRt/9aUB562xpfTYz3fe2
 DFRH1ybfQ+WsimRy/zuOocgMqiElD/Bf2lLX0PHdAZL13ifwIRxduNtpQXnsKcxLCB/gO53YZSVI+2du4eA5WplqOdOF2/7RQ0Q4XDVeDSf/wdf4RlcVjp01
 jKKEYF2y49dv2H8cun5vsgaOdvSKdHcyaoHW+kZ0rd9JdZfMgL5B3mxMRWmOs1jl9WjHjP2YzgClgL0CFfufOernn3TdHCQQQ2EwRzYArR8feRFkZo1fn3wd
 mBdqI9fg6ZMr7qSP1flKiOG1/yiShbGoi0BaBwZw0jc3w8P969yT+FKi1C4qlTGbbu8kgm+BImV26psyA7goxEAt1Bs0A70M+Ifu9SshjQ0xMRue9wOEcgbx
 vFyXnpyiq0A+glWXNLazLP4tHpVjIz0HJyYbcw==
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
Reply-To: haiyangz@microsoft.com
Cc: olaf@aepfle.de, sthemmin@microsoft.com, haiyangz@microsoft.com,
 linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
 vkuznets@redhat.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

Fix the status code returned to the host. Also add range
check for rx packet offset and length.

Haiyang Zhang (2):
  hv_netvsc: Fix the return status in RX path
  hv_netvsc: Add range checking for rx packet offset and length

 drivers/net/hyperv/hyperv_net.h   |  1 +
 drivers/net/hyperv/netvsc.c       | 25 +++++++++++++++++++++----
 drivers/net/hyperv/netvsc_drv.c   |  2 +-
 drivers/net/hyperv/rndis_filter.c |  4 ++--
 4 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
