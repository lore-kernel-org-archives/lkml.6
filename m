Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3264303-1522274426-2-6378489148619097264
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522274425; b=v8Ic5HVBBKZd9uMmcJKRSdj2R7aA1G/uissWv1UqbzpLcqZ
    JjWCThVmIhKbCavnxZslMk8WyvI/5eYINtMlKsYmw8SPfaHbr7rPMBWEIVW+G2VJ
    D2TJ9cMqqJFwHXae4af8n43LU7s7vREiFhZ0dglL0KqSNg1/fOohflu5qL54ZCBA
    ZM3LdCgJgImhgDaIdRGHm5shJwXW46cqf0Y+38T0Dn16gR7UHRj2oTMQ2mE/gaMQ
    RklFmh4HdwmTiyI0omk0JVxE1SEXdGGkNQfzvnXj9Ntfb53VrWt+DGyZRLHJYQDT
    PIdgaL0QCsDe8PsdAedTxle+S/OlzB32QM+a/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:subject:from:references:date
    :in-reply-to:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522274425; bh=h
    wZb19CqPQ8I+0Vz2iN1yNrqPyXd0BAOb+2X7Xtm1pg=; b=Sxf3VDMa9ttiK1+ob
    /U7S6PaHO6dr/HErA7jNriLh0xUpBmo7HUp0b9vPP8IrpBBohRt7dWl85bgYygUW
    Syr6Dg1q8z2vU9ESwbxEV1EyqQaZ7sQU9OZ+JdUwGxsS7BkMdtRiYT4/EvUjQLYC
    vWBjqNxdsk2MtnvV0tFHTBFlape95QNwaBpErOcx8EPkl+fvP1Nnu2iPEg7sTi9x
    bcVX62DnzqKDaabDW+0fGVJXNBENId72s9p917QYNeLWlkvWfV/L9epb0MaVwYNo
    NcB0P9ysUflG6iRAo8vYBZg6fQ+g2pC1afDdPalvpalU+as8+Mj5baByXpVeP999
    4RaGQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=lJHHTLCB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=lJHHTLCB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAtzdRhMSfsu9PenCWCFsVJAYystDSJsxtqmeOJsjV/y+Q6KbENKXPC0hvoK4fzL+pksUkBW5cAZcQ16X5gXs7YqfPzLthwI7qArYChwDhIk6L2n5iM5
    bEXwEO6qXxa+pP5FEoKRxpukrsKW46jPIsQFKSMcrzuTJ472Q6/annAA4sjw84FL4Isu5nYYfXg+BlM8XYkxaNDxIhSwqtN1SharewIGRqYD7ALEADIeM2H2
    QIDko8e/R3hCRuGxk8G8/Q==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=WEj0VKLxBG5bU8RMDDYA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
To: Long Li <longli@linuxonhyperv.com>
Subject: Re: [Resend Patch 1/3] Vmbus: Add function to report available ring
 buffer to write in total ring size percentage
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180328004840.22787-1-longli@linuxonhyperv.com>
Date: Wed, 28 Mar 2018 18:00:11 -0400
In-Reply-To: <20180328004840.22787-1-longli@linuxonhyperv.com> (Long Li's
 message of "Tue, 27 Mar 2018 17:48:38 -0700")
Message-ID: <yq1y3ibhndg.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8846
 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=381
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803280216
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
Cc: Stephen Hemminger <sthemmin@microsoft.com>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "James E . J . Bottomley" <JBottomley@odin.com>, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Long,

> Netvsc has a function to calculate how much ring buffer in percentage is
> available to write. This function is also useful for storvsc and other
> vmbus devices.

What is the submission strategy for this series? Do you expect it to go
through net or scsi? If the latter, I'll need an ack from davem.

-- 
Martin K. Petersen	Oracle Linux Engineering
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
