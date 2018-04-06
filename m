Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-150357-1522981286-2-9265245071932328708
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522981285; b=eCFOtym+5HhKH4BzGIO1txhFXAtBOd/VYQ7y7UhiLztUrMA3O3
    hc2CpwM+n6AsJbW/RinUNerEwmlTCJ+sjJMgbupntQl/XmgpX/JG5aplKZ+VpaB8
    bYKEGEy5jVo9gqpLIPpMPjTFSvynr1SWYWwe4214/CLYz0/jqlFPI9cKygD3Qa0f
    UNukseUzgB5LNmfyeswqGJ9kKdum7pKCrFnGnhamux/az1N4KmnbEzsWrqgUMdXw
    f9wMGIAomy5lpJfh4z9aXQTB0k2Cgz2kF2/JN4fc+26WLt9fRMvf8rHQKj0ypwUl
    6zSafPTlfH4tVmOVRmm/vgU2ltye56zswTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:subject:from
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522981285; bh=997Mb
    KB9OpgvK9FcV+TdIkCmf8xJhn4PZtRKT4uOTzA=; b=pektK7EPAhgox5Lkj/yqJ
    sXnkcoNPEoxkjWUtLBxrGrxHXqezARhvK76LruVN9pBP1Z5a1yTnhBApvXt7uZcq
    6+ZkH24/VmWy8Zfo3aFG+TYHDF0g267dDdWG+cPXrTRqfK3zRocqibfkim+k20si
    Oh3RJJ/ZvCipOdwU5X9NjUJMwIWoGPwqm1++8x23NbeqigNScVPkJIjLLE2kSA+P
    nAAUlj3Jehqojd/YRGJVG7P7RV/idhzu9xFrDwb4Qrd0B4EiEKu3xQy9gvwwh/NI
    kV5DcpBON1Wa5eSdKr2o/lAGzZ2gevolc2cA5YgfTgdhdWaCMGHn2ppzHX3TjDtu
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIrAqi0KHW/EHzDqMGMXu+402t4Jm2v0p9tKOMJCRzgCJrTcpg7seaQWH6VMO6W4LiGlOZATb2tkfHGxTpTcHVl7w8Bv0GMDZkBzSTgQVLUDXHDhYKBN
    sjxCm0LXLClvk+bD/RBDTpGrukBTj+r7Vfb7/+RccjXIBp4xFSapUOigoPblG/T9DCFeYATBKrojvcRFAnaT6ClgVrnWHsLPCVAIJSVGrnWsu8hehjQQxxT/
    ZZq93lTc7HZGO7/mrh60DA==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=20KFwNOVAAAA:8 a=D19gQVrFAAAA:8
    a=DDOyTI_5AAAA:8 a=v-CaPzKvIMOI5kAogFsA:9 a=CjuIK1q_8ugA:10 a=JZBxSqCIBzwA:10
    a=W4TVW4IDbPiebHqcZpNg:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 05 Apr 2018 22:21:18 -0400 (EDT)
Message-Id: <20180405.222118.1398487531695482550.davem@davemloft.net>
To: mgamal@redhat.com
Subject: Re: [PATCH 0/4] hv_netvsc: Fix shutdown issues on older Windows hosts
From: David Miller <davem@davemloft.net>
In-Reply-To: <1522955361-14704-1-git-send-email-mgamal@redhat.com>
References: <1522955361-14704-1-git-send-email-mgamal@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
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
Cc: otubo@redhat.com, sthemmin@microsoft.com, netdev@vger.kernel.org,
 haiyangz@microsoft.com, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mohammed Gamal <mgamal@redhat.com>
Date: Thu,  5 Apr 2018 21:09:17 +0200

> Guests running on WS2012 hosts would not shutdown when changing network
> interface setting (e.g. Number of channels, MTU ... etc). 
> 
> This patch series addresses these shutdown issues we enecountered with WS2012
> hosts. It's essentialy a rework of the series sent in 
> https://lkml.org/lkml/2018/1/23/111 on top of latest upstream
> 
> Fixes: 0ef58b0a05c1 ("hv_netvsc: change GPAD teardown order on older versions")

Series applied, thank you.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
