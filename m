Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3191090-1524778349-2-5208815009552041886
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
    1524778348; b=Z0FyKSYu6WmF+kHP9NZzZWmFX9WWQMjEPFw4CcFdYqxzCmQ0yF
    pocI8Kg7UqkburPZXley7zzzaHzQDKKBlYaM7nh5CShijK/UOMFk2BCmCISVunjN
    xNEPsXWPh5NMSRpyMY6X4nuTjApC2mixVYzNGYL1SbRorA8n7sLue6GaxOzkM2Pv
    QBET+U6GUc4viVWRkGHHlhaQnQnLPB+xMBN+3foIqd83NevSx9iD4OXfdQ9OFJYq
    /GOit3L0N4Dg6liSBzdp/J1qsdMOYfRG9ofVkyhl9R2PJ+bUx9jjMFywgQc+/kPZ
    zFIqn+AH+o+Qqiq8f3MCwgpTqh0Yd3fUr2JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524778348; bh=bMen5
    n+Fv+xOvrfr/UjVG/0cnlZI1ZtlinoJ3BgdjUY=; b=EogeZ0ZDO1NO0/SYycc9w
    DjR18KKbSkPXI4+eV51+C0sgbyq4TsZTPBPpd3AP0IqsTpsBBvK+dIDZhncA0DtX
    pdtw+HZJ1g46mecjAX2m48xTMqVsz38HlOACDPLpJ8BQ63F6migV2I3oit2qSpu1
    WY4nh2XelVSCEt+GVQAIPEHwq7Hmf1I/svHa7kxVvk2DhvDdqOe/USqoGhcP9QTO
    DO8GMSZD8mz6o49dRPqI99rl4VNWG2TbFBcfdP9cqwNAC4zoFwF1nvrz7j1JRFmY
    ba7wIJoxZtM/gYhAvBLP8rZmhRIbvtWdzHF/hQ0drebSYWZ09RNmE6p3UMQGwIaH
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=g+bMtFNn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=g+bMtFNn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGjRvxmmArj5LVIdli/Eh1m7DP4fBrz1lqH2ZeZRMp/Fd/sjfV4IjQfep3MHZtpVNaVwkx/Ubibqn+5EsmWGnWYQF9qsVpN9eWFnhj4xMEPojHkAFLrY
    RArmgn8ENKfuQG9YZLvnveOa2GYr7WbGpfu2Br6bbADMQ7iHkhbbRYDucLEVYRcxSztioVrpSANQ0MWoEv4mTfW4oAbtLH4/YdMJaJPX9cwWYOyBDXrUR0QY
    C7o6Kax9B12pbyZuUz5oEg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Odnh0R2cAAAA:8 a=DDOyTI_5AAAA:8
    a=2FwAexzAoKdf2mvhNVIA:9 a=CjuIK1q_8ugA:10 a=lNAA6UHySJB7qmBR1x20:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 27 Apr 2018 00:31:49 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: kys@microsoft.com
Subject: Re: [PATCH 2/5] X86: Hyper-V: Enable IPI enlightenments
Message-ID: <20180426213148.d5udlgzgbvtym25p@mwanda>
References: <20180425181110.8683-1-kys@linuxonhyperv.com>
 <20180425181250.8740-1-kys@linuxonhyperv.com>
 <20180425181250.8740-2-kys@linuxonhyperv.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180425181250.8740-2-kys@linuxonhyperv.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8875
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=737
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804260200
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
Cc: olaf@aepfle.de, sthemmin@microsoft.com, gregkh@linuxfoundation.org,
 jasowang@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 Michael.H.Kelley@microsoft.com, hpa@zytor.com, apw@canonical.com,
 devel@linuxdriverproject.org, tglx@linutronix.de, vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 11:12:47AM -0700, kys@linuxonhyperv.com wrote:
> +/*
> + * IPI implementation on Hyper-V.
> + */
> +
> +static int __send_ipi_mask(const struct cpumask *mask, int vector)
> +{
> +	int cur_cpu, vcpu;
> +	struct ipi_arg_non_ex **arg;
> +	struct ipi_arg_non_ex *ipi_arg;
> +	int ret = 1;

Not specifically related to this patch, but hv code sometimes returns 1
on error or U64_MAX.  It's slightly magical.  Maybe
HV_STATUS_INVALID_HYPERCALL_INPUT (3) would be more appropriate?  Or we
could make a new more generic error code:

#define HV_STATUS_INVALID        1

regards,
dan carpenter
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
