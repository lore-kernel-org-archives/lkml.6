Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2640437-1523329132-2-2927399607669817221
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523329132; b=CoUVv4Ftx8d+M2lFrgEQluS8xgckiIaMD4fyQgZWHXL4fdnmqS
    TkOhciyYvkhhVxVzwLjYMOUgSbiQVMj60RNRK5ni6oYqVkphJFckgB6d4I3Rf4ly
    5vxy15rD7Pibi8m+Yu8Z2OWMHNocmYoTGAEQ3W9WjVqQox/LbTinJWbJKkAov4lp
    29tNEDNhaG+yIneUkMLoOy/ygr46sYzeRMQYdQkbTr0ELish5xZTRw1LqEh1S9Jl
    0/m4cPgmMpbGieDeX385C0YhefI81MV4GASfndu0+DBfqs1lF6XQ3IxUE1WR0Qpv
    5+MHXo0br/d2QLC8Kf2dugdeL4TE35d0MJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:subject:from:references:date
    :in-reply-to:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523329132; bh=FuMOk
    bGxjwmsyjrt1fXuaZG0aI3JLCacA2HCnWub+yI=; b=Xg2GpGNQ5z/BDuonb/syk
    AYgMX6cAcLpGl+LJdbBVjghhZdTDcsKUOrantzUyD3z4THDJPWFT3yBJffCZv7kY
    D/jHn2M05VxUfUulHNysVjgkQ40WkW4+iPg1C3GlhP0qj730xM/GUnIws4qK2/Lt
    /dj2OqP8n0CJ0RQro9J9PdjihmSF3vTQpM7+fFqBF34Ro4Q1ukCJnUXXVAv5wOyn
    fYPc2U0mNRCD6CcM3MJpM9pr9RzxJyySyWNnJHBGZUnOciFtUR3RIDXHMvhzdYGY
    8ViLdksMOvRax57vHXYYrqBVPd3T0WnZ96Nj/9eDQbugRcagEk7ohL0I+uRMhl1D
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=PWF4oZvx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=PWF4oZvx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEYuqVPhSPcbV1I8gg6AmN8U3taKKXnkKL0KkoDyKf5qHSTKgW2ddIaiB722osQgy3AV+oogVNrDtN7EuaZyjetUXb5lf4Ra9jIw5ob5t8dxgIMWTFMq
    xb0/DrPscqrZwaSrCOxZYMvIsq32GbpHORjOVD9URo9k/7bvEz9GUAJ8HY/BgOXTysDfDCPYS3AbjOEQd0HOB4Tn1zoJUDRSZZBmAdrMvpQDT1q553GZGs74
    f/AmRv0h6Mkj2wtBpHd2Lg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=_l-KicPsFdZ9Yn-cmqgA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
To: Long Li <longli@microsoft.com>
Subject: Re: [Resend Patch 1/3] Vmbus: Add function to report available ring
 buffer to write in total ring size percentage
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180328004840.22787-1-longli@linuxonhyperv.com>
 <yq1y3ibhndg.fsf@oracle.com>
 <MWHPR2101MB072958DDC25845615C3B1ADCCEA30@MWHPR2101MB0729.namprd21.prod.outlook.com>
Date: Mon, 09 Apr 2018 22:58:38 -0400
In-Reply-To: <MWHPR2101MB072958DDC25845615C3B1ADCCEA30@MWHPR2101MB0729.namprd21.prod.outlook.com>
 (Long Li's message of "Wed, 28 Mar 2018 22:42:45 +0000")
Message-ID: <yq1d0z722e9.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8858
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=574
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804100029
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
Cc: Stephen Hemminger <sthemmin@microsoft.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "James E . J . Bottomley" <JBottomley@odin.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 Long Li <longli@linuxonhyperv.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Long,

> I hope this patch set goes through SCSI, because it's purpose is to
> improve storvsc.
>
> If this strategy is not possible, I can resubmit the 1st two patches to
> net, and the 3rd patch to scsi after the 1st two are merged.

Applied to my staging tree for 4.18/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
