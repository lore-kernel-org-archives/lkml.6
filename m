Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2351238-1524253019-2-17127566453672502132
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524253018; b=goYgKmWHIo6QT9bCwPjQd4V3D+BXn6+e1WlwF18egEVvNDk+xn
    M8McxfTrPPHhwHyK0NsiOC1nQgGdpzcallaPPhX5uGoEx5rFgy8Ld9xblh4UHryY
    KxEV56aROzBGJRJZCdcoq6vfn/h88gMz2cC76LfIk3ux1Y0dIv5JtKd579YtL5vk
    EYmQKN7qh9aE2SbRO75a1xOJTi+OWsL8BxollsHJbCPYU5RsoeTxzc5AXAfa0mFg
    s3VjZmYgvJ6OSX6cdEVFbJIz+hjbpuM9Z7zNgeKM5eBc+bCO4xlibCIQdTo4JDIK
    M54fZFBtSAxTZmOmihyQ6gaBJWyImF0q8nHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:subject:from:references:date
    :in-reply-to:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524253018; bh=HU8w0
    6ELJydqItsOI8KmW3W/qYjtEQqp4K79Rm/SrvQ=; b=SvDBns59nJewh6xC5BbTp
    xMmB8AxvYvaMjFbvjZh9D2WeQyzxjUmEwnVZD0fXeIgOMs7SIT9aC2uvN2OTI23q
    0w03deAeZKB6xeV/4FdBtPdkonXwvMHFKluuvRtMsLYZ+LcBKC4NlPoEavoVYDnA
    fpibRNAEuoF9OrtoZVT3+pZmdJp1/1nfR8B4ZDye7VP43voVM0a0fGvmni/VgjCC
    8tKZQPTNk/nqLoIvmwDNYZSNRSYh6oXHbAbGjInSn3Udx6yxrVCel2gWV8Yx1DQe
    UYctaIiIjAXtd7bkbMkNxR6jvvNMZO/THN7BAMYjVvQkcdWipipSl6QHYF+qNuUJ
    g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=cOp2l4BT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=cOp2l4BT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL0z6nVy22SkSBD+lz09i2xMPkEpND1qfcXZiSTBtBhV21EP+iMUsr0aZfu0yhBUqshk20xDKfL0k/f7Fq1j6YNUDN58QS24TpDFhroK3sfpmLzhvnWE
    oFQtq50MM6LLnEZIEMYNmAPjDrKIe+m/2ukqEkmrVsqeVJBy1w/xMNE2HxkhmpgTGr88wBdNa8A3w+ey6Kv+WP1YzBC7MAZEQPfvfgAIo+NsULYn2Bqye81E
    Gd9W4Y+An+W6fmvOiPDKag==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=-2sHaBnr2xzOQxfWxrcA:9
    a=p84Iv3GZUVyS68QU:21 a=3T82Zjg8buUBL6FL:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
To: Long Li <longli@microsoft.com>
Subject: Re: [PATCH v2] storvsc: Set up correct queue depth values for IDE
 devices
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180322214718.29547-1-longli@linuxonhyperv.com>
 <DM5PR2101MB1030FD5B6261CC7BCF0092D1DCAF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
 <MWHPR2101MB072978A101FEFBCF2D32E872CEB60@MWHPR2101MB0729.namprd21.prod.outlook.com>
 <yq1bmefna14.fsf@oracle.com>
 <MWHPR2101MB072916BAB0F56AA2CD8C444BCEB50@MWHPR2101MB0729.namprd21.prod.outlook.com>
Date: Fri, 20 Apr 2018 15:36:45 -0400
In-Reply-To: <MWHPR2101MB072916BAB0F56AA2CD8C444BCEB50@MWHPR2101MB0729.namprd21.prod.outlook.com>
 (Long Li's message of "Thu, 19 Apr 2018 04:59:12 +0000")
Message-ID: <yq1fu3pisaa.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8869
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=494
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804200197
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
 Haiyang Zhang <haiyangz@microsoft.com>,
 "James E . J . Bottomley" <JBottomley@odin.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
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

> If num_cpus=1, we don't have any sub channels.
>
> The host offers one sub channel for VM with 5 CPUs, after that it offers
> an additional sub channel every 4 CPUs.
>
> The primary channel is always offered.

Applied to 4.17/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
